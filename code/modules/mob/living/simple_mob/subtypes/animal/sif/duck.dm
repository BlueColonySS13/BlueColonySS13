// Crystal-feather "ducks" are rather weak, but will become aggressive if you have food.

/mob/living/simple_mob/animal/sif/duck
	name = "crystal-feather duck"
	desc = "A glittering flightless bird."
	tt_desc = "S Anatidae vitriae"

	faction = "duck"

	icon_state = "duck"
	icon_living = "duck"
	icon_dead = "duck_dead"
	icon = 'icons/mob/animal.dmi'
	has_eye_glow = TRUE

	maxHealth = 50
	health = 50

	movement_cooldown = 0

	melee_damage_lower = 2
	melee_damage_upper = 10
	base_attack_cooldown = 1 SECOND
	attack_edge = 1		// Razor-edged wings, and 'claws' made for digging through ice.
	attacktext = list("nipped", "bit", "cut", "clawed")

	say_list_type = /datum/say_list/duck
	ai_holder_type = /datum/ai_holder/simple_mob/retaliate/cooperative

/datum/say_list/duck
	speak = list("Wack!", "Wock?", "Wack.")
	emote_see = list("ruffles its wings","looks around", "preens itself")
	emote_hear = list("quacks", "giggles")

/mob/living/simple_mob/animal/sif/duck/IIsAlly(mob/living/L)
	. = ..()

	var/has_food = FALSE
	for(var/obj/item/I in L.get_contents())	// Do they have food?
		if(istype(I, /obj/item/weapon/reagent_containers/food))
			has_food = TRUE
			break
	if(has_food)	// Yes? Gimme the food.
		return FALSE
