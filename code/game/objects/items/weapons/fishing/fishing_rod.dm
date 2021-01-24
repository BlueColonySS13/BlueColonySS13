
/obj/item/weapon/material/fishing_rod
	name = "crude fishing rod"
	desc = "A crude rod made for catching fish."
	description_info = "A tool usable on water-tiles to attempt to catch fish by swiping it over them.\
	You can add or remove cable by wirecutter or coil respectively to allow its use.\
	Any food containing things like protein, sugar, or standard nutriment can be attached to the rod, allowing for faster fishing based on the amount.\
	You can examine the rod to check if it has bait attached, and examine it automatically if so.\
	\
	Ctrl clicking the rod will remove any attached bait from the rod."
	description_antag = "Some fishing rods can be utilized as long-range, sharp weapons, though their pseudo ranged ability comes at the cost of slow speed."
	icon_state = "fishing_rod"
	item_state = "fishing_rod"
	force_divisor = 0.25
	throwforce = 7
	sharp = TRUE
	attack_verb = list("whipped", "battered", "slapped", "fished", "hooked")
	hitsound = 'sound/weapons/punchmiss.ogg'
	applies_material_colour = TRUE
	default_material = "wood"
	can_dull = FALSE
	var/strung = TRUE
	var/line_break = TRUE

	var/obj/item/weapon/reagent_containers/food/snacks/Bait
	var/bait_type = /obj/item/weapon/reagent_containers/food/snacks

	var/cast = FALSE

	attackspeed = 3 SECONDS

/obj/item/weapon/material/fishing_rod/built
	strung = FALSE

/obj/item/weapon/material/fishing_rod/examine(mob/M as mob)
	..()
	if(Bait)
		to_chat(M, "<span class='notice'>\The [src] has \the [Bait] hanging on its hook.</span>")
		Bait.examine(M)

/obj/item/weapon/material/fishing_rod/CtrlClick(mob/user)
	if((src.loc == user || Adjacent(user)) && Bait)
		Bait.forceMove(get_turf(user))
		to_chat(user, "<span class='notice'>You remove the bait from \the [src].</span>")
		Bait = null
	else
		..()

/obj/item/weapon/material/fishing_rod/New()
	..()
	update_icon()

/obj/item/weapon/material/fishing_rod/attackby(obj/item/I as obj, mob/user as mob)
	if(I.is_wirecutter() && strung)
		strung = FALSE
		to_chat(user, "<span class='notice'>You cut \the [src]'s string!</span>")
		update_icon()
		return
	else if(istype(I, /obj/item/stack/fishing_line) && !strung)
		var/obj/item/stack/fishing_line/F = I
		if(F.amount < 5)
			to_chat(user, "<span class='warning'>You do not have enough length in \the [F] to string this!</span>")
			return
		if(do_after(user, rand(10 SECONDS, 20 SECONDS)))
			F.use(5)
			strung = TRUE
			to_chat(user, "<span class='notice'>You re-string \the [src]!</span>")
			update_icon()
			return
	else if(istype(I, bait_type))
		if(Bait)
			Bait.forceMove(get_turf(user))
			to_chat(user, "<span class='notice'>You swap \the [Bait] with \the [I].</span>")
		Bait = I
		user.drop_from_inventory(Bait)
		Bait.forceMove(src)
		update_bait()
	return ..()

/obj/item/weapon/material/fishing_rod/update_icon()
	overlays.Cut()
	..()
	if(strung)
		overlays += image(icon, "[icon_state]_string")

/obj/item/weapon/material/fishing_rod/proc/update_bait()
	if(istype(Bait, bait_type))
		var/foodvolume
		for(var/datum/reagent/re in Bait.reagents.reagent_list)
			if(re.id == "nutriment" || re.id == "protein" || re.id == "glucose")
				foodvolume += re.volume

		toolspeed = initial(toolspeed) * min(0.75, (0.5 / max(0.5, (foodvolume / Bait.reagents.maximum_volume))))

	else
		toolspeed = initial(toolspeed)

/obj/item/weapon/material/fishing_rod/proc/consume_bait()
	if(Bait)
		qdel(Bait)
		Bait = null
		return TRUE
	return FALSE

/obj/item/weapon/material/fishing_rod/attack(var/mob/M as mob, var/mob/user as mob, var/def_zone)
	if(cast)
		to_chat(user, "<span class='notice'>You cannot cast \the [src] when it is already in use!</span>")
		return FALSE
	update_bait()
	return ..()

/obj/item/weapon/material/fishing_rod/modern
	name = "fishing rod"
	desc = "A refined rod for catching fish."
	icon_state = "fishing_rod_modern"
	item_state = "fishing_rod"
	reach = 4
	attackspeed = 2 SECONDS
	default_material = "titanium"

	toolspeed = 0.85

/obj/item/weapon/material/fishing_rod/modern/built
	strung = FALSE

/obj/item/weapon/material/fishing_rod/pro
	name = "fishmaster pro series 6000"
	desc = "The pinnacle of fishing rod technology."
	icon_state = "fishing_rod_pro"
	item_state = "fishing_rod"
	reach = 4
	attackspeed = 2 SECONDS
	default_material = "plasteel"

	toolspeed = 0.75

/obj/item/stack/fishing_line
	name = "fishing line"
	desc = "Line used for fishing rods."
	icon = 'icons/obj/power.dmi'
	icon_state = "coil"
	amount = 15
	max_amount = 15
	w_class = ITEMSIZE_SMALL
	throw_speed = 2
	throw_range = 5
	slot_flags = SLOT_BELT
	item_state = "coil"
	attack_verb = list("whipped", "lashed", "disciplined", "flogged")
	stacktype = /obj/item/stack/fishing_line
	drop_sound = 'sound/items/drop/accessory.ogg'

/obj/item/stack/fishing_line/suicide_act(mob/user)
	var/datum/gender/TU = gender_datums[user.get_visible_gender()]
	if(locate(/obj/item/weapon/stool) in user.loc)
		user.visible_message("<span class='suicide'>[user] is making a noose with the [src.name]! It looks like [TU.he] [TU.is] trying to commit suicide.</span>")
	else
		user.visible_message("<span class='suicide'>[user] is strangling [TU.himself] with the [src.name]! It looks like [TU.he] [TU.is] trying to commit suicide.</span>")
	return(OXYLOSS)