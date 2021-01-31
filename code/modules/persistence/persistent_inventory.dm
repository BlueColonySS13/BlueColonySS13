
/obj/machinery/inventory_machine
	name = "inv-tri"
	desc = "The inv-tri bot 4500 is a friendly and helpful bot that will allow you to store your possessions."
	icon = 'icons/obj/machines/inventory_box.dmi'
	icon_state = "inv-tri_on"
	anchored = TRUE
	density = TRUE

	light_range = 4
	light_power = 2
	light_color = "#ebf7fe"  //white blue

	var/owner_name = ""
	var/bank_id = ""
	var/owner_uid = ""
	var/charge = 1500	// this is a charge to start your own inventory. owners can change this

	var/awaiting_payment = FALSE
	var/staff_pin = 0

	var/maint_mode = FALSE
	var/atmpt_maint_mode = FALSE

	var/disabled = FALSE

	var/datum/persistent_inventory/current_inventory

	var/withdrawing = FALSE

	unique_save_vars = list("owner_name", "bank_id", "owner_uid", "charge", "staff_pin", "awaiting_payment", "maint_mode", "atmpt_maint_mode", "disabled")

	circuit = /obj/item/weapon/circuitboard/inventory_box

	save_contents = FALSE

	var/item_processing = FALSE


/obj/machinery/inventory_machine/New()
	..()
	GLOB.inventory_boxes += src

/obj/machinery/inventory_machine/nanotrasen/New()
	..()
	link_nt_account()

/obj/machinery/inventory_machine/nanotrasen/proc/link_nt_account()
	var/datum/money_account/nt_dep = dept_acc_by_id(DEPT_NANOTRASEN)

	if(!nt_dep)
		return

	owner_name = "Nanotrasen"
	bank_id = nt_dep.account_number
	owner_uid = "Nanotrasen"
	charge = 3000
	staff_pin = 10000	// you can't enter a pin over 9999, so this is unhackable.


/obj/machinery/inventory_machine/update_icon()
	if(disabled)
		icon_state = "inv-tri_off"
		return

	if(emagged)
		icon_state = "inv-tri_emagged"
		return

	icon_state = "inv-tri_on"

/obj/machinery/inventory_machine/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		emagged = TRUE
		visible_message("<b>[src]</b> beeps, \"<span class='danger'>Th-th-THA- Thank you for using the BZZT- tron 9000.</span>\" ")
		flick("inv-tri_emag",src)
		update_icon()
		return 1

/obj/machinery/inventory_machine/proc/set_new_owner(obj/item/weapon/card/id/I)
	if(!I)
		return
	if(!I.registered_name || !I.unique_ID)
		visible_message("<span class='info'>Error with citizen details. Please check your ID with an administrator.</span>")
		return
	owner_name = I.registered_name
	owner_uid = I.unique_ID
	bank_id = I.associated_account_number
	visible_message("<span class='info'>New owner set to '[I.registered_name]'.</span>")
	playsound(src, 'sound/machines/chime.ogg', 25)
	staff_pin = rand(1111,9999)

	return TRUE


/obj/machinery/inventory_machine/examine(mob/user)
	..()
	if(charge)
		to_chat(user, "It costs <b>[cash2text( charge, FALSE, TRUE, TRUE )]</b> to open an inventory account here.")
	if(owner_name)
		to_chat(user, "It belongs to [owner_name], contact them for any issues.")
	if(!anchored)
		to_chat(user, "<b>It is loose from the floor!</b>")
	else
		to_chat(user, "<b>It is firmly anchored to the floor.</b>")
	if(!disabled)
		to_chat(user, "<b>It is ready for use.</b>")
	else
		to_chat(user, "<b>It is disabled.</b>")

/obj/machinery/inventory_machine/attack_hand(mob/user as mob)
	src.add_fingerprint(user)
	if(stat & (BROKEN|NOPOWER))
		return

	interact(user)
	updateDialog()

/obj/machinery/inventory_machine/interact(mob/user as mob)
	var/dat

	dat = get_full_data(user)

	var/datum/browser/popup = new(user, "inventory_machine", "[src]", 550, 650, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "inventory_machine")


/obj/machinery/inventory_machine/proc/get_full_data(mob/user as mob)
	var/dat

	//title and welcome
	dat += "<b>[name]</b><br>"


	if(!config.canonicity && !atmpt_maint_mode && !maint_mode)
		dat += "<b>Error code 402:</b> Issue with database, systems will be down until this is rectified."
		return dat

	if(!owner_uid || !owner_name)
		dat += "Please swipe your ID to claim ownership of this machine.<br>"
		return dat

	if(disabled && !atmpt_maint_mode && !maint_mode)
		dat += "<b>Error code 502:</b> Machine has been disabled by owner."
		dat += "<br><br><a href='?src=\ref[src];attempt_maint=1'>Access Maintenance Mode</a>"
		return dat

	if(!check_account_exists(bank_id))
		dat += "<i>There appears to be an issue with the payment account of this vendor. Please contact the owner.</i>"
		dat += "<br><br><a href='?src=\ref[src];attempt_maint=1'>Access Maintenance Mode</a>"
		return dat

	if(atmpt_maint_mode)
		dat += "Please swipe the initial ID you used to register this machine, or enter a staff pin code.<br>"

		dat += "<br><br><a href='?src=\ref[src];enter_pin=1'>Enter Staff Pin</a>"
		dat += "<a href='?src=\ref[src];cancel=1'>Cancel &#8617</a>"

		return dat

	if(maint_mode)
		dat += "Welcome to Maintenance mode. Remember to Exit Maintenance Mode when you are done, to lock and secure your machine.<br><br>"
		dat += "<b>Staff pin:</b> [staff_pin]<br>"
		dat += "<b>Status:</b> [disabled ? "Disabled" : "Enabled"]<br>"
		dat += "<b>New Accounts Price:</b> [cash2text( charge, FALSE, TRUE, TRUE )]<br><br>"

		dat += "<a href='?src=\ref[src];change_pin=1'>Change Staff Pin</a> "
		dat += "<a href='?src=\ref[src];disable_machine_toggle=1'>Disable Machine</a> "
		dat += "<a href='?src=\ref[src];change_pricing=1'>Change Pricing</a> "
		dat += "<a href='?src=\ref[src];toggle_anchor=1'>Toggle Anchors</a> "
		dat += "<a href='?src=\ref[src];edit_bank=1'>Update Bank Details</a> "

		dat += "<br><br><a href='?src=\ref[src];exit_maint_mode=1'>Exit Maint Mode</a>"

		return dat

	if(awaiting_payment && !current_inventory)
		dat += "Please pay <b>[cash2text( charge, FALSE, TRUE, TRUE )]</b> to open a new account. Card, cash and charge card compatible.<br><br>"

		dat += "<a href='?src=\ref[src];cancel=1'>Back</a>"
		return dat

	if(!current_inventory)
		dat += "<i>Welcome to the future of inventory storage</i> - this [name] will allow you store your items via bluespace and request them at any time.<br><br>"
		dat += "It costs <b>[cash2text( charge, FALSE, TRUE, TRUE )]</b> to make a new account. You can access existing accounts from this terminal. <br><br>"

		dat += "<a href='?src=\ref[src];access_inv=1'>Access Inventory</a>"
		dat += "<br><br><a href='?src=\ref[src];attempt_maint=1'>Access Maintenance Mode</a>"
	else
		dat += "Welcome <b>[current_inventory.owner_name]</b>,<br><br> You can withdraw or deposit items here. To deposit items, please place them into the bottom flap of the machine.<br>"

		dat += "<b>[length(current_inventory.stored_items) ? "[length(current_inventory.stored_items)]" : "0"]/[current_inventory.max_possible_items]</b> inventory slots<br><br>"

		dat += "<div class='statusDisplay'>"


		if(isemptylist(current_inventory.stored_items))
			dat += "No items in inventory. Place items into this inventory box to store."
		else

			for(var/datum/map_object/MO in current_inventory.stored_items)
				dat += "<a href='?src=\ref[src];choice=withdraw_item;item=\ref[MO]'>Withdraw</a> <b>[MO.name]</b><br>"

		dat += "</div><br>"

		dat += "<br><br><a href='?src=\ref[src];cancel=1'>Exit Inventory</a>"

	return dat


/obj/machinery/inventory_machine/attackby(var/obj/item/I, var/mob/user)
	add_fingerprint(user)

	if(!ishuman(user))
		return ..()

	var/mob/living/carbon/human/H = user

	var/obj/item/weapon/card/id/O

	if(istype(I,/obj/item/weapon/card/id))
		O = I

	if(O)
		if(!owner_uid || !owner_name)
			visible_message("<span class='notice'>[H] swipes their ID card over \the [src].</span>")
			if(!set_new_owner(O))
				return

			to_chat(H, "<span class='info'>A message displays on the screen: \"Your staff pin code is <b>[staff_pin]</b> - Please keep this safe and only share to those you trust\" \
 	 You can change this at any time.</span>")
			updateDialog()
			update_icon()
			return

		if(atmpt_maint_mode)
			if(O.unique_ID != owner_uid)
				visible_message("<span class='notice'>Authentication mismatch, please try again.</span>")
				return
			else
				atmpt_maint_mode = FALSE
				maint_mode = TRUE
				updateDialog()
				update_icon()
				return

	if(!config.canonicity) // the following is blocked off if it's not canon. Just putting in a check.
		return

	if(current_inventory)
		if(item_processing)
			visible_message("<b>[src]</b> beeps, \"<span class='danger'>Please wait!</span>\" ")
			return FALSE
		if(I.dont_save)
			visible_message("<b>[src]</b> beeps, \"<span class='danger'>I'm sorry! I'm unable to accept this item!</span>\" ")
			flick("inv-tri_warn",src)
			return
		if(current_inventory.max_possible_items <= length(current_inventory.stored_items))
			visible_message("<b>[src]</b> beeps, \"<span class='danger'>I'm sorry! You've reached your inventory limit!</span>\" ")
			flick("inv-tri_warn",src)
			return


		if(!emagged && INVENTORY_BOX_CONTROL)
			var/safety = 200
			var/list/objects_to_search = list(I)
			var/has_illegal_things = FALSE

			while(objects_to_search.len)
				if(--safety <= 0) // Just in case.
					message_admins("Recursion limit hit when trying to parse contraband status of the contents of \the [I].")
					return
				var/atom/movable/AM = objects_to_search[1]

				var/contraband_status = AM.is_legal()
				if(!contraband_status)
					has_illegal_things = TRUE
					break

				objects_to_search -= AM
				objects_to_search += AM.get_saveable_contents()

			if(has_illegal_things)
				visible_message("<b>[src]</b> beeps, \"<span class='danger'>I can't take this item as it is a government controlled item, I'm sorry!</span>\" ")
				flick("inv-tri_warn",src)
				playsound(src, 'sound/machines/deniedbeep.ogg', 50, FALSE)
				return


		item_processing = TRUE
		user.drop_from_inventory(I, src)
		I.forceMove(src) // move item into it to prevent glitches.

		current_inventory.add_item(I, user)

		item_processing = FALSE
		updateDialog()
		update_icon()
		return

	if(awaiting_payment && !current_inventory)
		var/paid = FALSE

		if(O)
			paid = pay_with_card(O, H)

		if(istype(I,/obj/item/weapon/spacecash))
			if(istype(I,/obj/item/weapon/spacecash/ewallet))
				var/obj/item/weapon/spacecash/ewallet/chargecard = I
				paid = pay_with_ewallet(chargecard, H)

			else
				var/obj/item/weapon/spacecash/cash = I
				paid = pay_with_cash(cash, H)

		if(paid)
			current_inventory = make_new_inventory(H.real_name, H.unique_id)
			awaiting_payment = FALSE
			to_chat(user, "Payment accepted!")
			updateDialog()
			update_icon()


/obj/machinery/inventory_machine/proc/pay_with_card(obj/item/weapon/card/id/I, mob/user)
	if(!I)
		to_chat(user, "<span class='warning'ERROR: Report this in #bug-reports.")

	var/datum/money_account/customer_account = get_account(I.associated_account_number)
	if(!customer_account)
		visible_message("<span class='notice'>Error: Unable to access account. Please contact technical support if problem persists.</span>")
		return

	if(customer_account.suspended)
		visible_message("<span class='notice'>Unable to access account: account suspended.")
		return

	// Have the customer punch in the PIN before checking if there's enough money. Prevents people from figuring out acct is
	// empty at high security levels
	if(customer_account.security_level != 0) //If card requires pin authentication (ie seclevel 1 or 2)
		var/attempt_pin = input("Enter pin code", "Inventory Box Purchase") as num
		customer_account = attempt_account_access(I.associated_account_number, attempt_pin, 2)

		if(!customer_account)
			visible_message("Unable to access account: incorrect credentials.")
			return

	if(charge > customer_account.money)
		visible_message("Insufficient funds in account.")
		return

	// debit money from the purchaser's account
	customer_account.money -= charge
	customer_account.add_transaction_log("[owner_name] (via [name])", "Inventory Box Purchase", -charge, "Inventory Box")
	charge_to_account(bank_id, "[customer_account.owner_name] (via [src])", "Inventory Box Purchase", "Inventory Box", charge)

	return TRUE

/obj/machinery/inventory_machine/proc/pay_with_cash(var/obj/item/weapon/spacecash/cashmoney, mob/user)
	if(charge > cashmoney.worth)

		// This is not a status display message, since it's something the character
		// themselves is meant to see BEFORE putting the money in
		to_chat(user, "\icon[cashmoney] <span class='warning'>That is not enough money.</span>")
		return 0

	if(istype(cashmoney, /obj/item/weapon/spacecash))

		visible_message("<span class='info'>\The [usr] inserts some cash into \the [src].</span>")
		cashmoney.worth -= charge
		charge_to_account(bank_id, "[src]", "Inventory Box Purchase", "Inventory Box", charge)

		if(cashmoney.worth <= 0)
			usr.drop_from_inventory(cashmoney)
			qdel(cashmoney)
		else
			cashmoney.update_icon()

	return TRUE

/obj/machinery/inventory_machine/proc/pay_with_ewallet(var/obj/item/weapon/spacecash/ewallet/wallet, user)
	visible_message("<span class='info'>[user] swipes \the [wallet] through \the [src].</span>")
	if(charge > wallet.worth)
		visible_message("Insufficient funds on chargecard.")
		return 0
	else
		wallet.worth -= charge
		charge_to_account(bank_id, "[src]", "Inventory Box Purchase", "Inventory Box", charge)
		return TRUE

/obj/machinery/inventory_machine/proc/try_staff_pin(mob/user)
	var/attempt_pin = input("Enter staff pin code (max: 9999)", "Vendor transaction") as num

	if(attempt_pin > 9999)
		to_chat(user, "<span class='warning'>ERROR: Pins do not exceed 9999.</span>")
		return

	if(attempt_pin != staff_pin)
		to_chat(user, "<span class='warning'>ERROR: Incorrect pin number.</span>")
	else
		atmpt_maint_mode = FALSE
		maint_mode = TRUE

/obj/machinery/inventory_machine/proc/check_inventory_lists(mob/user, var/obj/item/weapon/card/id/I)
	if(!I || !I.unique_ID || !I.registered_name)
		return FALSE

	var/datum/persistent_inventory/new_inv

	for(var/obj/machinery/inventory_machine/INV in GLOB.inventory_boxes)
		if(INV.current_inventory && INV.current_inventory.unique_id == I.unique_ID)
			return FALSE

	for(var/datum/persistent_inventory/PI in GLOB.persistent_inventories)
		if(PI.unique_id == I.unique_ID)
			return PI

	new_inv = make_new_inventory(I.registered_name, I.unique_ID)

	if(new_inv)
		var/full_path = "data/persistent/inventories/[I.unique_ID].sav"
		if(fexists(full_path))
			new_inv.load_inventory()

		return new_inv


/obj/machinery/inventory_machine/proc/make_new_inventory(owner_nm, uid)
	var/datum/persistent_inventory/new_inv = new /datum/persistent_inventory(src)

	new_inv.owner_name = owner_nm
	new_inv.unique_id = uid

	return new_inv

/obj/machinery/inventory_machine/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["access_inv"])
		var/mob/user = usr
		var/obj/item/weapon/card/id/I = user.GetIdCard()

		if(!I || !I.unique_ID)
			to_chat(usr, "<b>You need to wear a valid ID with your citizen details linked in order to access your inventory.</b>")

		if(!check_persistent_storage_exists(I.unique_ID))
			awaiting_payment = TRUE
		else
			var/datum/persistent_inventory/new_inv = check_inventory_lists(usr, I)

			if(!new_inv)
				visible_message("<b>[src]</b> beeps, \"<span class='danger'>Oh no! [usr] I wasn't able to access your inventory account, it either exists already or is open elsewhere!</span>\" ")
				flick("inv-tri_warn",src)
				return

			visible_message("<b>[src]</b> beeps, \"<span class='notice'>Welcome back!</span>\" ")
			flick("inv-tri_accept",src)

			current_inventory = new_inv

	if(href_list["disable_machine_toggle"])
		if(!maint_mode)
			return

		disabled = !disabled
		if(disabled)
			to_chat(usr, "<b>The machine is now disabled.</b> It cannot be used by the public.")
		else
			to_chat(usr, "<b>The machine is now enabled.</b> It now can be used by the public.")

	if(href_list["exit_maint_mode"])
		if(!maint_mode)
			return

		maint_mode = FALSE

	if(href_list["attempt_maint"])
		atmpt_maint_mode = TRUE

	if(href_list["cancel"])
		if(item_processing)
			return FALSE

		atmpt_maint_mode = FALSE
		maint_mode = FALSE
		current_inventory = null
		awaiting_payment = FALSE


	if(href_list["enter_pin"])
		if(!atmpt_maint_mode || maint_mode)
			return

		try_staff_pin(usr)

	if(href_list["change_pin"])
		if(!maint_mode)
			return

		var/new_pin = input("Enter new staff pin code (max 9999)", "Vendor transaction") as num
		if(!new_pin || (0 > new_pin))
			return
		if(new_pin > 9999)
			to_chat(usr, "<span class='warning'>ERROR: Pins do not exceed 9999.</span>")
			return

		staff_pin = new_pin

		to_chat(usr, "<span class='info'>Pin successfully changed to [new_pin].</span>")

	if(href_list["change_pricing"])
		if(!maint_mode)
			return

		var/min_charge = 800

		var/new_charge = input(usr,"Set a fee for using the inventory box. (Min [min_charge])","Inventory Fee", charge) as null|num

		if(min_charge > new_charge)
			new_charge = min_charge

		charge = new_charge
		to_chat(usr, "\The [src] will now charge [charge] credits per usage.")

	if(href_list["toggle_anchor"])
		if(!maint_mode)
			return

		anchored = !anchored
		playsound(src, 'sound/items/drill_use.ogg', 25)

		if(anchored)
			to_chat(usr, "<b>The anchors tether themselves back into the floor. It is now secured.</b>")
		else
			to_chat(usr, "<b>You toggle the anchors of the display case. It can now be moved.</b>")

	if(href_list["edit_bank"])
		if(!maint_mode)
			return

		var/new_bank = sanitize(input("Please enter the bank id you wish to replace the former. Leave blank to cancel.", "Set Bank", bank_id) as text, 100)

		if(!new_bank)
			return

		if(!check_account_exists(new_bank))
			alert("#[new_bank] does not appear to link to any bank ID in the database. Please try again.")
			return

		bank_id = new_bank
		alert("New bank account ID set to #[new_bank].")

	if(href_list["choice"])
		switch(href_list["choice"])

			if("withdraw_item")
				var/item = locate(href_list["item"])

				if(withdrawing || !current_inventory || !item || !(item in current_inventory.stored_items) )
					return

				var/datum/map_object/MO = item

				withdrawing = TRUE
				var/obj/withdraw_item = full_item_load(MO, get_turf(src))


				if(!withdraw_item)
					withdrawing = FALSE
					return

				playsound(src, 'sound/machines/chime.ogg', 25)
				flick("inv-tri_accept",src)

				to_chat(usr, "\icon[src] <b>[withdraw_item]</b> has been withdrawn.")

				current_inventory.stored_items -= MO
				qdel(MO)
				listclearnulls(current_inventory.stored_items)
				withdrawing = FALSE





	updateDialog()
	update_icon()




/proc/check_persistent_storage_exists(unique_id)
	for(var/datum/persistent_inventory/PI in GLOB.persistent_inventories)
		if(PI.unique_id == unique_id)
			return PI

	var/full_path = "data/persistent/inventories/[unique_id].sav"
	if(!full_path)			return FALSE
	if(fexists(full_path)) return TRUE

	return FALSE

// datums for persistent inventory
/datum/persistent_inventory
	var/name = "Persistent Inventory"

	var/list/disallowed_items = list()

	var/owner_name = ""
	var/unique_id = ""

	var/list/stored_items = list()

	var/max_possible_items = 60 // it won't exceed this amount

/datum/persistent_inventory/New()
	..()
	GLOB.persistent_inventories += src

/datum/persistent_inventory/proc/add_item(var/obj/item/O, mob/user)
	if(disallowed_items.len && is_type_in_list(O, disallowed_items))
		return FALSE

	var/datum/map_object/MO = full_item_save(O)

	stored_items += MO
	if(user)
		to_chat(user, "You add [O] to the storage.")
	qdel(O)

	return MO

/datum/persistent_inventory/proc/save_inventory()
	var/full_path = "data/persistent/inventories/[unique_id].sav"
	if(!full_path)			return 0

	var/savefile/S = new /savefile(full_path)
	if(!fexists(full_path)) return 0

	if(!S)					return 0
	S.cd = "/"

	S["stored_items"] 		<<		stored_items
	S["owner_name"] 		<<		owner_name
	S["unique_id"] 		<<		unique_id
	return 1

/datum/persistent_inventory/proc/load_inventory()
	var/init_uid = unique_id

	var/full_path = "data/persistent/inventories/[unique_id].sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	S["stored_items"] 		>>		stored_items
	S["owner_name"] 		>>		owner_name
	S["unique_id"] 		>>		unique_id

	if(!stored_items)
		stored_items = list()
	if(!owner_name)
		owner_name = ""
	if(!unique_id)
		unique_id = init_uid

	listclearnulls(stored_items)

	return 1


/proc/delete_persistent_inventory(unique_id)
	var/full_path = "data/persistent/inventories/[unique_id].sav"
	if(!full_path)			return 0

	if(!fexists(full_path)) return 0

	fdel(full_path)

	return 1




