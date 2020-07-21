/datum/bounty/leisure
	category = CAT_LEISURE

/datum/bounty/leisure/diva_dresses
	name = "Sassy Dresses Needed!"
	author = "Spotlight! Diva Catalogue"
	description = "We need designer brand dresses to be shipped over to us right away, let us know when you can! Muah!"

	random_items_wanted = list(
	/obj/item/clothing/under/dress/flamenco = 1,
	/obj/item/clothing/under/dress/westernbustle = 1,
	/obj/item/clothing/under/dress/red_swept_dress = 1,
	/obj/item/clothing/under/dress/blacktango = 1,
	/obj/item/clothing/under/dress/blacktango/alt = 1,
	/obj/item/clothing/under/dress/redeveninggown = 1,
	/obj/item/clothing/under/dress/black_corset = 1,
	/obj/item/clothing/under/dress/cropdress = 1,
	/obj/item/clothing/under/dress/darkred = 1,
	/obj/item/clothing/under/dress/bluedress = 1,
	/obj/item/clothing/under/dress/twistfront = 1,
	/obj/item/clothing/under/dress/littleblackdress = 1,
	/obj/item/clothing/under/dress/festivedress = 1
	)

	department_reward = 300
	individual_reward = 50

	days_until_expiry = 2



/datum/bounty/leisure/beanies
	name = "High End Beanies"
	author = "Ginger Polluos"
	description = "Right, it says here on the magazine that customers want silk beanies. So that's what we want. Any color, doesn't matter - they are \
	into that avant garde stuff anyway. It has to be made out silk, you hear me?"

	items_wanted = list(/obj/item/clothing/head/beanie = 10)

	department_reward = 600
	individual_reward = 170

	days_until_expiry = 1


/datum/bounty/leisure/beanies/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/clothing/head/beanie))
		if(O.name_unlabel) // to prevent hand labeller cheating
			if(findtext(O.name_unlabel, "silk"))
				return TRUE
			else
				return FALSE

		if(findtext(O.name, "silk"))
			return TRUE

	return FALSE


/datum/bounty/leisure/pucker_up
	name = "Pucker Up"
	author = "Weeland-Yunati Cosmetics Division"
	description = "We need ten lipsticks urgently for an Avant-Garde and revolutionary photoshoot. \
	Hurry! Angelo's foundation is melting! Our designer told us the perfect photo-finish hex color is \
	%MAKEUPCOLOR, no other colors will be accepted."

	items_wanted = list(/obj/item/weapon/lipstick = 8)

	department_reward = 150
	individual_reward = 25

	days_until_expiry = 1

	var/makeup_color = "#FF0000"


/datum/bounty/leisure/pucker_up/setup_bounty()
	makeup_color = "#"+get_random_colour()


/datum/bounty/leisure/pucker_up/replace_all_strings()
	..()
	description = replacetext(description, "%MAKEUPCOLOR", makeup_color)


/datum/bounty/leisure/pucker_up/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/weapon/lipstick))
		var/obj/item/weapon/lipstick/makeup = O

		if(uppertext(makeup.colour) == makeup_color)
			return TRUE

	return FALSE


/datum/bounty/leisure/pucker_up/night_shadow
	name = "Bat Your Lashes"
	author = "Weeland-Yunati Cosmetics Division"
	description = "We're doing makeup for a superhero themed photoshoot. For one of the villains we need an eyeshadow that's powerful \
	and memorable. Our designer said an eyeshadow with %MAKEUPCOLOR would do the trick! You know what to do."

	items_wanted = list(/obj/item/weapon/lipstick/eyeshadow = 8)

	department_reward = 120
	individual_reward = 25

	days_until_expiry = 1


/datum/bounty/leisure/pucker_up/making_me_blush
	name = "Making Me Blush"
	author = "Weeland-Yunati Cosmetics Division"
	description = "We're having an exciting romance based shoot in Blue Colony today for our internet portfolio. The rosey cheeks must \
	be on point as that's what the competition judges mark for. Our designer insists blusher with the color %MAKEUPCOLOR would be the best choice."

	items_wanted = list(/obj/item/weapon/lipstick/blusher = 8)

	department_reward = 120
	individual_reward = 25

	days_until_expiry = 1

/datum/bounty/leisure/jackening
	name = "The Jackening"
	author = "OlasVo Fashion Company"
	description = "Hm, yes. We'll take an order #73. We're advertising coats and jackets, thankfully it sells all year because Blue Colony is a cold, cold place. \
	Need it ASAP."

	random_items_wanted = list(
	/obj/item/clothing/suit/storage/toggle/coat,
	/obj/item/clothing/suit/storage/toggle/leather_jacket,
	/obj/item/clothing/suit/storage/toggle/leather_jacket/sleeveless,
	/obj/item/clothing/suit/storage/leather_jacket_alt,
	/obj/item/clothing/suit/storage/toggle/brown_jacket,
	)

	department_reward = 120
	individual_reward = 25

	days_until_expiry = 1