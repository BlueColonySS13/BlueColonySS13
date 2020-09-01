/mob/living/simple_animal/hostile/ash_drake
	name = "creature"
	desc = "The legends foretold of their return. One word: Run."
	tt_desc = "Analysis: Run." //RUN
	icon = 'icons/mob/256x256.dmi'
	icon_state = "ashdrake"
	icon_living = "ashdrake"
	icon_dead = "ashdrake_dead"
	pixel_x = -128
	pixel_y = -128

	faction = "cult"
	intelligence_level = SA_HUMANOID
	cooperative = 1
	run_at_them = 0

	response_help = "decides against their better judgement to poke"
	response_disarm = "makes a futile attempt to shove"
	response_harm = "hits"

	maxHealth = 1000
	health = 1000
	speed = 8

	harm_intent_damage = 0
	melee_damage_lower = 30
	melee_damage_upper = 35
	attack_sharp = 4
	attack_edge = 4

	attacktext = list("slashed", "bitten", "mauled", "clawed", "brutalized", "gored")
	attack_sound = 'sound/weapons/bladeslice.ogg'
	a_intent = I_HURT

	environment_smash = 2
	status_flags = CANPUSH

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	heat_damage_per_tick = 20
	unsuitable_atoms_damage = 15