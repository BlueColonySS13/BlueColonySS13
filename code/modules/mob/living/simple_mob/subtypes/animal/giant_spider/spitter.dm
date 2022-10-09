/mob/living/simple_mob/animal/giant_spider/spitter
	desc = "Slick and Black, it makes you shudder to look at it. This one has brilliant amber eyes, and a strange abdomen marking ."
	tt_desc = "X Brachypelma phorus vomitus"
	icon_state = "spitter"
	icon_living = "spitter"
	icon_dead = "spitter_dead"
	maxHealth = 90
	health = 90
	projectilesound = 'sound/effects/spray2.ogg'
	projectiletype = /obj/item/projectile/energy/neurotoxin/toxic
	base_attack_cooldown = 10
	melee_damage_lower = 8
	melee_damage_upper = 15
	poison_per_bite = 2
	poison_type = "acid"
	player_msg = "You can fire a ranged attack by clicking on an enemy or tile at a distance."
	ai_holder_type = /datum/ai_holder/simple_mob/ranged

// Check if we should acid, or just shoot the pain ball
/mob/living/simple_mob/animal/giant_spider/spitter/should_special_attack(atom/A)
	if(ismob(A))
		if(ishuman(A))
			var/mob/living/carbon/human/H = A
			if(!H.legcuffed)
				return TRUE
	return FALSE

// Now we've got a running human in sight, time to throw the bola
/mob/living/simple_mob/animal/giant_spider/spitter/do_special_attack(atom/A)
	set waitfor = FALSE
	set_AI_busy(TRUE)
	var/obj/item/projectile/energy/neurotoxin/toxic/B = new /obj/item/projectile/energy/neurotoxin/toxic(src.loc)
	playsound(src, 'sound/effects/spray2.ogg', 100, 1)
	if(!B)
		return
	B.launch(A)
	set_AI_busy(FALSE)