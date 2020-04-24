//Meal Card Code//

/obj/item/weapon/card/foodstamp
	name = "social service card"
	desc = "An Electronic Benefits Transfer card to access social service benefits. This one is capable of contactless fund transfers."
	icon_state = "foodstamp"

	var/registered_name = "Unknown" // The name registered_name on the card
	slot_flags = SLOT_ID | SLOT_EARS
	var/assignment = null	//can be alt title or the actual job
	var/registered_user = null
	var/authorising_user
	var/meals_remaining = 3
	var/age = "\[UNSET\]"
	var/blood_type = "\[UNSET\]"
	var/dna_hash = "\[UNSET\]"
	var/fingerprint_hash = "\[UNSET\]"
	var/sex = "\[UNSET\]"
	var/icon/front
	var/icon/side

	var/locked = FALSE

/obj/item/weapon/card/foodstamp/initialize()
	..()
	meals_remaining = FOODSTAMP_MEALS

/obj/item/weapon/card/foodstamp/proc/update_name()
	name = "[registered_name]'s social service card"

//Data for Examine is stored here
/obj/item/weapon/card/foodstamp/proc/dat()
	var/dat = ("<table><tr><td>")
	dat += text("Name: []</A><BR>", registered_name)
	dat += text("Sex: []</A><BR>\n", sex)
	dat += text("Age: []</A><BR>\n", age)
	dat += text("Job: []</A><BR>\n", assignment)
	dat += text("Fingerprint: []</A><BR>\n", fingerprint_hash)
	dat += text("Blood Type: []<BR>\n", blood_type)
	dat += text("DNA Hash: []<BR><BR>\n", dna_hash)
	if(front && side)
		dat +="<td align = center valign = top>Photo:<br><img src=front.png height=80 width=80 border=4><img src=side.png height=80 width=80 border=4></td>"
	dat += "</tr></table>"
	return dat

/obj/item/weapon/card/foodstamp/proc/show(mob/user as mob)
	if(front && side)
		user << browse_rsc(front, "front.png")
		user << browse_rsc(side, "side.png")
	var/datum/browser/popup = new(user, "idcard", name, 600, 250)
	popup.set_content(dat())
	popup.set_title_image(usr.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()
	return

//Shows SS Card details - Examine
/obj/item/weapon/card/foodstamp/examine(mob/user)
	set src in oview(1)
	if(in_range(usr, src))
		show(usr)
		usr << desc
	else
		usr << "<span class='warning'>It is too far away.</span>"


//Read the SS Card's information
/obj/item/weapon/card/foodstamp/verb/read_meal_card()
	set name = "Read Social Service Card"
	set category = "Object"
	set src in usr

	if(registered_name)
		to_chat(usr, "This card was validated by [authorising_user].")
		to_chat(usr, "This card is registered to [registered_name].")
		to_chat(usr, "There are [meals_remaining] remaining meals on the card.")
	else
		to_chat(usr, "The card is blank.")
	return

/obj/item/weapon/card/foodstamp/attack_self(mob/user as mob)
	// We use the fact that registered_name is not unset should the owner be vaporized, to ensure the id doesn't magically become unlocked.
	if(locked)
		if(!registered_user && register_user(user))
			to_chat(user, "<span class='notice'>The microscanner marks you as a registered social service provider, preventing others from editing its information.</span>")
			show(user)
	else
		ui_interact(user)
	..()

/obj/item/weapon/card/foodstamp/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/data[0]
	var/entries[0]
	entries[++entries.len] = list("name" = "Lock",	"value" = "Lock Card")
	entries[++entries.len] = list("name" = "Meals Remaining",	"value" = meals_remaining)
	entries[++entries.len] = list("name" = "Factory Reset",	"value" = "Use With Care")
	data["entries"] = entries

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "social_service_card.tmpl", "Social Service Card", 600, 400)
		ui.set_initial_data(data)
		ui.open()

/obj/item/weapon/card/foodstamp/proc/register_user(var/mob/user)

	var/obj/item/weapon/card/id/I = user.GetIdCard()
	if(!I || !I.registered_name)
		to_chat(user, "You need a valid ID in order to register this social services ID card.")
		return

	src.age = I.age
	src.sex = I.sex
	src.blood_type = I.blood_type
	src.fingerprint_hash = I.fingerprint_hash
	src.dna_hash = I.dna_hash
	src.registered_name = I.registered_name
	src.assignment = I.assignment
	src.front = I.front
	src.side = I.side
	to_chat(user, "<span class='notice'>The microscanner activates as you pass it over the ID, copying its details.</span>")

	registered_user = user.name

	update_name()
	return TRUE

/obj/item/weapon/card/foodstamp/proc/unset_registered_user(var/mob/user)
	if(!registered_user || (user && user != registered_user))
		return
	registered_user = null

/obj/item/weapon/card/foodstamp/CanUseTopic(mob/user)
	if(registered_user)
		return STATUS_CLOSE
	return ..()

/obj/item/weapon/card/foodstamp/Topic(href, href_list, var/datum/topic_state/state)
	if(..())
		return 1

	var/mob/user = usr
	if(href_list["set"])
		switch(href_list["set"])
			if("Lock")
				var/lock_status = alert("Lock this card? This cannot be undone.", "Lock Card", "Yes", "No")
				if(lock_status == "Yes")
					to_chat(user, "<span class='notice'>This card has now been locked.</span>")
					authorising_user = usr.name
					locked = TRUE

			if("Meals Remaining")
				var/new_meals_remaining = input(user,"How many meals would you like to put on this card?","Remaining Meals", meals_remaining) as null|num
				if(!isnull(new_meals_remaining) && CanUseTopic(user, state))
					if(new_meals_remaining < 0)
						meals_remaining = initial(meals_remaining)
					else
						meals_remaining = new_meals_remaining
					user << "<span class='notice'>Remaining meals has been set to '[meals_remaining]'.</span>"
					. = 1

			if("Factory Reset")
				if(alert("This will factory reset the card, including access and owner. Continue?", "Factory Reset", "No", "Yes") == "Yes" && CanUseTopic(user, state))
					age = initial(age)
					assignment = initial(assignment)
					name = initial(name)
					blood_type = initial(blood_type)
					dna_hash = initial(dna_hash)
					sex = initial(sex)
					fingerprint_hash = initial(fingerprint_hash)
					registered_name = initial(registered_name)
					front = initial(front)
					side = initial(side)
					unset_registered_user()
					user << "<span class='notice'>All information has been deleted from \the [src].</span>"
					. = 1

	// Always update the UI, or buttons will spin indefinitely
	SSnanoui.update_uis(src)


