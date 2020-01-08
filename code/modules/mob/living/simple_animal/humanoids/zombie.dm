/mob/living/simple_animal/hostile/zombie
	name = "zombie"
	desc = "Looks like just another night-shift worker, nothing to be worried about. Righ?"
	icon_state = "zombie"
	icon_living = "zombie"

	faction =  "zombie"

	attacktext = list("bitten")

	maxHealth = 75
	health = 75

	run_at_them = 1

	harm_intent_damage = 4
	melee_damage_lower = 12
	melee_damage_upper = 12

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0

	var/corpse = /obj/effect/landmark/mobcorpse/zombie

	emote_hear = list("drools", "blinks lazily")
	emote_see = list("growls","screams")

/mob/living/simple_animal/hostile/zombie/death()
	..()
	if(corpse)
		new corpse (src.loc)
	qdel(src)
	return

/mob/living/simple_animal/hostile/zombie/PunchTarget()
	if(!Adjacent(target_mob))
		return

	custom_emote(1, pick( list("slashes at [target_mob]", "bites [target_mob]") ) )

	var/damage = rand(melee_damage_lower, melee_damage_upper)

	if(ishuman(target_mob))
		var/mob/living/carbon/human/H = target_mob
		var/dam_zone = pick(BP_TORSO, BP_L_HAND, BP_R_HAND, BP_L_LEG, BP_R_LEG)
		var/obj/item/organ/external/affecting = H.get_organ(ran_zone(dam_zone))
		H.apply_damage(damage, BRUTE, affecting, H.run_armor_check(affecting, "melee"), H.get_armor_soak(affecting, "melee"))
		var/infection_chance = 20
		var/armor = H.run_armor_check(affecting,"melee")
		infection_chance = infection_chance - armor
		if(prob(infection_chance))
			if(H.reagents)
				H.reagents.add_reagent("trioxin", 10)
		return H
	else if(isliving(target_mob))
		var/mob/living/L = target_mob
		L.adjustBruteLoss(damage)
		return L
	else
		..()