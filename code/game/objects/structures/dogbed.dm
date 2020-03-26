/obj/structure/dogbed
	name = "pet bed"
	desc = "A bed made especially for dogs, or other similarly sized pets."
	icon = 'icons/obj/furniture.dmi'
	icon_state = "dogbed"
	can_buckle = 1
	buckle_dir = SOUTH
	buckle_lying = 1
	burn_state = 0 //Burnable
	burntime = SHORT_BURN

/obj/structure/dogbed/initialize()
	..()
	// if you map an animal on top of a dog bed, it should stay here and stop dirtying the office.
	for(var/M in get_turf(src))
		buckle_mob(M)