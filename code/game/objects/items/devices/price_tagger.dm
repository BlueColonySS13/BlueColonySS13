/obj/item/device/price_tagger
	name = "price tagger"
	icon = 'icons/obj/device.dmi'
	icon_state = "price_tagger"
	desc = "Allows you to set a price on a specific item. You can toggle the setting on it to allow it to add or remove certain things."

	var/set_price = 0		// Things are free, by default?

	var/on = TRUE
	var/scan_sound = 'sound/effects/checkout.ogg'

	unique_save_vars = list("set_price", "on")

/obj/item/device/price_tagger/verb/set_pricing()
	set name = "Set Pricing"
	set desc = "Set a price for a specific object."
	set category = "Object"
	set src in usr

	change_pricing()

/obj/item/device/price_tagger/verb/set_toggle_status()
	set name = "Toggle Status"
	set desc = "Toggle the tagger off or on."
	set category = "Object"
	set src in usr

	change_toggle()



/obj/item/device/price_tagger/attack_self(mob/user)
	change_pricing(user)


/obj/item/device/price_tagger/proc/change_toggle(mob/user)
	if(user.incapacitated())
		return

	on = !on
	if(on)
		to_chat(user, "<span class='notice'>You turn \the [src] on.</span>")
	else
		to_chat(user, "<span class='notice'>You turn \the [src] off.</span>")

/obj/item/device/price_tagger/proc/change_pricing(mob/user)

	if(user.incapacitated())
		return

	var/price_setting = input("Select a decal.") as null|anything in list("Set Price", "Remove Price Tag", "Toggle Status")

	switch(price_setting)
		if("Set Price")
			set_price = input("Input a new price (Inputting 0 will make the item free).") as num
			to_chat(user, "You set [src]'s price setting to <b>[cash2text( set_price, FALSE, TRUE, TRUE )]</b>.")
			return

		if("Remove Price Tag")
			set_price = null
			to_chat(user, "You clear the price setting. Cash systems will now attempt to auto-detect an object's value.")
			return

		if("Toggle Status")
			change_toggle(user)
			return



/obj/item/device/price_tagger/afterattack(var/atom/A, var/mob/user, proximity, params)
	if(!on)
		return

	if(!proximity)
		return

	add_fingerprint(user)


	if(!istype(A, /obj/))
		return

	var/obj/O = A


	if(istype(A.loc, /mob/))
		to_chat(usr, "You need to set [O] down before it can be labelled!")
		return
		
	if(0 > set_price)	// no negative pricing
		return

	O.tagged_price = set_price

	if(set_price)
		to_chat(usr, "You set the value of [O] to <b>[cash2text( set_price, FALSE, TRUE, TRUE )]</b>")
	else
		to_chat(usr, "You remove the digital price tag on [O].")

	playsound(src, scan_sound, 25)

/obj/item/device/price_scanner
	name = "price scanner"
	desc = "Using an up-to-date database of various costs and prices, this device estimates the market price of an item up to 0.001% accuracy."
	icon_state = "price_scanner"
	origin_tech = list(TECH_MATERIAL = 6)
	var/scan_sound = 'sound/effects/checkout.ogg'
	var/on = TRUE

/obj/item/device/price_scanner/attack_self(mob/user)
	if(user.incapacitated())
		return

	on = !on
	if(on)
		to_chat(user, "<span class='notice'>You turn \the [src] on.</span>")
	else
		to_chat(user, "<span class='notice'>You turn \the [src] off.</span>")


/obj/item/device/price_scanner/afterattack(atom/movable/target, mob/user)
	if(!on)
		return

	user.show_message("\The [target]: [cash2text( target.get_item_cost(), FALSE, TRUE, TRUE )]")
	playsound(src, scan_sound, 25)
