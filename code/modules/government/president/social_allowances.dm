
/datum/persistent_option/number_value/social_allowances
	portal_grouping = "Social Services"
	portal_category = "Social Allowances"

/datum/persistent_option/number_value/social_allowances/food_stamps
	name = "Food Stamps Allowance"
	description = "This is the max amount of food stamps someone can redeem if they redeem a food stamp."
	id = "food_stamps_allowance"
	value = 3
	min_value = 1
	max_value = 5

/datum/persistent_option/number_value/social_allowances/food_stamps/get_formatted_value(fake_value) // for use in UIs
	var/the_value = get_value()
	if(fake_value)
		the_value = fake_value
	return (the_value ? "[the_value] stamp(s)" : "None")