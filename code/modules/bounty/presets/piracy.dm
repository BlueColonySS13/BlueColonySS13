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

	department_reward = 150
	individual_reward = 70

	days_until_expiry = 2

/datum/bounty/piracy/bluespace_tomatoseed
	name = "Bluespace Research: Mutant Plants"
	author = "Z"
	description = "When I was working for NanoTrasen, I was informed that there was a genetically modified tomato that has the ability to teleport people \
	across short distances when thrown. This greatly fascinates me... if you could get me some seeds I can continue research on how this might come about."

	seeds_wanted = list("bluespacetomato" = 5)

	department_reward = 300
	individual_reward = 100

	days_until_expiry = 3

/datum/bounty/piracy/bluespace_beaker
	name = "Bluespace Research: Beakers"
	author = "Z"
	description = "NanoTrasen scientists are always elusive about their secrets, their cliques of secrecy about bluespace tech never ceases to impress me, \
	even someone with close ties such as I could not touch what they develop. I do recall a time where a NanoTrasen scientist taunted that I will never get \
	to use a bluespace beaker as an intern. Well, let's prove them wrong shall we?"

	items_wanted = list(/obj/item/weapon/reagent_containers/glass/beaker/bluespace = 1)

	department_reward = 250
	individual_reward = 80

	days_until_expiry = 3


/datum/bounty/piracy/bluespace_lunchbox
	name = "Not-Really Bluespace Research: Lunchbox"
	author = "Z"
	description = "This doesn't really serve actual purpose, I want one."

	items_wanted = list(/obj/item/weapon/storage/toolbox/lunchbox/bluespace_lunchbox = 1)

	department_reward = 30
	individual_reward = 15

	days_until_expiry = 1


/datum/bounty/piracy/bluespace_slime
	name = "Bluespace Research: Slimes"
	author = "Z"
	description = "There's a highly dangerous, yet functional slime that has bluespace utilizing properties in it's DNA. Many people don't know the true origin \
	of slimes, it is theorized that NanoTrasen may have found the original descendant somewhere in Sol. If this is true, it may also mean that we \
	have found the origin of bluespace technology itself! If you manage to wrangle one, please bring the extract to me so that I may get my genetics-savvy \
	associate to study it."

	items_wanted = list(/obj/item/slime_extract/bluespace = 1)

	department_reward = 400
	individual_reward = 250

	days_until_expiry = 1

/datum/bounty/piracy/corporate_espionage
	name = "You Wouldn't Download a Gun"
	author = "Daydream"

	description = "We’ve been monitoring the Sayoko Sakakihara Institute of Science’s servers for any good paydata and we think we’ve hit the \
	jackpot. Download some high-level tech data from their server and send it our way. Some of it might be useful for future runs. Make sure it's \
	atleast Level 6 tech. You’ll get your creds upon successful delivery of the data disk."

	items_wanted = list(/obj/item/weapon/disk/tech_disk = 1)

	department_reward = 300
	individual_reward = 150

/datum/bounty/piracy/corporate_espionage/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/weapon/disk/tech_disk))
		var/obj/item/weapon/disk/tech_disk/tekdisk = O

		if(tekdisk.stored.level >= 6)
			return TRUE

	return FALSE

/datum/bounty/piracy/radio_pirate
	name = "Pirate Radio"
	author = "First Mate John Swallow"

	description = "Ahoy, chum. We be needing a specific tech from ye today! Our crew is planning a heist on a facility with a Class VI onboard AI \
	and we need access to its binary channel. Send us a design disk with the plans for a Binary Encryption Key. Ye'll be rewarded handsomely!"

	items_wanted = list(/obj/item/weapon/disk/design_disk = 1)

	department_reward = 300
	individual_reward = 175

/datum/bounty/piracy/radio_pirate/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/weapon/disk/design_disk))
		var/obj/item/weapon/disk/design_disk/D = O

		if(D.blueprint == /datum/design/item/binaryencrypt)
			return TRUE

	return FALSE

/datum/bounty/piracy/do_androids_dream
	name = "Do Synths Dream of Electric Diyaabs?"
	author = "0R4CL3"

	description = "Howzit, chummer? Our bitjockeys over in Atlus need to get their hands on some NewTek. Unsurprisingly, the research \
	facilities over there are locked up tighter than You know what? Nevermind. Get us 3 Robotic Intelligence Circuits and you’ll get some scratch."

	items_wanted = list(/obj/item/device/mmi/digital/robot = 3)

	department_reward = 190
	individual_reward = 90