// Complete chumps but a little bit hardier than mice.

/mob/living/simple_mob/animal/passive/hare
	name = "ice hare"
	real_name = "ice hare"
	desc = "A small horned herbivore with a tough 'ice-like' hide."
	tt_desc = "S Lepus petropellis" //Sivian hare rockskin

	icon_state = "hare"
	icon_living = "hare"
	icon_dead = "hare_dead"
	icon_rest = "hare_rest"

	maxHealth = 20
	health = 20

	armor = list(
		"melee" = 30,
		"bullet" = 5,
		"laser" = 5,
		"energy" = 0,
		"bomb" = 10,
		"bio" = 0,
		"rad" = 0
		)

	armor_soak = list(
		"melee" = 5,
		"bullet" = 0,
		"laser" = 0,
		"energy" = 0,
		"bomb" = 0,
		"bio" = 0,
		"rad" = 0
		)

	movement_cooldown = 2

	mob_size = MOB_SMALL
	pass_flags = PASSTABLE
	layer = MOB_LAYER
	density = 0

	response_help  = "pets"
	response_disarm = "nudges"
	response_harm   = "kicks"

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat

	say_list_type = /datum/say_list/hare

/datum/say_list/hare
	speak = list("Snrf...","Crk!")
	emote_hear = list("crackles","sniffles")
	emote_see = list("stomps the ground", "sniffs the air", "chews on something")