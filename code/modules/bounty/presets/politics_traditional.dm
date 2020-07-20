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