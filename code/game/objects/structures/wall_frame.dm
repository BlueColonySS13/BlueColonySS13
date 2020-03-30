// Basically see-through walls. Used for windows
// If nothing has been built on the low wall, you can climb on it

/obj/structure/wall_frame
	name = "low wall"
	desc = "A low wall section which serves as the base of windows, amongst other things."
	icon = 'icons/obj/wall_frame.dmi'
	icon_state = "frame"

	climbable = 1
	anchored = 1
	density = 1
	throwpass = 1
	layer = TABLE_LAYER
	color = COLOR_GUNMETAL
	var/stripe_color
	var/maxhealth = 10
	var/health = 10

	blend_objects = list(/obj/structure/window/framed, /obj/machinery/door) // Objects which to blend with
	noblend_objects = list(/obj/machinery/door/window, /obj/structure/window/framed)

	unique_save_vars = list("stripe_color", "health")

/obj/structure/wall_frame/New(var/new_loc)
	..(new_loc)

	update_connections(1)
	update_icon()

/obj/structure/wall_frame/initialize()
	. = ..()


/obj/structure/wall_frame/examine(mob/user)
	. = ..()

	if(health == maxhealth)
		to_chat(user, "<span class='notice'>It seems to be in fine condition.</span>")
	else
		var/dam = health / maxhealth
		if(dam <= 0.3)
			to_chat(user, "<span class='notice'>It's got a few dents and scratches.</span>")
		else if(dam <= 0.7)
			to_chat(user, "<span class='warning'>A few pieces of panelling have fallen off.</span>")
		else
			to_chat(user, "<span class='danger'>It's nearly falling to pieces.</span>")
	if(stripe_color)
		to_chat(user, "<span class='notice'>It has a smooth coat of paint applied.</span>")

/obj/structure/wall_frame/attackby(var/obj/item/weapon/W, var/mob/user)
	src.add_fingerprint(user)

	if(iswrench(W))
		for(var/obj/structure/S in loc)
			if(istype(S, /obj/structure/window))
				to_chat(user, "<span class='notice'>There is still a window on the low wall!</span>")
				return
			else if(istype(S, /obj/structure/grille))
				to_chat(user, "<span class='notice'>There is still a grille on the low wall!</span>")
				return
		playsound(src, W.usesound, 50, 1)
		to_chat(user, "<span class='notice'>Now disassembling the low wall...</span>")
		if(do_after(user, 40,src))
			to_chat(user, "<span class='notice'>You dissasembled the low wall!</span>")
			dismantle()


	//grille placing begin
	if(istype(W, /obj/item/stack/rods))
		var/obj/item/stack/rods/ST = W
		for(var/obj/structure/window/WINDOW in loc)
			if(WINDOW.dir == get_dir(src, user))
				to_chat(user, "<span class='notice'>There is a window in the way.</span>")
				return
		if(!in_use)
			if(ST.get_amount() < 2)
				to_chat(user, "<span class='warning'>You need at least two rods to do this.</span>")
				return
			to_chat(usr, "<span class='notice'>Assembling grille...</span>")
			ST.in_use = 1
			if (!do_after(user, 10))
				ST.in_use = 0
				return
			var/obj/structure/grille/F = new /obj/structure/grille(loc)
			to_chat(usr, "<span class='notice'>You assemble a grille</span>")
			ST.in_use = 0
			F.add_fingerprint(usr)
			ST.use(2)
		return
	//grille placing end

	//window placing begin
	else if(istype(W,/obj/item/stack/material))
		var/obj/item/stack/material/ST = W
		if(!ST.material.created_window)
			return 0

		for(var/obj/structure/window/WINDOW in loc)
			to_chat(user, "<span class='notice'>There is already a window there.</span>")
			return

		to_chat(user, "<span class='notice'>You start placing the window.</span>")
		if(do_after(user,20,src))
			for(var/obj/structure/window/WINDOW in loc)
				to_chat(user, "<span class='notice'>There is already a window there.</span>")
				return

			var/wtype = ST.material.created_window
			if (ST.use(1))
				var/obj/structure/window/WD = new wtype(loc)
				to_chat(user, "<span class='notice'>You place the [WD] on [src].</span>")
				WD.anchored = TRUE
				WD.update_icon()
		return
	//window placing end

	..()
	return

/obj/structure/wall_frame/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return 1
	if(istype(mover,/obj/item/projectile))
		return 1
	if(istype(mover) && climbable)
		return 1

// icon related

// icon related

/obj/structure/wall_frame/update_icon()
	overlays.Cut()
	var/image/I


	for(var/i = 1 to 4)
		if(other_connections[i] != "0")
			I = image('icons/obj/wall_frame.dmi', "frame_other[connections[i]]", dir = 1<<(i-1))
		else
			I = image('icons/obj/wall_frame.dmi', "frame[connections[i]]", dir = 1<<(i-1))
		overlays += I

	if(stripe_color)
		for(var/i = 1 to 4)
			if(other_connections[i] != "0")
				I = image('icons/obj/wall_frame.dmi', "stripe_other[connections[i]]", dir = 1<<(i-1))
			else
				I = image('icons/obj/wall_frame.dmi', "stripe[connections[i]]", dir = 1<<(i-1))
			I.color = stripe_color
			overlays += I

/obj/structure/wall_frame/titanium
	color = COLOR_TITANIUM

/obj/structure/wall_frame/hull
	color = COLOR_HULL

/obj/structure/wall_frame/blue
	color = COLOR_BLUE_GRAY

/*
/obj/structure/wall_frame/hull/initialize()
	. = ..()
	if(prob(40))
		var/spacefacing = FALSE
		for(var/direction in cardinal)
			var/turf/T = get_step(src, direction)
			var/area/A = get_area(T)
			if(A && (A.area_flags & AREA_FLAG_EXTERNAL))
				spacefacing = TRUE
				break
		if(spacefacing)
			var/bleach_factor = rand(10,50)
			color = adjust_brightness(color, bleach_factor)
	update_icon()
*/