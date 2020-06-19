/datum/bounty/recycling
	category = CAT_JANITOR

/datum/bounty/recycling/packet_curtains
	name = "Packets for Curtains!"
	author = "The Eco Charity"
	description = "Plastic recycling is so important for our economy and planet. If you please, send us some bread tube packets. \
	We'll use it for the Ando-shower curtain company that needs it. God bless."

	items_wanted = list(/obj/item/trash/tastybread = 5)

	department_reward = 30
	individual_reward = 10

	days_until_expiry = 5

/datum/bounty/recycling/reduce_reuse
	name = "Reduce, Reuse, and Recycle!"
	author = "Blue Colony Commitee of Environmentalism"
	description = "We've already ruined one planet with our wasteful ways and non-biodegradable waste! Do a good deed today \
	and get paid while you're at it! Pick up any cardboard boxes you find out on the streets and send it to us for recycling! Let's keep \
	Pollux clean for future generations! Be sure to flatten the boxes before sending them!"

	items_wanted = list(/obj/item/stack/material/cardboard = 30)

	department_reward = 150
	individual_reward = 50

/datum/bounty/recycling/boneman
	name = "Spooky Scary Skeletons"
	author = "Adam Skellington III"
	description = "I run a museum of macabre oddities and knick-nacks. My last supplier met an... unfortunate end but I still \
	do not have enough bones for my main attraction. Please, if you come across any bones, send them to me. You will be handsomely compensated."

	items_wanted = list(/obj/item/weapon/bone = 4)

	department_reward = 200
	individual_reward = 75

/datum/bounty/recycling/boneman/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/weapon/bone))
		return TRUE

	return FALSE