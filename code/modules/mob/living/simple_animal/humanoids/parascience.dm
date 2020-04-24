/mob/living/simple_animal/hostile/parascience
	name = "paramilitary agent"
	desc = "A soldier with a strange prong-shaped emblem on their back."
	icon_state = "parascience"
	icon_living = "parascience"
	icon_dead = "parascience_dead"
	intelligence_level = SA_HUMANOID

	faction = "parascience"
	maxHealth = 100
	health = 100
	speed = 4

	run_at_them = 0
	cooperative = 1
	investigates = 1
	firing_lines = 1
	returns_home = 1
	reacts = 1

	turns_per_move = 5
	stop_when_pulled = 0
	status_flags = CANPUSH

	response_help = "hugs"
	response_disarm = "shoves"
	response_harm = "hits"

	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 15
	environment_smash = 1
	attacktext = list("punched", "kicked", "hand chopped")

	min_oxy = 5
	max_oxy = 0
	min_tox = 0
	max_tox = 1
	min_co2 = 0
	max_co2 = 5
	min_n2 = 0
	max_n2 = 0
	unsuitable_atoms_damage = 15

	speak_chance = 1
	speak = list("I knew I was going to Hell but I wasn't expecting to work their too...",
				"When are we gonna get out of this chicken-shit outfit?",
				"Wish I had better equipment...",
				"I knew I should have been a line chef...",
				"Fuckin' goggles keeps fogging up.",
				"Anyone else smell that?")
	emote_hear = list("sniffs","coughs","taps his foot")
	emote_see = list("looks around", "checks his equipment")
	say_understood = list()
	say_cannot = list()
	say_maybe_target = list("What's that?","Is someone there?","Is that...?","Hmm?")
	say_got_target = list("Target sighted!","Contact!","Engaging!","Civilian in the AO!")
	reactions = list("Hey guys, you ready?" = "Let's do this!")

/* Ranged Guys */
/mob/living/simple_animal/hostile/parascience/ranged
	icon_state = "parascience_ranged"
	icon_living = "parascience_ranged"

	ranged = 1
	rapid = 1
	projectiletype = /obj/item/projectile/bullet/rifle/a762
//	casingtype = /obj/item/ammo_casing/spent	//Makes infinite stacks of bullets when put in PoIs.
	projectilesound = 'sound/weapons/gunshot/gunshot2.ogg'

	loot_list = list(/obj/item/weapon/gun/projectile/automatic/sts35 = 100)

/mob/living/simple_animal/hostile/parascience/legless
	name = "Gerald Gear"
	desc = "No one should have to suffer like this."
	icon_state = "legless"
	icon_living = "legless"
	icon_dead = "legless"

	response_help = "realizes there is nothing they can do to help"
	attacktext = list("tries to hit", "flails at", "weakly taps")

	status_flags = null
	speed = 13
	cooperative = 0
	investigates = 0

	melee_damage_lower = 0
	melee_damage_upper = 0
	attack_armor_pen = 0

	speak_chance = 1
	speak = list("I c-can't feel m-my-y l-legs......",
				"Please... Someone... my eyes...",
				"Help...",
				"Is anyone there...? Please...",
				"I can hear them... waiting outside.. for me...",
				"Please... I'm in the maintenance room....")
	emote_hear = list("sniffs","coughs","cries", "moans", "groans")
	emote_see = list("flails helplessly", "struggles to crawl")
	say_understood = list()
	say_cannot = list()
	say_maybe_target = list("Is that a recovery t-team...?","Is someone there?","Is that...?","I heard something...")
	say_got_target = list("Please, please be human...","Kill me, please!","I won't become one of those things! I'll kill every last one of you demons!")
	reactions = list("Hey guys, you ready?" = "Please... I just want to go home.")