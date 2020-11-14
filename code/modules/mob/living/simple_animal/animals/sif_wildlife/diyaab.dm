/mob/living/simple_animal/retaliate/diyaab
	name = "diyaab"
	desc = "A small pack animal. Although largely herbivorous, it will hunt meat on occasion."
	tt_desc = "A small pack animal."
	faction = "diyaab"
	icon_state = "diyaab"
	icon_living = "diyaab"
	icon_dead = "diyaab_dead"
	icon = 'icons/jungle.dmi'

	faction = "diyaab"
	cooperative = 1

	maxHealth = 25
	health = 25
	speed = 1
	move_to_delay = 1

	response_help = "pets"
	response_disarm = "shoves"

	melee_damage_lower = 4
	melee_damage_upper = 12
	attack_sharp = 1		//Bleeds, but it shouldn't rip off a limb?

	attacktext = list("gouged")
	cold_damage_per_tick = 0

	speak_chance = 5
	speak = list("Awrr?","Aowrl!","Worrl")
	emote_see = list("sniffs the air cautiously","looks around")
	emote_hear = list("snuffles")