/obj/effect/falling_effect
	name = "you should not see this"
	desc = "no data"
	invisibility = 101
	anchored = TRUE
	density = FALSE
	unacidable = TRUE
	var/falling_type = /mob/living/simple_animal/hostile/carp

/obj/effect/falling_effect/initialize(mapload, type = /mob/living/simple_animal/hostile/carp)
	..()
	falling_type = type
	return INITIALIZE_HINT_LATELOAD

/obj/effect/falling_effect/LateInitialize()
	new falling_type(src)
	var/atom/movable/dropped = pick(contents) // Stupid, but allows to get spawn result without efforts if it is other type(Or if it was randomly generated).
	dropped.loc = get_turf(src)
	var/initial_x = dropped.pixel_x
	var/initial_y = dropped.pixel_y
	dropped.plane = 1
	dropped.pixel_x = rand(-150, 150)
	dropped.pixel_y = 500 // When you think that pixel_z is height but you are wrong
	dropped.density = FALSE
	dropped.opacity = FALSE
	animate(dropped, pixel_y = initial_y, pixel_x = initial_x , time = 7)
	spawn(7)
		dropped.end_fall()
	qdel(src)

/atom/movable/proc/end_fall()
	for(var/atom/movable/AM in loc)
		if(AM != src)
			AM.ex_act(1)

	for(var/mob/living/M in oviewers(6, src))
		shake_camera(M, 2, 2)

	playsound(loc, 'sound/effects/meteorimpact.ogg', 50, 1)
	density = initial(density)
	opacity = initial(opacity)
	plane = initial(plane)

/obj/effect/falling_effect/singularity_act()
	return

/obj/effect/falling_effect/singularity_pull()
	return

/obj/effect/falling_effect/ex_act()
	return


/obj/effect/falling_effect/carpfall
	name = "space carp"

/obj/effect/falling_effect/carpfall/initialize(mapload)
	..()
	falling_type = pick(prob(75);/mob/living/simple_animal/hostile/carp/weak,
				prob(15);/mob/living/simple_animal/hostile/carp,
				prob(10);/mob/living/simple_animal/hostile/carp/large)
	return INITIALIZE_HINT_LATELOAD

/obj/effect/falling_effect/carpfall/LateInitialize()
	new falling_type(src)
	var/mob/living/simple_animal/dropped = pick(contents) // Stupid, but allows to get spawn result without efforts if it is other type(Or if it was randomly generated).
	dropped.ai_inactive = 1 //Don't fight eachother while we're still setting up!
	dropped.loc = get_turf(src)
	var/initial_x = dropped.pixel_x
	var/initial_y = dropped.pixel_y
	dropped.plane = 1
	dropped.pixel_x = rand(-150, 150)
	dropped.pixel_y = 500 // When you think that pixel_z is height but you are wrong
	dropped.density = FALSE
	dropped.opacity = FALSE
	animate(dropped, pixel_y = initial_y, pixel_x = initial_x , time = 7)
	if(prob(65))
		spawn(7)
			dropped.visible_message("<span class='danger'>\The [dropped.name] splatters on impact!</span>")
			dropped.gib()
	spawn(7)
		dropped.ai_inactive = 0 //wakey wakey
	qdel(src)


/obj/effect/falling_effect/carpfall/carpnado
	name = "space carp moving at incredibly high speed"

/obj/effect/falling_effect/carpfall/carpnado/initialize(mapload)
	..()
	falling_type = pick(prob(70);/mob/living/simple_animal/hostile/carp/weak,
				prob(19);/mob/living/simple_animal/hostile/carp,
				prob(10);/mob/living/simple_animal/hostile/carp,
				prob(1);/mob/living/simple_animal/hostile/carp/large/huge)
	return INITIALIZE_HINT_LATELOAD