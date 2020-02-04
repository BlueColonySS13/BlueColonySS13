

/proc/is_voting_ineligible(var/mob/living/carbon/human/H)
	if(!ishuman(H))
		return "Not Human"

	if(persistent_economy.voting_age > H.age)
		return "Not Old Enough"

	if(H.internal_organs_by_name[O_BRAIN])
		var/obj/item/organ/internal/brain/B = H.internal_organs_by_name[O_BRAIN]
		if(B.robotic)
			return "Has a Synthetic Brain"

	if(!persistent_economy.citizenship_vote && H.home_system != using_map.starsys_name)
		return "Is from [H.home_system] and not from [using_map.starsys_name]"

	var/datum/data/record/police_record = get_sec_record(H)
	if(police_record)
		var/list/criminal_record = police_record.fields["crim_record"]
		if(!isemptylist(criminal_record))
			return "Has a criminal record"

	return 0

/atom/movable/proc/is_contraband()
	return

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
	PERMIT_SELLING,
	PERMIT_POSSESSION,
	LEGAL
	)

