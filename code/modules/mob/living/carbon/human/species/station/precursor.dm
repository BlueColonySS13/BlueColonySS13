/datum/species/precursor
	name = SPECIES_PRECURSOR
	name_plural = "Precursors"
	icobase = 'icons/mob/human_races/r_precursor.dmi'
	deform = 'icons/mob/human_races/r_def_precursor.dmi'
	default_language = LANGUAGE_PRECURSOR
	language = LANGUAGE_PRECURSOR
	species_language = LANGUAGE_PRECURSOR
	num_alternate_languages = 1
	unarmed_types = list(/datum/unarmed_attack/diona)
	rarity_value = 6
	blurb = "The Precusors were a space-faring race that dominated the Milky Way galaxy over 3 billion \
	years ago. Their numbers have been reduced to a handful that survived the Blood Wars against a powerful \
	threat from another dimension. Mankind has very little information about the Precursors and the only evidence \
	of their existence are remnants of their technology that can be found preserved on various celestial bodies or \
	floating through the endless expanse of space."

	flags = NO_SCAN | NO_SLIP | NO_MINOR_CUT | NO_HALLUCINATION | NO_INFECT

	mob_size = MOB_LARGE
	slowdown = -1

	icon_template = 'icons/mob/human_races/precursor/template.dmi'
	damage_overlays = 'icons/mob/human_races/precursor/damage_overlay.dmi'
	damage_mask = 'icons/mob/human_races/precursor/damage_mask.dmi'
	blood_mask = 'icons/mob/human_races/precursor/blood_mask.dmi'
	fire_icon_state = "generic"

	speech_bubble_appearance = "precursor"
	speech_sounds = list('sound/voice/shriek1.ogg')
	speech_chance = 25
	scream_verb = "bellows"

	death_message = "collapses into a heap and twitches before falling limp, dead and lifeless..."
	knockout_message = "collapses into a heap!"

	min_age = 8000
	max_age = 12000

	warning_low_pressure = 50
	hazard_low_pressure = -1

	body_temperature = 210

	cold_level_1 = 160
	cold_level_2 = 130
	cold_level_3 = 80

	breath_cold_level_1 = 140
	breath_cold_level_2 = 110
	breath_cold_level_3 = 60

	cold_discomfort_level = 185
	cold_discomfort_strings = list(
		"You feel chilly.",
		"You shiver suddenly.",
		"Your chilly flesh trembles."
		)

	heat_level_1 = 260
	heat_level_2 = 300
	heat_level_3 = 900
	breath_heat_level_1 = 280
	breath_heat_level_2 = 350
	breath_heat_level_3 = 1150

	heat_discomfort_level = 225
	list/heat_discomfort_strings = list(
		"You feel sweat drip down your tendrils.",
		"You feel uncomfortably warm.",
		"Your skin prickles in the heat."
		)

	siemens_coefficient = 0.55

	gluttonous = 2

	flags = NO_SCAN
	spawn_flags = SPECIES_IS_RESTRICTED | SPECIES_IS_WHITELISTED | SPECIES_NO_FBP_CONSTRUCTION | SPECIES_NO_FBP_CHARGEN
	appearance_flags = HAS_EYE_COLOR | HAS_HAIR_COLOR

	blood_color = "#2de00d"
	flesh_color = "#90edeb"

	move_trail = /obj/effect/decal/cleanable/blood/tracks/snake

	reagent_tag = IS_PRECURSOR

	has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest/precursor),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin/precursor),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/precursor),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm/precursor),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/precursor),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/precursor),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/precursor),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg/precursor),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/precursor),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/precursor),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/precursor)
	)

	has_organ = list(
		O_BRAIN =        /obj/item/organ/internal/brain/precursor,
		O_EYES =         /obj/item/organ/internal/eyes/precursor,
		O_HEART =         /obj/item/organ/internal/heart,
		O_NUTRIENT =   /obj/item/organ/internal/diona/nutrients,
		O_GBLADDER = /obj/item/organ/internal/diona/bladder
		)

	genders = list(MALE, FEMALE)
	ambiguous_genders = TRUE

/datum/species/precursor/get_random_name(var/gender)
	var/datum/language/species_language = all_languages[default_language]
	return species_language.get_random_name(gender)

/datum/species/precursor/can_breathe_water()
	return TRUE

/datum/species/precursor/hug(var/mob/living/carbon/human/H, var/mob/living/target)

	var/t_him = "them"
	if(ishuman(target))
		var/mob/living/carbon/human/T = target
		switch(T.identifying_gender)
			if(MALE)
				t_him = "him"
			if(FEMALE)
				t_him = "her"
	else
		switch(target.gender)
			if(MALE)
				t_him = "him"
			if(FEMALE)
				t_him = "her"

	H.visible_message("<span class='notice'>\The [H] wraps [target] in their tendrils to make [t_him] feel better!</span>", \
					"<span class='notice'>You warp [target] in your tendrils to make [t_him] feel better!</span>")

/datum/hud_data/precursor
	has_internals = FALSE
	gear = list(
		"l_ear" = list("loc" = ui_iclothing, "name" = "Aux Port", "slot" = slot_l_ear,   "state" = "ears", "toggle" = 1),
		"head" =  list("loc" = ui_glasses,   "name" = "Hat",      "slot" = slot_head,    "state" = "hair", "toggle" = 1),
		"back" =  list("loc" = ui_back,      "name" = "Back",     "slot" = slot_back,    "state" = "back"),
		"id" =    list("loc" = ui_id,        "name" = "ID",       "slot" = slot_wear_id, "state" = "id"),
		"belt" =  list("loc" = ui_belt,      "name" = "Belt",     "slot" = slot_belt,    "state" = "belt")
	)

