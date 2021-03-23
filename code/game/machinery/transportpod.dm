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
	var/obj/item/weapon/device/linked_remote

/obj/machinery/transportpod/New()
	..()
	name += " #[rand(000,999)]"

/obj/machinery/transportpod/president
	name = "president's ballistic transportation pod"
	req_access = list(access_president)

/obj/machinery/transportpod/government
	name = "government official's ballistic transportation pod"
	req_access = list(access_cent_general)

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

/obj/item/weapon/device/pod_recaller
	name = "ballistic transportation pod caller"
	desc = "A handheld device capable of remotely launching ballistic transportation pods."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"
	var/obj/machinery/transportpod/linked_pod

/obj/item/weapon/device/pod_recaller/New()
	for(var/obj/machinery/transportpod/P in world)
		if(!(istype(P, /obj/machinery/transportpod/president)))
			if(!P.linked_remote)
				P.linked_remote = src
				linked_pod = P
				return

/obj/item/weapon/device/pod_recaller/examine(mob/user)
	..(user)
	if(linked_pod)
		to_chat(user, "It is linked to [linked_pod].")

/obj/item/weapon/device/pod_recaller/attack_self(mob/user as mob)
	..()
	if(linked_pod)
		if(linked_pod.z != 4)
			to_chat(user, span("warning", "The linked ballistic transportation pod is already in the area and cannot be recalled!"))
			playsound(src.loc, 'sound/machines/buzz-sigh.ogg', 50, 1)
			return 0
		else
			var/turf/T = get_turf(user)
			to_chat(user, span("notice", "Your ballistic transportation pod will arrive in approximately 20 seconds."))
			spawn(rand(150,250)) //15-20 seconds to arrive
			playsound(user.loc, 'sound/effects/shuttles/hyperspace_end.ogg', 50, 1)
			linked_pod.forceMove(T)
			return 1
	else
		to_chat(user, span("warning", "Your [src] does not have a linked transportation pod!"))
		return 0

/obj/item/weapon/device/pod_recaller/president/New()
	for(var/obj/machinery/transportpod/president/P in world)
		if(!P.linked_remote)
			P.linked_remote = src
			linked_pod = P
			return