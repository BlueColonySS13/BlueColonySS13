/obj/machinery/dye_generator
	name = "Dye Generator"
	icon = 'icons/obj/vending.dmi'
	icon_state = "barbervend"
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 40
	var/dye_color = "#000000"
	clicksound = "button"
	circuit = /obj/item/weapon/circuitboard/dye_generator
	var/making = 0

	var/dye_amount = 50
	var/max_dye = 50

	unique_save_vars = list("dye_color", "dye_amount")

/obj/machinery/dye_generator/examine()
	..()
	if(!dye_amount)
		to_chat(usr, "There is no dye left in the machine.")
	else
		to_chat(usr, "It is currently producing dye of a <font color='[dye_color]'>certain color</font>. It has [dye_amount] uses left.")

/obj/machinery/dye_generator/initialize()
	power_change()

/obj/machinery/dye_generator/power_change()
	if(stat & BROKEN)
		icon_state = "[initial(icon_state)]-broken"
		set_light(0)
	else
		if(powered())
			icon_state = initial(icon_state)
			stat &= ~NOPOWER
			set_light(2, l_color = dye_color)
		else
			spawn(rand(0, 15))
				src.icon_state = "[initial(icon_state)]-off"
				stat |= NOPOWER
				set_light(0)

/obj/machinery/dye_generator/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				qdel(src)
				return
		if(3.0)
			if(prob(25))
				stat |= BROKEN
				icon_state = "[initial(icon_state)]-broken"


/obj/machinery/dye_generator/proc/change_dye_color(mob/user)
	var/temp = input(user, "Choose a dye color", "Dye Color") as color
	dye_color = temp
	set_light(2, l_color = temp)

/obj/machinery/dye_generator/attack_hand(mob/user as mob)
	..()
	src.add_fingerprint(user)
	if(stat & (BROKEN|NOPOWER))
		return

	change_dye_color(user)

/obj/machinery/dye_generator/attackby(obj/item/weapon/W, mob/user, params)
	if(making)
		to_chat(user,"<span class='notice'>[src] is currently busy, try waiting a while.</span>")
		return

	if(default_unfasten_wrench(user, W, time = 60))
		return


	if(istype(W, /obj/item/photochromatic_dye_refill))
		var/obj/item/photochromatic_dye_refill/refill = W
		dye_amount = max_dye
		to_chat(user,"<span class='notice'>You refill the dye in [src] with [refill].</span>")
		qdel(refill)
		return


	if(istype(W, /obj/item/dye_bottle))
		if(dye_amount)
			user.visible_message("<span class='notice'>[user] fills the [W] up with some dye.</span>","<span class='notice'>You fill the [W] up with some hair dye.</span>")
			var/obj/item/dye_bottle/HD = W

			dye_amount--
			HD.dye_uses = HD.max_dye_uses
			HD.dye_color = dye_color
			HD.update_dye_overlay()
			return
		else
			to_chat(user, "<span class='notice'>There's a lack of dye in the machine, you can't fill [W] up.</span>")
			return

	if(istype(W, /obj/item/stack/wax))
		user.visible_message("<span class='notice'>[user] inserts [W] into the [src].</span>","<span class='notice'>You insert [W] into the [src].</span>")
		var/obj/item/stack/wax/B = W
		playsound(loc, 'sound/effects/bubbles2.ogg', 5, 1, 5)
		user.drop_from_inventory(B, src)
		B.forceMove(src)
		making = 1
		spawn(70)
			playsound(loc, 'sound/effects/pop.ogg', 5, 1, 5)
			B.stack_color = dye_color
			B.forceMove(loc)
			making = 0
		return


	..()


/obj/machinery/dye_generator/commercial
	name = "commercial dying machine"
	desc = "Enter your coins, card or charge cards to pay and have your clothes dyed!"

	icon_state = "commercial_dye"

	var/owner_name = ""
	var/bank_id = ""
	var/owner_uid = ""
	var/charge = 15

	var/paid = FALSE

	circuit = /obj/item/weapon/circuitboard/dye_generator/commercial

	unique_save_vars = list("dye_color", "dye_amount", "owner_name", "bank_id", "owner_uid", "charge")

/obj/machinery/dye_generator/commercial/examine(mob/user)
	..()
	if(charge)
		to_chat(user, "The usage fee for this [src] is <b>[cash2text( charge, FALSE, TRUE, TRUE )]</b>.")
	if(owner_name)
		to_chat(user, "It belongs to [owner_name], contact them for any issues.")

/obj/machinery/dye_generator/commercial/verb/set_price()
	set src in oview(1)
	set category = "Object"
	set name = "Set Dye Machine Price"

	if(usr.real_name != owner_name)
		return
	else
		var/new_charge = input(usr,"Set a fee for using the [src].","Fee", charge) as null|num

		if(!isnull(new_charge))
			if(new_charge < 0)
				charge = initial(charge)
			else
				charge = new_charge
				to_chat(usr, "\The [src] will now charge <b>[cash2text( charge, FALSE, TRUE, TRUE )]</b> per usage.")

/obj/machinery/dye_generator/commercial/attack_hand(mob/user as mob)
	src.add_fingerprint(user)
	if(stat & (BROKEN|NOPOWER))
		return

	interact(user)
	updateDialog()

/obj/machinery/dye_generator/commercial/interact(mob/user as mob)
	var/dat

	dat = get_full_data(user)

	var/datum/browser/popup = new(user, "dye_generator", "[src]", 550, 650, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "dye_generator")

/obj/machinery/dye_generator/commercial/proc/get_full_data(mob/user as mob)
	var/dat

	//title
	dat += "<b>[name]</b><br>"

	if(!owner_uid)
		dat += "Please swipe your ID to claim ownership of this machine.<br>"
		return dat

	if(!check_account_exists(bank_id))
		dat += "<i>There appears to be an issue with the payment account of this vendor. Please contact the owner.</i>"
		return dat

	dat += "The machine produces bottles of multi-purpose dye that can be used to dye clothing, materials and hair, it will dispense a bottle containing your selected dye. Please insert cash or use card to complete this process.<br>"

	if(!dye_amount)
		dat += "This machine has run out of dye, please contact the owner.<br>"
		return dat

	if(!paid)
		dat += "Please insert <b>[cash2text( charge, FALSE, TRUE, TRUE )]</b> to use this machine.<br>"

	dat += "<b>Dye Color:</b> <font face='fixedsys' size='3' color='[dye_color]'><table style='display:inline;' bgcolor='[dye_color]'><tr><td>__</td></tr></table></font> [dye_color] <br>"

	dat += "<a href='?src=\ref[src];change_dye=1'>Change Dye Color</a>"

	if(paid)
		dat += "<a href='?src=\ref[src];make_bottle=1'>Dispense Dye Bottle</a>"

	return dat


/obj/machinery/dye_generator/commercial/attackby(var/obj/item/I, var/mob/user)
	add_fingerprint(user)
	if(!paid)
		if(istype(I,/obj/item/weapon/card/id))
			var/obj/item/weapon/card/id/O = I
			if(!owner_name)
				visible_message("<span class='notice'>[usr] swipes their ID card over \the [src].</span>")
				set_new_owner(I)
				return
			else
				paid = pay_with_card(O, user)

		if(istype(I,/obj/item/weapon/spacecash))
			if(istype(I,/obj/item/weapon/spacecash/ewallet))
				var/obj/item/weapon/spacecash/ewallet/chargecard = I
				paid = pay_with_ewallet(chargecard, user)

			else
				var/obj/item/weapon/spacecash/cash = I
				paid = pay_with_cash(cash, user)

		if(paid)
			to_chat(user, "Payment accepted!")
			updateDialog()

	else
		to_chat(user, "Payment has already been accepted for the dye generator!")
		return



/obj/machinery/dye_generator/commercial/proc/pay_with_card(obj/item/weapon/card/id/I, mob/user)
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
		var/attempt_pin = input("Enter pin code", "Dye Machine Bottle Purchase") as num
		customer_account = attempt_account_access(I.associated_account_number, attempt_pin, 2)

		if(!customer_account)
			visible_message("Unable to access account: incorrect credentials.")
			return

	if(charge > customer_account.money)
		visible_message("Insufficient funds in account.")
		return

	// debit money from the purchaser's account
	customer_account.money -= charge
	customer_account.add_transaction_log("[owner_name] (via [name])", "Dye Machine Bottle Purchase", -charge, "Dye Vendor")
	charge_to_account(bank_id, "Dye Machine ([customer_account.owner_name] (via [name]))", "Dye Machine Bottle Purchase", "Dye Vendor", charge)

	return TRUE

/obj/machinery/dye_generator/commercial/proc/pay_with_cash(var/obj/item/weapon/spacecash/cashmoney, mob/user)
	if(charge > cashmoney.worth)

		// This is not a status display message, since it's something the character
		// themselves is meant to see BEFORE putting the money in
		to_chat(user, "\icon[cashmoney] <span class='warning'>That is not enough money.</span>")
		return 0

	if(istype(cashmoney, /obj/item/weapon/spacecash))

		visible_message("<span class='info'>\The [usr] inserts some cash into \the [src].</span>")
		cashmoney.worth -= charge
		charge_to_account(bank_id, "Dye Machine", "Dye Machine Bottle Purchase", "Dye Vendor", charge)

		if(cashmoney.worth <= 0)
			usr.drop_from_inventory(cashmoney)
			qdel(cashmoney)
		else
			cashmoney.update_icon()

	return TRUE

/obj/machinery/dye_generator/commercial/proc/pay_with_ewallet(var/obj/item/weapon/spacecash/ewallet/wallet, user)
	visible_message("<span class='info'>[user] swipes \the [wallet] through \the [src].</span>")
	if(charge > wallet.worth)
		visible_message("Insufficient funds on chargecard.")
		return 0
	else
		wallet.worth -= charge
		charge_to_account(bank_id, "Dye Machine", "Dye Machine Bottle Purchase", "Dye Vendor", charge)
		return TRUE

/obj/machinery/dye_generator/commercial/proc/dispense_dye_bottle()
	playsound(src.loc, 'sound/machines/reagent_dispense.ogg', 25, 1)
	sleep(10)

	var/obj/item/dye_bottle/dye = new(loc)
	dye.dye_color = dye_color
	dye.dye_uses = dye.max_dye_uses
	dye.update_dye_overlay()
	dye_amount--

	paid = FALSE


/obj/machinery/dye_generator/commercial/proc/set_new_owner(obj/item/weapon/card/id/I)
	if(!I)
		return
	owner_name = I.registered_name
	owner_uid = I.unique_ID
	bank_id = I.associated_account_number
	visible_message("<span class='info'>New owner set to '[I.registered_name]'.</span>")
	playsound(src, 'sound/machines/chime.ogg', 25)


/obj/machinery/dye_generator/commercial/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["change_dye"])
		change_dye_color(usr)

	if(href_list["make_bottle"])
		if(paid)
			dispense_dye_bottle()

	updateDialog()

/obj/item/photochromatic_dye_refill
	name = "photochromatic dye refill"
	desc = "A refillable bottle used for holding dyes of all sorts of colors."
	icon = 'icons/obj/objects.dmi'
	icon_state = "dye_refill"


//Hair Dye Bottle

/obj/item/dye_bottle
	name = "Hair Dye Bottle"
	desc = "A refillable bottle used for holding dyes of all sorts of colors."
	icon = 'icons/obj/cosmetics.dmi'
	icon_state = "hairdyebottle"
	throwforce = 0
	throw_speed = 4
	throw_range = 7
	force = 0
	w_class = 1.0
	var/dye_color = "#FFFFFF"

	var/dye_uses = 0
	var/max_dye_uses = 5
	matter = list("glass" = 20)
	unique_save_vars = list("dye_color", "dye_uses")

	price_tag = 5

/obj/item/dye_bottle/examine()
	..()

	to_chat(usr, "It has [dye_uses] uses left.")

/obj/item/dye_bottle/New()
	..()
	update_dye_overlay()

/obj/item/dye_bottle/on_persistence_load()
	update_dye_overlay()

/obj/item/dye_bottle/proc/update_dye_overlay()
	overlays.Cut()

	if(dye_uses)
		var/image/I = new('icons/obj/cosmetics.dmi', "hairdyebottle-overlay")
		I.color = dye_color
		overlays += I

/obj/item/dye_bottle/proc/use_dye()
	if(!dye_uses)
		return

	dye_uses--
	update_dye_overlay()

/obj/item/dye_bottle/afterattack(var/atom/A, var/mob/user)
	add_fingerprint(user)

	if(!dye_uses)
		to_chat(user, "<span class='notice'>There's no dye left in the bottle!</span>")
		return

	var/obj/item/clothing/WD = A
	if(istype(WD))
		WD.color = dye_color
		WD.update_icon()
		use_dye()
		return

	var/obj/structure/curtain/CU = A
	if(istype(CU))
		CU.color = dye_color
		use_dye()
		return

	var/obj/item/stack/S = A
	if(istype(S))
		if(!S.dyeable)
			to_chat(S, "<span class='notice'>It doesn't look like the machine can accept this material.</span>")
			return
		S.stack_color = dye_color
		S.update_icon()
		use_dye()
		return


/obj/item/dye_bottle/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(!dye_uses)
		to_chat(user, "<span class='notice'>There's no dye left in the bottle!</span>")
		return

	if(user.a_intent != "help")
		..()
		return
	if(!(M in view(1)))
		..()
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M

		var/dye_list = list("hair")

		if(H.gender == MALE)
			dye_list += "facial hair"

		dye_list += "highlights"


		var/what_to_dye = input(user, "Choose an area to apply the dye","Dye Application") in dye_list

		user.visible_message("<span class='notice'>[user] starts dying [M]'s [what_to_dye]!</span>", "<span class='notice'>You start dying [M]'s [what_to_dye]!</span>")
		if(do_after(user, 50, target = H))
			switch(what_to_dye)
				if("hair")
					var/r_hair = hex2num(copytext(dye_color, 2, 4))
					var/g_hair = hex2num(copytext(dye_color, 4, 6))
					var/b_hair = hex2num(copytext(dye_color, 6, 8))
					if(H.change_hair_color(r_hair, g_hair, b_hair))
						H.update_dna()
				if("facial hair")
					var/r_facial = hex2num(copytext(dye_color, 2, 4))
					var/g_facial = hex2num(copytext(dye_color, 4, 6))
					var/b_facial = hex2num(copytext(dye_color, 6, 8))
					if(H.change_facial_hair_color(r_facial, g_facial, b_facial))
						H.update_dna()
				if("highlights")
					var/new_grad_style = input(user, "Choose a color pattern for your hair:", "Character Preference", H.grad_style)  as null|anything in GLOB.hair_gradients

					var/r_grad = hex2num(copytext(dye_color, 2, 4))
					var/g_grad = hex2num(copytext(dye_color, 4, 6))
					var/b_grad = hex2num(copytext(dye_color, 6, 8))


					if(H.change_highlight_hair_color(r_grad, g_grad, b_grad, new_grad_style))
						H.update_dna()

		user.visible_message("<span class='notice'>[user] finishes dying [M]'s [what_to_dye]!</span>", "<span class='notice'>You finish dying [M]'s [what_to_dye]!</span>")
		use_dye()