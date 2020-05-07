/obj/machinery/door/window
	name = "interior door"
	desc = "A strong door."
	icon = 'icons/obj/doors/windoor.dmi'
	icon_state = "left"
	var/base_state = "left"
	min_force = 4
	hitsound = 'sound/effects/Glasshit.ogg'
	maxhealth = 150 //If you change this, consiter changing ../door/window/brigdoor/ health at the bottom of this .dm file
	health = 150
	visible = 0.0
	use_power = 0
	flags = ON_BORDER
	opacity = 0
	var/obj/item/weapon/airlock_electronics/electronics = null
	explosion_resistance = 5
	air_properties_vary_with_direction = 1

/obj/machinery/door/window/New()
	..()
	update_nearby_tiles()
	if (src.req_access && src.req_access.len)
		src.icon_state = "[src.icon_state]"
		src.base_state = src.icon_state
	return

/obj/machinery/door/window/update_icon()
	if(density)
		icon_state = base_state
	else
		icon_state = "[base_state]open"

/obj/machinery/door/window/proc/shatter(var/display_message = 1)
	new /obj/item/weapon/material/shard(src.loc)
	new /obj/item/weapon/material/shard(src.loc)
	new /obj/item/stack/cable_coil(src.loc, 1)
	var/obj/item/weapon/airlock_electronics/ae
	if(!electronics)
		ae = new/obj/item/weapon/airlock_electronics( src.loc )
		if(!src.req_access)
			src.check_access()
		if(src.req_access.len)
			ae.conf_access = src.req_access
		else if (src.req_one_access.len)
			ae.conf_access = src.req_one_access
			ae.one_access = 1
	else
		ae = electronics
		electronics = null
		ae.loc = src.loc
	if(operating == -1)
		ae.icon_state = "door_electronics_smoked"
		operating = 0
	src.density = 0
	playsound(src, "shatter", 70, 1)
	if(display_message)
		visible_message("[src] shatters!")
	qdel(src)

/obj/machinery/door/window/Destroy()
	density = 0
	update_nearby_tiles()
	return ..()

/obj/machinery/door/window/Bumped(atom/movable/AM as mob|obj)
	if (!( ismob(AM) ))
		var/mob/living/bot/bot = AM
		if(istype(bot))
			if(density && src.check_access(bot.botcard) && !locked)
				open()
				sleep(50)
				close()
		else if(istype(AM, /obj/mecha))
			var/obj/mecha/mecha = AM
			if(density)
				if(mecha.occupant && src.allowed(mecha.occupant) && !locked)
					open()
					sleep(50)
					close()
		return
	if (!( ticker ))
		return
	if (src.locked)
		return
	if (src.operating)
		return
	if (src.density && src.allowed(AM))
		open()
		if(src.check_access(null))
			sleep(50)
		else //secure doors close faster
			sleep(20)
		close()
	return

/obj/machinery/door/window/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover) && mover.checkpass(PASSGLASS))
		return 1
	if(get_dir(loc, target) == dir) //Make sure looking at appropriate border
		if(air_group) return 0
		return !density
	else
		return 1

/obj/machinery/door/window/CheckExit(atom/movable/mover as mob|obj, turf/target as turf)
	if(istype(mover) && mover.checkpass(PASSGLASS))
		return 1
	if(get_dir(loc, target) == dir)
		return !density
	else
		return 1

/obj/machinery/door/window/open()
	if (operating == 1) //doors can still open when emag-disabled
		return 0
	if (!ticker)
		return 0
	if (!operating) //in case of emag
		operating = 1
	flick(text("[src.base_state]opening"), src)
	playsound(src.loc, 'sound/machines/windowdoor.ogg', 100, 1)
	sleep(10)

	explosion_resistance = 0
	density = 0
	update_icon()
	update_nearby_tiles()

	if(operating == 1) //emag again
		operating = 0
	return 1

/obj/machinery/door/window/close()
	if (operating)
		return 0
	src.operating = 1
	flick(text("[]closing", src.base_state), src)
	playsound(src.loc, 'sound/machines/windowdoor.ogg', 100, 1)

	density = 1
	update_icon()
	explosion_resistance = initial(explosion_resistance)
	update_nearby_tiles()

	sleep(10)
	operating = 0
	return 1

/obj/machinery/door/window/take_damage(var/damage)
	src.health = max(0, src.health - damage)
	if (src.health <= 0)
		shatter()
		return

/obj/machinery/door/window/attack_ai(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/door/window/attack_hand(mob/user as mob)

	if(keypad && !p_open)
		if(!istype(user, /mob/living/silicon))
			user.set_machine(src)
			var/dat = text("<TT><B>[]</B><BR>\n\nLock Status: []",src, (src.locked ? "LOCKED" : "UNLOCKED"))
			var/message = "Code"
			if((src.l_set == 0) && (!src.emagged) && (!src.l_setshort))
				dat += text("<p>\n<b>5-DIGIT PASSCODE NOT SET.<br>ENTER NEW DOOR PASSCODE.</b>")
			if(src.emagged)
				dat += text("<p>\n<font color=red><b>LOCKING SYSTE	M ERROR - 1701</b></font>")
			if(src.l_setshort)
				dat += text("<p>\n<font color=red><b>ALERT: MEMORY SYSTEM ERROR - 6040 201</b></font>")
			message = text("[]", src.code)
			if(!src.locked)
				message = "*****"
			dat += text("<HR>\n>[]<BR>\n<A href='?src=\ref[];type=1'>1</A>-<A href='?src=\ref[];type=2'>2</A>-<A href='?src=\ref[];type=3'>3</A><BR>\n<A href='?src=\ref[];type=4'>4</A>-<A href='?src=\ref[];type=5'>5</A>-<A href='?src=\ref[];type=6'>6</A><BR>\n<A href='?src=\ref[];type=7'>7</A>-<A href='?src=\ref[];type=8'>8</A>-<A href='?src=\ref[];type=9'>9</A><BR>\n<A href='?src=\ref[];type=R'>R</A>-<A href='?src=\ref[];type=0'>0</A>-<A href='?src=\ref[];type=E'>E</A><BR>\n</TT>", message, src, src, src, src, src, src, src, src, src, src, src, src)
			if(!locked)
				dat += "<BR>\n<A href='?src=\ref[src];keypad_toggleopen=1'>Toggle Open/Close</A> <A href='?src=\ref[src];keypad_lock=1'>Lock</A>"

			var/datum/browser/popup = new(user, "keypad_door", "[src]", 300, 280, src)
			popup.set_content(jointext(dat,null))
			popup.open()

			onclose(user, "keypad_door")
			return

	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		if(H.species.can_shred(H))
			playsound(src.loc, 'sound/effects/Glasshit.ogg', 75, 1)
			visible_message("<span class='danger'>[user] smashes against the [src.name].</span>", 1)
			user.do_attack_animation(src)
			user.setClickCooldown(user.get_attack_speed())
			take_damage(25)
			return
	return src.attackby(user, user)

/obj/machinery/door/window/emag_act(var/remaining_charges, var/mob/user)
	if (density && operable())
		operating = -1
		flick("[src.base_state]spark", src)
		sleep(6)
		open()
		return 1

/obj/machinery/door/window/attackby(obj/item/weapon/I as obj, mob/user as mob)

	//If it's in the process of opening/closing, ignore the click
	if (src.operating == 1)
		return

	// Fixing.
	if(istype(I, /obj/item/weapon/weldingtool) && user.a_intent == I_HELP)
		var/obj/item/weapon/weldingtool/WT = I
		if(health < maxhealth)
			if(WT.remove_fuel(1 ,user))
				to_chat(user, "<span class='notice'>You begin repairing [src]...</span>")
				playsound(src, WT.usesound, 50, 1)
				if(do_after(user, 40 * WT.toolspeed, target = src))
					health = maxhealth
					update_icon()
					to_chat(user, "<span class='notice'>You repair [src].</span>")
		else
			to_chat(user, "<span class='warning'>[src] is already in good condition!</span>")
		return

	//Emags and ninja swords? You may pass.
	if (istype(I, /obj/item/weapon/melee/energy/blade))
		if(emag_act(10, user))
			var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
			spark_system.set_up(5, 0, src.loc)
			spark_system.start()
			playsound(src.loc, "sparks", 50, 1)
			playsound(src.loc, 'sound/weapons/blade.ogg', 50, 1)
			visible_message("<span class='warning'>The glass door was sliced open by [user]!</span>")
		return 1

	//If it's opened/emagged, crowbar can pry it out of its frame.
	if (!density && istype(I, /obj/item/weapon/crowbar))
		playsound(src, I.usesound, 50, 1)
		user.visible_message("[user] begins prying the windoor out of the frame.", "You start to pry the windoor out of the frame.")
		if (do_after(user,40 * I.toolspeed))
			to_chat(user,"<span class='notice'>You pried the windoor out of the frame!</span>")

			var/obj/structure/windoor_assembly/wa = new/obj/structure/windoor_assembly(src.loc)
			if (istype(src, /obj/machinery/door/window/brigdoor))
				wa.secure = "secure_"
			if (src.base_state == "right" || src.base_state == "rightsecure")
				wa.facing = "r"
			wa.set_dir(src.dir)
			wa.anchored = 1
			wa.created_name = name
			wa.state = "02"
			wa.step = 2
			wa.update_state()

			if(operating == -1)
				wa.electronics = new/obj/item/weapon/circuitboard/broken()
			else
				if(!electronics)
					wa.electronics = new/obj/item/weapon/airlock_electronics()
					if(!src.req_access)
						src.check_access()
					if(src.req_access.len)
						wa.electronics.conf_access = src.req_access
					else if (src.req_one_access.len)
						wa.electronics.conf_access = src.req_one_access
						wa.electronics.one_access = 1
				else
					wa.electronics = electronics
					electronics = null
			operating = 0
			qdel(src)
			return

	//If it's a weapon, smash windoor. Unless it's an id card, agent card, ect.. then ignore it (Cards really shouldnt damage a door anyway)
	if(src.density && istype(I, /obj/item/weapon) && !istype(I, /obj/item/weapon/card))
		user.setClickCooldown(user.get_attack_speed(I))
		var/aforce = I.force
		playsound(src.loc, 'sound/effects/Glasshit.ogg', 75, 1)
		visible_message("<span class='danger'>[src] was hit by [I].</span>")
		if(I.damtype == BRUTE || I.damtype == BURN)
			take_damage(aforce)
		return


	add_fingerprint(user)

	if (allowed(user) && !locked)
		if (density)
			open()
		else
			close()

	else if (density)
		flick(text("[]deny", src.base_state), src)

	return



/obj/machinery/door/window/brigdoor
	name = "secure door"
	icon = 'icons/obj/doors/windoor.dmi'
	icon_state = "leftsecure"
	base_state = "leftsecure"
	req_access = list(access_security)
	var/id = null
	maxhealth = 300
	health = 300.0 //Stronger doors for prison (regular window door health is 150)

/obj/machinery/door/window/brigdoor/shatter()
	new /obj/item/stack/rods(src.loc, 2)
	..()


/obj/machinery/door/window/northleft
	dir = NORTH

/obj/machinery/door/window/eastleft
	dir = EAST

/obj/machinery/door/window/westleft
	dir = WEST

/obj/machinery/door/window/southleft
	dir = SOUTH

/obj/machinery/door/window/northright
	dir = NORTH
	icon_state = "right"
	base_state = "right"

/obj/machinery/door/window/eastright
	dir = EAST
	icon_state = "right"
	base_state = "right"

/obj/machinery/door/window/westright
	dir = WEST
	icon_state = "right"
	base_state = "right"

/obj/machinery/door/window/southright
	dir = SOUTH
	icon_state = "right"
	base_state = "right"

/obj/machinery/door/window/brigdoor/northleft
	dir = NORTH

/obj/machinery/door/window/brigdoor/eastleft
	dir = EAST

/obj/machinery/door/window/brigdoor/westleft
	dir = WEST

/obj/machinery/door/window/brigdoor/southleft
	dir = SOUTH

/obj/machinery/door/window/brigdoor/northright
	dir = NORTH
	icon_state = "rightsecure"
	base_state = "rightsecure"

/obj/machinery/door/window/brigdoor/eastright
	dir = EAST
	icon_state = "rightsecure"
	base_state = "rightsecure"

/obj/machinery/door/window/brigdoor/westright
	dir = WEST
	icon_state = "rightsecure"
	base_state = "rightsecure"

/obj/machinery/door/window/brigdoor/southright
	dir = SOUTH
	icon_state = "rightsecure"
	base_state = "rightsecure"

/obj/machinery/door/window/Topic(href, href_list)
	..()
	if((usr.stat || usr.restrained()) || (get_dist(src, usr) > 1))
		return

	if(keypad && !src.p_open)
		if((usr.stat || usr.restrained()) || (get_dist(src, usr) > 1))
			return

		src.add_fingerprint(usr)

		if(href_list["keypad_toggleopen"])
			if (src.allowed(usr))
				if (src.density)
					open()
				else
					close()


		if(href_list["keypad_lock"])
			if(locked)
				return

			locked = TRUE

		if(href_list["type"])
			playsound(src.loc, 'sound/effects/click.ogg', 100, 1)
			if(href_list["type"] == "E")
				if((src.l_set == 0) && (length(src.code) == 5) && (!src.l_setshort) && (src.code != "ERROR"))
					src.l_code = src.code
					src.l_set = 1
				else if((src.code == src.l_code) && (src.emagged == 0) && (src.l_set == 1))
					src.locked = 0
					update_icon()
				else
					src.code = "ERROR"
			else
				if((href_list["type"] == "R") && (src.emagged == 0) && (!src.l_setshort))
					src.locked = 1
					update_icon()
					src.code = null
					if(open)
						src.close(usr)
				else
					src.code += text("[]", href_list["type"])
					if(length(src.code) > 5)
						src.code = "ERROR"
					return

			for(var/mob/M in viewers(1, src.loc))
				if((M.client && M.machine == src))
					src.attack_hand(M)
				return
