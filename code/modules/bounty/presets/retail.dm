/datum/bounty/retail
	category = CAT_RETAIL

/datum/bounty/retail/stagecraft
	name = "Stagecraft"
	author = "Mime Serial Number 876"
	description = "Mime Serial Number 876 Imitates typing into keyboard at a terminal and wipes \
	forehead like a momentous task has been completed."

	items_wanted = list(/obj/item/weapon/hand_labeler = 3)

	department_reward = 200
	individual_reward = 30

	days_until_expiry = 1

/datum/bounty/retail/pucker_up
	name = "Pucker Up"
	author = "Weeland-Yunati Cosmetics Division"
	description = "We need ten lipsticks urgently for an Avant-Garde and revolutionary photoshoot. \
	Hurry! Angelo’s foundation is melting! Our designer told us the perfect photo-finish hex color is \
	%MAKEUPCOLOR, no other colors will be accepted."

	items_wanted = list(/obj/item/weapon/lipstick = 8)

	department_reward = 150
	individual_reward = 25

	days_until_expiry = 1

	var/makeup_color = "#FF0000"

/datum/bounty/retail/pucker_up/setup_bounty()
	makeup_color = "#"+get_random_colour()

/datum/bounty/retail/pucker_up/replace_all_strings()
	..()
	description = replacetext(description, "%MAKEUPCOLOR", makeup_color)

/datum/bounty/retail/pucker_up/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/weapon/lipstick))
		var/obj/item/weapon/lipstick/makeup = O

		if(makeup.colour == makeup_color)
			return TRUE

	return FALSE

/datum/bounty/retail/pucker_up/night_shadow
	name = "Bat Your Lashes"
	author = "Weeland-Yunati Cosmetics Division"
	description = "We're doing makeup for a superhero themed photoshoot. For one of the villains we need an eyeshadow that's powerful \
	and memorable. Our designer said an eyeshadow with %MAKEUPCOLOR would do the trick! You know what to do."

	items_wanted = list(/obj/item/weapon/lipstick/eyeshadow = 8)

	department_reward = 150
	individual_reward = 25

	days_until_expiry = 1

/datum/bounty/retail/pucker_up/making_me_blush
	name = "Making Me Blush"
	author = "Weeland-Yunati Cosmetics Division"
	description = "We're having an exciting romance based shoot in Blue Colony today for our internet portfolio. The rosey cheeks must \
	be on point as that's what the competition judges mark for. Our designer insists blusher with the color %MAKEUPCOLOR would be the best choice."

	items_wanted = list(/obj/item/weapon/lipstick/blusher = 8)

	department_reward = 150
	individual_reward = 25

	days_until_expiry = 1

/datum/bounty/retail/inner_toolbox
	name = "Channel Your Inner Che"
	author = "Mime Serial Number 876"
	description = "Working out at home is a big thing again. I am developing a new martial arts video for my \
	“something to do at home” subscription video service. It uses random everyday objects as weapons. Works wonders. \
	This upcoming episode is going to feature toolboxes, so get me fresh ones."

	items_wanted = list(/obj/item/weapon/storage/toolbox/mechanical = 5)

	department_reward = 30
	individual_reward = 5

	days_until_expiry = 2


/datum/bounty/retail/diva_dresses
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

/datum/bounty/retail/gonna_dye
	name = "I'm Gonna Dye"
	author = "Sierra Battoux"
	description = "As a designer hairdresser I must have the most fashionable color for the party. But I can't find my dye bottle for my \
	special dye mix! Someone help me!"

	items_wanted = list(/obj/item/dye_bottle = 1)

	department_reward = 20
	individual_reward = 5

	days_until_expiry = 1


/datum/bounty/retail/ashtray_coof
	name = "It's Getting Ashy In Here"
	author = "Thomas Couf"
	description = "Yeah, so I invited some friends over. We all like to smoke... now my sofa's ruined. Can't find an ashtray anywhere in my \
	area, if you can send two for us it would be great."

	items_wanted = list(/obj/item/weapon/material/ashtray = 2)

	department_reward = 70
	individual_reward = 30

	days_until_expiry = 1
