/mob/living/simple_animal/hostile/flesh_golem
	name = "creature"
	desc = "A massive creature with exposed musculature and sinew."
	tt_desc = "A massive creature with exposed musculature and sinew."
	icon = 'icons/mob/96x96megafauna.dmi'
	icon_state = "bubblegum"
	icon_living = "bubblegum"
	icon_dead = "bubblegum"

	faction = "cult"
	intelligence_level = SA_ANIMAL
	maxHealth = 800
	health = 800
	speed = 10

	harm_intent_damage = 9

	melee_damage_lower = 13
	melee_damage_upper = 25
	attack_armor_pen = 6
	attack_sharp = 2
	attack_edge = 2

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

	attacktext = list("slammed","bashed","smashed", "clawed", "gouged")
	attack_sound = 'sound/weapons/bite.ogg'

	speak_emote = list("gutturally croaks")

	supernatural = 1

/mob/living/simple_animal/hostile/flesh_golem/Life()
	..()
	check_horde()

/mob/living/simple_animal/hostile/flesh_golem/death()
	..()
	visible_message("<b>[src]</b> explodes in spectacular fashion!")
	new /obj/effect/gibspawner/human(src.loc)
	qdel(src)