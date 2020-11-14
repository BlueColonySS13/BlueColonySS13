/decl/hierarchy/outfit/job/assistant
	name = OUTFIT_JOB_NAME("Civilian")
	id_type = /obj/item/weapon/card/id/assistant
	uniform = /obj/item/clothing/under/rank/orderly

/decl/hierarchy/outfit/job/assistant/visitor
	name = OUTFIT_JOB_NAME("Visitor")
	id_pda_assignment = "Visitor"
	uniform = /obj/item/clothing/under/suit_jacket/tan

/decl/hierarchy/outfit/job/assistant/socialite
	name = OUTFIT_JOB_NAME("Socialite")
	id_pda_assignment = "Socialite"
	uniform = /obj/item/clothing/under/aristocrat

/decl/hierarchy/outfit/job/assistant/resident
	name = OUTFIT_JOB_NAME("Resident")
	id_pda_assignment = "Resident"
	uniform = /obj/item/clothing/under/scratch


/decl/hierarchy/outfit/job/service/janitor
	name = OUTFIT_JOB_NAME("Janitor")
	suit = /obj/item/clothing/suit/storage/toggle/hivisjacket
	uniform = /obj/item/clothing/under/rank/janitor
	id_type = /obj/item/weapon/card/id/civilian/janitor
	pda_type = /obj/item/device/pda/janitor



/decl/hierarchy/outfit/job/civilian/chaplain
	name = OUTFIT_JOB_NAME("Chaplain")
	uniform = /obj/item/clothing/under/rank/chaplain
	l_hand = /obj/item/weapon/storage/bible
	id_type = /obj/item/weapon/card/id/civilian/chaplain
	pda_type = /obj/item/device/pda/chaplain


/decl/hierarchy/outfit/job/heads/judge
	name = OUTFIT_JOB_NAME("Judge")
	l_ear = /obj/item/device/radio/headset/headset_judge
	uniform = /obj/item/clothing/under/suit_jacket/charcoal
	head = /obj/item/clothing/head/powdered_wig
	suit = /obj/item/clothing/suit/judgerobe
	shoes = /obj/item/clothing/shoes/laceup
	l_hand = /obj/item/weapon/clipboard
	id_type = /obj/item/weapon/card/id/heads/judge
	pda_type = /obj/item/device/pda/lawyer
	backpack_contents = list(/obj/item/clothing/accessory/permit/gun/tier_three = 1,
	/obj/item/weapon/card/department/law = 1)

/decl/hierarchy/outfit/job/heads/judge/post_equip(mob/living/carbon/human/H)
	..()
	for(var/obj/item/clothing/accessory/permit/gun/tier_three/permit in H.back.contents)
		permit.set_name(H.real_name)

/decl/hierarchy/outfit/job/civilian/defense/defense
	name = OUTFIT_JOB_NAME("Defense Attorney")
	l_ear = /obj/item/device/radio/headset/headset_legal
	uniform = /obj/item/clothing/under/lawyer/blue
	suit = /obj/item/clothing/suit/storage/toggle/lawyer/bluejacket
	shoes = /obj/item/clothing/shoes/black
	glasses = /obj/item/clothing/glasses/sunglasses/big
	l_hand = /obj/item/weapon/clipboard
	id_type = /obj/item/weapon/card/id/civilian/defense
	pda_type = /obj/item/device/pda/lawyer

/decl/hierarchy/outfit/job/prosecution
	name = OUTFIT_JOB_NAME("District Prosecutor")
	l_ear = /obj/item/device/radio/headset/ia
	uniform = /obj/item/clothing/under/lawyer/purpsuit
	suit = /obj/item/clothing/suit/storage/toggle/lawyer/purpjacket
	shoes = /obj/item/clothing/shoes/brown
	glasses = /obj/item/clothing/glasses/sunglasses/big
	id_type = /obj/item/weapon/card/id/security/prosecutor
	pda_type = /obj/item/device/pda/lawyer

/decl/hierarchy/outfit/job/civilian/secretary
	name = OUTFIT_JOB_NAME("Secretary")
	l_ear = /obj/item/device/radio/headset/headset_com
	shoes = /obj/item/clothing/shoes/brown
	id_type = /obj/item/weapon/card/id/civilian/secretary

/decl/hierarchy/outfit/job/civilian/secretary/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/suit_jacket/checkered/skirt
	else
		uniform = /obj/item/clothing/under/suit_jacket/checkered


/decl/hierarchy/outfit/job/civilian/prisoner
	name = OUTFIT_JOB_NAME("Prisoner")
	id_pda_assignment = "Prisoner"
	uniform = /obj/item/clothing/under/color/orange/prisoneralt
	shoes = /obj/item/clothing/shoes/orange
	backpack_contents = list(/obj/item/weapon/storage/mre/menu13 = 2)
