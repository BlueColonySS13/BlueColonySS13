/mob/living/simple_animal/hostile/strider
	name = "creature"
	desc = "What looks to be a canine that clawed its way out from the pits of hell."
	tt_desc = "Canis Ignem" //dog fire??
	icon_state = "goliath_baby"
	icon_living = "goliath_baby"
	icon_dead = "goliath_baby_dead"

	faction = "cult"
	intelligence_level = SA_HUMANOID
	maxHealth = 60
	health = 60
	speed = 12

	turns_per_move = 5
	response_help = "pets"
	response_disarm = "shoves"
	response_harm = "hits"

	harm_intent_damage = 10

	melee_damage_lower = 10
	melee_damage_upper = 18
	attack_armor_pen = 5	//It's a horror from beyond, I ain't gotta explain 5 AP

	attacktext = list("chomps", "bites", "scratches")
	attack_sound = 'sound/hallucinations/growl1.ogg'

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 1000

	speak_chance = 0
	supernatural = 1

/mob/living/simple_animal/hostile/strider/set_target()
	. = ..()
	if(.)
		audible_emote("growls at [target_mob]")

/mob/living/simple_animal/hostile/strider/PunchTarget()
	. = ..()
	var/mob/living/L = .
	if(istype(L))
		if(prob(12))
			L.Weaken(3)
			L.visible_message("<span class='danger'>\the [src] knocks down \the [L]!</span>")

/mob/living/simple_animal/hostile/strider/Life()
	..()
	check_horde()