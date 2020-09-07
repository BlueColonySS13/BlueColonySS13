/obj/effect/spawner/conditional_spawn
	var/things_to_spawn = list()
	var/conditional_var_id = "" // needs portal id here. if set to "TRUE" it will spawn this item

/obj/effect/spawner/conditional_spawn/New()
	if(conditional_var_id)
		for(var/V in things_to_spawn)
			new V(loc)

	qdel(src)