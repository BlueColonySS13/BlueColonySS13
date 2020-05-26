/decl/hierarchy/outfit/job/business
	name = OUTFIT_JOB_NAME("business")

/decl/hierarchy/outfit/job/business/formal
	name = OUTFIT_COSTUME("Formal")
	uniform = /obj/item/clothing/under/suit_jacket{ starting_accessories=list(/obj/item/clothing/accessory/wcoat) }
	shoes = /obj/item/clothing/shoes/black
	gloves = /obj/item/clothing/gloves/black
	shoes = /obj/item/clothing/shoes/dress


/decl/hierarchy/outfit/job/business/mailman
	name = OUTFIT_JOB_NAME("Mailman")
	uniform = /obj/item/clothing/under/rank/mailman

/decl/hierarchy/outfit/job/business/bartender
	name = OUTFIT_JOB_NAME("Bartender")
	uniform = /obj/item/clothing/under/rank/bartender
	pda_type = /obj/item/device/pda/bar
	backpack_contents = list(/obj/item/clothing/accessory/permit/gun/tier_three/bar = 1)

/decl/hierarchy/outfit/job/service/bartender/post_equip(mob/living/carbon/human/H)
	..()
	for(var/obj/item/clothing/accessory/permit/gun/tier_three/bar/permit in H.back.contents)
		permit.set_name(H.real_name)

/decl/hierarchy/outfit/job/business/chef
	name = OUTFIT_JOB_NAME("Chef")
	uniform = /obj/item/clothing/under/rank/chef
	suit = /obj/item/clothing/suit/chef
	head = /obj/item/clothing/head/chefhat

/decl/hierarchy/outfit/job/business/bartender/barista
	name = OUTFIT_JOB_NAME("Barista")
	backpack_contents = null

/decl/hierarchy/outfit/job/business/bartender/waiter
	name = OUTFIT_JOB_NAME("Waiter")
	uniform = /obj/item/clothing/under/waiter
	backpack_contents = null

/decl/hierarchy/outfit/job/business/barber
	name = OUTFIT_JOB_NAME("Barber")
	uniform = /obj/item/clothing/under/rank/barber
	r_pocket = /obj/item/weapon/scissors/barber


/decl/hierarchy/outfit/job/business/journalist
	name = OUTFIT_JOB_NAME("Journalist")
	uniform = /obj/item/clothing/under/suit_jacket/red
	pda_type = /obj/item/device/pda/librarian

/decl/hierarchy/outfit/job/business/explorer
	name = OUTFIT_JOB_NAME("Explorer")
	shoes = /obj/item/clothing/shoes/boots/winter/explorer
	uniform = /obj/item/clothing/under/explorer
	mask = /obj/item/clothing/mask/gas/explorer
	suit = /obj/item/clothing/suit/storage/hooded/explorer
	gloves = /obj/item/clothing/gloves/black
	l_ear = /obj/item/device/radio/headset
	id_pda_assignment = "Explorer"

/decl/hierarchy/outfit/job/business/priest
	name = OUTFIT_JOB_NAME("Priest")
	uniform = /obj/item/clothing/under/rank/chaplain
	l_hand = /obj/item/weapon/storage/bible
	pda_type = /obj/item/device/pda/chaplain

/decl/hierarchy/outfit/job/business/janitor
	name = OUTFIT_JOB_NAME("Janitor")
	uniform = /obj/item/clothing/under/rank/janitor


/decl/hierarchy/outfit/job/business/gardener
	name = OUTFIT_JOB_NAME("Gardener")
	uniform = /obj/item/clothing/under/rank/hydroponics
	suit = /obj/item/clothing/suit/storage/apron
	gloves = /obj/item/clothing/gloves/botanic_leather
	backpack = /obj/item/weapon/storage/backpack/hydroponics
	satchel_one = /obj/item/weapon/storage/backpack/satchel/hyd
	messenger_bag = /obj/item/weapon/storage/backpack/messenger/hyd
