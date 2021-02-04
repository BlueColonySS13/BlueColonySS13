//Look Sir, free crabs!
/mob/living/simple_mob/animal/passive/crab
	name = "crab"
	desc = "A hard-shelled crustacean. Seems quite content to lounge around all the time."
	tt_desc = "E Cancer bellianus"
	faction = "crabs"

	icon_state = "crab"
	icon_living = "crab"
	icon_dead = "crab_dead"

	mob_size = MOB_SMALL

	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "stomps"
	friendly = "pinches"

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/crab

	say_list_type = /datum/say_list/crab

//COFFEE! SQUEEEEEEEEE!
/mob/living/simple_mob/animal/passive/crab/Coffee
	name = "Coffee"
	real_name = "Coffee"
	desc = "It's Coffee, the other pet!"

/mob/living/simple_mob/animal/passive/crab/green
	name = "mutant crab"
	desc = "This crab has an oddly green color, you usually find these in sewers."
	color = COLOR_GREEN

/mob/living/simple_mob/animal/passive/crab/sif
	icon = 'icons/mob/fish.dmi'
	tt_desc = "S Ocypode glacian"

/mob/living/simple_mob/animal/passive/crab/sif/New()
	..()
	adjust_scale(rand(5,15) / 10)

// Meat!

/obj/item/weapon/reagent_containers/food/snacks/meat/crab
	name = "meat"
	desc = "A chunk of meat."
	icon_state = "crustacean-meat"