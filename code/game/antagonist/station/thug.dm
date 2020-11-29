
/datum/antagonist/thug
	id = MODE_THUG
	role_type = BE_RENEGADE
	role_text = "Thug"
	role_text_plural = "Thugs"
	bantype = "renegade"
	restricted_jobs = list("Prisoner", "AI", "Cyborg","Mayor","City Clerk", "Chief of Police","Police Officer",\
	"Prison Warden","Detective","Medical Director","Maintenance Director","Research Director","Judge")
	welcome_text = "Sometimes, people just need to get messed up. Luckily, that's what you're here to do."
	antag_text = "You are a <b>thug</b>! You work with other thugs who work together to do what thugs do, be it violence, drug dealing, theft, or \
	just extreme self-defense. Try to make sure other players have fun! <b>This role is for crime breaking gang antics not murderboning.</b> \
	This is a <b>teamwork role</b>, roleplay with your fellow gang members and brainstorm what you will do. AOOC may be used."
	flags = ANTAG_SUSPICIOUS | ANTAG_IMPLANT_IMMUNE | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	can_speak_aooc = TRUE
	can_hear_aooc = TRUE
	antaghud_indicator = "thug"
	antag_indicator = "thug"
	initial_spawn_req = 2
	initial_spawn_target = 4
	hard_cap = 8
	police_per_antag = 2
	minimum_player_age = 1

	//Thugs get their own universal outfit, each round.
	var/gang_gimmick = "biker_gang"
	var/nick

	var/hat
	var/uniform
	var/suit
	var/shoes
	var/gloves
	var/accessory
	var/weapon

	allow_lobbyjoin = TRUE

	var/list/all_thugs = list()

/datum/antagonist/thug/New()
	..()
	pick_outfit()

/datum/antagonist/thug/proc/get_gang(var/mob/living/carbon/human/gang_mob)
	var/msg

	msg += "<b>Your gang:</b><br>"
	for (var/mob/living/carbon/human/C in all_thugs)
		if(C.mind.special_role == "Thug")
			to_chat(gang_mob, "[nick] <b>[C.name]</b>, the [C.job].")

/datum/antagonist/thug/proc/pick_outfit()
	//Picks a random outfit each round, so thugs have their identity.

	gang_gimmick = pick("skull_crew", "biker_gang", "bandit")

	switch(gang_gimmick)
		if("skull_crew")
			hat = /obj/item/clothing/mask/bandana/skull
			uniform = /obj/item/clothing/under/aristocrat
			suit = /obj/item/clothing/suit/storage/flannel
			shoes = /obj/item/clothing/shoes/hitops/black
			accessory = /obj/item/clothing/accessory/scarf/zebra
			gloves = /obj/item/clothing/gloves/knuckledusters
			weapon = /obj/item/weapon/gun/projectile/pirate
			nick = "Comrade"

		if("biker_gang")
			hat = /obj/item/clothing/mask/bandana/red
			uniform = /obj/item/clothing/under/pants/greyjeans
			suit = /obj/item/clothing/suit/storage/bomber/alt
			shoes = /obj/item/clothing/shoes/boots/combat
			accessory = /obj/item/clothing/accessory/bracelet/material/gold
			gloves = /obj/item/clothing/gloves/fingerless
			weapon = /obj/item/weapon/gun/projectile/luger/brown
			nick = "Biker"

		if("bandit")
			hat = /obj/item/clothing/mask/bandana/gold
			uniform = /obj/item/clothing/under/pants/ripped
			suit = /obj/item/clothing/suit/storage/greyjacket
			shoes = /obj/item/clothing/shoes/boots/combat
			accessory = /obj/item/clothing/mask/balaclava
			gloves = /obj/item/clothing/gloves/brown
			weapon = /obj/item/weapon/gun/projectile/pirate/thug
			nick = "Bandit"

/datum/antagonist/thug/equip(var/mob/living/carbon/human/player)

	if(!..())
		return

	all_thugs += player

	get_gang(player)

	to_chat(player, "<span class='danger'>You remember that you brought your uniform and weapons in a box with you - as discussed from a meeting with your gang...</span>")

	var/obj/item/weapon/storage/box/kit = new(get_turf(player))
	kit.make_nonpersistent() // box contents should be non-persistent, not just the box haha. no free gun for you.
	kit.max_storage_space = 35
	kit.max_w_class = 8
	kit.name = "large strange kit"
	kit.color = "#808080"
	new hat(kit)
	new uniform(kit)
	new suit(kit)
	new shoes(kit)
	new accessory(kit)
	new gloves(kit)
	new weapon(kit)

	// Attempt to put into a container.
	if(player.equip_to_storage(kit))
		return

	// If that failed, attempt to put into any valid non-handslot
	if(player.equip_to_appropriate_slot(kit))
		return

	// If that failed, then finally attempt to at least let the player carry the weapon
	player.put_in_hands(kit)



/datum/antagonist/thug/unequip(var/mob/living/carbon/human/player)
	if(!istype(player))
		return 0

	all_thugs -= player

	return 1