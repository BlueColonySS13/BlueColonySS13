/obj/machinery/autolathe
	name = "Autolathe"
	desc = "It produces items using metal and glass."
	icon_state = "autolathe"
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 2000
	circuit = /obj/item/weapon/circuitboard/autolathe
	var/datum/category_collection/machine_recipes
	var/category_type = /datum/category_collection/crafting/autolathe

	var/list/stored_material =  list(DEFAULT_WALL_MATERIAL = 0, "glass" = 0, "plastic" = 0, "copper" = 0, "aluminium" = 0)
	var/list/storage_capacity = list(DEFAULT_WALL_MATERIAL = 35000, "glass" = 22500, "plastic" = 22500, "copper" = 22500, "aluminium" = 22500)
	var/datum/category_group/current_category

	var/hacked = 0
	var/disabled = 0
	var/shocked = 0
	var/busy = 0

	var/mat_efficiency = 1
	var/build_time = 50

	var/datum/wires/autolathe/wires = null

	var/process_sound = 'sound/machines/copier.ogg'

	var/print_multiplier = 1
	var/max_multiplier = 10

	var/commercial = FALSE
	var/owner_name = null // name of the actual owner.
	var/owner_uid = null // UID of the actual owner.
	var/bank_id = null // Account ID that the autolathe will use to recieve money

	unique_save_vars = list("stored_material", "hacked", "owner_name", "owner_uid", "bank_id")

/obj/machinery/autolathe/examine(mob/user)
	..()
	if(owner_name)
		to_chat(user, "[name] belongs to <b>[owner_name]</b>, report any issues with the machine to the owner.")
	if(commercial)
		to_chat(user, "<b>You can buy items from this unit.</b>")

/obj/machinery/autolathe/commercial
	name = "Fabri-Mate"
	desc = "A state-of-the-art automatic fabricator that prints on demand."
	icon_state = "fabrimate"
	commercial = TRUE
	circuit = /obj/item/weapon/circuitboard/autolathe/commercial

	storage_capacity = list(DEFAULT_WALL_MATERIAL = 135000, "glass" = 122500, "plastic" = 122500, "copper" = 122500, "aluminium" = 122500)

/obj/machinery/autolathe/New()
	..()
	wires = new(src)
	component_parts = list()
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(src)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(src)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(src)
	component_parts += new /obj/item/weapon/stock_parts/manipulator(src)
	component_parts += new /obj/item/weapon/stock_parts/console_screen(src)
	RefreshParts()

/obj/machinery/autolathe/Destroy()
	qdel(wires)
	wires = null
	return ..()

/obj/machinery/autolathe/proc/update_recipe_list()
	if(!machine_recipes)
		if(!autolathe_recipes)
			autolathe_recipes = new category_type()
		machine_recipes = autolathe_recipes
		current_category = machine_recipes.categories[1]

/obj/machinery/autolathe/proc/get_screen_data(mob/user as mob)
	var/list/dat = list()
	dat += "<center><h1>[capitalize(name)]</h1><hr/>"

	if(commercial && (!owner_uid || !bank_id || !owner_name))
		dat += "Please swipe your ID to claim ownership of this machine.<br>"
		return dat

	if(!disabled)
		dat += "<table width = '100%'>"
		var/list/material_top = list("<tr>")
		var/list/material_bottom = list("<tr>")

		for(var/material in stored_material)
			material_top += "<td width = '25%' align = center><b>[material]</b></td>"
			material_bottom += "<td width = '25%' align = center>[stored_material[material]]<b>/[storage_capacity[material]]</b></td>"


		dat += "[material_top.Join()]</tr>[material_bottom.Join()]</tr></table><hr>"
		dat += "<b>Print Multiplier</b>: <a href='?src=\ref[src];change_print_multiplier=1'>[print_multiplier]</a><br>"
		dat += "<h2>Printable Designs</h2><h3>"

		var/eligible_items = current_category.items

		dat += "Showing: <a href='?src=\ref[src];change_category=1'>[current_category]</a>.</h3></center><table width = '100%'>"

		for(var/datum/category_item/crafting/R in eligible_items)
			if(R.hidden && !hacked)
				continue

			if(commercial && !R.show_commercially)
				continue

			var/total_cost = (R.get_pricing() * print_multiplier)
			var/can_make = 1
			var/list/material_string = list()
			var/list/multiplier_string = list()
			var/max_sheets
			var/comma
			if(!R.resources || !R.resources.len)
				material_string += "No resources required.</td>"
			else

				//Make sure it's buildable and list requires resources.
				for(var/material in R.resources)
					var/sheets = round(stored_material[material]/round(R.resources[material]*mat_efficiency))
					if(isnull(max_sheets) || max_sheets > sheets)
						max_sheets = sheets
					if(!isnull(stored_material[material]) && stored_material[material] < (print_multiplier * round(R.resources[material]*mat_efficiency)))
						can_make = 0
					if(!comma)
						comma = 1
					else
						material_string += ", "
					material_string += "[(round(R.resources[material] * mat_efficiency)) * print_multiplier] [material]"

				material_string += ".  [commercial ? "<b>Cost:</b> [total_cost ? cash2text(total_cost, FALSE, TRUE, TRUE ) : ""]" : ""]<br></td>"

				//Build list of multipliers for sheets.
				if(R.is_stack)
					if(max_sheets && max_sheets > 0)
						max_sheets = min(max_sheets, R.max_stack) // Limit to the max allowed by stack type.
						multiplier_string += "<br>"
						for(var/i = 5;i<max_sheets;i*=2) //5,10,20,40...
							multiplier_string  += "<a href='?src=\ref[src];make=\ref[R];multiplier=[i]'>\[x[i]\]</a>"
						multiplier_string += "<a href='?src=\ref[src];make=\ref[R];multiplier=[max_sheets]'>\[x[max_sheets]\]</a>"

			dat += "<tr><td width = 180>[R.hidden ? "<font color = 'red'>*</font>" : ""]<b>[can_make ? "<a href='?src=\ref[src];make=\ref[R];multiplier=1'>" : ""][R.name][can_make ? "</a>" : ""]</b>[R.hidden ? "<font color = 'red'>*</font>" : ""][multiplier_string.Join()]</td><td align = right>[material_string.Join()]</tr>"

		dat += "</table><hr>"

		return dat


/obj/machinery/autolathe/interact(mob/user as mob)
	update_recipe_list()

	if(..() || (disabled && !panel_open))
		to_chat(user, "<span class='danger'>\The [src] is disabled!</span>")
		return

	if(shocked)
		shock(user, 50)

	var/dat = get_screen_data(user)

	var/datum/browser/popup = new(user, "autolathe", "[src]", 650, 650, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "autolathe")

/obj/machinery/autolathe/proc/set_new_owner(obj/item/weapon/card/id/I, custom_bank = null)
	owner_name = I.registered_name
	owner_uid = I.unique_ID
	bank_id = (custom_bank ? custom_bank : I.associated_account_number)
	visible_message("<span class='info'>New owner set to '[I.registered_name]'.</span>")
	playsound(src, 'sound/machines/chime.ogg', 25)


/obj/machinery/autolathe/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(busy)
		to_chat(user, "<span class='notice'>\The [src] is busy. Please wait for completion of previous operation.</span>")
		return

	if(commercial)
		var/obj/item/weapon/card/id/I = O.GetID()
		if(I)
			if(!I.unique_ID || !I.registered_name || !I.associated_account_number || !check_account_exists(I.associated_account_number))
				visible_message("<span class='notice'>There is an issue with setting your ownership on this machine, it could be due to a lack of details on the card like \
				a unique id, name, or valid bank details. Please contact a technician for more details.</span>")
				return
			else
				var/datum/business/B = get_business_by_owner_uid(I.unique_ID)
				var/biz_id = null
				if(B)
					if("Business" == alert("Would you like to link this to your business account or personal one?", "Bank Account Linking", "Business", "Personal"))

						var/datum/money_account/department/department_account = B.get_bank()
						if(department_account)
							biz_id = department_account.account_number

				set_new_owner(I, biz_id)
				return

	if(default_deconstruction_screwdriver(user, O))
		updateUsrDialog()
		return
	if(default_deconstruction_crowbar(user, O))
		return
	if(default_part_replacement(user, O))
		return

	if(stat)
		return

	if(panel_open)
		//Don't eat multitools or wirecutters used on an open lathe.
		if(O.is_multitool() || O.is_wirecutter())
			if(trigger_lot_security_system(user, /datum/lot_security_option/vandalism, "Opened \the [src] with \the [O]."))
				return
			wires.Interact(user)
			return

	if(O.loc != user && !(istype(O,/obj/item/stack)))
		return 0

	if(is_robot_module(O))
		return 0

	if(istype(O,/obj/item/ammo_magazine/clip) || istype(O,/obj/item/ammo_magazine/s357) || istype(O,/obj/item/ammo_magazine/s38)) // Prevents ammo recycling exploit with speedloaders.
		user << "\The [O] is too hazardous to recycle with the autolathe!"
		return
		/*  ToDo: Make this actually check for ammo and change the value of the magazine if it's empty. -Spades
		var/obj/item/ammo_magazine/speedloader = O
		if(speedloader.stored_ammo)
			user << "\The [speedloader] is too hazardous to put back into the autolathe while there's ammunition inside of it!"
			return
		else
			speedloader.matter = list(DEFAULT_WALL_MATERIAL = 75) // It's just a hunk of scrap metal now.
	if(istype(O,/obj/item/ammo_magazine)) // This was just for immersion consistency with above.
		var/obj/item/ammo_magazine/mag = O
		if(mag.stored_ammo)
			user << "\The [mag] is too hazardous to put back into the autolathe while there's ammunition inside of it!"
			return*/

	//Resources are being loaded.
	var/obj/item/eating = O
	if(!eating.matter)
		user << "\The [eating] does not contain significant amounts of useful materials and cannot be accepted."
		return

	var/filltype = 0       // Used to determine message.
	var/total_used = 0     // Amount of material used.
	var/mass_per_sheet = 0 // Amount of material constituting one sheet.

	for(var/material in eating.matter)

		if(isnull(stored_material[material]) || isnull(storage_capacity[material]))
			continue

		if(stored_material[material] >= storage_capacity[material])
			continue

		var/total_material = eating.matter[material]

		//If it's a stack, we eat multiple sheets.
		if(istype(eating,/obj/item/stack))
			var/obj/item/stack/stack = eating
			total_material *= stack.get_amount()

		if(stored_material[material] + total_material > storage_capacity[material])
			total_material = storage_capacity[material] - stored_material[material]
			filltype = 1
		else
			filltype = 2

		stored_material[material] += total_material
		total_used += total_material
		mass_per_sheet += eating.matter[material]

	if(!filltype)
		user << "<span class='notice'>\The [src] is full. Please remove material from the autolathe in order to insert more.</span>"
		return
	else if(filltype == 1)
		user << "You fill \the [src] to capacity with \the [eating]."
	else
		user << "You fill \the [src] with \the [eating]."

	flick("[initial(icon_state)]_o", src) // Plays metal insertion animation. Work out a good way to work out a fitting animation. ~Z

	if(istype(eating,/obj/item/stack))
		var/obj/item/stack/stack = eating
		stack.use(max(1, round(total_used/mass_per_sheet))) // Always use at least 1 to prevent infinite materials.
	else
		user.remove_from_mob(O)
		qdel(O)

	updateUsrDialog()
	return

/obj/machinery/autolathe/attack_hand(mob/user as mob)
	user.set_machine(src)
	interact(user)

/obj/machinery/autolathe/Topic(href, href_list)
	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	if(busy)
		to_chat(usr, "<span class='notice'>The autolathe is busy. Please wait for completion of previous operation.</span>")
		return

	if(href_list["change_print_multiplier"])
		var/new_multiplier = input("Current multiplier is [print_multiplier], input the new amount of items you want to print. Max is [max_multiplier].", "Set Multiplier", print_multiplier) as num|null

		if(!new_multiplier || (1 > new_multiplier) || (new_multiplier > max_multiplier) )
			return

		print_multiplier = round(new_multiplier)
		updateUsrDialog()
		return


	if(href_list["change_category"])

		var/choice = input("Which category do you wish to display?") as null|anything in machine_recipes.categories
		if(!choice) return
		current_category = choice

	if(href_list["make"] && machine_recipes)
		var/multiplier = text2num(href_list["multiplier"])
		var/datum/category_item/crafting/making = locate(href_list["make"]) in current_category.items


		if(!making)
			return
		if(!making.is_stack && multiplier != 1)
			return

		if(commercial && making.get_pricing())

			var/transaction_amount = (making.get_pricing() * print_multiplier) * multiplier
			var/obj/item/weapon/card/id/I = usr.GetIdCard()

			if(!I || !I.associated_account_number)
				src.visible_message("\icon[src]<span class='warning'>ALERT: No ID card found, please wear or hold an ID on hand to complete this purchase.</span>")
				return

			var/datum/money_account/D = get_account(I.associated_account_number)

			var/attempt_pin = ""
			if(D && D.security_level)
				attempt_pin = input("Enter PIN", "Transaction") as num
				D = null
			D = attempt_account_access(I.associated_account_number, attempt_pin, 2)

			if(!D)
				src.visible_message("\icon[src]<span class='warning'>Unable to access account. Check security settings and try again.</span>")
				return


			if(D.suspended)
				src.visible_message("\icon[src]<span class='warning'>Your account has been suspended.</span>")
				return

			if(transaction_amount > D.money)
				src.visible_message("\icon[src]<span class='warning'>Not enough funds.</span>")
				return

			if("No" == alert("Confirm purchase of [making.name] for [cash2text( making.get_pricing(), FALSE, TRUE, TRUE )]?", "Purchase of [making.name]", "No", "Yes"))
				return


			// Transfer the money

			var/tax_amount = SSpersistent_options.get_persistent_option_value(making.get_tax())
			var/tax_subtract = (transaction_amount * tax_amount)
			var/post_tax_amount = transaction_amount - tax_subtract

			SSeconomy.charge_main_department(tax_subtract, "[D.owner_name]'s [src] Tax Transfer: [making.name]")

			charge_to_account(D.account_number, "[D.owner_name]'s [name]", "[making.name] x[print_multiplier]", name, -transaction_amount)
			charge_to_account(bank_id, "[D.owner_name]'s [name]", "[making.name] x[print_multiplier][tax_amount ? " (After [tax_amount * 100]% tax)" : ""]", name, post_tax_amount)


		sanitize_integer(multiplier, 1, 100, 1)
		sanitize_integer(print_multiplier, 1, max_multiplier, 1)

		busy = 1
		playsound(src.loc, process_sound, 30, 1)
		update_use_power(2)

		//Check if we still have the materials.
		for(var/material in making.resources)
			if(!isnull(stored_material[material]))
				if((stored_material[material] < round(making.resources[material] * mat_efficiency) * multiplier) * print_multiplier)
					busy = 0
					to_chat(usr, "<span class='notice'>You don't have enough materials for this.</span>")
					return

		//Consume materials.
		for(var/material in making.resources)
			if(!isnull(stored_material[material]))
				stored_material[material] = max(0, stored_material[material] - (round(making.resources[material] * mat_efficiency) * multiplier) * print_multiplier)

		update_icon() // So lid closes

		for(var/i = 0, i < print_multiplier, i++)
			sleep(build_time)

			update_use_power(1)
			update_icon() // So lid opens

			//Sanity check.
			if(!making || !src) return

			//Create the desired item(s).

			var/obj/item/I = new making.path(src.loc)

			if(LAZYLEN(making.force_matter))			// forces the matter list to be something else.
				I.matter = making.force_matter


			if(making.prefix)
				I.name = "[making.prefix] [I.name]"
			if(making.suffix)
				I.name = "[I.name] [making.suffix]"
			if(making.override_color)
				I.color = making.override_color

			if(istype(I, /obj/item/weapon/material) && making.material_id)
				var/obj/item/weapon/material/mat_item = I
				mat_item.material = get_material_by_name(making.material_id)
				mat_item.update_icon()

			if(multiplier > 1 && istype(I, /obj/item/stack))
				var/obj/item/stack/S = I
				S.amount = multiplier


		busy = 0
		update_icon()

	updateUsrDialog()

/obj/machinery/autolathe/update_icon()
	if(panel_open)
		icon_state = "[initial(icon_state)]_t"
	else if(busy)
		icon_state = "[initial(icon_state)]_n"
	else
		if(icon_state == "[initial(icon_state)]_n")
			flick("[initial(icon_state)]_u", src) // If lid WAS closed, show opening animation
		icon_state = "[initial(icon_state)]"

//Updates overall lathe storage size.
/obj/machinery/autolathe/RefreshParts()
	..()
	var/mb_rating = 0
	var/man_rating = 0
	for(var/obj/item/weapon/stock_parts/matter_bin/MB in component_parts)
		mb_rating += MB.rating
	for(var/obj/item/weapon/stock_parts/manipulator/M in component_parts)
		man_rating += M.rating

	for(var/V in storage_capacity)	// automatically calculates for us.
		storage_capacity[V] = (mb_rating * storage_capacity[V])

	build_time = 50 / man_rating
	mat_efficiency = 1.1 - man_rating * 0.1// Normally, price is 1.25 the amount of material, so this shouldn't go higher than 0.8. Maximum rating of parts is 3

/obj/machinery/autolathe/dismantle()
	for(var/mat in stored_material)
		var/material/M = get_material_by_name(mat)
		if(!istype(M))
			continue
		var/obj/item/stack/material/S = new M.stack_type(get_turf(src))
		if(stored_material[mat] > S.perunit)
			S.amount = round(stored_material[mat] / S.perunit)
		else
			qdel(S)
	..()
	return 1
