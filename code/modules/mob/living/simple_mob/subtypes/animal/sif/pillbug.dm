/mob/living/simple_mob/animal/passive/pillbug
	name = "fire bug"
	desc = "A tiny plated bug found in Pollux's volcanic regions."
	tt_desc = "S Armadillidiidae calidi"

	icon_state = "pillbug"
	icon_living = "pillbug"
	icon_dead = "pillbug_dead"

	health = 15
	maxHealth = 15
	mob_size = MOB_MINISCULE

	response_help  = "gently touches"
	response_disarm = "rolls over"
	response_harm   = "stomps on"

	armor = list(
		"melee" = 30,
		"bullet" = 10,
		"laser" = 50,
		"energy" = 50,
		"bomb" = 30,
		"bio" = 100,
		"rad" = 100
		)

	// The frostfly's body is incredibly cold at all times, natural resistance to things trying to burn it.
	armor_soak = list(
		"melee" = 10,
		"bullet" = 0,
		"laser" = 10,
		"energy" = 10,
		"bomb" = 0,
		"bio" = 0,
		"rad" = 0
		)