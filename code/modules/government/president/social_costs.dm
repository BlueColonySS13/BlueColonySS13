
/datum/persistent_option/number_value/social_cost
	var_to_edit = "value"
	portal_category = "Social Costs"
	portal_grouping = "Social Services"

	min_value = 0
	max_value = 10000
	value_is_money = TRUE

/datum/persistent_option/number_value/social_cost/food_stamps_wage
	name = "Food Stamp Eligibility Wage"
	description = "This is the cap for someone's wage before they are ineligible for a food stamp. Only will work if food stamps are enabled."
	id = "food_stamps_wage"
	value = 25
	min_value = 0
	max_value = 9000

/datum/persistent_option/number_value/social_cost/business_registration
	name = "Business Registration Fee"
	description = "This is registration fee required to be paid upon making a new business."
	id = "business_registration"
	value = 3500

/*
/datum/persistent_option/number_value/social_cost/party_registration
	name = "Party Registration Fee"
	description = "This is registration fee required to be paid upon making a new business."
	id = "party_registration"
	value = 3500
*/