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
	if(persistent_economy && (0.10 >= persistent_economy.gambling_tax))
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
	if(persistent_economy && (0.20 >= persistent_economy.tax_rate_upper))
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
	if(persistent_economy && (0.20 >= persistent_economy.housing_tax))
		return TRUE

	return FALSE

/datum/bounty/politics_traditional/drugs_illegal
	name = "Make Drugs Illegal Again"
	author = "Earl Pennington"
	description = "There's a general issue facing our society today - drugs. Namely recreational ones that provide nothing but lunacy. Make sure they \
	are illegal - think about it. Not only do we get the scum of society locked away, but it's so much profit for the state. "

	custom_requirement = "Have someone in power and make cannabis, ecstasy, crack, cocaine, heroin, meth, lsd, dmt, ayahuasca, bath salts, and krokodil all illegal."

	department_reward = 4500
	individual_reward = 850

	days_until_expiry = 6

/datum/bounty/politics_traditional/drugs_illegal/check_for_completion()
	var/list/substance_laws = list(persistent_economy.law_CANNABIS, \
	persistent_economy.law_ECSTASY, \
	persistent_economy.law_CRACK, \
	persistent_economy.law_COCAINE, \
	persistent_economy.law_HEROIN, \
	persistent_economy.law_METH, \
	persistent_economy.law_LSD, \
	persistent_economy.law_BATHSALTS, \
	persistent_economy.law_DMT, \
	persistent_economy.law_AYAHUASCA, \
	persistent_economy.law_KROKODIL)

	for(var/V in substance_laws)
		if(V != ILLEGAL)
			return FALSE

	return TRUE

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
	if(10 >= persistent_economy.minimum_wage)
		return TRUE

	return FALSE