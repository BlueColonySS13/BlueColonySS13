// Somewhere between a fox and a weasel. Doesn't mess with stuff significantly bigger than it, but you don't want to get on its bad side.

/mob/living/simple_mob/animal/sif/siffet
	name = "siffet"
	desc = "A small, solitary predator with silky fur. Despite its size, the Siffet is ferocious when provoked."
	tt_desc = "S Pruinaeictis velocis" //Sivian frost weasel, fast

	faction = "siffet"

	mob_size = MOB_SMALL

	icon_state = "siffet"
	icon_living = "siffet"
	icon_dead = "siffet_dead"
	icon = 'icons/mob/animal.dmi'

	maxHealth = 60
	health = 60

	movement_cooldown = 0

	melee_damage_lower = 10
	melee_damage_upper = 15
	base_attack_cooldown = 1 SECOND
	attack_sharp = 1
	attacktext = list("sliced", "snapped", "gnawed")

	say_list_type = /datum/say_list/siffet
	ai_holder_type = /datum/ai_holder/simple_mob/siffet

/datum/say_list/siffet
	speak = list("Yap!", "Heh!", "Huff.")
	emote_see = list("sniffs its surroundings","flicks its ears", "scratches the ground")
	emote_hear = list("chatters", "huffs")

/datum/ai_holder/simple_mob/siffet
	hostile = TRUE
	retaliate = TRUE

/datum/ai_holder/simple_mob/siffet/post_melee_attack(atom/A) //Evasive
	if(holder.Adjacent(A))
		holder.IMove(get_step(holder, pick(alldirs)))
		holder.face_atom(A)

/mob/living/simple_mob/animal/sif/siffet/IIsAlly(mob/living/L)
	. = ..()
	if(!. && L.mob_size > 10) //Attacks things it considers small enough to take on, otherwise only attacks if attacked.
		return TRUE