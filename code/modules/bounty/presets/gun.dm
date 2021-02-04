/datum/bounty/gun
	category = CAT_GUNS
	tax_type = WEAPONS_TAX

/datum/bounty/gun/smg_guards
	name = "Get the Ultra Premium Care Plan: It Sounds Better"
	author = "Howard Hows"
	description = "So my guards are not looking \"future soldier\" enough. I change out their outfits almost once a year \
	with new doodads but something is missing. Ah! Their gun does not have an adjective in the name. Simply out of date. \
	Please make sure to send 4 Prototype SMGs so normal troop’s equipment does not catch up to ours."

	items_wanted = list(/obj/item/weapon/gun/projectile/automatic = 4)

	department_reward = 3000
	individual_reward = 900

	days_until_expiry = 2

/datum/bounty/gun/pdf_testing
	name = "PDF Weapons Testing"
	author = "Planetary Defense Force"
	description = "We're doing some testing on our armories and their loadouts to be up to date with the cutting edge of \
	military technology. This means turning to you for testing some interesting weapons. Please send us your most cutting \
	edge energy weaponry."

	items_wanted = list(/obj/item/weapon/gun/energy/toxgun = 4)

	department_reward = 2000
	individual_reward = 600

	days_until_expiry = 2

/datum/bounty/gun/overkill
	name = "Overkill"
	author = "Master Commander Fist McLaserbiceps Odinkiller Zombiestomper Doomslayer MCLXVII"
	description = "\[Expletives removed.\]"

	items_wanted = list(/obj/item/weapon/gun/magnetic/fuelrod = 1)

	department_reward = 3000
	individual_reward = 1000

	days_until_expiry = 2

/datum/bounty/gun/new_toys
	name = "New Toys"
	author = "Ironside Firing Range"
	description = "Here at Ironside Firing Range, we're always seeking the latest in firearms for our guests. We're hoping \
	for something brand-new and never before seen. Send us something that's hip, now, and wow."

	items_wanted = list(/obj/item/weapon/gun/energy/temperature = 2)

	department_reward = 1200
	individual_reward = 300

	days_until_expiry = 2

/datum/bounty/gun/bioweapon
	name = "Green Goo"
	author = "Master Commander Fist McLaserbiceps Odinkiller Zombiestomper Doomslayer MCLXVII"
	description = "\[This message has been redacted due to violating the terms of service.\]"

	items_wanted = list(/obj/item/weapon/gun/energy/decloner = 1)

	department_reward = 600
	individual_reward = 150

/datum/bounty/gun/spider_hunter
	name = "Spider Infestation: No More"
	author = "Parker Peterson"
	description = "There's a huge infestation of radioactive spiders underneath a geothermal vent here in San Uttenre. The local \
	population is small enough as it is and they don't need spiders picking off what little people remain. Send in the big guns \
	so I can clear out the nest. You know what they say - \"With great power must also come great big cannons.\""

	items_wanted = list(/obj/item/weapon/gun/energy/lasercannon = 2)

	department_reward = 900
	individual_reward = 250

/datum/bounty/gun/dont_taze_me_bro
	name = "Don't Taze Me Bro!"
	author = "Hammerdown"

	description = "We’re in need of equipment for our next run. It's gonna be a milk run this time, I can feel it. This one’s gotta stay lowkey so \
	we’re going with non-lethal weapons - Twitchers, specifically. Get us 3 stun revolvers to outfit the crew and we’ll send some credits your way."

	items_wanted = list(/obj/item/weapon/gun/energy/stunrevolver = 3)

	department_reward = 2200
	individual_reward = 850

/*
/datum/bounty/gun/low_demand
	name = "UNAVAILABLE"
	author = "UNAVAILABLE"

	description = "The Firearms and Ammunition manufacturing subsytem of the Boun-T is currently down for maintenance. We apologize for any inconvenience."

	items_wanted = list(/obj/item/bounty_holder = 999)

	department_reward = 0
	individual_reward = 0

*/