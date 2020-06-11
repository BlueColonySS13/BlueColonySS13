/datum/bounty/health_pharma
	category = CAT_HEALTH

/datum/bounty/health_pharma/tricord_contractor
	name = "Contractor Work"
	author = "Lazy Guillaume, MD"
	description = "People keep coming into my office complaining about pains and horrible lacerations and how I should do my job. \
	I just need an easy way to get them out. I was talking to Shady Guy Behind the Market but he said I would have to go somewhere \
	like behind the market to get anything from him and that is too far. Please send me some Tricordrazine pills so I will not \
	actually have to do my job."

	reagents_wanted = list("tricordrazine" = 200)

	department_reward = 200
	individual_reward = 50

	days_until_expiry = 1


/datum/bounty/health_pharma/mental_asylum
	name = "Definitely A Medical Emergency"
	author = "Falsus Mental Asylum"
	description = "We’re running dangerously low on Chloral Hydrate, and some of our more... interesting patients are starting to wake up. \
	We need a restock in order to keep our \"patients\" completely sedated until they’re ready for \"treatment\". Yes. Treatment."

	reagents_wanted = list("chloralhydrate" = 300)

	department_reward = 2000
	individual_reward = 400

	days_until_expiry = 1

/datum/bounty/health_pharma/bitter_medicine
	name = "Bitter Medicine"
	author = "Pollux Charitable Foundation"
	description = "We’re running low on basic medical supplies for our people. We need Bicardine and Trauma Kits desperately, \
	but we don’t have much money. We hope this will suffice."

	items_wanted = list(/obj/item/stack/medical/advanced/bruise_pack = 5)

	reagents_wanted = list("bicaridine" = 120)

	department_reward = 300
	individual_reward = 40

	days_until_expiry = 1
