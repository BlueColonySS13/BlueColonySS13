/datum/bounty/agriculture
	category = CAT_FARM

/datum/bounty/agriculture/vape_weed
	name = "Vape Weed"
	author = "Green eVape Pharma"
	description = "Yes, we vape. We're looking to sell THC and CBD vape fluid, we're lacking in both at the moment and plan to make more. \
	We'll shoot a decent sum if you send us 30 cannabis plants so we can make the stoners happy. Peace and, no deus strains, please."

	grown_wanted = list("cannabis" = 30)

	department_reward = 260
	individual_reward = 40

	days_until_expiry = 1

/datum/bounty/agriculture/potato_famine
	name = "Potato Famine"
	author = "Andromedan Shipping Incorporated"
	description = "We were scheduled to deliver an annual restock of the potato seed stores on Andromeda, \
	but a potato blight somehow managed to get onto the ship. We need to speed up our acquisition, ASAP. \
	It's not too much, since it's just seed stock, though."

	grown_wanted = list("potato" = 40)

	department_reward = 250
	individual_reward = 40

	days_until_expiry = 1

/datum/bounty/agriculture/catsup
	name = "Make up Catsup"
	author = "Impersonator Reggie"
	description = "I have to make this room look like a crime scene. I need a lot of Catsup in order to make \
	the police think that there is a lot of blood. I know, I am a pretty original thinker. \
	Don't copy that idea though, it's mine."

	grown_wanted = list("tomato" = 20)

	department_reward = 100
	individual_reward = 20

	days_until_expiry = 1

/datum/bounty/agriculture/lemon_genes
	name = "Weak Genes"
	author = "Melvis Press"
	description = "I eat cereal with lemonade."

	grown_wanted = list("lemon" = 3)

	department_reward = 80
	individual_reward = 10

	days_until_expiry = 1

/datum/bounty/agriculture/birthday_egg
	name = "Birthday Egg Crisis"
	author = "Charleston Catering Company"
	description = "This is a disaster! We need a box full of twelve eggs, we're baking a massive cake for our son's birthday party \
	tomorrow and have run out. Please send it in an egg box, we don't accept loose eggs."

	items_wanted = list(/obj/item/weapon/storage/fancy/egg_box = 1)

	department_reward = 140
	individual_reward = 50

	days_until_expiry = 1

/datum/bounty/agriculture/birthday_egg/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/weapon/storage/fancy/egg_box))
		var/obj/item/weapon/storage/fancy/egg_box/eggbox = O

		var/eggcount = 0
		for(var/obj/E in eggbox.GetAllContents())
			if(istype(E, /obj/item/weapon/reagent_containers/food/snacks/egg))
				eggcount++

		if(eggcount >= 12)
			return TRUE

	return FALSE