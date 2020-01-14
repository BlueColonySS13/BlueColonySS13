
/obj/item/weapon/baby
	name = "baby"
	desc = "A very, very young child. How cute."
	icon = 'icons/obj/baby.dmi'
	hitsound = 'sound/weapons/baby_cry.ogg'
	icon_state = "baby-blackeyed"
	w_class = ITEMSIZE_LARGE
	slot_flags = SLOT_BACK|SLOT_OCLOTHING

/obj/item/weapon/baby/equipped(var/mob/user, var/slot)
	switch(slot)
		if(slot_back) //Mask is the default for all the settings
			icon_state = initial(icon_state)

		if(slot_wear_suit)
			icon_state = "[initial(icon_state)]_chest"

	return ..()

/obj/item/weapon/baby/attack_self(mob/living/user as mob)
	if (user.client)
		if(user.client.prefs.muted & MUTE_IC)
			src << "\red You cannot speak in IC (muted)."
			return

	var/message = sanitize(copytext(input(user, "[name]...", "Baby Emote", null)  as text,1,MAX_MESSAGE_LEN))
	if(!message)
		return
	if ((src.loc == user && usr.stat == 0))
		for(var/mob/O in (viewers(user)))
			O.show_message("<B>[src]</B> [message]")

/obj/item/weapon/baby/verb/rename_baby()
	set name = "Rename Baby"
	set category = "Object"
	set desc = "Click to rename your baby."
	set src in usr

	var/input = sanitize(input(usr, "What do you want to name the baby?", "Rename Baby", null) as text, MAX_NAME_LEN)

	if(!input)
		return

	name = input
	return

/obj/item/weapon/baby/verb/baby_emote()
	set name = "Baby Emote"
	set category = "Object"
	set desc = "Click to have your baby perform an emote."
	set src in usr

	var/message = sanitize(copytext(input(usr, "[name]...", "Baby Emote", null)  as text,1,MAX_MESSAGE_LEN))
	if(!message)
		return
	if ((src.loc == usr && usr.stat == 0))
		for(var/mob/O in (viewers(usr)))
			O.show_message("<B>[src]</B> [message]")

/obj/item/weapon/baby/black
	icon_state = "baby-black"

/obj/item/weapon/baby/tanned
	icon_state = "baby-tanned"