/obj/machinery/vr_sleeper
	name = "virtual reality sleeper"
	desc = "A fancy bed with built-in sensory I/O ports and connectors to interface users' minds with their bodies in virtual reality."
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "redpod_0"
	density = 1
	anchored = 1
	circuit = /obj/item/weapon/circuitboard/vr_sleeper
	var/mob/living/carbon/human/occupant = null
	var/mob/living/carbon/human/avatar = null
	var/datum/mind/vr_mind = null

	var/force_removal = FALSE	// allow force removal (important for prison VR sets)

	use_power = 1
	idle_power_usage = 15
	active_power_usage = 200
	light_color = "#FF0000"

	dont_save = TRUE


/obj/machinery/vr_sleeper/examine(mob/user)
	..()
	if(occupant && avatar)
		to_chat(user, "You see <b>[occupant]</b> inside. The game title above them says <b>[get_area(avatar)]</b>.")

/obj/machinery/vr_sleeper/prison_vr
	name = "prison virtual reality sleeper"
	desc = "An inmate has to pass the time somehow. This is how."
	icon_state = "syndipod_0"
	force_removal = TRUE

/obj/machinery/vr_sleeper/New()
	..()
	component_parts = list()
	component_parts += new /obj/item/weapon/stock_parts/scanning_module(src)
	component_parts += new /obj/item/stack/material/glass/reinforced(src, 2)

	RefreshParts()

/obj/machinery/vr_sleeper/initialize()
	. = ..()
	update_icon()

/obj/machinery/vr_sleeper/process()
	if(stat & (NOPOWER|BROKEN))
		return

/obj/machinery/vr_sleeper/update_icon()
	if(force_removal)
		icon_state = "syndipod_[occupant ? "1" : "0"]"
	else
		icon_state = "redpod_[occupant ? "1" : "0"]"

/obj/machinery/vr_sleeper/Topic(href, href_list)
	if(..())
		return 1

	if(usr == occupant)
		to_chat(usr, "<span class='warning'>You can't reach the controls from the inside.</span>")
		return

	add_fingerprint(usr)

	if(href_list["eject"])
		go_out()

	return 1

/obj/machinery/vr_sleeper/attackby(var/obj/item/I, var/mob/user)
	add_fingerprint(user)
	if(default_deconstruction_screwdriver(user, I))
		return
	else if(default_deconstruction_crowbar(user, I))
		if(occupant && avatar)
			avatar.exit_vr()
			avatar = null
			go_out()
		return


/obj/machinery/vr_sleeper/MouseDrop_T(var/mob/living/carbon/human/target, var/mob/living/carbon/human/user)
	if(user.stat || user.lying || !Adjacent(user) || !target.Adjacent(user)|| !isliving(target))
		return
	go_in(target, user)



/obj/machinery/sleeper/relaymove(var/mob/user)
	..()
	if(usr.incapacitated())
		return
	go_out()



/obj/machinery/vr_sleeper/emp_act(var/severity)
	if(stat & (BROKEN|NOPOWER))
		..(severity)
		return

	if(occupant)
		// This will eject the user from VR
		// ### Fry the brain?
		go_out()

	..(severity)

/obj/machinery/vr_sleeper/verb/eject()
	set src in oview(1)
	set category = "Object"
	set name = "Eject VR Capsule"

	if(usr.incapacitated())
		return

	if(!occupant)
		return

	if(avatar && !force_removal)
		if(alert(avatar, "Someone wants to remove you from virtual reality. Do you want to leave?", "Leave VR?", "Yes", "No") == "No")
			return

	// The player in VR is fine with leaving, kick them out and reset avatar
	if(avatar)
		avatar.exit_vr()
		avatar = null

	go_out()
	add_fingerprint(usr)

/obj/machinery/vr_sleeper/verb/climb_in()
	set src in oview(1)
	set category = "Object"
	set name = "Enter VR Capsule"

	if(usr.incapacitated())
		return
	go_in(usr, usr)
	add_fingerprint(usr)

/obj/machinery/vr_sleeper/relaymove(mob/user as mob)
	if(user.incapacitated())
		return 0 //maybe they should be able to get out with cuffs, but whatever
	go_out()

/obj/machinery/vr_sleeper/proc/go_in(var/mob/M, var/mob/user)
	if(!M)
		return
	if(stat & (BROKEN|NOPOWER))
		return
	if(!ishuman(M))
		user << "<span class='warning'>\The [src] rejects [M] with a sharp beep.</span>"
	if(occupant)
		user << "<span class='warning'>\The [src] is already occupied.</span>"
		return

	if(M == user)
		visible_message("\The [user] starts climbing into \the [src].")
	else
		visible_message("\The [user] starts putting [M] into \the [src].")

	if(do_after(user, 20))
		if(occupant)
			to_chat(user, "<span class='warning'>\The [src] is already occupied.</span>")
			return
		M.stop_pulling()
		if(M.client)
			M.client.perspective = EYE_PERSPECTIVE
			M.client.eye = src
		M.loc = src
		update_use_power(2)
		occupant = M

		update_icon()

		enter_vr()
	return

/obj/machinery/vr_sleeper/proc/go_out()
	if(!occupant)
		return

	if(occupant.client)
		occupant.client.eye = occupant.client.mob
		occupant.client.perspective = MOB_PERSPECTIVE
	occupant.loc = src.loc
	occupant = null
	for(var/atom/movable/A in src) // In case an object was dropped inside or something
		if(A == circuit)
			continue
		if(A in component_parts)
			continue
		A.loc = src.loc
	update_use_power(1)
	update_icon()

/obj/machinery/vr_sleeper/proc/enter_vr()

	// No mob to transfer a mind from
	if(!occupant)
		return

	// No mind to transfer
	if(!occupant.mind)
		return

	// Mob doesn't have an active consciousness to send/receive from
	if(occupant.stat != CONSCIOUS)
		return

	avatar = occupant.vr_link
	// If they've already enterred VR, and are reconnecting, prompt if they want a new body
	if(avatar && alert(occupant, "You already have a Virtual Reality avatar. Would you like to use it?", "New avatar", "Yes", "No") == "No")
		// Delink the mob
		occupant.vr_link = null
		avatar = null

	if(!avatar)
		// Get the desired spawn location to put the body
		var/S = null
		var/list/vr_landmarks = list()
		for(var/obj/effect/landmark/virtual_reality/sloc in landmarks_list)
			vr_landmarks += sloc.name

		S = input(occupant, "Please select a location to spawn your avatar at:", "Spawn location") as null|anything in vr_landmarks
		if(!S)
			return 0

		for(var/obj/effect/landmark/virtual_reality/i in landmarks_list)
			if(i.name == S)
				S = i
				break

		avatar = new(S, "Virtual Reality Avatar")
		// If the user has a non-default (Human) bodyshape, make it match theirs.
		if(occupant.species.name != "Promethean" && occupant.species.name != "Human")
			avatar.shapeshifter_change_shape(occupant.species.name)
		avatar.forceMove(get_turf(S))			// Put the mob on the landmark, instead of inside it
		avatar.Sleeping(1)

		occupant.enter_vr(avatar)

		// Prompt for username after they've enterred the body.
		var/newname = sanitize(input(avatar, "You are entering virtual reality. Your username is currently [src.name]. Would you like to change it to something else?", "Name change") as null|text, MAX_NAME_LEN)
		if (newname)
			avatar.real_name = newname

	else
		occupant.enter_vr(avatar)

/obj/machinery/vr_sleeper/business
	var/charge = 15
	var/paid = FALSE
	var/owner_name = ""
	var/bank_id = ""
	var/owner_uid = ""
	unique_save_vars = list("owner_name", "bank_id", "owner_uid", "charge")

	dont_save = FALSE

/obj/machinery/vr_sleeper/business/proc/speak(var/message)
	if(stat & NOPOWER)
		return

	if(!message)
		return

	for(var/mob/O in hearers(src, null))
		O.show_message("<span class='game say'><span class='name'>\The [src]</span> beeps, \"[message]\"</span>",2)
	return

/obj/machinery/vr_sleeper/business/examine(mob/user)
	..()
	if(charge)
		to_chat(user, "The usage fee for this VR Sleeper is <b>[cash2text( charge, FALSE, TRUE, TRUE )]</b>.")

/obj/machinery/vr_sleeper/business/attackby(var/obj/item/I, var/mob/user)
	add_fingerprint(user)
	if(default_deconstruction_screwdriver(user, I))
		return
	else if(default_deconstruction_crowbar(user, I))
		if(occupant && avatar)
			avatar.exit_vr()
			avatar = null
			go_out()
		return

	if(!paid)
		if(istype(I,/obj/item/weapon/card/id))
			var/obj/item/weapon/card/id/O = I
			if(!owner_name)
				visible_message("<span class='notice'>[usr] swipes their ID card over \the [src].</span>")
				owner_name = O.registered_name
				bank_id = O.associated_account_number
				owner_uid = O.unique_ID
				return
			else
				paid = pay_with_card(O, user)
				speak("Card payment accepted!")

		if(istype(I,/obj/item/weapon/spacecash))
			if(istype(I,/obj/item/weapon/spacecash/ewallet))
				var/obj/item/weapon/spacecash/ewallet/chargecard = I
				paid = pay_with_ewallet(chargecard, user)
				speak("Chargecard payment accepted!")
			else
				var/obj/item/weapon/spacecash/cash = I
				paid = pay_with_cash(cash, user)
				speak("Cash payment accepted!")
	else
		speak("Payment has already been accepted for the VR Sleeper Experience!")
		return

/obj/machinery/vr_sleeper/business/verb/set_price()
	set src in oview(1)
	set category = "Object"
	set name = "Set VR Price"

	if(usr.real_name != owner_name)
		return
	else
		var/new_charge = input(usr,"Set a fee for using the VR Sleeper.","VR Fee", charge) as null|num

		if(!isnull(new_charge))
			if(new_charge < 0)
				charge = initial(charge)
			else
				charge = new_charge
				to_chat(usr, "\The [src] will now charge [charge] credits per usage.")

/obj/machinery/vr_sleeper/business/go_in(var/mob/M, var/mob/user)
	if(!M)
		return
	if(stat & (BROKEN|NOPOWER))
		return
	if(!ishuman(M))
		user << "<span class='warning'>\The [src] rejects [M] with a sharp beep.</span>"
	if(occupant)
		user << "<span class='warning'>\The [src] is already occupied.</span>"
		return

	if(paid)
		if(M == user)
			visible_message("\The [user] starts climbing into \the [src].")
		else
			visible_message("\The [user] starts putting [M] into \the [src].")

		if(do_after(user, 20))
			if(occupant)
				to_chat(user, "<span class='warning'>\The [src] is already occupied.</span>")
				return
			M.stop_pulling()
			if(M.client)
				M.client.perspective = EYE_PERSPECTIVE
				M.client.eye = src
			M.loc = src
			update_use_power(2)
			occupant = M

			update_icon()

			enter_vr()
			return
	else
		speak("You must pay [charge] credits to enter virtual reality!")
		return

/obj/machinery/vr_sleeper/business/go_out()
	if(!occupant)
		return

	if(occupant.client)
		occupant.client.eye = occupant.client.mob
		occupant.client.perspective = MOB_PERSPECTIVE
	occupant.loc = src.loc
	occupant = null
	for(var/atom/movable/A in src) // In case an object was dropped inside or something
		if(A == circuit)
			continue
		if(A in component_parts)
			continue
		A.loc = src.loc
	update_use_power(1)
	update_icon()
	paid = FALSE

/obj/machinery/vr_sleeper/business/proc/pay_with_card(obj/item/weapon/card/id/I, mob/user)
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
		var/attempt_pin = input("Enter pin code", "VR Sleeper Fee") as num
		customer_account = attempt_account_access(I.associated_account_number, attempt_pin, 2)

		if(!customer_account)
			visible_message("Unable to access account: incorrect credentials.")
			return

	if(charge > customer_account.money)
		visible_message("Insufficient funds in account.")
		return

	// debit money from the purchaser's account
	customer_account.money -= charge
	customer_account.add_transaction_log("[owner_name] (via [name])", "VR Sleeper Charge", -charge, name)
	charge_to_account(bank_id, "VR Sleeper", "VR Sleeper Experience Purchase ([owner_name] (via [name]))", "VR Sleeper", charge)

	return TRUE

/obj/machinery/vr_sleeper/business/proc/pay_with_cash(var/obj/item/weapon/spacecash/cashmoney, mob/user)
	if(charge > cashmoney.worth)

		// This is not a status display message, since it's something the character
		// themselves is meant to see BEFORE putting the money in
		to_chat(user, "\icon[cashmoney] <span class='warning'>That is not enough money.</span>")
		return 0

	if(istype(cashmoney, /obj/item/weapon/spacecash))

		visible_message("<span class='info'>\The [usr] inserts some cash into \the [src].</span>")
		cashmoney.worth -= charge
		charge_to_account(bank_id, "VR Sleeper", "VR Sleeper Experience Purchase", "VR Sleeper", charge)

		if(cashmoney.worth <= 0)
			usr.drop_from_inventory(cashmoney)
			qdel(cashmoney)
		else
			cashmoney.update_icon()

	return TRUE

/obj/machinery/vr_sleeper/business/proc/pay_with_ewallet(var/obj/item/weapon/spacecash/ewallet/wallet, user)
	visible_message("<span class='info'>[user] swipes \the [wallet] through \the [src].</span>")
	if(charge > wallet.worth)
		visible_message("Insufficient funds on chargecard.")
		return 0
	else
		wallet.worth -= charge
		charge_to_account(bank_id, "VR Sleeper", "VR Sleeper Experience Purchase", "VR Sleeper", charge)
		return TRUE