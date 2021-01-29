/datum/persistent_option/number_value/legal_pricing
	min_value = 0
	max_value = 50000
	value = 10
	portal_category = "Public Legal Pricing"
	portal_grouping = "Economy Settings"
	value_is_money = TRUE

/datum/persistent_option/number_value/legal_pricing/minor_appeal
	name = "Minor Appeal Fee"
	description = "A fee to cover the cost incurred by the Court to hear an appeal on Misdemeanour or Criminal Offense"
	id = "minor_appeal"
	value = 300

/datum/persistent_option/number_value/legal_pricing/mayoral_appeal
	name = "Mayoral Appeal Fee"
	description = "A fee to cover the cost of a member of the Mayoral Corps hearing an appeal for a Misdemeanour or Criminal Offense."
	id = "mayoral_appeal"
	value = 150

/datum/persistent_option/number_value/legal_pricing/small_claims
	name = "Small Claims Suit Fee"
	description = "A fee to cover the cost of filing a lawsuit seeking damages 4999Cr or less."
	id = "small_claims"
	value = 500

/datum/persistent_option/number_value/legal_pricing/large_claims
	name = "Large Claims Suit Fee"
	description = "A fee to cover the cost of filing a lawsuit seeking damages 5000Cr or more."
	id = "large_claims"
	value = 1000

/datum/persistent_option/number_value/legal_pricing/court_fine
	name = "Court Fine"
	description = "A administrative fine issued by the Judge or Magistrate to counsel or a litigant for misconduct."
	id = "court_fine"
	value = 100

/datum/persistent_option/number_value/legal_pricing/high_court_appeal
	name = "High Court of Pollux Appeal Fee"
	description = "A fee to cover the cost inccured by the High Court of the Republic of Pollux to hear an appeal."
	id = "high_court_appeal"
	value = 1000