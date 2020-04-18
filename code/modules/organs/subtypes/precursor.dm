/obj/item/organ/external/chest/precursor
	name =                    "tendril junction"
	amputation_point =        "axis"
	joint =                   "central axis"
	icon_name = "torso"
	w_class =                 ITEMSIZE_LARGE
	body_part =               LOWER_TORSO
	parent_organ =            BP_TORSO
	dislocated =              -1
	max_damage =              50
	min_broken_damage =       25
	encased = "ceramic hull"

/obj/item/organ/external/groin/precursor
	name =                    "trailing tendrils"
	icon_name = "groin"
	joint =                   "base"
	dislocated =              -1
	max_damage =              50
	min_broken_damage =       25
	encased = "ceramic hull"

/obj/item/organ/external/head/precursor
	name =                    "precursor head"
	icon_name = "head"
	amputation_point =        "connector socket"
	joint =                   "connector socket"
	dislocated =              -1
	max_damage =              50
	min_broken_damage =       25
	encased = "ceramic hull"

/obj/item/organ/external/arm/precursor
	name =                    "left grasping tendril"
	icon_name = "l_arm"
	amputation_point =        "midpoint"
	joint =                   "base"
	dislocated =              -1
	max_damage =              20
	min_broken_damage =       10

/obj/item/organ/external/arm/right/precursor
	name =                    "right grasping tendril"
	icon_name = "r_arm"
	amputation_point =        "midpoint"
	joint =                   "base"
	dislocated =              -1
	max_damage =              20
	min_broken_damage =       10

/obj/item/organ/external/hand/precursor
	name =                    "left maniple tendril"
	icon_name = "l_hand"
	amputation_point =        "midpoint"
	joint =                   "base"
	dislocated =              -1
	max_damage =              20
	min_broken_damage =       10
	parent_organ = BP_L_ARM
	can_grasp = 1

/obj/item/organ/external/hand/right/precursor
	name =                    "right maniple tendril"
	icon_name = "r_hand"
	amputation_point =        "midpoint"
	joint =                   "base"
	dislocated =              -1
	max_damage =              20
	min_broken_damage =       10
	parent_organ = BP_R_ARM

/obj/item/organ/external/leg/precursor
	name =                    "first tendril"
	amputation_point =        "midpoint"
	joint =                   "base"
	icon_name =               "l_leg"
	organ_tag =               BP_L_LEG
	parent_organ =            BP_TORSO
	dislocated =              -1
	max_damage =              20
	min_broken_damage =       10

/obj/item/organ/external/leg/right/precursor
	name =                    "second tendril"
	icon_name =               "r_leg"
	organ_tag =               BP_R_LEG

/obj/item/organ/external/foot/precursor
	name =                    "third tendril"
	icon_name =               "l_foot"
	organ_tag =               BP_L_FOOT
	parent_organ = BP_L_LEG

/obj/item/organ/external/foot/right/precursor
	name =                    "fourth tendril"
	icon_name =               "r_foot"
	organ_tag =               BP_R_FOOT
	parent_organ = BP_R_LEG

/obj/item/organ/internal/brain/precursor
	name = "mentality matrix"
	desc = "A soft and spongy mass of flesh that serves as the brain of a Precursor."
	icon = 'icons/mob/human_races/precursor/organs.dmi'
	icon_state = "brain"

/obj/item/organ/internal/eyes/precursor
	name = "receptor prisms"
	desc = "Semi-crystalline orbs that serve as the eyes of a Precursor."
	icon = 'icons/mob/human_races/precursor/organs.dmi'
	icon_state = "eyes"
