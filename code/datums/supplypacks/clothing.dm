/*
*	Here is where any supply packs
*	related to weapons live.
*/


/datum/supply_pack/clothing
	group = "Clothing"
	spend_type = SPEND_GROOMING

/datum/supply_pack/randomised/clothing
	group = "Clothing"
	spend_type = SPEND_GROOMING

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
			/obj/item/clothing/under/pants/blue,
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


datum/supply_pack/clothing/bag_collection
	name = "Various Bags (Bulk)"
	containername = "Various Bags (Bulk)"
	containertype = /obj/structure/closet
	cost = 100
	contains = list(
			/obj/item/weapon/storage/backpack/satchel = 5,
			/obj/item/weapon/storage/backpack/dufflebag = 5,
			/obj/item/weapon/storage/backpack/purse = 5,
			/obj/item/weapon/storage/backpack/messenger = 5,
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
			/obj/item/clothing/under/dress/vneck = 2,
			/obj/item/clothing/under/dress/pinktutu = 2
			)

datum/supply_pack/clothing/cascington_import_bags
	name = "Cascington Imported Bags"
	containername = "Cascington Imported Bags"
	containertype = /obj/structure/closet
	cost = 800
	contains = list(
			/obj/item/weapon/storage/briefcase/clutch/obsidienne = 5,
			/obj/item/weapon/storage/wallet/obsidienne = 5,
			/obj/item/weapon/storage/backpack/purse/obsidienne = 5,
			/obj/item/weapon/storage/backpack/satchel/obsidienne = 5,
			)


datum/supply_pack/clothing/dress_collection
	name = "Dress Collection"
	containername = "Dress Collection"
	containertype = /obj/structure/closet
	cost = 400
	contains = list(
	/obj/item/clothing/under/oldwoman,
	/obj/item/clothing/under/dress/dress_orange,
	/obj/item/clothing/under/dress/flamenco,
	/obj/item/clothing/under/dress/westernbustle,
	/obj/item/clothing/under/dress/flower_dress,
	/obj/item/clothing/under/dress/red_swept_dress,
	/obj/item/clothing/under/dress/dress_green,
	/obj/item/clothing/under/dress/blacktango,
	/obj/item/clothing/under/dress/blacktango/alt,
	/obj/item/clothing/under/dress/redeveninggown,
	/obj/item/clothing/under/dress/stripeddress,
	/obj/item/clothing/under/dress/dress_saloon,
	/obj/item/clothing/under/dress/dress_fire,
	/obj/item/clothing/under/dress/dress_hr,
	/obj/item/clothing/under/dress/dress_green,
	/obj/item/clothing/under/dress/black_corset,
	/obj/item/clothing/under/sundress,
	/obj/item/clothing/under/sundress_white,
	/obj/item/clothing/under/dress/polka,
	/obj/item/clothing/under/dress/cropdress,
	/obj/item/clothing/under/dress/darkred,
	/obj/item/clothing/under/dress/bluedress,
	/obj/item/clothing/under/dress/twistfront,
	/obj/item/clothing/under/dress/wench,
	/obj/item/clothing/under/dress/littleblackdress,
	/obj/item/clothing/under/dress/festivedress
	)

datum/supply_pack/clothing/skirt_collection
	name = "Skirt Collection"
	containername = "Skirt Collection"
	containertype = /obj/structure/closet
	cost = 200
	contains = list(
	/obj/item/clothing/under/skirt,
	/obj/item/clothing/under/skirt/khaki,
	/obj/item/clothing/under/skirt/blue,
	/obj/item/clothing/under/skirt/red,
	/obj/item/clothing/under/skirt/swept,
	/obj/item/clothing/under/skirt/denim,
	/obj/item/clothing/under/skirt/pencil,
	/obj/item/clothing/under/skirt/pleated,
	/obj/item/clothing/under/skirt/outfit/plaid_blue,
	/obj/item/clothing/under/skirt/outfit/plaid_purple,
	/obj/item/clothing/under/skirt/outfit/plaid_red
	)

datum/supply_pack/clothing/swimsuits
	name = "Swimsuits"
	containername = "Swimsuits Collection"
	containertype = /obj/structure/closet
	cost = 20
	contains = list(
				/obj/item/clothing/under/swimsuit/black,
				/obj/item/clothing/under/swimsuit/blue,
				/obj/item/clothing/under/swimsuit/purple,
				/obj/item/clothing/under/swimsuit/green,
				/obj/item/clothing/under/swimsuit/red,
				/obj/item/clothing/under/swimsuit/striped,
				/obj/item/clothing/under/swimsuit/white,
				/obj/item/clothing/under/swimsuit/earth
				)


datum/supply_pack/clothing/croptops
	name = "Croptops Collection"
	containername = "Croptops Collection"
	containertype = /obj/structure/closet
	cost = 30
	contains = list(
	/obj/item/clothing/under/croptop,
	/obj/item/clothing/under/croptop/grey,
	/obj/item/clothing/under/croptop/red,
	/obj/item/clothing/under/cuttop,
	/obj/item/clothing/under/cuttop/red)


datum/supply_pack/clothing/hats
	name = "Hat Collection"
	containername = "Hat Collection"
	containertype = /obj/structure/closet
	cost = 130
	contains = list(
						/obj/item/clothing/head/beaverhat,
						/obj/item/clothing/head/fedora,
						/obj/item/clothing/head/fez,
						/obj/item/clothing/head/feathertrilby,
						/obj/item/clothing/head/flatcap,
						/obj/item/clothing/head/hasturhood,
						/obj/item/clothing/head/soft/blue,
						/obj/item/clothing/head/soft/black,
						/obj/item/clothing/head/soft/rainbow,
						/obj/item/clothing/head/soft/mime,
						/obj/item/clothing/head/bandana,
						/obj/item/clothing/head/orangebandana,
						/obj/item/clothing/head/greenbandana,
						/obj/item/clothing/head/pin/butterfly,
						/obj/item/clothing/head/pin/flower,
						/obj/item/clothing/head/pin/flower/blue,
						/obj/item/clothing/head/pin/flower/orange,
						/obj/item/clothing/head/pin/flower/pink,
						/obj/item/clothing/head/pin/flower/violet,
						/obj/item/clothing/head/pin/flower/white,
						/obj/item/clothing/head/pin/flower/yellow,
						/obj/item/clothing/head/pin/pink,
						/obj/item/clothing/head/beanie,
						/obj/item/clothing/head/soft/green,
						/obj/item/clothing/head/soft/grey,
						/obj/item/clothing/head/soft/mime,
						/obj/item/clothing/head/soft/purple,
						/obj/item/clothing/head/soft/orange,
						/obj/item/clothing/head/soft/purple,
						/obj/item/clothing/head/soft/red,
						/obj/item/clothing/head/soft/yellow,
						/obj/item/clothing/head/lavender_crown,
						/obj/item/clothing/head/poppy_crown,
						/obj/item/clothing/head/sunflower_crown)

datum/supply_pack/clothing/shoes
	name = "Generic Shoes Collection"
	containername = "Generic Shoes Collection"
	containertype = /obj/structure/closet
	cost = 130
	contains = list(/obj/item/clothing/shoes/sandal,
						/obj/item/clothing/shoes/black,
						/obj/item/clothing/shoes/brown,
						/obj/item/clothing/shoes/blue,
						/obj/item/clothing/shoes/green,
						/obj/item/clothing/shoes/yellow,
						/obj/item/clothing/shoes/purple,
						/obj/item/clothing/shoes/orange,
						/obj/item/clothing/shoes/red,
						/obj/item/clothing/shoes/white,
						/obj/item/clothing/shoes/rainbow,
						/obj/item/clothing/shoes/hitops,
						/obj/item/clothing/shoes/hitops/black,
						/obj/item/clothing/shoes/hitops/brown,
						/obj/item/clothing/shoes/hitops/blue,
						/obj/item/clothing/shoes/hitops/green,
						/obj/item/clothing/shoes/hitops/yellow,
						/obj/item/clothing/shoes/hitops/purple,
						/obj/item/clothing/shoes/hitops/orange,
						/obj/item/clothing/shoes/hitops/red,
						/obj/item/clothing/shoes/swimmingfins,
						/obj/item/clothing/shoes/leather,
						/obj/item/clothing/shoes/dress,
						/obj/item/clothing/shoes/dress/white,
						/obj/item/clothing/shoes/boots/winter,
						/obj/item/clothing/shoes/skater,
						/obj/item/clothing/shoes/laceup,
						/obj/item/clothing/shoes/slippers,

						)



datum/supply_pack/clothing/stylish_boots
	name = "Stylish Boots Selection"
	containername = "Generic Shoes Collection"
	containertype = /obj/structure/closet
	cost = 200
	contains = list(/obj/item/clothing/shoes/boots/stylish = 2,
				/obj/item/clothing/shoes/boots/stylish/red = 2,
				/obj/item/clothing/shoes/boots/stylish/navy = 2,
				/obj/item/clothing/shoes/boots/stylish/charcoal = 2,
				/obj/item/clothing/shoes/boots/stylish/silver = 2)


datum/supply_pack/clothing/heels
	name = "Ladies Heels (Bulk)"
	containername = "Ladies Heels (Bulk)"
	containertype = /obj/structure/closet
	cost = 130
	contains = list(/obj/item/clothing/shoes/heels = 10,
				/obj/item/clothing/shoes/heels/long = 10)
