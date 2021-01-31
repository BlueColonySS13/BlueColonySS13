/datum/persistent_option/number_value/medical_pricing
	min_value = 0
	max_value = 50000
	value = 10
	portal_category = "Public Healthcare Pricing"
	portal_grouping = "Economy Settings"
	value_is_money = TRUE

/datum/persistent_option/number_value/medical_pricing/basic_treatment
	name = "Damage (Oxyloss, Toxin, Burns, Brute) under 50 ticks"
	description = "A basic treatment which usually involves items within any medical pack under 50 ticks."
	id = "medical_basic_treatment"
	value = 45

/datum/persistent_option/number_value/medical_pricing/basic_treatment_over
	name = "Damage (Oxyloss, Toxin, Burns, Brute) over 50 ticks"
	description = "A basic treatment which usually involves items within any medical pack under 50 ticks."
	id = "medical_basic_treatment_over"
	value = 60

/datum/persistent_option/number_value/medical_pricing/basic_treatment_vend
	name = "NanoMed Vended Items"
	description = "Items vended from NanoMed Plus."
	id = "medical_basic_treatment_vend"
	value = 35

/datum/persistent_option/number_value/medical_pricing/basic_treatment_iv
	name = "IV Drip"
	description = "Use of IV drip to restore patient blood."
	id = "medical_basic_treatment_iv"
	value = 85

/datum/persistent_option/number_value/medical_pricing/machinery_cryo
	name = "Cryo Cell"
	description = "Use of cryo cell."
	id = "medical_machinery_cryo"
	value = 140

/datum/persistent_option/number_value/medical_pricing/bone_surgery
	name = "Bone Repair Surgery"
	description = "Surgery to mend and repair bones, per bone."
	id = "medical_bone_surgery"
	value = 450

/datum/persistent_option/number_value/medical_pricing/organ_repair
	name = "Organ Repair Surgery"
	description = "Surgery to mend injured or septic organs, per organ."
	id = "medical_organ_repair"
	value = 550

/datum/persistent_option/number_value/medical_pricing/internal_bleeding
	name = "Internal Bleeding"
	description = "Fixing internal bleeding."
	id = "medical_internal_bleeding"
	value = 450

/datum/persistent_option/number_value/medical_pricing/replacement_organs
	name = "Organ Replacement"
	description = "Organ replacement surgery. Organs sold separately."
	id = "medical_replacement_organs"
	value = 1700


/datum/persistent_option/number_value/medical_pricing/replacement_limbs
	name = "Limb Replacement"
	description = "Limb replacement surgery. Limbs sold separately."
	id = "medical_replacement_limbs"
	value = 1500


/datum/persistent_option/number_value/medical_pricing/facial
	name = "Facial Reconstruction Surgery"
	description = "Surgical reconstruction of a face for cosmetic purposes."
	id = "medical_facial"
	value = 500

/datum/persistent_option/number_value/medical_pricing/miscellaneous_stasis
	name = "Stasis Bag"
	description = "Use of stasis bag to transport an individual."
	id = "medical_miscellaneous_stasis"
	value = 45

/datum/persistent_option/number_value/medical_pricing/genetics_treatment
	name = "Genetics Treatment"
	description = "Any form of genetics treatment, that includes dna modification or cloning."
	id = "medical_genetics_treatment"
	value = 1100

/datum/persistent_option/number_value/medical_pricing/physical
	name = "Physical Check Up"
	description = "A physical check up to check general physical health."
	id = "medical_physical"
	value = 80


/datum/persistent_option/number_value/medical_pricing/therapy
	name = "Therapy Session"
	description = "A psychotherapy session which is used to treat mental health."
	id = "medical_therapy"
	value = 150

/datum/persistent_option/number_value/medical_pricing/group_therapy
	name = "Group Therapy Session"
	description = "To be charged per one person in a group therapy session."
	id = "medical_group_therapy"
	value = 100

/datum/persistent_option/number_value/medical_pricing/psych_permit_eval
	name = "Psych Permit Evaluation"
	description = "An evaluation to determine if the holder is suitable to hold a gun permit or to check up frequently if they are still eligible for one."
	id = "medical_psych_permit_eval"
	value = 400