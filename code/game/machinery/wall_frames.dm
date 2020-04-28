/obj/item/frame
	name = "frame parts"
	desc = "Used for building frames."
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "frame_bitem"
	flags = CONDUCT
	var/build_machine_type
	var/refund_amt = 5
	var/refund_type = /obj/item/stack/material/steel
	var/reverse = 0 //if resulting object faces opposite its dir (like light fixtures)
	var/list/frame_types_floor
	var/list/frame_types_wall

	var/is_floor_frame = TRUE
	var/is_wall_frame = FALSE

/obj/item/frame/proc/update_type_list()
	if(!frame_types_floor)
		frame_types_floor = construction_frame_floor
	if(!frame_types_wall)
		frame_types_wall = construction_frame_wall

/obj/item/frame/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/wrench))
		new refund_type(get_turf(src.loc), refund_amt)
		qdel(src)
		return
	..()

/obj/item/frame/attack_self(mob/user as mob)
	..()
	update_type_list()
	var/datum/frame/frame_types/frame_type
	if(!build_machine_type)
		var/datum/frame/frame_types/response = input(user, "What kind of frame would you like to make?", "Frame type request", null) as null|anything in frame_types_floor
		if(!response)
			return
		frame_type = response

		build_machine_type = /obj/structure/frame

		if(frame_type.frame_size != 5)
			new /obj/item/stack/material/steel(user.loc, (5 - frame_type.frame_size))

	var/ndir
	ndir = user.dir
	if(!(ndir in cardinal))
		return

	var/obj/machinery/M = new build_machine_type(get_turf(src.loc), ndir, 1, frame_type)

	if(is_wall_frame)
		// Automatically place it in the right direction/pixel it.
		if(M.pixel_x == 0 && M.pixel_y == 0)

			var/turf/here = get_turf(M)
			var/placing = 0
			for(var/checkdir in GLOB.cardinal)
				var/turf/T = get_step(here, checkdir)
				if(T.density)
					placing = checkdir
					break
				for(var/thing in T)
					var/atom/O = thing
					if(O.simulated && !O.CanPass(src, T))
						placing = checkdir
						break
			switch(placing)
				if(NORTH)
					M.pixel_x = 0
					M.pixel_y = 30
				if(SOUTH)
					M.pixel_x = 0
					M.pixel_y = -30
				if(EAST)
					M.pixel_x = 30
					M.pixel_y = 0
				if(WEST)
					M.pixel_x = -30
					M.pixel_y = 0

	M.add_fingerprint(user)
	if(istype(src.loc, /obj/item/weapon/gripper)) //Typical gripper shenanigans
		user.drop_item()
	qdel(src)

/obj/item/frame/proc/try_build(turf/on_wall, mob/user as mob)
	update_type_list()

	if(get_dist(on_wall, user)>1)
		return

	var/ndir
	if(reverse)
		ndir = get_dir(user, on_wall)
	else
		ndir = get_dir(on_wall, user)

	if(!(ndir in cardinal))
		return

	var/turf/loc = get_turf(user)

	if(is_floor_frame && !is_wall_frame)
		if(!loc.is_floor())
			to_chat(user, "<span class='danger'>\The frame cannot be placed on this spot.</span>")
			return

	if(is_wall_frame && !is_floor_frame)
		if(!loc.is_wall())
			to_chat(user, "<span class='danger'>\The frame cannot be placed on this spot.</span>")
			return

//	if((A.requires_power == 0 || A.is_space() )&& !isLightFrame())
//		to_chat(user, "<span class='danger'>\The [src] Alarm cannot be placed in this area.</span>")
//		return

	if(gotwallitem(loc, ndir))
		to_chat(user, "<span class='danger'>There's already an item on this wall!</span>")
		return

	var/datum/frame/frame_types/frame_type
	if(!build_machine_type)
		var/datum/frame/frame_types/response = input(user, "What kind of frame would you like to make?", "Frame type request", null) as null|anything in frame_types_wall
		if(!response)
			return
		frame_type = response

		build_machine_type = /obj/structure/frame

		if(frame_type.frame_size != 5)
			new /obj/item/stack/material/steel(user.loc, (5 - frame_type.frame_size))

	var/obj/machinery/M = new build_machine_type(loc, ndir, 1, frame_type)
	M.add_fingerprint(user)

	if(is_wall_frame)
		// Automatically place it in the right direction/pixel it.
		if(M.pixel_x == 0 && M.pixel_y == 0)

			var/turf/here = get_turf(M)
			var/placing = 0
			for(var/checkdir in GLOB.cardinal)
				var/turf/T = get_step(here, checkdir)
				if(T.density)
					placing = checkdir
					break
				for(var/thing in T)
					var/atom/O = thing
					if(O.simulated && !O.CanPass(src, T))
						placing = checkdir
						break
			switch(placing)
				if(NORTH)
					M.pixel_x = 0
					M.pixel_y = 30
				if(SOUTH)
					M.pixel_x = 0
					M.pixel_y = -30
				if(EAST)
					M.pixel_x = 30
					M.pixel_y = 0
				if(WEST)
					M.pixel_x = -30
					M.pixel_y = 0

	if(istype(src.loc, /obj/item/weapon/gripper)) //Typical gripper shenanigans
		user.drop_item()
	qdel(src)

/obj/item/frame/proc/isLightFrame()
	return FALSE

/obj/item/frame/wallsafe
	name = "secure safe frame"
	desc = "A starting frame for building a secure as can be safe."
	icon = 'icons/obj/storage.dmi'
	icon_state = "safe"
	refund_amt = 3
	build_machine_type = /obj/item/weapon/storage/secure/safe
	is_wall_frame = TRUE
	is_floor_frame = FALSE

/obj/item/frame/light
	name = "light fixture frame"
	desc = "Used for building lights."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "tube-construct-item"
	refund_amt = 2	//TFF 17/1/20 - Oversight fix for infinite steel produciton.
	build_machine_type = /obj/machinery/light_construct
	is_wall_frame = TRUE
	reverse = 1

/obj/item/frame/light/isLightFrame()
	return TRUE

/obj/item/frame/light/small
	name = "small light fixture frame"
	icon_state = "bulb-construct-item"
	refund_amt = 1
	build_machine_type = /obj/machinery/light_construct/small

/obj/item/frame/light/floor
	name = "small floor fixture frame"
	icon_state = "bulb-construct-item"
	refund_amt = 1
	build_machine_type = /obj/machinery/light_construct/floor
	is_wall_frame = TRUE
	is_floor_frame = TRUE

/obj/item/frame/extinguisher_cabinet
	name = "extinguisher cabinet frame"
	desc = "Used for building fire extinguisher cabinets."
	icon = 'icons/obj/closet.dmi'
	icon_state = "extinguisher_empty"
	refund_amt = 4
	build_machine_type = /obj/structure/extinguisher_cabinet
	is_wall_frame = TRUE
	is_floor_frame = FALSE

/obj/item/frame/atm
	name = "ATM frame"
	desc = "Used for building ATMs."
	icon = 'icons/obj/terminals.dmi'
	icon_state = "atm"
	refund_amt = 4
	build_machine_type = /obj/machinery/atm
	is_wall_frame = TRUE
	is_floor_frame = FALSE

/obj/item/frame/noticeboard
	name = "noticeboard frame"
	desc = "Used for building noticeboards."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "nboard00"
	refund_amt = 4
	refund_type = /obj/item/stack/material/wood
	build_machine_type = /obj/structure/noticeboard
	is_wall_frame = TRUE
	is_floor_frame = FALSE

/obj/item/frame/mirror
	name = "mirror frame"
	desc = "Used for building mirrors."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "mirror_frame"
	refund_amt = 1
	build_machine_type = /obj/structure/mirror
	is_wall_frame = TRUE
	is_floor_frame = FALSE
	reverse = TRUE

/obj/item/frame/fireaxe_cabinet
	name = "fire axe cabinet frame"
	desc = "Used for building fire axe cabinets."
	icon = 'icons/obj/closet.dmi'
	icon_state = "fireaxe1000"
	refund_amt = 4
	build_machine_type = /obj/structure/closet/fireaxecabinet
	is_wall_frame = TRUE
	is_floor_frame = FALSE


/obj/item/frame/display_case
	name = "electronic display case frame"
	desc = "Used for building display cases."
	icon = 'icons/obj/display_case.dmi'
	icon_state = "preview"
	refund_amt = 4
	build_machine_type = /obj/machinery/electronic_display_case
	is_wall_frame = FALSE
	is_floor_frame = TRUE


/obj/item/frame/shutters
	name = "blast shutters frame"
	desc = "Used for building blast shutters."
	icon = 'icons/obj/doors/rapid_pdoor.dmi'
	icon_state = "shutter1"
	refund_amt = 4
	build_machine_type = /obj/machinery/door/blast/shutters
	is_wall_frame = FALSE
	is_floor_frame = TRUE

/obj/item/frame/weightlifter
	name = "weight lifting assembly"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "weightlifter"
	density = TRUE
	refund_amt = 3
	build_machine_type = /obj/structure/fitness/weightlifter
	is_wall_frame = FALSE
	is_floor_frame = TRUE

/obj/item/frame/shutters/regular
	name = "blast door frame"
	desc = "Used for building blast doors."
	icon = 'icons/obj/doors/rapid_pdoor.dmi'
	icon_state = "pdoor1"
	refund_amt = 4
	build_machine_type = /obj/machinery/door/blast/regular
	is_wall_frame = FALSE
	is_floor_frame = TRUE

/obj/item/frame/thick_gate
	name = "thick gate frame"
	desc = "Used for building thick gates."
	icon = 'icons/obj/doors/city_shutters.dmi'
	icon_state = "shutter1"
	refund_amt = 4
	build_machine_type = /obj/machinery/door/blast/gate
	is_wall_frame = FALSE
	is_floor_frame = TRUE

/obj/item/frame/thin_gate
	name = "thin gate frame"
	desc = "Used for building thin gates."
	icon = 'icons/obj/doors/city_shutters.dmi'
	icon_state = "shutter2_1"
	refund_amt = 4
	build_machine_type = /obj/machinery/door/blast/gate/thin
	is_wall_frame = FALSE
	is_floor_frame = TRUE

/obj/item/frame/plastic
	refund_type = /obj/item/stack/material/plastic

/obj/item/frame/plastic/sink
	name = "sink frame"
	desc = "Used for building Sinks"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "sink"
	refund_amt = 2
	build_machine_type = /obj/structure/sink
	is_wall_frame = TRUE
	is_floor_frame = FALSE

/obj/item/frame/plastic/kitchensink
	name = "kitchen Sink frame"
	desc = "Used for building Kitchen Sinks"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "sink_alt"
	refund_amt = 2
	build_machine_type = /obj/structure/sink/kitchen
	is_wall_frame = TRUE
	is_floor_frame = FALSE

/obj/item/frame/plastic/toilet
	name = "toilet frame"
	desc = "Used for making toilets."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "toilet00"
	refund_amt = 2
	build_machine_type = /obj/structure/toilet
	is_wall_frame = TRUE
	is_floor_frame = FALSE

/obj/item/frame/plastic/urinal
	name = "urinals frame"
	desc = "Used for making urinals."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "urinal"
	refund_amt = 2
	build_machine_type = /obj/structure/urinal
	is_wall_frame = TRUE
	is_floor_frame = FALSE

/obj/item/frame/plastic/shower
	name = "shower frame"
	desc = "Used for building showers"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "shower"
	refund_amt = 2
	build_machine_type = /obj/machinery/shower
	is_wall_frame = TRUE
	is_floor_frame = TRUE

/obj/item/frame/plastic/punchingbag
	name = "punching bag assembly"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "punchingbag"
	density = TRUE
	refund_amt = 3
	build_machine_type = /obj/structure/fitness/punchingbag
	is_wall_frame = FALSE
	is_floor_frame = TRUE