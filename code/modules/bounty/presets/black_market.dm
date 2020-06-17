/datum/bounty/black_market
	category = CAT_BLACKMARKET

/datum/bounty/black_market/self_defense
	name = "Self Defence Course"
	author = "Shady Guy behind the Market"

	description = "I know a guy, who knows a guy, who will pay very well for any Police equipment you can scrounge up. \
	A single collapsible baton would make a certain buyer very happy. Just think of it as giving the PD a lesson on why you should \
	not lose your kit on the job (or off the job I dunno)."

	items_wanted = list(/obj/item/weapon/melee/classic_baton = 1)

	department_reward = 1000
	individual_reward = 500

	days_until_expiry = 2

/datum/bounty/black_market/do_androids_dream
	name = "Do Synths Dream of Electric Diyaabs?"
	author = "0R4CL3"

	description = "Howzit, chummer? Our bitjockeys over in Atlus need to get their hands on some NewTek. Unsurprisingly, the research \
	facilities over there are locked up tighter than You know what? Nevermind. Get us 3 Robotic Intelligence Circuits and you’ll get some scratch."

	items_wanted = list(/obj/item/device/mmi/digital/robot = 3)

	department_reward = 2550
	individual_reward = 1000

/datum/bounty/black_market/dont_taze_me_bro
	name = "Don't Taze Me Bro!"
	author = "Hammerdown"

	description = "We’re in need of equipment for our next run. It's gonna be a milk run this time, I can feel it. This one’s gotta stay lowkey so \
	we’re going with non-lethal weapons - Twitchers, specifically. Get us 3 stun revolvers to outfit the crew and we’ll send some credits your way."

	items_wanted = list(/obj/item/weapon/gun/energy/stunrevolver = 3)

	department_reward = 2200
	individual_reward = 850

/datum/bounty/black_market/corporate_espionage
	name = "You Wouldn't Download a Gun"
	author = "Daydream"

	description = "We’ve been monitoring the Sayoko Sakakihara Institute of Science’s servers for any good paydata and we think we’ve hit the \
	jackpot. Download some high-level tech data from their server and send it our way. Some of it might be useful for future runs. Make sure it's \
	atleast Level 6 tech. You’ll get your creds upon successful delivery of the data disk."

	items_wanted = list(/obj/item/weapon/disk/tech_disk = 1)

	department_reward = 4000
	individual_reward = 2000

/datum/bounty/black_market/corporate_espionage/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/weapon/disk/tech_disk))
		var/obj/item/weapon/disk/tech_disk/tekdisk = O

		if(tekdisk.stored.level >= 6)
			return TRUE

	return FALSE

/datum/bounty/black_market/radio_pirate
	name = "Pirate Radio"
	author = "First Mate John Swallow"

	description = "Ahoy, chum. We be needing a specific tech from ye today! Our crew is planning a heist on a facility with a Class VI onboard AI \
	and we need access to its binary channel. Send us a design disk with the plans for a Binary Encryption Key. Ye'll be rewarded handsomely!"

	items_wanted = list(/obj/item/weapon/disk/design_disk = 1)

	department_reward = 3000
	individual_reward = 1750

/datum/bounty/black_market/radio_pirate/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/weapon/disk/design_disk))
		var/obj/item/weapon/disk/design_disk/D = O

		if(D.blueprint == /datum/design/item/binaryencrypt)
			return TRUE

	return FALSE

/datum/bounty/black_market/vampire
	name = "The Most Dangerous Game"
	author = "Vladislav Vanburg"
	description = "Our organization is in search of the blood of the most dangerous game... Unfortunately, we can only procure \
	so much through proper channels. Please, send us 750u of blood. We will compensate you most generously. We only ask that you \
	ask no questions."

	reagents_wanted = list("blood" = 750)

	department_reward = 2500
	individual_reward = 750

	days_until_expiry = 3