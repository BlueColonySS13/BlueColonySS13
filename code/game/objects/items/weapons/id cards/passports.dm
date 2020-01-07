//passports are merely fluff, for now...

/obj/item/weapon/passport
	name = "passport"
	desc = "This is an electronic passport that allows you to travel between colonies."
	icon = 'icons/obj/passport.dmi'
	icon_state = "passport"

	var/forged = FALSE
	var/citizenship = "Vetra"	// other options
	var/owner = "the owner"

	var/edits_left = 1

/obj/item/weapon/passport/examine(mob/user)
	..()
	if(in_range(user, src) || istype(user, /mob/observer/dead))
		show_passport(usr)
	else
		to_chat(user, "<span class='notice'>You have to go closer if you want to read it.</span>")
	return


/obj/item/weapon/passport/proc/show_passport(mob/user)
	to_chat(user, "This is [name] that shows that [owner] was born in [citizenship].")
	if(forged)
		to_chat(user, "The holographic seal appears strangely duller than usual.")

/mob/proc/update_passport(var/obj/item/weapon/passport/pass)
	if(pass.citizenship == "Unset") pass.citizenship = "Vetra" //Defaults unset birth systems to a vetra passport. Otherwise, it will say "X was born in Unset".

	if(pass.citizenship == "Andromeda") icon_state = "androgov_passport"  //Matches icon to location
	else if(pass.citizenship == "Vetra") icon_state = "polgov_passport"
	else if(pass.citizenship == "Sol") icon_state = "solgov_passport"
	else if(pass.citizenship == "Cobrastan") icon_state = "cobrastan_passport" //a cheeky little easter egg for fans of Papers, Please
	else icon_state = "passport"

/obj/item/weapon/passport/attack_self(mob/user as mob)

	if(forged && edits_left)
		src.owner = sanitize(copytext(input(usr, "Enter your desired name (You can only change this once!)", "Owner Name", null)  as text,1,30))
		src.citizenship = sanitize(copytext(input(usr, "Enter your desired birthplace (You can only change this once!)", "Birthplace", null)  as text,1,30))
		src.name = "[owner]'s passport"
		if(src.citizenship == "Cobrastan")
			src.desc = "This is an electronic passport that allows you to travel between colonies. The serial number is 1234-OKOK."
		user.update_passport(src)
		edits_left = 0
	else
		user.visible_message("\The [user] flashes their passport. It shows that [owner] was born in [citizenship].",\
			"You flash your passport. It shows that [owner] was born in [citizenship].")

		src.add_fingerprint(user)
		return

//Antag options - Forgery
/obj/item/weapon/passport/emag_act(var/remaining_charges, var/mob/user)
	if(!forged)
		user.visible_message("<span class='warning'>\The [user] does something to \the [src], causing the passport to flash!</span>",\
			"<span class='warning'>You unlock the passport's editing subroutine.</span>")
		forged = 1

	if(forged)
		to_chat(user, "<span class='warning'>You have already emagged \the [src]!")

/******************************************************************
  Temporary passports in case it gets lost, destroyed, or stolen.
******************************************************************/
/obj/item/weapon/passport/temporary
	name = "blank temporary passport"
	desc = "This is an electronic temporary passport issued to those who have lost theirs. It only allows you to travel within your birth colony."
	icon_state = "temporary"
	var/registered_user = null

/obj/item/weapon/passport/temporary/attack_self(mob/user as mob)
	if(!registered_user)
		user.visible_message("\The [user] places their fingerprint on \the [src.name]'s scanner.",\
			"<span class='notice'>The microscanner scans your identity and automatically updates \the [src.name]'s details.</span>")
		src.registered_user = user
		src.owner = user.real_name
		src.name = "[owner]'s temporary passport"
		src.citizenship = user.mind.prefs.home_system
		if(src.citizenship == "Unset") src.citizenship = "Vetra"

	else if(forged && edits_left)
		src.owner = sanitize(copytext(input(usr, "Enter your desired name (You can only change this once!)", "Owner Name", null)  as text,1,30))
		src.citizenship = sanitize(copytext(input(usr, "Enter your desired birthplace (You can only change this once!)", "Birthplace", null)  as text,1,30))
		src.name = "[owner]'s temporary passport"
		edits_left = 0

	else
		user.visible_message("\The [user] flashes their temporary passport. It shows that [owner] was born in [citizenship].",\
			"You flash your temporary passport. It shows that [owner] was born in [citizenship].")

		src.add_fingerprint(user)
		return


/obj/item/weapon/passport/temporary/emag_act(var/remaining_charges, var/mob/user)
	if(!registered_user)
		to_chat(user, "<span class = 'notice'>Emagging \the [src.name] would be useless before activating it!</span>")
		return

	if(!forged)
		user.visible_message("<span class='warning'>\The [user] does something to \the [src], causing the passport to flash!</span>",\
			"<span class='warning'>You unlock the temporary passport's editing subroutine.</span>")
		forged = 1

	if(forged)
		to_chat(user, "<span class='warning'>You have already emagged \the [src]!")

/***************************************************************************************************************************
  Diplomat's passport for events and what-not. May be useful if our lawmakers rule that diplomats have diplomatic immunity.
***************************************************************************************************************************/
/obj/item/weapon/passport/temporary/diplomat
	name = "blank diplomatic passport"
	desc = "This is an electronic passport that allows you to travel between colonies. This one has a diplomatic seal."
	icon_state = "diplomat"
	var/source_colony = null

/obj/item/weapon/passport/temporary/diplomat/attack_self(mob/user as mob)
	if(!registered_user)
		user.visible_message("\The [user] places their fingerprint on \the [src.name]'s scanner.",\
			"<span class='notice'>The microscanner scans your identity and automatically updates \the [src.name]'s details.</span>")
		src.registered_user = user
		src.owner = user.real_name
		src.name = "[owner]'s temporary passport"
		src.citizenship = user.mind.prefs.home_system
		if(src.citizenship == "Unset") src.citizenship = "Vetra"
		src.source_colony = sanitize(copytext(input(usr, "Enter the colony you represent.", "Representative Colony", null)  as text,1,30))
	else
		user.visible_message("\The [user] flashes their diplomatic passport. It shows that [owner] was born in [citizenship]. They are a diplomat for [source_colony]",\
			"You flash your diplomatic passport. It shows that [owner] was born in [citizenship]. [owner] is a diplomat for [source_colony].")

		src.add_fingerprint(user)
		return

/obj/item/weapon/passport/temporary/diplomat/emag_act(var/remaining_charges, var/mob/user)
	to_chat(user, "<span class='warning'>The [src] has heavily encrypted subroutines, preventing you from emagging it!")
	return