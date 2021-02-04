/datum/bounty/politics_traditional
	category = CAT_POLITICALTRAD

/datum/bounty/politics_traditional/gambling
	name = "Gambling Is A Right"
	author = "Henry Bjork"
	description = "Taxing fun? It's ridiculous isn't it? Here's a deal, make sure gambling is kept under 10% tax and I'll pass my winnings \
	over to you on a regular basis. Deal or no deal?"

	custom_requirement = "Have someone in power change gambling tax to be at or under 10%, once that is done this bounty will be a passive \
	source of income to claim at any time."

	department_reward = 600
	individual_reward = 150

	days_until_expiry = 6

/datum/bounty/politics_traditional/gambling/check_for_completion()
	if(0.10 >= SSpersistent_options.get_persistent_option_value(GAMBLING_TAX))
		return TRUE

	return FALSE


/datum/bounty/politics_traditional/rich_tax
	name = "Taxation Is Theft"
	author = "Carl Capiton"
	description = "Our income is what makes this colony thrive, some politicians think that they rob us blind and give to the thieves and beggars \
	who never earned it. A good funder does not allow this to happen."

	custom_requirement = "Have someone in power change the upper class tax to be at or under 20%, once that is done this bounty will be a passive \
	source of income to claim at any time."

	department_reward = 1000
	individual_reward = 250

	days_until_expiry = 6

/datum/bounty/politics_traditional/rich_tax/check_for_completion()
	if(0.20 >= SSpersistent_options.get_persistent_option_value(UPPER_TAX))
		return TRUE

	return FALSE


/datum/bounty/politics_traditional/property_values
	name = "Property Values"
	author = "Carl Capiton"
	description = "Property is the lifeblood ot profit, unfortunately some communinists believe it is their life's duty to tax and squat any hard-working \
	person who dares to own and maintain land, we need to keep the housing tax low."

	custom_requirement = "Have someone in power change the housing tax to be at or under 20%, once that is done this bounty will be a passive \
	source of income to claim at any time."

	department_reward = 1500
	individual_reward = 450

	days_until_expiry = 6


/datum/bounty/politics_traditional/property_values/check_for_completion()
	if(0.20 >= SSpersistent_options.get_persistent_option_value(PROPERTY_TAX))
		return TRUE

	return FALSE


/datum/bounty/politics_traditional/minimum_wage
	name = "Unsustainable Wages"
	author = "Earl Pennington"
	description = "The biggest issue when running an enterprise is paying your employees. Imagine Sol finger waggling us to keep their people coming here. Ha! \
	Let's lower the minimum wage, Solarians do and will work for literally anything."

	custom_requirement = "Have someone in power set the minimum wage to 10 credits and under."

	department_reward = 700
	individual_reward = 450

	days_until_expiry = 6

/datum/bounty/politics_traditional/minimum_wage/check_for_completion()
	if(10 >= SSpersistent_options.get_persistent_option_value("minimum_wage"))
		return TRUE

	return FALSE