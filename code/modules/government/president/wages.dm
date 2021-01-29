
/datum/persistent_option/number_value/wages
	min_value = 0
	max_value = 300
	value = 10
	portal_category = "Wages"

	value_is_money = TRUE

	portal_grouping = "Economy Settings"

/datum/persistent_option/number_value/wages/minimum_wage
	name = "Minimum Wage"
	description = "This is the minimum wage that is required for all businesses to obey. Does not apply to public jobs - which you will have to \
	adjust manually."
	id = "minimum_wage"

/datum/persistent_option/number_value/wages/synth_minimum_wage
	name = "Synth Minimum Wage"
	description = "This is the minimum wage that synths will be paid, if at all. Only will work if you have allowed synthetic discrimination to exist."
	id = "synth_minimum_wage"
	value = 0

/datum/persistent_option/number_value/wages/nonnational_minimum_wage
	name = "Non-National Minimum Wage"
	description = "This is the minimum wage for people born outside of Pollux and lack citizenship. Only will work if you have allowed non-Vetran \
	discrimination to exist."
	id = "nonnational_minimum_wage"

/datum/persistent_option/number_value/wages/mpv_minimum_wage
	name = "Mass-Produced Vatborn Minimum Wage"
	description = "This is the minimum wage for mass produced vatborn. Only will work if you have allowed mass produced vatborn discrimination to exist."
	id = "vatborn_minimum_wage"
	value = 0
