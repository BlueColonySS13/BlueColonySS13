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

/datum/bounty/recycling/dont_box
	name = "Don't Put Me In A Box"
	author = "Sarah Fardeep"
	description = "As we struggle with the highly capitalistic and materialistic reality of our world I will be making an art exhibit to liberate \
	the minds of people in Cascington. Boxes, that is all this one needs."

	items_wanted = list(/obj/item/weapon/storage/box = 8)

	department_reward = 70
	individual_reward = 50

/datum/bounty/recycling/boneman
	name = "Spooky Scary Skeletons"
	author = "Adam Skellington III"
	description = "I run a museum of macabre oddities and knick-nacks. My last supplier met an... unfortunate end but I still \
	do not have enough bones for my main attraction. Please, if you come across any bones, send them to me. You will be handsomely compensated."

	random_items_wanted = list(
	/obj/item/weapon/bone/arm,
	/obj/item/weapon/bone/leg,
	/obj/item/weapon/bone/ribs,
	/obj/item/weapon/bone/skull

	)

	department_reward = 100
	individual_reward = 75

	allow_subtypes = TRUE


/datum/bounty/recycling/absolute_trash
	name = "Absolute Trash"
	author = "Sarah Fardeep"
	description = "We're making a display - no, a statement! I have been arranging junk heaps in a true work of art to critique our wasteful nature. I'm \
	just missing one thing..."

	random_items_wanted = list(
	/obj/item/trash/candle,
	/obj/item/trash/candle/candelabra_stand,
	/obj/item/trash/candy,
	/obj/item/trash/candy/proteinbar,
	/obj/item/trash/cheesie,
	/obj/item/trash/chips,
	/obj/item/trash/liquidfood,
	/obj/item/trash/liquidprotein,
	/obj/item/trash/pistachios,
	/obj/item/trash/plate,
	/obj/item/trash/popcorn,
	/obj/item/trash/raisins,
	/obj/item/trash/semki,
	/obj/item/trash/snack_bowl,
	/obj/item/trash/sosjerky,
	/obj/item/trash/syndi_cakes,
	/obj/item/trash/tastybread,
	/obj/item/trash/tray,
	/obj/item/trash/unajerky,
	/obj/item/trash/waffles
	)

	department_reward = 90
	individual_reward = 50