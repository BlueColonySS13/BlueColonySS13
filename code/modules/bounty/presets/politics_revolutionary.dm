/datum/bounty/politics_revolutionary
	category = CAT_POLITICALREVO

/datum/bounty/politics_revolutionary/eat_the_rich
	name = "Eat The Rich"
	author = "Oliver Yaya"
	description = "Yes, the colony needs money to run. That money shouldn't be coming from the vulnerable - it should be coming from those who \
	have nothing to lose. Look at them, haughty and stingy. Make the government tax them what they deserve. Today they dine on peasant, tomorrow \
	we dine on THEM."

	custom_requirement = "Have someone in power change upper class tax to be at or over 50% tax, once that is done this bounty will be a passive \
	source of income to claim at any time."

	department_reward = 700
	individual_reward = 150

	days_until_expiry = 6

/datum/bounty/politics_revolutionary/eat_the_rich/check_for_completion()
	if(SSpersistent_options.get_persistent_option_value(UPPER_TAX) >= 0.40)
		return TRUE

	return FALSE

/datum/bounty/politics_revolutionary/eat_landlords
	name = "Eat The Landlords"
	author = "Oliver Yaya"
	description = "Since the Atlus incident, many Blue Colony citizens don't even have a roof over their heads, it's absolutely appauling. \
	The worst part is that the new properties being built there are SO expensive. Landlords often drive up prices and rent to compensate for \
	the government's housing tax, the working class can barely afford to let property to run businesses."

	custom_requirement = "Have someone in power change housing tax to be at or under 15% tax, once that is done this bounty will be a passive \
	source of income to claim at any time."

	department_reward = 400
	individual_reward = 150

	days_until_expiry = 6


/datum/bounty/politics_revolutionary/eat_landlords/check_for_completion()
	if(0.15 >= SSpersistent_options.get_persistent_option_value(PROPERTY_TAX))
		return TRUE

	return FALSE


/datum/bounty/politics_revolutionary/tobacco_industry
	name = "Tobacco Industry Corruption"
	author = "Oliver Yaya"
	description = "The tobacco industry of this colony is one of the most corrupt. Because NT does not care about regulations, big tobacco \
	has no problem with false advertising - the result is political lobbying for protection and exploiting Sol immigrants. Well, we'll show them won't we?"

	custom_requirement = "Have someone in power change tobacco tax to be 40% and over, once that is done this bounty will be a passive \
	source of income to claim at any time."

	department_reward = 2600
	individual_reward = 450

	days_until_expiry = 6


/datum/bounty/politics_revolutionary/eat_landlords/check_for_completion()
	if(SSpersistent_options.get_persistent_option_value(TOBACCO_TAX) >= 0.40)
		return TRUE

	return FALSE



/datum/bounty/politics_revolutionary/health_issues
	name = "Healthcare Issues"
	author = "Oliver Yaya"
	description = "Personally I don't think healthcare should have a price, but if does have a price it shouldn't cost a leg and an arm. NanoTrasen is \
	the richest company in the galaxy owning more money than actual governments under SolGov, yet it cannot provide for the health of its citizens? \
	The money should be coming out of the pockets of corporates, not levied onto citizens, it's not fair."

	custom_requirement = "Have someone in power change medical tax to be 15% and under, once that is done this bounty will be a passive \
	source of income to claim at any time."


	department_reward = 1600
	individual_reward = 150

	days_until_expiry = 6



/datum/bounty/politics_revolutionary/health_issues/check_for_completion()
	if(0.15 >= SSpersistent_options.get_persistent_option_value(MEDICAL_TAX))
		return TRUE

	return FALSE



/datum/bounty/politics_revolutionary/minimum_wage
	name = "Unsustainable Wages"
	author = "Micheal Dover"

	description = "Business owners and the public sector continue to make things difficult for the workers, raise the minimum wage to ensure people \
	can feed themselves and their families."

	custom_requirement = "Have someone in power set the minimum wage to 50 credits and over."

	department_reward = 700
	individual_reward = 450

	days_until_expiry = 6

/datum/bounty/politics_revolutionary/minimum_wage/check_for_completion()
	if(SSpersistent_options.get_persistent_option_value("minimum_wage") >= 50)
		return TRUE

	return FALSE

