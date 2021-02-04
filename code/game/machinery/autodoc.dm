/obj/machinery/autodoc
	var/mob/living/carbon/occupant
	var/datum/autodoc/autodoc_processor
	var/locked
	name = "Autodoc"
	icon = 'icons/obj/autodoc.dmi'
	icon_state = "powered_off"
	density = 1
	anchored = 1

	circuit = /obj/item/weapon/circuitboard/autodoc
	use_power = 1
	idle_power_usage = 60
	active_power_usage = 10000

/obj/machinery/autodoc/New()
	. = ..()
	autodoc_processor = new/datum/autodoc/capitalist_autodoc()
	autodoc_processor.holder = src

/obj/machinery/autodoc/relaymove(mob/user as mob)
	if (user.stat)
		return
	src.go_out()
	return

/obj/machinery/autodoc/verb/eject()
	set src in oview(1)
	set category = "Object"
	set name = "Eject Autodoc"

	if (usr.incapacitated())
		return
	src.go_out()
	add_fingerprint(usr)
	return

/obj/machinery/autodoc/verb/move_inside()
	set src in oview(1)
	set category = "Object"
	set name = "Enter Autodoc"

	if(usr.stat)
		return
	if(src.occupant)
		usr << SPAN_WARNING("The autodoc is already occupied!")
		return
	if(usr.abiotic())
		usr << SPAN_WARNING("The subject cannot have abiotic items on.")
		return
	set_occupant(usr)
	src.add_fingerprint(usr)
	return

/obj/machinery/autodoc/proc/go_out()
	if (!occupant || locked)
		return
	if(autodoc_processor.active)
		to_chat(usr, SPAN_WARNING("Autodoc is locked down! Abort all oberations if you need to go out or wait untill all operations would be done."))
		return
	for(var/obj/O in src)
		if(circuit && O == circuit)
			continue
		O.forceMove(loc)
	occupant.forceMove(loc)
	occupant.reset_view()
	occupant.unset_machine()
	occupant = null
	autodoc_processor.set_patient(null)
	update_use_power(1)
	update_icon()

/obj/machinery/autodoc/proc/set_occupant(var/mob/living/L)
	L.forceMove(src)
	occupant = L

	add_fingerprint(usr)
	autodoc_processor.set_patient(L)
	ui_interact(L)
	update_use_power(2)
	L.set_machine(src)

	update_icon()

/obj/machinery/autodoc/proc/put_mob(var/mob/living/carbon/target, var/mob/user)
	if (src.occupant)
		to_chat(user,SPAN_NOTICE("The autodoc is already occupied!"))
		return
	if(target.buckled)
		to_chat(user, SPAN_NOTICE("Unbuckle the subject before attempting to move them."))
		return
	if(target.abiotic())
		to_chat(user, SPAN_NOTICE("Subject cannot have abiotic items on."))
		return
	set_occupant(target)
	src.add_fingerprint(user)
	return TRUE

/obj/machinery/autodoc/MouseDrop_T(var/mob/living/carbon/target, var/mob/user)
	if(!ismob(target))
		return
	if (src.occupant)
		to_chat(user,SPAN_WARNING("The autodoc is already occupied!"))
		return
	if (target.abiotic())
		to_chat(user, SPAN_WARNING("Subject cannot have abiotic items on."))
		return
	if (target.buckled)
		to_chat(user, SPAN_NOTICE("Unbuckle the subject before attempting to move them."))
		return
	user.visible_message(
		SPAN_NOTICE("\The [user] begins placing \the [target] into \the [src]."),
		SPAN_NOTICE("You start placing \the [target] into \the [src].")
	)
	if(!do_after(user, 30, src) || !Adjacent(target))
		return
	set_occupant(target)
	src.add_fingerprint(user)
	return


/obj/machinery/autodoc/attackby(var/obj/item/weapon/G as obj, var/mob/user as mob)
	if(istype(G, /obj/item/weapon/grab))
		var/obj/item/weapon/grab/grab = G
		if(!ismob(grab.affecting))
			return
		if(occupant)
			to_chat(user,"<span class='warning'>\The [src] is already occupied by [occupant].</span>")
		if(grab.affecting.has_buckled_mobs())
			to_chat(user, span("warning", "\The [grab.affecting] has other entities attached to it. Remove them first."))
			return
		var/mob/M = grab.affecting
		qdel(grab)
		put_mob(M, user)
		return
	..()

/obj/machinery/autodoc/attack_hand(mob/user)
	if(occupant == user)
		ui_interact(occupant)
		return
	else
		// you can only operate an autodoc externally if the person inside hasn't logged in, or is knocked out/dead
		if(!autodoc_processor.patient_account || (occupant && occupant.stat))
			ui_interact(user)

	..()


/obj/machinery/autodoc/process()
	if(stat & (NOPOWER|BROKEN))
		autodoc_processor.stop()
		return
	if(occupant)
		locked = autodoc_processor.active

	update_icon()

/obj/machinery/autodoc/ui_interact(mob/user, ui_key, datum/nanoui/ui, force_open = 2, datum/topic_state/state =  default_state)
	return autodoc_processor.ui_interact(user, ui_key, ui, force_open, state)

/obj/machinery/autodoc/Topic(href, href_list)
	return autodoc_processor.Topic(href, href_list)

/obj/machinery/autodoc/update_icon()
	if(stat & (NOPOWER|BROKEN))
		icon_state = "powered_off"
	else
		icon_state = "powered_on"
	if(autodoc_processor.active)
		icon_state = "active"