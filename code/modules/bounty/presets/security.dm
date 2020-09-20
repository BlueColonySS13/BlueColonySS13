/datum/bounty/security
	category = CAT_SEC

/datum/bounty/security/self_defense
	name = "Self Defence Course"
	author = "Shady Guy behind the Market"

	description = "I know a guy, who knows a guy, who will pay very well for any Police equipment you can scrounge up. \
	A single collapsible baton would make a certain buyer very happy. Just think of it as giving the PD a lesson on why you should \
	not lose your kit on the job (or off the job I dunno)."

	items_wanted = list(/obj/item/weapon/melee/classic_baton = 1)

	department_reward = 1000
	individual_reward = 500

	days_until_expiry = 2
