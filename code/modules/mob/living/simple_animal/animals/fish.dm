// Different types of fish! They are all subtypes of this tho
/mob/living/simple_animal/fish
	name = "fish"
	desc = "Its a fishy.  No touchy fishy."
	tt_desc = "Its a fishy.  No touchy fishy."
	icon = 'icons/mob/fish.dmi'
	icon_state = "trout-dead"

	icon_gib = "generic_gib"

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/fish
	intelligence_level = SA_ANIMAL

	// By defautl they can be in any water turf.  Subtypes might restrict to deep/shallow etc
	var/global/list/suitable_turf_types =  list(
		/turf/simulated/floor/beach/water,
		/turf/simulated/floor/beach/coastline,
		/turf/simulated/floor/holofloor/beach/water,
		/turf/simulated/floor/holofloor/beach/coastline,
		/turf/simulated/floor/water
	)

// Don't swim out of the water
/mob/living/simple_animal/fish/handle_wander_movement()
	if(isturf(src.loc) && !resting && !buckled && canmove) //Physically capable of moving?
		lifes_since_move++ //Increment turns since move (turns are life() cycles)
		if(lifes_since_move >= turns_per_move)
			if(!(stop_when_pulled && pulledby)) //Some animals don't move when pulled
				var/moving_to = 0 // otherwise it always picks 4, fuck if I know.   Did I mention fuck BYOND
				moving_to = pick(cardinal)
				dir = moving_to			//How about we turn them the direction they are moving, yay.
				var/turf/T = get_step(src,moving_to)
				if(T && is_type_in_list(T, suitable_turf_types))
					Move(T)
					lifes_since_move = 0

// Take damage if we are not in water
/mob/living/simple_animal/fish/handle_breathing()
	var/turf/T = get_turf(src)
	if(T && !is_type_in_list(T, suitable_turf_types))
		if(prob(50))
			say(pick("Blub", "Glub", "Burble"))
		adjustBruteLoss(unsuitable_atoms_damage)

/mob/living/simple_animal/fish/bass
	name = "bass"
	tt_desc = "A bass of some kind."
	icon_state = "bass-swim"
	icon_living = "bass-swim"
	icon_dead = "bass-dead"
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/fish/bass

/mob/living/simple_animal/fish/trout
	name = "trout"
	tt_desc = "A trout of some kind."
	icon_state = "trout-swim"
	icon_living = "trout-swim"
	icon_dead = "trout-dead"
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/fish/trout

/mob/living/simple_mob/animal/passive/fish/salmon
	name = "salmon"
	tt_desc = "A salmon of some kind."
	icon_state = "salmon-swim"
	icon_living = "salmon-swim"
	icon_dead = "salmon-dead"
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/fish/salmon

/mob/living/simple_animal/fish/perch
	name = "perch"
	tt_desc = "A perch of some kind."
	icon_state = "perch-swim"
	icon_living = "perch-swim"
	icon_dead = "perch-dead"
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/fish/perch

/mob/living/simple_animal/fish/pike
	name = "pike"
	tt_desc = "A pike of some kind."
	icon_state = "pike-swim"
	icon_living = "pike-swim"
	icon_dead = "pike-dead"
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/fish/pike

/mob/living/simple_animal/fish/koi
	name = "koi"
	tt_desc = "Cyprinus Rubrofuscus"
	icon_state = "koi-swim"
	icon_living = "koi-swim"
	icon_dead = "koi-dead"
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/fish/piranha

/mob/living/simple_animal/fish/piranha
	name = "piranha"
	tt_desc = "Pygocentrus Nattereri"
	icon_state = "piranha-swim"
	icon_living = "piranha-swim"
	icon_dead = "piranha-dead"
	faction = "piranha"
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/fish/piranha
	hostile = TRUE
