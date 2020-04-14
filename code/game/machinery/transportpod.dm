/obj/machinery/transportpod
	name = "ballistic transportation pod"
	desc = "A fast transit ballistic pod used to get from one place to the next. Batteries not included!"
	icon = 'icons/obj/structures.dmi'
	icon_state = "borg_pod_opened"

	density = 1 //thicc
	anchored = 1
	use_power = 0

	var/in_transit = 0
	var/mob/occupant = null

	var/id = null	// if an id is set, this will travel to any instance of /obj/effect/landmark/transport_location with the same id. See landmarks.dm

/obj/machinery/transportpod/president
	name = "president's ballistic transportation pod"
	req_access = list(access_president)


/obj/machinery/transportpod/relaymove(mob/user as mob)
	if(user.stat)
		return
	go_out()
	return

/obj/machinery/transportpod/update_icon()
	..()
	if(occupant)
		icon_state = "borg_pod_closed"
	else
		icon_state = "borg_pod_opened"

/obj/machinery/transportpod/Bumped(var/mob/living/O)
	go_in(O)

/obj/machinery/transportpod/proc/go_in(var/mob/living/carbon/human/O)
	if(occupant)
		return

	if(!ishuman(O))
		return

	if(O.incapacitated()) //aint no sleepy people getting in here
		return

	add_fingerprint(O)
	O.reset_view(src)
	O.forceMove(src)
	occupant = O
	update_icon()
	var/obj/effect/landmark/transport_location/teleport_to

	if(alert(O, "Do you wish to travel to a location?", , "Yes", "No") == "Yes")
		var/list/all_transports = list()
		for(var/obj/effect/landmark/transport_location/T in transports_list)
			all_transports += T.name

		var/destination = input(usr, "Where would you like to go?.", "Transport Pod") as null|anything in all_transports
		if(!destination)
			go_out()
			return
		for(var/obj/effect/landmark/transport_location/B in transports_list)
			if(destination == B.name)
				teleport_to = B

		if(!teleport_to)
			go_out()
			return

		if(!allowed(O))
			to_chat(O, "<b>You lack the access needed to ride this pod!</b>")
			go_out()
			return

		var/turf/T = get_turf(teleport_to)
		if(!T)
			go_out()
			return

		in_transit = 1
		playsound(src, HYPERSPACE_WARMUP)

		sleep(45)
		if(occupant)
			src.forceMove(T)
		sleep(10)

	go_out()
	return 1

/obj/machinery/transportpod/proc/go_out()
	if(!occupant)
		return

	occupant.forceMove(src.loc)
	occupant.reset_view()
	occupant = null
	update_icon()

/obj/machinery/transportpod/verb/move_eject()
	set category = "Object"
	set name = "Eject Pod"
	set src in oview(1)

	if(usr.incapacitated())
		return

	go_out()
	add_fingerprint(usr)
	return

/obj/machinery/transportpod/verb/move_inside()
	set category = "Object"
	set name = "Enter Pod"
	set src in oview(1)

	if(usr.incapacitated()) //just to DOUBLE CHECK the damn sleepy people don't touch the pod
		return

	go_in(usr)

