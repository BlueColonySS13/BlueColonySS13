/datum/turf_initializer/maintenance/sewer/mob_spawn()
	return /obj/random/mob/sewer


/datum/turf_initializer/maintenance/sewer/item_spawn()
	if(prob(2))
		return /obj/random/contraband
	..()