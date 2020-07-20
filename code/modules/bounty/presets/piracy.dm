/datum/bounty/piracy
	category = CAT_PIRACY	// mostly for bluespace stealing shenanigans for Quercus

/datum/bounty/piracy/bluespace_teleporter
	name = "Bluespace Research: S-R Travel"
	author = "Z"
	description = "One of the greatest technological mysteries that NanoTrasen has is bluespace technology. I want to learn more about it, \
	I think it would be in our best interest if the monopoly on bluespace travel was lifted. It would help other intergalatic tech businesses \
	gain traction, and it would help dispell the elitist band of NT scientists stifling academia. I want a hand teleportation device so it can be \
	deconstructed and analysed."

	items_wanted = list(/obj/item/weapon/hand_tele = 1)

	department_reward = 700
	individual_reward = 300

	days_until_expiry = 2