/*
*	Here is where any supply packs
*	related to weapons live.
*/


/datum/supply_pack/clothing
	group = "Clothing"

/datum/supply_pack/randomised/clothing
	group = "Clothing"

/datum/supply_pack/clothing/wizard
	name = "Wizard costume"
	contains = list(
			/obj/item/weapon/staff,
			/obj/item/clothing/suit/wizrobe/fake,
			/obj/item/clothing/shoes/sandal,
			/obj/item/clothing/head/wizard/fake
			)
	cost = 300
	containertype = /obj/structure/closet/crate
	containername = "Wizard costume crate"

/datum/supply_pack/randomised/clothing/hats
	num_contained = 4
	contains = list(
			/obj/item/clothing/head/collectable/chef,
			/obj/item/clothing/head/collectable/paper,
			/obj/item/clothing/head/collectable/tophat,
			/obj/item/clothing/head/collectable/captain,
			/obj/item/clothing/head/collectable/beret,
			/obj/item/clothing/head/collectable/welding,
			/obj/item/clothing/head/collectable/flatcap,
			/obj/item/clothing/head/collectable/pirate,
			/obj/item/clothing/head/collectable/wizard,
			/obj/item/clothing/head/collectable/hardhat,
			/obj/item/clothing/head/collectable/HoS,
			/obj/item/clothing/head/collectable/thunderdome,
			/obj/item/clothing/head/collectable/swat,
			/obj/item/clothing/head/collectable/slime,
			/obj/item/clothing/head/collectable/police,
			/obj/item/clothing/head/collectable/slime,
			/obj/item/clothing/head/collectable/xenom,
			/obj/item/clothing/head/collectable/petehat
			)
	name = "Collectable hat crate!"
	cost = 100
	containertype = /obj/structure/closet/crate
	containername = "Collectable hats crate! Brought to you by Bass.inc!"

/datum/supply_pack/randomised/clothing/costume
	num_contained = 3
	contains = list(
			/obj/item/clothing/suit/pirate,
			/obj/item/clothing/suit/judgerobe,
			/obj/item/clothing/accessory/wcoat,
			/obj/item/clothing/suit/hastur,
			/obj/item/clothing/suit/holidaypriest,
			/obj/item/clothing/suit/nun,
			/obj/item/clothing/suit/imperium_monk,
			/obj/item/clothing/suit/ianshirt,
			/obj/item/clothing/under/gimmick/rank/captain/suit,
			/obj/item/clothing/under/gimmick/rank/head_of_personnel/suit,
			/obj/item/clothing/under/lawyer/purpsuit,
			/obj/item/clothing/under/rank/mailman,
			/obj/item/clothing/under/dress/dress_saloon,
			/obj/item/clothing/suit/suspenders,
			/obj/item/clothing/suit/storage/toggle/labcoat/mad,
			/obj/item/clothing/suit/bio_suit/plaguedoctorsuit,
			/obj/item/clothing/under/schoolgirl,
			/obj/item/clothing/under/owl,
			/obj/item/clothing/under/waiter,
			/obj/item/clothing/under/gladiator,
			/obj/item/clothing/under/soviet,
			/obj/item/clothing/under/scratch,
			/obj/item/clothing/under/wedding/bride_white,
			/obj/item/clothing/suit/chef,
			/obj/item/clothing/suit/storage/apron/overalls,
			/obj/item/clothing/under/redcoat,
			/obj/item/clothing/under/kilt
			)
	name = "Costumes crate"
	cost = 200
	containertype = /obj/structure/closet/crate
	containername = "Actor Costumes"

/datum/supply_pack/clothing/formal_wear
	contains = list(
			/obj/item/clothing/head/bowler,
			/obj/item/clothing/head/that,
			/obj/item/clothing/suit/storage/toggle/internalaffairs,
			/obj/item/clothing/suit/storage/toggle/lawyer/bluejacket,
			/obj/item/clothing/suit/storage/toggle/lawyer/purpjacket,
			/obj/item/clothing/under/suit_jacket,
			/obj/item/clothing/under/suit_jacket/female,
			/obj/item/clothing/under/suit_jacket/really_black,
			/obj/item/clothing/under/suit_jacket/red,
			/obj/item/clothing/under/lawyer/bluesuit,
			/obj/item/clothing/under/lawyer/purpsuit,
			/obj/item/clothing/shoes/black = 2,
			/obj/item/clothing/shoes/leather,
			/obj/item/clothing/accessory/wcoat
			)
	name = "Formalwear closet"
	cost = 450
	containertype = /obj/structure/closet
	containername = "Formalwear for the best occasions."

datum/supply_pack/clothing/witch
	name = "Witch costume"
	containername = "Witch costume"
	containertype = /obj/structure/closet
	cost = 50
	contains = list(
			/obj/item/clothing/suit/wizrobe/marisa/fake,
			/obj/item/clothing/shoes/sandal,
			/obj/item/clothing/head/wizard/marisa/fake,
			/obj/item/weapon/staff/broom
			)

/datum/supply_pack/randomised/clothing/costume_hats
	name = "Costume hats"
	containername = "Actor hats crate"
	containertype = /obj/structure/closet/crate
	cost = 70
	num_contained = 3
	contains = list(
			/obj/item/clothing/head/redcoat,
			/obj/item/clothing/head/mailman,
			/obj/item/clothing/head/plaguedoctorhat,
			/obj/item/clothing/head/pirate,
			/obj/item/clothing/head/hasturhood,
			/obj/item/clothing/head/powdered_wig,
			/obj/item/clothing/head/pin/flower,
			/obj/item/clothing/head/pin/flower/yellow,
			/obj/item/clothing/head/pin/flower/blue,
			/obj/item/clothing/head/pin/flower/pink,
			/obj/item/clothing/head/pin/clover,
			/obj/item/clothing/head/pin/butterfly,
			/obj/item/clothing/mask/gas/owl_mask,
			/obj/item/clothing/mask/gas/monkeymask,
			/obj/item/clothing/head/helmet/gladiator,
			/obj/item/clothing/head/ushanka
			)

datum/supply_pack/clothing/wedding
	name = "Womens Wedding Dress Collection"
	containername = "Womens Wedding Dress Collection"
	containertype = /obj/structure/closet
	cost = 450
	contains = list(
			/obj/item/clothing/under/wedding/bride_orange,
			/obj/item/clothing/under/wedding/bride_purple,
			/obj/item/clothing/under/wedding/bride_blue,
			/obj/item/clothing/under/wedding/bride_red,
			/obj/item/clothing/under/wedding/bride_white,
			/obj/item/clothing/under/sundress,
			/obj/item/clothing/under/dress/dress_green,
			/obj/item/clothing/under/dress/dress_pink,
			/obj/item/clothing/under/dress/dress_orange,
			/obj/item/clothing/under/dress/dress_yellow,
			/obj/item/clothing/under/dress/dress_saloon
			)

datum/supply_pack/clothing/jeans
	name = "Jeans Collection"
	containername = "Jeans Collection"
	containertype = /obj/structure/closet
	cost = 450
	contains = list(
			/obj/item/clothing/under/pants,
			/obj/item/clothing/under/pants/black,
			/obj/item/clothing/under/pants/camo,
			/obj/item/clothing/under/pants/classicjeans,
			/obj/item/clothing/under/pants/mustangjeans,
			/obj/item/clothing/under/pants/greyjeans,
			/obj/item/clothing/under/pants/khaki,
			/obj/item/clothing/under/pants/leather,
			/obj/item/clothing/under/pants/red,
			/obj/item/clothing/under/pants/ripped,
			/obj/item/clothing/under/pants/tan,
			/obj/item/clothing/under/pants/white,
			/obj/item/clothing/under/pants/youngfolksjeans
			)


datum/supply_pack/clothing/jeans_ripped
	name = "Ripped Jeans Collection"
	containername = "Ripped Jeans Collection"
	containertype = /obj/structure/closet
	cost = 350
	contains = list(
			/obj/item/clothing/under/pants/ripped,
			/obj/item/clothing/under/pants/blackjeans/ripped,
			/obj/item/clothing/under/pants/classicjeans/ripped,
			/obj/item/clothing/under/pants/mustangjeans/ripped,
			/obj/item/clothing/under/pants/greyjeans/ripped
			)

datum/supply_pack/clothing/baggy_pants
	name = "Baggy Pants Collection"
	containername = "Baggy Pants Collection"
	containertype = /obj/structure/closet
	cost = 380
	contains = list(
			/obj/item/clothing/under/pants/baggy/black,
			/obj/item/clothing/under/pants/baggy/blackjeans,
			/obj/item/clothing/under/pants/baggy/camo,
			/obj/item/clothing/under/pants/baggy/classicjeans,
			/obj/item/clothing/under/pants/baggy/greyjeans,
			/obj/item/clothing/under/pants/baggy/khaki,
			/obj/item/clothing/under/pants/baggy/mustangjeans,
			/obj/item/clothing/under/pants/baggy/red,
			/obj/item/clothing/under/pants/baggy/tan,
			/obj/item/clothing/under/pants/baggy/track,
			/obj/item/clothing/under/pants/baggy/white,
			/obj/item/clothing/under/pants/baggy/youngfolksjeans
			)


datum/supply_pack/clothing/track_pants
	name = "Track Pants Collection"
	containername = "Track Pants Collection"
	containertype = /obj/structure/closet
	cost = 180
	contains = list(
			/obj/item/clothing/under/pants/track,
			/obj/item/clothing/under/pants/track/blue,
			/obj/item/clothing/under/pants/track/green,
			/obj/item/clothing/under/pants/track/red,
			/obj/item/clothing/under/pants/track/white,
			/obj/item/clothing/under/pants/baggy/khaki
			)


datum/supply_pack/clothing/polychromatic
	name = "Polychromatic Clothes Collection"
	containername = "Polychromatic Clothes Collection"
	containertype = /obj/structure/closet
	cost = 600
	contains = list(
			/obj/item/clothing/under/polychromic/shimatank,
			/obj/item/clothing/under/polychromic/bottomless,
			/obj/item/clothing/under/polychromic/shortpants/pantsu,
			/obj/item/clothing/under/polychromic/femtank,
			/obj/item/clothing/under/polychromic/pleat,
			/obj/item/clothing/under/polychromic/shortpants,
			/obj/item/clothing/under/polychromic/jumpsuit,
			/obj/item/clothing/under/polychromic/shorts,
			/obj/item/clothing/under/polychromic/skirt,
			/obj/item/clothing/under/polychromic/kilt,
			/obj/item/clothing/under/polychromic/shirt
			)

datum/supply_pack/clothing/castor_import_clothing
	name = "Castor Imported Clothing"
	containername = "Castor Imported Clothing"
	containertype = /obj/structure/closet
	cost = 3000
	contains = list(
			/obj/item/clothing/under/aristocrat = 5,
			/obj/item/clothing/accessory/tie/cravat = 5,
			/obj/item/clothing/under/arisgroom = 2,
			/obj/item/clothing/under/arisbestman = 2,
			/obj/item/clothing/suit/tailcoat = 3,
			/obj/item/clothing/suit/tailcoat/ladies = 3,
			/obj/item/clothing/suit/tailcoat/ladies/red = 3,
			/obj/item/clothing/head/bowler = 3,
			/obj/item/clothing/head/bowlerhat = 3,
			/obj/item/clothing/head/collectable/tophat = 3
			)

datum/supply_pack/clothing/cascington_import_clothing
	name = "Cascington Imported Clothing"
	containername = "Cascington Imported Clothing"
	containertype = /obj/structure/closet
	cost = 1200
	contains = list(
			/obj/item/clothing/suit/storage/toggle/peacoat = 3,
			/obj/item/clothing/suit/storage/toggle/dress = 3,
			/obj/item/clothing/under/blazer = 2,
			/obj/item/clothing/under/blazer/skirt = 2,
			/obj/item/clothing/suit/storage/poshblazer = 3,
			/obj/item/clothing/under/dress/vneck = 2
			)


