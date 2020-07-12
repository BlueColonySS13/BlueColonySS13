/datum/turf_initializer/mines/InitializeTurf(var/turf/simulated/T)
	if(istype(T, /turf/simulated/mineral))
		sort_mines(T)
		return
	if(prob(20) && istype(T, /turf/simulated/floor/tiled))
		new /obj/effect/floor_decal/rust(T)

/datum/turf_initializer/mines/proc/sort_mines(var/turf/simulated/T)

	var/turf/simulated/mineral/M = T

	if(!M.ignore_mapgen)
		if(M.density)
			if(prob(5))
				M.make_floor()
		else
			if(prob(5))
				M.make_wall()

		if(M.density)
			//determining if this is going to be an ore rock
			if(prob(15))
				//if this IS an ore rock, it will likely be a common mineral, otherwise it will be a rare one.
				if(prob(90))
					M.make_ore()
				else
					M.make_ore(1)

		else
			if(prob(1))
				new /obj/machinery/crystal(M)
