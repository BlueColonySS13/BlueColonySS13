GLOBAL_LIST_INIT(metal_detector_items, typecacheof(list(
	/obj/item/weapon/gun,
	/obj/item/weapon/material,
	/obj/item/weapon/melee,
	/obj/item/device/transfer_valve,
	/obj/item/weapon/grenade/,
	/obj/item/ammo_casing/,
	/obj/item/ammo_magazine
	)))

/obj/machinery/metal_detector
	name = "metal detector"
	desc = "An advanced metal detector used to detect weapons."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "metal_detector"
	anchored = TRUE
	req_one_access = list(access_security, access_judge, access_heads, access_bodyguard)
	idle_power_usage = 100

	plane = MOB_PLANE
	layer = ABOVE_MOB_LAYER

/obj/machinery/metal_detector/New() //TODO: Convert all machinery to use Initialize. Christ.
	..()
	component_parts = list()
	component_parts += new /obj/item/weapon/circuitboard/metal_detector(src)
	component_parts += new /obj/item/weapon/stock_parts/scanning_module(src)
	component_parts += new /obj/item/weapon/stock_parts/scanning_module(src)
	component_parts += new /obj/item/weapon/stock_parts/scanning_module(src)
	component_parts += new /obj/item/weapon/stock_parts/console_screen(src)
	RefreshParts()

/obj/machinery/metal_detector/examine(mob/user)
	if((stat & NOPOWER))
		to_chat(user, "An advanced metal detector used to detect weapons. It is currently unpowered.")
	else if((stat & BROKEN))
		to_chat(user, "An advanced metal detector used to detect weapons. It seems to be broken.")
	else
		to_chat(user, "An advanced metal detector used to detect weapons.")

/obj/machinery/metal_detector/attackby(obj/item/W, mob/usr)

	if(default_deconstruction_screwdriver(usr, W))
		return

	if(default_deconstruction_crowbar(usr, W))
		return
	
	..()

/obj/machinery/metal_detector/Crossed(var/mob/living/M)
	..()

	if((stat & (NOPOWER|BROKEN)))
		return

	if(!istype(M))
		return
	if(allowed(M))
		return

	var/list/items_to_check = M.GetAllContents()
	for(var/A in items_to_check)
		if(is_type_in_typecache(A, GLOB.metal_detector_items))
			trigger_alarm()
			break

/obj/machinery/metal_detector/proc/trigger_alarm()
	use_power(100)
	flick("metal_detector_anim", src)
	visible_message("<span class='danger'>\The [src] sends off an alarm!</span>")
	playsound(src, 'sound/machines/alarm4.ogg', 60, 1)
