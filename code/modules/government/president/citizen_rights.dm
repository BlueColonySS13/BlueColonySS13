

/datum/persistent_option/toggle/rights/voting
	var_to_edit = "toggle_status"
	make_referendum = TRUE
	toggle_status = TRUE
	portal_category = "Voting Rights"
	portal_grouping = "Social Law"

// Voting Rights
/datum/persistent_option/toggle/rights/voting/get_formatted_value(fake_value) // for use in UIs
	var/the_value = (!isnull(fake_value) ? fake_value : get_value())
	return (the_value ? "Can Vote" : "Cannot Vote")

/datum/persistent_option/toggle/rights/voting/nonnational
	name = "Non-National Voting Rights"
	description = "Can people with non-Polluxian nationality vote?"
	id = "voting_nonnational"

/datum/persistent_option/toggle/rights/voting/human
	name = "Human Voting Rights"
	description = "Can humans vote?"
	id = "voting_human"
	required_access_view = access_ceo
	required_access_edit = access_ceo

/datum/persistent_option/toggle/rights/voting/synthetic
	name = "Synthetic Voting Rights"
	description = "Can synthetics vote?"
	id = "voting_synthetic"
	toggle_status = FALSE

/datum/persistent_option/toggle/rights/voting/mpvatborn
	name = "Mass-Produced Vatborn Voting Rights"
	description = "Can mass produced vatborn vote?"
	id = "voting_mpvatborn"
	toggle_status = FALSE

/datum/persistent_option/toggle/rights/voting/baseline
	name = "Baseline Vatborn Voting Rights"
	description = "Can baseline vatborn vote?"
	id = "voting_bvatborn"
	required_access_view = access_ceo
	required_access_edit = access_ceo

/datum/persistent_option/toggle/rights/voting/excon
	name = "Ex-Convict Voting Rights"
	description = "Can the formerly convicted vote?"
	id = "voting_excon"

// Minimum Ages

/datum/persistent_option/number_value/minimum_age
	min_value = 13
	max_value = 80
	value = 18
	var_to_edit = "value"
	portal_category = "Minimum Ages"
	portal_grouping = "Social Law"
	make_referendum = TRUE

/datum/persistent_option/number_value/minimum_age/get_formatted_value(fake_value) // for use in UIs
	var/the_value = (fake_value ? fake_value : value)
	return "[the_value] year(s)"


/datum/persistent_option/number_value/minimum_age/voting
	name = "Voting Age"
	description = "Change the minimum voting age."
	id = "min_age_voting"

/datum/persistent_option/number_value/minimum_age/drinking
	name = "Minimum Drinking Age"
	description = "Change the minimum drinking age."
	id = "min_age_drinking"

/datum/persistent_option/number_value/minimum_age/smoking
	name = "Minimum Smoking and Tobacco Usage Age"
	description = "Change the minimum smoking age."
	id = "min_age_smoking"

/datum/persistent_option/number_value/minimum_age/gambling
	name = "Minimum Gambling Age"
	description = "Change the minimum gambling age."
	id = "min_age_gambling"

/datum/persistent_option/number_value/minimum_age/weaponry
	name = "Minimum Weapon Permit Age"
	description = "Minimum age someone has to be to own a weapon permit."
	id = "min_age_weaponry"

/datum/persistent_option/number_value/minimum_age/sentencing
	name = "Minimum Sentencing Age"
	description = "Change the minimum age a person can be charged with a crime and convicted."
	id = "min_age_sentencing"

// Discrimination

/datum/persistent_option/toggle/discrimination
	portal_category = "Discrimination Policies"
	portal_grouping = "Social Law"
	make_referendum = TRUE

/datum/persistent_option/toggle/discrimination/human // these don't have an effect
	name = "Human Discrimination"
	description = "Allows the ability to discriminate humans at jobs or services."
	id = "discrim_human"
	required_access_edit = access_ceo

/datum/persistent_option/toggle/discrimination/bvatborn // these don't have an effect
	name = "Baseline Vatborn Discrimination"
	description = "Allows the ability to discriminate baseline vatborn at jobs or services."
	id = "discrim_bvatborn"
	required_access_edit = access_ceo

/datum/persistent_option/toggle/discrimination/synth
	name = "Synth Discrimination"
	description = "Allows the ability to discriminate synths at jobs or services."
	id = "discrim_synth"

/datum/persistent_option/toggle/discrimination/synth/on_option_change()
	..()
	if(get_value() == FALSE)
		for(var/datum/job/J in SSjobs.occupations)	// force all jobs to adapt
			J.synth_wage = null

/datum/persistent_option/toggle/discrimination/mpvatborn
	name = "Mass Produced Vatborn Discrimination"
	description = "Allows the ability to discriminate against mass produced vatborn at jobs or services."
	id = "discrim_mpvatborn"

/datum/persistent_option/toggle/discrimination/mpvatborn/on_option_change()
	..()
	if(get_value() == FALSE)
		for(var/datum/job/J in SSjobs.occupations)	// force all jobs to adapt
			J.mpv_wage = null

/datum/persistent_option/toggle/discrimination/excon
	name = "Ex-Convict Discrimination"
	description = "Allows the ability to discriminate against ex-convicts at jobs or services."
	id = "discrim_excon"

datum/persistent_option/toggle/discrimination/excon/on_option_change()
	..()
	if(get_value() == FALSE)
		for(var/datum/job/J in SSjobs.occupations)	// force all jobs to adapt
			J.clean_record_required = FALSE

/datum/persistent_option/toggle/discrimination/nonnational
	name = "Non-National Discrimination"
	description = "Allows the ability to discriminate against non-Polluxians at jobs or services."
	id = "discrim_nonnational"

/datum/persistent_option/toggle/discrimination/nonnational/on_option_change()
	..()
	if(get_value() == FALSE)
		for(var/datum/job/J in SSjobs.occupations)	// force all jobs to adapt
			J.nonnational_wage = null
