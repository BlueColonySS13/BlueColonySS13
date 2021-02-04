/*
*	Here is where any supply packs
*	related to clothing live.
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
	cost = 200
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
	cost = 120
	containertype = /obj/structure/closet/crate
	containername = "Actor Costumes"



datum/supply_pack/clothing/witch
	name = "Witch costume"
	containername = "Witch costume"
	containertype = /obj/structure/closet
	cost = 200
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
	cost = 120
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



datum/supply_pack/clothing/track_pants
	name = "Track Pants Collection"
	containername = "Track Pants Collection"
	containertype = /obj/structure/closet
	cost = 240
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
	cost = 600
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
	cost = 5000
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
	cost = 6400
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
	cost = 2000
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
	cost = 10000
	contains = list(
			/obj/item/weapon/storage/briefcase/clutch/obsidienne = 5,
			/obj/item/weapon/storage/wallet/obsidienne = 5,
			/obj/item/weapon/storage/backpack/purse/obsidienne = 5,
			/obj/item/weapon/storage/backpack/satchel/obsidienne = 5,
			)



datum/supply_pack/clothing/swimsuits
	name = "Swimsuits"
	containername = "Swimsuits Collection"
	containertype = /obj/structure/closet
	cost = 300
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
	cost = 200
	contains = list(
	/obj/item/clothing/under/croptop,
	/obj/item/clothing/under/croptop/grey,
	/obj/item/clothing/under/croptop/red,
	/obj/item/clothing/under/cuttop,
	/obj/item/clothing/under/cuttop/red)



datum/supply_pack/clothing/halloween
	name = "Halloween Costume Bundle"
	containername = "Halloween Costume Bundle"
	containertype = /obj/structure/closet
	cost = 1000
	contains = list(
			/obj/item/clothing/head/collectable/pirate,
			/obj/item/clothing/head/collectable/wizard,
			/obj/item/clothing/head/collectable/slime,
			/obj/item/clothing/head/collectable/xenom,
			/obj/item/clothing/head/collectable/petehat,
			/obj/item/clothing/head/redcoat,
			/obj/item/clothing/head/mailman,
			/obj/item/clothing/head/plaguedoctorhat,
			/obj/item/clothing/mask/gas/plaguedoctor,
			/obj/item/clothing/head/pirate,
			/obj/item/clothing/head/hasturhood,
			/obj/item/clothing/head/powdered_wig,
			/obj/item/clothing/suit/pirate,
			/obj/item/clothing/suit/hastur,
			/obj/item/clothing/suit/holidaypriest,
			/obj/item/clothing/suit/nun,
			/obj/item/clothing/suit/imperium_monk,
			/obj/item/clothing/suit/ianshirt,
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
			/obj/item/clothing/under/kilt
				)
