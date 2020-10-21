/decl/hierarchy/outfit/job/business
	name = OUTFIT_JOB_NAME("business")
	pda_slot = slot_belt

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

/decl/hierarchy/outfit/job/business/bartender/waiter/red
	name = OUTFIT_JOB_NAME("High End Waiter (Red)")
	uniform = /obj/item/clothing/under/sl_suit{ starting_accessories=list(/obj/item/clothing/accessory/wcoat/red) }
	shoes = /obj/item/clothing/shoes/dress
	gloves = /obj/item/clothing/gloves/white
	
/decl/hierarchy/outfit/job/business/bartender/waiter/grey
	name = OUTFIT_JOB_NAME("High End Waiter (Grey)")
	uniform = /obj/item/clothing/under/sl_suit{ starting_accessories=list(/obj/item/clothing/accessory/wcoat/grey) }
	shoes = /obj/item/clothing/shoes/dress
	gloves = /obj/item/clothing/gloves/white

/decl/hierarchy/outfit/job/business/bartender/waiter/brown
	name = OUTFIT_JOB_NAME("High End Waiter (Brown)")
	uniform = /obj/item/clothing/under/sl_suit{ starting_accessories=list(/obj/item/clothing/accessory/wcoat/brown) }
	shoes = /obj/item/clothing/shoes/dress
	gloves = /obj/item/clothing/gloves/white

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

/decl/hierarchy/outfit/job/business/engineer
	name = OUTFIT_JOB_NAME("Engineer")
	head = /obj/item/clothing/head/hardhat
	uniform = /obj/item/clothing/under/rank/engineer
	suit = /obj/item/clothing/suit/storage/toggle/hivisjacket
	pda_type = /obj/item/device/pda/engineering
	shoes = /obj/item/clothing/shoes/boots/workboots
	backpack = /obj/item/weapon/storage/backpack/industrial
	satchel_one = /obj/item/weapon/storage/backpack/satchel/eng
	messenger_bag = /obj/item/weapon/storage/backpack/messenger/engi
	pda_slot = slot_l_store

/decl/hierarchy/outfit/job/business/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/rank/scientist
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/device/pda/science
	backpack = /obj/item/weapon/storage/backpack/toxins
	satchel_one = /obj/item/weapon/storage/backpack/satchel/tox
	messenger_bag = /obj/item/weapon/storage/backpack/messenger/tox

/decl/hierarchy/outfit/job/business/doctor
	name = OUTFIT_JOB_NAME("Doctor")
	uniform = /obj/item/clothing/under/rank/medical
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/device/pda/medical
	backpack = /obj/item/weapon/storage/backpack/medic
	satchel_one = /obj/item/weapon/storage/backpack/satchel/med
	messenger_bag = /obj/item/weapon/storage/backpack/messenger/med

/decl/hierarchy/outfit/job/business/nurse
	name = OUTFIT_JOB_NAME("Nurse")
	uniform = /obj/item/clothing/under/rank/medical/scrubs
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/device/pda/medical
	backpack = /obj/item/weapon/storage/backpack/medic
	satchel_one = /obj/item/weapon/storage/backpack/satchel/med
	messenger_bag = /obj/item/weapon/storage/backpack/messenger/med

/decl/hierarchy/outfit/job/business/casual
	name = OUTFIT_JOB_NAME("Business Casual")
	uniform = /obj/item/clothing/under/sl_suit
	shoes = /obj/item/clothing/shoes/laceup
	
/decl/hierarchy/outfit/job/business/clown
	name = OUTFIT_JOB_NAME("Clown")
	uniform = /obj/item/clothing/under/rank/clown
	shoes = /obj/item/clothing/shoes/clown_shoes
	backpack = /obj/item/weapon/storage/backpack/clown
	head = /obj/item/clothing/mask/gas/clown_hat
	r_pocket = /obj/item/weapon/bikehorn
	
/decl/hierarchy/outfit/job/business/mime
	name = OUTFIT_JOB_NAME("Mime")
	uniform = /obj/item/clothing/under/mime
	shoes = /obj/item/clothing/shoes/mime
	head = /obj/item/clothing/head/beret
