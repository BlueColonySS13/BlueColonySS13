/obj/item/weapon/soap
	name = "soap"
	desc = "A cheap bar of soap. Doesn't smell."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "soap"
	w_class = ITEMSIZE_SMALL
	slot_flags = SLOT_HOLSTER
	throwforce = 0
	throw_speed = 4
	throw_range = 20

	var/uses = 80

/obj/item/weapon/soap/nanotrasen
	desc = "A NanoTrasen-brand bar of soap. Smells of phoron."
	icon_state = "soapnt"

/obj/item/weapon/soap/deluxe
	icon_state = "soapdeluxe"

/obj/item/weapon/soap/deluxe/New()
	desc = "A deluxe Waffle Co. brand bar of soap. Smells of [pick("lavender", "vanilla", "strawberry", "chocolate" ,"space")]."
	..()

/obj/item/weapon/soap/syndie
	desc = "An untrustworthy bar of soap. Smells of fear."
	icon_state = "soapsyndie"
/*
 * Soap
 */
/obj/item/weapon/soap/initialize()
	. = ..()
	create_reagents(5)
	wet()

/obj/item/weapon/soap/proc/wet()
	reagents.add_reagent("cleaner", 5)

/obj/item/weapon/soap/proc/use_soap(use_amount = 1, mob/user)
	uses -= use_amount

	if(0 >= uses)
		if(user)
			to_chat(user, "<span class='notice'>You used up all the soap!</span>")
		qdel(src)
	return

/obj/item/weapon/soap/Crossed(AM as mob|obj)
	if (istype(AM, /mob/living))
		var/mob/living/M =	AM
		M.slip("the [src.name]",3)

/obj/item/weapon/soap/afterattack(atom/target, mob/user as mob, proximity)
	if(!proximity) return
	//I couldn't feasibly  fix the overlay bugs caused by cleaning items we are wearing.
	//So this is a workaround. This also makes more sense from an IC standpoint. ~Carn
	if(user.client && (target in user.client.screen))
		to_chat(user, "<span class='notice'>You need to take that [target.name] off before cleaning it.</span>")
	else if(istype(target,/obj/effect/decal/cleanable/blood))
		to_chat(user, "<span class='notice'>You scrub \the [target.name] out.</span>")
		target.clean_blood()

		use_soap(1, user)
		return	//Blood is a cleanable decal, therefore needs to be accounted for before all cleanable decals.
	else if(istype(target,/obj/effect/decal/cleanable))
		to_chat(user, "<span class='notice'>You scrub \the [target.name] out.</span>")
		qdel(target)

		use_soap(1, user)
	else if(istype(target,/turf))
		to_chat(user, "<span class='notice'>You scrub \the [target.name] clean.</span>")
		var/turf/T = target
		T.clean(src, user)

		use_soap(1, user)
	else if(istype(target,/obj/structure/sink))
		to_chat(user, "<span class='notice'>You wet \the [src] in the sink.</span>")
		wet()
	else
		to_chat(user, "<span class='notice'>You clean \the [target.name].</span>")
		target.clean_blood()
	return

//attack_as_weapon
/obj/item/weapon/soap/attack(mob/living/target, mob/living/user, var/target_zone)
	if(target && user && ishuman(target) && ishuman(user) && !user.incapacitated() && user.zone_sel &&user.zone_sel.selecting == "mouth" )
		user.visible_message("<span class='danger'>\The [user] washes \the [target]'s mouth out with soap!</span>")
		user.setClickCooldown(DEFAULT_QUICK_COOLDOWN) //prevent spam
		return
	..()