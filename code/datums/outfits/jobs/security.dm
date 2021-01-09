/decl/hierarchy/outfit/job/security
	hierarchy_type = /decl/hierarchy/outfit/job/security
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	l_ear = /obj/item/device/radio/headset/headset_sec
	gloves = /obj/item/clothing/gloves/black
	shoes = /obj/item/clothing/shoes/boots/jackboots
	l_hand = /obj/item/weapon/book/manual/sop
	backpack = /obj/item/weapon/storage/backpack/security
	satchel_one = /obj/item/weapon/storage/backpack/satchel/sec
	backpack_contents = list(/obj/item/weapon/handcuffs = 1,
	/obj/item/clothing/accessory/permit/gun/tier_four = 1,
	/obj/item/device/holowarrant = 1)

	messenger_bag = /obj/item/weapon/storage/backpack/messenger/sec

/decl/hierarchy/outfit/job/security/post_equip(mob/living/carbon/human/H)
	..()
	for(var/obj/item/clothing/accessory/permit/gun/tier_four/permit in H.back.contents)
		permit.set_name(H.real_name)

/decl/hierarchy/outfit/job/security/hos
	name = OUTFIT_JOB_NAME("Chief of Police")
	head = /obj/item/clothing/head/police/policechiefcap
	l_ear = /obj/item/device/radio/headset/heads/hos
	uniform = /obj/item/clothing/under/rank/policechiefalt
	id_type = /obj/item/weapon/card/id/security/head
	pda_type = /obj/item/device/pda/heads/hos
	backpack_contents = list(/obj/item/weapon/handcuffs = 1,
	/obj/item/clothing/accessory/permit/gun/tier_four = 1,
	/obj/item/device/holowarrant = 1,
	/obj/item/weapon/card/department/police = 1)


/decl/hierarchy/outfit/job/security/warden
	name = OUTFIT_JOB_NAME("Prison Warden")
	head = /obj/item/clothing/head/police/policewardencap
	uniform = /obj/item/clothing/under/rank/wardenalt
	l_pocket = /obj/item/device/flash
	id_type = /obj/item/weapon/card/id/security/warden
	pda_type = /obj/item/device/pda/warden

//
// /decl/hierarchy/outfit/job/security/warden/pre_equip(mob/living/carbon/human/H)
//	..()
//	if(H.gender == FEMALE)
//		uniform = /obj/item/clothing/under/rank/warden/skirt

/decl/hierarchy/outfit/job/security/detective
	name = OUTFIT_JOB_NAME("Detective")
	head = /obj/item/clothing/head/det
	uniform = /obj/item/clothing/under/det
	suit = /obj/item/clothing/suit/storage/det_trench
	l_pocket = /obj/item/weapon/flame/lighter/zippo
	shoes = /obj/item/clothing/shoes/laceup
	id_type = /obj/item/weapon/card/id/security/detective
	pda_type = /obj/item/device/pda/detective
	backpack = /obj/item/weapon/storage/backpack
	satchel_one = /obj/item/weapon/storage/backpack/satchel/norm
	backpack_contents = list(/obj/item/weapon/storage/box/evidence = 1,
	/obj/item/clothing/accessory/permit/gun/tier_four = 1)

/decl/hierarchy/outfit/job/security/detective/forensic
	name = OUTFIT_JOB_NAME("Forensic technician")
	head = null
	suit = /obj/item/clothing/suit/storage/forensics/blue

/decl/hierarchy/outfit/job/security/officer
	name = OUTFIT_JOB_NAME("Police Officer")
	head = /obj/item/clothing/head/police/policeofficercap
	uniform = /obj/item/clothing/under/rank/policeofficeralt
	l_pocket = /obj/item/device/flash
	id_type = /obj/item/weapon/card/id/security/officer
	pda_type = /obj/item/device/pda/security

/decl/hierarchy/outfit/job/security/traffic
	name = OUTFIT_JOB_NAME("Traffic Warden")
	head = /obj/item/clothing/head/police/policetrafficcap
	uniform = /obj/item/clothing/under/rank/policetrafficalt
	suit = /obj/item/clothing/suit/storage/toggle/hazardvest/brightgreen
	l_pocket = /obj/item/device/flash
	id_type = /obj/item/weapon/card/id/security/officer
	pda_type = /obj/item/device/pda/security
	backpack_contents = list(/obj/item/device/camera = 1)

/decl/hierarchy/outfit/job/security/cadet
	name = OUTFIT_JOB_NAME("Police Cadet")
	head = /obj/item/clothing/head/police/policecadetcap
	uniform = /obj/item/clothing/under/rank/policecadetalt
	l_pocket = /obj/item/device/flash
	id_type = /obj/item/weapon/card/id/security/officer
	pda_type = /obj/item/device/pda/security

