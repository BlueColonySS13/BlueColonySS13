/datum/bounty/tech
	category = CAT_TECH

/datum/bounty/tech/ed_brutality
	name = "You Have 20 Seconds To Comply"
	author = "Ornias Police Department"
	description = "Another day, another unsanctioned protest in front of city hall... \
	We’re undermanned and need something to level the playing field. \
	Please send us a ED-209 assemblies to help spread the weight around."

	items_wanted = list(/obj/item/weapon/secbot_assembly/ed209_assembly = 4)

	department_reward = 260
	individual_reward = 40

	days_until_expiry = 3

/datum/bounty/tech/battleborgs
	name = "Battleborgs"
	author = "Weeland-Yunati Entertainment Division"
	description = "Our coliseum show needs more warriors to fight each other. We were thinking of a robot themed team for our new roster."

	items_wanted = list(
	/obj/item/weapon/circuitboard/mecha/durand/peripherals = 2,
	/obj/item/weapon/circuitboard/mecha/durand/targeting = 2,
	/obj/item/weapon/circuitboard/mecha/durand/main = 2
	)

	department_reward = 1200
	individual_reward = 200

	days_until_expiry = 3