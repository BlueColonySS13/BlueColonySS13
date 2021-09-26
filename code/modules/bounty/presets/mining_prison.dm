/datum/bounty/prison_mining
	category = CAT_PRISON_MINING
	author_department = DEPT_FACTORY	// Yes, the factory buys their raw materials from prison labour, just like many irl factories do. :)
	author = "Geminus City Factory"

	individual_reward = 0
	bounty_expires = FALSE
	delete_upon_completion = FALSE

/datum/bounty/prison_mining/coal
	name = "Factory Coal Stock"
	description = "The factory needs 50 pieces of coal to sell to customers, please provide promptly."

	items_wanted = list(/obj/item/weapon/ore/coal = 50)
	days_until_expiry = 10
	department_reward = 140

/datum/bounty/prison_mining/hematite
	name = "Factory Hematite Stock"
	description = "The factory needs 50 pieces of hematite ore to sell to customers, please provide promptly."

	items_wanted = list(/obj/item/weapon/ore/iron = 50)
	days_until_expiry = 6
	department_reward = 140

/datum/bounty/prison_mining/diamond
	name = "Factory Diamond Export Stock"
	description = "The factory needs 20 unprocessed diamonds to sell to customers abroad, please provide promptly."

	items_wanted = list(/obj/item/weapon/ore/diamond = 20)
	days_until_expiry = 12
	department_reward = 2500

/datum/bounty/prison_mining/sol_sand
	name = "Factory Sand Stock"
	description = "The factory needs 50 piles of sand to sell to customers, please provide promptly."

	items_wanted = list(/obj/item/weapon/ore/glass = 50)
	days_until_expiry = 2
	department_reward = 100

/datum/bounty/prison_mining/phoron // yes science is on it too
	name = "Research Phoron Stock"
	author_department = DEPT_RESEARCH
	description = "Geminus City laboratories requires phoron deposits for research purposes, please send a supply when you can."

	items_wanted = list(/obj/item/weapon/ore/phoron = 50)

	department_reward = 200

/datum/bounty/prison_mining/phoron_healthcare // yes even the hospital
	name = "Chemistry Phoron Stock"
	description = "Geminus City hospital's pharmacist sector requires large amounts of phoron to keep productivity running, please send supplies."
	author_department = DEPT_HEALTHCARE
	items_wanted = list(/obj/item/weapon/ore/phoron = 100)

	department_reward = 400

/datum/bounty/prison_mining/sol_gold // yes even sol
	name = "Sol Mineral Exports: Gold"
	description = "As you may know, gold is running scarce on Earth and Mars, we're not fond of buying this at such inflated prices which is why we \
	have come to you. We'll cover the bluespace teleportation fee."
	author_department = DEPT_SOLGOV
	items_wanted = list(/obj/item/weapon/ore/gold = 100)

	department_reward = 1400

/datum/bounty/prison_mining/sol_silver
	name = "Sol Mineral Exports: Silver"
	description = "Space faring colonies treat silver as if it were platinum - not that they could tell the difference, please send us some - we'll pay for \
	travel."
	author_department = DEPT_SOLGOV
	items_wanted = list(/obj/item/weapon/ore/silver = 100)

	department_reward = 900

/datum/bounty/prison_mining/solgov_phoron // yes even solgov
	name = "SolGov Phoron Trade Agreement"
	description = "As per the SolGov and Polluxian trade agreement please send a fixed sum of phoron, as promised we will reimburse and cover bluespace costs."
	author_department = DEPT_SOLGOV
	items_wanted = list(/obj/item/weapon/ore/phoron = 300)

	department_reward = 3400

/datum/bounty/prison_mining/solgov_uranium
	name = "SolGov Uranium Trade Agreement"
	description = "As per the SolGov and Polluxian trade agreement please send a fixed sum of uranium, as promised we will reimburse and cover bluespace costs."
	author_department = DEPT_SOLGOV
	items_wanted = list(/obj/item/weapon/ore/uranium = 150)

	department_reward = 1400