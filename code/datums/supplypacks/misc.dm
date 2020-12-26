/*
*	Here is where any supply packs
*	that don't belong elsewhere live.
*/


/datum/supply_pack/misc
	group = "Miscellaneous"

/datum/supply_pack/randomised/misc
	group = "Miscellaneous"


/datum/supply_pack/randomised/misc/card_packs
	num_contained = 5
	contains = list(
			/obj/item/weapon/pack/cardemon,
			/obj/item/weapon/pack/spaceball,
			/obj/item/weapon/deck/holder
			)
	name = "Trading Card Crate"
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "cards crate"

/datum/supply_pack/misc/rpg_set
	name = "Tabletop Game and Card Set"
	contains = list(/obj/item/weapon/storage/box/characters,
	/obj/item/weapon/storage/dicecup/loaded,
	/obj/item/weapon/storage/pill_bottle/dice_nerd,
	/obj/item/weapon/deck/cah,
	/obj/item/weapon/deck/cah/black,
	/obj/item/weapon/deck/tarot,
	/obj/item/weapon/deck/cards,
	)

	cost = 50
	containertype = /obj/structure/closet/crate
	containername = "Tabletop Game and Card Set"


/datum/supply_pack/misc/business_cards
	name = "business and invitation cards"
	contains = list(/obj/item/weapon/paper/card/business = 5,
	/obj/item/weapon/paper/card/business/random = 5,
	/obj/item/weapon/paper/card/invitation = 5,
	/obj/item/weapon/paper/card/invitation/random = 5)
	cost = 25
	containername = "Business and invitation cards"

/datum/supply_pack/misc/chaplaingear
	name = "Chaplain equipment"
	contains = list(
			/obj/item/clothing/under/rank/chaplain,
			/obj/item/clothing/shoes/black,
			/obj/item/clothing/suit/nun,
			/obj/item/clothing/head/nun_hood,
			/obj/item/clothing/suit/storage/hooded/chaplain_hoodie,
			/obj/item/clothing/suit/storage/hooded/chaplain_hoodie/whiteout,
			/obj/item/clothing/suit/holidaypriest,
			/obj/item/clothing/under/wedding/bride_white,
			/obj/item/weapon/storage/backpack/cultpack,
			/obj/item/weapon/storage/box/candle_box = 3
			)
	cost = 250
	containertype = "/obj/structure/closet/crate"
	containername = "Chaplain equipment crate"

/datum/supply_pack/randomised/misc/webbing
	name = "Webbing crate"
	num_contained = 4
	contains = list(
			/obj/item/clothing/accessory/storage/black_vest,
			/obj/item/clothing/accessory/storage/brown_vest,
			/obj/item/clothing/accessory/storage/white_vest,
			/obj/item/clothing/accessory/storage/black_drop_pouches,
			/obj/item/clothing/accessory/storage/brown_drop_pouches,
			/obj/item/clothing/accessory/storage/white_drop_pouches,
			/obj/item/clothing/accessory/storage/webbing
			)
	cost = 120
	containertype = "/obj/structure/closet/crate"
	containername = "Webbing crate"
	spend_type = SPEND_WEAPONS

/datum/supply_pack/misc/journalist
	name = "Journalism Kit"
	contains = list(
	/obj/item/device/camera,
	/obj/item/device/tvcamera = 1)
	cost = 230
	containertype = /obj/structure/closet/crate
	containername = "Journalism Kit"
	spend_type = SPEND_OFFICE

/datum/supply_pack/misc/camera_film
	name = "Camera Film Refills"
	contains = list(
	/obj/item/device/camera_film = 5)
	cost = 25
	containertype = /obj/structure/closet/crate
	containername = "Camera Film Refills"
	spend_type = SPEND_OFFICE

/datum/supply_pack/misc/stoneblock
	name = "Sculpting Kit"
	contains = list (
	/obj/structure/sculpting_block = 2,
	/obj/item/weapon/pickaxe/autochisel = 1
	)
	cost = 80
	containertype = /obj/structure/largecrate
	containername = "Sculpting Kit"

/datum/supply_pack/misc/plushie
	name = "Wholesale Plushie crate"
	contains = list(
			/obj/item/toy/plushie/nymph,
				/obj/item/toy/plushie/mouse,
				/obj/item/toy/plushie/kitten,
				/obj/item/toy/plushie/lizard,
				/obj/item/toy/plushie/black_cat,
				/obj/item/toy/plushie/black_fox,
				/obj/item/toy/plushie/blue_fox,
				/obj/random/carp_plushie,
				/obj/item/toy/plushie/coffee_fox,
				/obj/item/toy/plushie/corgi,
				/obj/item/toy/plushie/crimson_fox,
				/obj/item/toy/plushie/deer,
				/obj/item/toy/plushie/girly_corgi,
				/obj/item/toy/plushie/grey_cat,
				/obj/item/toy/plushie/marble_fox,
				/obj/item/toy/plushie/octopus,
				/obj/item/toy/plushie/orange_cat,
				/obj/item/toy/plushie/orange_fox,
				/obj/item/toy/plushie/pink_fox,
				/obj/item/toy/plushie/purple_fox,
				/obj/item/toy/plushie/red_fox,
				/obj/item/toy/plushie/robo_corgi,
				/obj/item/toy/plushie/siamese_cat,
				/obj/item/toy/plushie/spider,
				/obj/item/toy/plushie/tabby_cat,
				/obj/item/toy/plushie/tuxedo_cat,
				/obj/item/toy/plushie/white_cat
				)
	cost = 300
	containertype = "/obj/structure/closet/crate/large"
	containername = "Wholesale Plushie crate"

/datum/supply_pack/misc/cosmetics_set
	name = "Cosmetics Set"
	containername = "Cosmetics Set"
	containertype = "/obj/structure/closet/crate"
	cost = 50
	contains = list(
				/obj/item/weapon/lipstick/red,
				/obj/item/weapon/lipstick/purple,
				/obj/item/weapon/lipstick/jade,
				/obj/item/weapon/lipstick/black,
				/obj/item/weapon/lipstick/maroon,
				/obj/item/weapon/lipstick/pink,
				/obj/item/weapon/lipstick/brown,
				/obj/item/weapon/lipstick/nude,
				/obj/item/weapon/lipstick/blusher/red,
				/obj/item/weapon/lipstick/blusher/purple,
				/obj/item/weapon/lipstick/blusher/jade,
				/obj/item/weapon/lipstick/blusher/black,
				/obj/item/weapon/lipstick/blusher/maroon,
				/obj/item/weapon/lipstick/blusher/pink,
				/obj/item/weapon/lipstick/blusher/brown,
				/obj/item/weapon/lipstick/blusher/nude,
				/obj/item/weapon/lipstick/eyeshadow/red,
				/obj/item/weapon/lipstick/eyeshadow/purple,
				/obj/item/weapon/lipstick/eyeshadow/jade,
				/obj/item/weapon/lipstick/eyeshadow/black,
				/obj/item/weapon/lipstick/eyeshadow/maroon,
				/obj/item/weapon/lipstick/eyeshadow/pink,
				/obj/item/weapon/lipstick/eyeshadow/brown
				)
	containertype = "/obj/structure/closet/crate"

/datum/supply_pack/misc/grooming_set
	name = "Grooming Set"
	containername = "Grooming Set"
	containertype = "/obj/structure/closet/crate"
	cost = 30
	contains = list(
				/obj/item/weapon/haircomb/random = 5,
				/obj/item/weapon/haircomb/brush = 5
				)
	containertype = "/obj/structure/closet/crate"

/datum/supply_pack/misc/barber_set
	name = "Barber Set"
	containername = "Barber Set"
	containertype = "/obj/structure/closet/crate"
	cost = 100
	contains = list(
				/obj/item/weapon/razor = 1,
				/obj/item/weapon/razor/blade = 1,
				/obj/item/weapon/razor/blade/disposable = 5,
				/obj/item/weapon/scissors/barber = 3
				)
	containertype = "/obj/structure/closet/crate"

/datum/supply_pack/misc/hair_trinkets
	name = "Hair Trinket Set"
	containername = "Hair Trinket Set"
	containertype = "/obj/structure/closet/crate"
	cost = 600
	contains = list(
			/obj/item/clothing/head/pin = 3,
			/obj/item/clothing/head/pin/bow = 3,
			/obj/item/clothing/head/pin/butterfly = 3,
			/obj/item/clothing/head/pin/clover = 3,
			/obj/item/clothing/head/pin/flower = 3,
			/obj/item/clothing/head/pin/flower/blue = 3,
			/obj/item/clothing/head/pin/flower/pink = 3,
			/obj/item/clothing/head/pin/flower/yellow = 3,
			/obj/item/clothing/head/pin/flower/violet = 3,
			/obj/item/clothing/head/pin/flower/blue = 3,
			/obj/item/clothing/head/pin/flower/orange = 3,
			/obj/item/clothing/head/pin/flower/white = 3,
			/obj/item/clothing/head/pin/magnetic = 3,
			/obj/item/clothing/head/pin/pink = 3

			)



/datum/supply_pack/misc/umbrella
	name = "Umbrella crate"
	containername = "Umbrella crate"
	containertype = "/obj/structure/closet/crate"
	cost = 45
	contains = list(
				/obj/item/weapon/melee/umbrella/random = 5
				)
	containertype = "/obj/structure/closet/crate"


/datum/supply_pack/misc/mre_rations
	num_contained = 6
	name = "Emergency - MREs"
	contains = list(/obj/item/weapon/storage/mre,
					/obj/item/weapon/storage/mre/menu2,
					/obj/item/weapon/storage/mre/menu3,
					/obj/item/weapon/storage/mre/menu4,
					/obj/item/weapon/storage/mre/menu5,
					/obj/item/weapon/storage/mre/menu6,
					/obj/item/weapon/storage/mre/menu7,
					/obj/item/weapon/storage/mre/menu8,
					/obj/item/weapon/storage/mre/menu9,
					/obj/item/weapon/storage/mre/menu10)
	cost = 400
	containertype = /obj/structure/closet/crate/freezer
	containername = "ready to eat rations"

/datum/supply_pack/misc/calories_scanner
	name = "calories scanners"
	contains = list(/obj/item/device/calories_scanner = 5)

	cost = 40
	containertype = /obj/structure/closet/crate
	containername = "calories scanners"



