

/proc/is_voting_ineligible(var/mob/living/carbon/human/H)
	if(!ishuman(H))
		return "Not Human"

	if(SSpersistent_options.get_persistent_option_value("min_age_voting") > H.age)
		return "Not Old Enough"

	if(H.species)
		var/datum/species/species = H.species
		if(species && species.portal_vote_id)
			if(!SSpersistent_options.get_persistent_option_value(species.portal_vote_id))
				return "[species.name] cannot vote."

	if(!SSpersistent_options.get_persistent_option_value("voting_synthetic"))
		if(H.internal_organs_by_name[O_BRAIN])
			var/obj/item/organ/internal/brain/B = H.internal_organs_by_name[O_BRAIN]
			if(B.robotic > 1)
				return "Has a Synthetic Brain"

	if(!SSpersistent_options.get_persistent_option_value("voting_noncitizen"))
		if(H.home_system != using_map.starsys_name)
			return "Is from [H.home_system] and not from [using_map.starsys_name]"

	if(!SSpersistent_options.get_persistent_option_value("voting_excon"))
		var/datum/data/record/police_record = get_sec_record(H)
		if(police_record)
			var/list/criminal_record = police_record.fields["crim_record"]
			if(!isemptylist(criminal_record))
				return "Has a criminal record"

	return 0

/atom/movable/var/contraband_type = null // put the portal id of the tax we're charging here.
/datum/reagent/var/contraband_type = null // put the portal id of the tax we're charging here.

/atom/movable/proc/is_contraband() // gets the type of contraband
	return SSpersistent_options.get_persistent_option_value(contraband_type)

/datum/reagent/proc/is_contraband() // gets the type of contraband
	return SSpersistent_options.get_persistent_option_value(contraband_type)

/atom/movable/proc/is_legal() // if it isn't legal, it'll return false. if it is, i'll return true
	var/contraband_status = is_contraband()

	if(contraband_status == LEGAL || !contraband_status)
		return TRUE

	return FALSE

var/global/list/potential_contraband = list(
	"Cannabis",
	"Alcohol",
	"Ecstasy",
	"Psilocybin",
	"Crack",
	"Cocaine",
	"Heroin",
	"Meth",
	"Nicotine",
	"Stimm",
	"Cyanide",
	"Chloral Hydrate",
	"Guns",
	"Short Knives",
	"Long Knives",
	"Explosives",
	"LSD",
	"DMT",
	"Bath Salts",
	"Ayahuasca",
	"Krokodil"
	)

var/global/list/tax_groups = list(
	"General Sales Tax",
	"Business Income Tax",
	"Medical Tax",
	"Weapons Tax",
	"Alcoholic Tax",
	"Tobacco Tax",
	"Recreational Drug Tax",
	"Gambling Tax"
	)

var/global/list/contraband_classifications = list(
	ILLEGAL,
	PROFESSIONAL_ONLY,
	PROFESSIONAL_SALE,
	PERMIT_SELLING,
	PERMIT_POSSESSION,
	LEGAL
	)

