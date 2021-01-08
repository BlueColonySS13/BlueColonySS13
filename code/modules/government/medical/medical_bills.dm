var/global/list/medical_bills = list()

/hook/startup/proc/populate_medical_datums()
	instantiate_medical_bills()
	return 1

/proc/instantiate_medical_bills()
	//This proc loads all laws, if they don't exist already.

	for(var/instance in subtypesof(/datum/medical_bill))
		var/datum/medical_bill/M = new instance
		medical_bills += M

		if(M.portal_id)
			M.cost = SSpersistent_options.get_persistent_option_value(M.portal_id) // takes the id from the portal and uses the price there.


/datum/medical_bill

	var/name = "Sample Medical Bill"
	var/description = "n/a"

	var/portal_id = null					// will borrow cost from this, if enabled

	var/cost = 0							//	In credits

	var/insurance_coverage = INSURANCE_BASIC	// The type of insurance that covers this treatment.
	var/can_edit = 1

/datum/medical_bill/basic_treatment
	name = "Damage (Oxyloss, Toxin, Burns, Brute) under 50 ticks"
	description = "A basic treatment which usually involves items within any medical pack under 50 ticks."
	portal_id = "medical_basic_treatment"

	insurance_coverage = INSURANCE_BASIC

/datum/medical_bill/basic_treatment_over
	name = "Damage (Oxyloss, Toxin, Burns, Brute) over 50 ticks"
	description = "A basic treatment which usually involves items within any medical pack over 50 ticks."
	portal_id = "medical_basic_treatment_over"

	insurance_coverage = INSURANCE_BASIC

/datum/medical_bill/basic_treatment_vend
	name = "NanoMed Vended Items"
	description = "Items vended from NanoMed Plus."
	portal_id = "medical_basic_treatment_vend"
	insurance_coverage = INSURANCE_BASIC

/datum/medical_bill/basic_treatment_iv
	name = "IV Drip"
	description = "Use of IV drip to restore patient blood."
	portal_id = "medical_basic_treatment_iv"
	insurance_coverage = INSURANCE_BASIC

/datum/medical_bill/machinery_cryo
	name = "Cryo Cell"
	description = "Use of cryo cell."
	portal_id = "medical_machinery_cryo"
	insurance_coverage = INSURANCE_BASIC

/datum/medical_bill/bone_surgery
	name = "Bone Repair Surgery"
	description = "Surgery to mend and repair bones, per bone."
	portal_id = "medical_bone_surgery"
	insurance_coverage = INSURANCE_INTERMEDIATE

/datum/medical_bill/organ_repair
	name = "Organ Repair Surgery"
	description = "Surgery to mend injured or septic organs, per organ."
	portal_id = "medical_organ_repair"
	insurance_coverage = INSURANCE_INTERMEDIATE

/datum/medical_bill/internal_bleeding
	name = "Internal Bleeding"
	description = "Fixing internal bleeding."
	portal_id = "medical_internal_bleeding"
	insurance_coverage = INSURANCE_BASIC

/datum/medical_bill/replacement_organs
	name = "Organ Replacement"
	description = "Organ replacement surgery. Organs sold separately."
	portal_id = "medical_replacement_organs"
	insurance_coverage = INSURANCE_HIGH

/datum/medical_bill/replacement_limbs
	name = "Limb Replacement"
	description = "Limb replacement surgery. Limbs sold separately."
	portal_id = "medical_replacement_limbs"
	insurance_coverage = INSURANCE_HIGH

/datum/medical_bill/facial
	name = "Facial Reconstruction Surgery"
	description = "Surgical reconstruction of a face for cosmetic purposes."
	portal_id = "medical_facial"
	insurance_coverage = INSURANCE_HIGH

/datum/medical_bill/miscellaneous_stasis
	name = "Stasis Bag"
	description = "Use of stasis bag to transport an individual."
	portal_id = "medical_miscellaneous_stasis"
	insurance_coverage = INSURANCE_BASIC

/datum/medical_bill/genetics_treatment
	name = "Genetics Treatment"
	description = "Any form of genetics treatment, that includes dna modification or cloning."
	portal_id = "medical_genetics_treatment"
	insurance_coverage = INSURANCE_HIGH

/datum/medical_bill/physical
	name = "Physical Check Up"
	description = "A physical check up to check general physical health."
	portal_id = "medical_physical"
	insurance_coverage = INSURANCE_BASIC

/datum/medical_bill/therapy
	name = "Therapy Session"
	description = "A psychotherapy session which is used to treat mental health."
	portal_id = "medical_therapy"
	insurance_coverage = INSURANCE_BASIC

/datum/medical_bill/group_therapy
	name = "Group Therapy Session"
	description = "To be charged per one person in a group therapy session."
	portal_id = "medical_group_therapy"

	insurance_coverage = INSURANCE_BASIC

/datum/medical_bill/psych_permit_eval
	name = "Psych Permit Evaluation"
	description = "An evaluation to determine if the holder is suitable to hold a gun permit or to check up frequently if they are still eligible for one."
	portal_id = "medical_psych_permit_eval"

	insurance_coverage = INSURANCE_BASIC
