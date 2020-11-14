/*
*	Here is where any supply packs
*	related to civilian tasks live
*/

/datum/supply_pack/supply
	group = "Supplies"
	containertype = /obj/structure/closet/crate
	spend_type = SPEND_OFFICE

/datum/supply_pack/supply/toner
	name = "Toner cartridges"
	contains = list(/obj/item/device/toner = 6)
	cost = 75 //the ink industry continues to defile our wallets even in the 26th century
	containertype = /obj/structure/closet/crate
	containername = "Toner cartridges"

/datum/supply_pack/supply/janitor
	name = "Janitorial supplies"
	contains = list(
			/obj/item/weapon/reagent_containers/glass/bucket,
			/obj/item/weapon/mop,
			/obj/item/clothing/under/rank/janitor,
			/obj/item/clothing/gloves/black,
			/obj/item/clothing/head/soft/purple,
			/obj/item/weapon/storage/belt/janitor,
			/obj/item/clothing/shoes/galoshes,
			/obj/item/weapon/caution = 4,
			/obj/item/weapon/storage/bag/trash,
			/obj/item/device/lightreplacer,
			/obj/item/weapon/reagent_containers/spray/cleaner,
			/obj/item/weapon/reagent_containers/glass/rag,
			/obj/item/weapon/grenade/chem_grenade/cleaner = 3,
			/obj/structure/mopbucket
			)
	cost = 100
	containertype = /obj/structure/closet/crate
	containername = "Janitorial supplies"
	spend_type = SPEND_CLEANING

/datum/supply_pack/supply/shipping
	name = "Shipping supplies"
	contains = list(
				/obj/fiftyspawner/cardboard,
				/obj/item/weapon/packageWrap = 4,
				/obj/item/weapon/wrapping_paper = 2,
				/obj/item/device/destTagger,
				/obj/item/weapon/hand_labeler,
				/obj/item/weapon/wirecutters,
				/obj/item/weapon/tape_roll = 2)
	cost = 25
	containertype = "/obj/structure/closet/crate"
	containername = "Shipping supplies crate"

/datum/supply_pack/supply/bureaucracy
	contains = list(
			/obj/item/weapon/clipboard = 2,
			/obj/item/weapon/pen/red,
			/obj/item/weapon/pen/blue,
			/obj/item/weapon/pen/blue,
			/obj/item/device/camera_film,
			/obj/item/weapon/folder/blue,
			/obj/item/weapon/folder/red,
			/obj/item/weapon/folder/yellow,
			/obj/item/weapon/hand_labeler,
			/obj/item/weapon/tape_roll,
			/obj/structure/filingcabinet/chestdrawer{anchored = 0},
			/obj/item/weapon/paper_bin
			)
	name = "Office supplies"
	cost = 50
	containertype = /obj/structure/closet/crate
	containername = "Office supplies crate"

/datum/supply_pack/supply/spare_communicators
	name = "spare communicators"
	cost = 100
	containertype = /obj/structure/closet/crate
	containername = "Spare communicator crate"
	contains = list(/obj/item/device/communicator = 3)

/datum/supply_pack/supply/communicator_watches
	name = "communicator watches"
	cost = 150
	containertype = /obj/structure/closet/crate
	containername = "Communicator watch crate"
	contains = list(/obj/item/device/communicator/watch = 3)

/datum/supply_pack/supply/minergear
	name = "shaft miner equipment"
	contains = list(
			/obj/item/weapon/storage/backpack/industrial,
			/obj/item/weapon/storage/backpack/satchel/eng,
			/obj/item/clothing/suit/storage/hooded/wintercoat/miner,
			/obj/item/device/radio/headset/headset_cargo,
			/obj/item/clothing/under/rank/miner,
			/obj/item/clothing/gloves/black,
			/obj/item/clothing/shoes/black,
			/obj/item/device/analyzer,
			/obj/item/weapon/storage/bag/ore,
			/obj/item/device/flashlight/lantern,
			/obj/item/weapon/shovel,
			/obj/item/weapon/pickaxe,
			/obj/item/weapon/mining_scanner,
			/obj/item/clothing/glasses/material,
			/obj/item/clothing/glasses/meson
			)
	cost = 100
	containertype = "/obj/structure/closet/crate/secure"
	containername = "shaft miner equipment"
	access = access_mining
	spend_type = SPEND_MININGSUPPLIES

/datum/supply_pack/supply/mule
	name = "mulebot Crate"
	contains = list()
	cost = 250
	containertype = /obj/structure/largecrate/animal/mulebot
	containername = "mulebot Crate"

/datum/supply_pack/supply/cargotrain
	name = "cargo Train Tug"
	contains = list(/obj/vehicle/train/engine)
	cost = 150
	containertype = /obj/structure/largecrate
	containername = "cargo Train Tug Crate"

/datum/supply_pack/supply/cargotrailer
	name = "cargo Train Trolley"
	contains = list(/obj/vehicle/train/trolley)
	cost = 300
	containertype = /obj/structure/largecrate
	containername = "cargo Train Trolley Crate"

/datum/supply_pack/supply/sticky_notes
	name = "stationery - sticky notes (50)"
	contains = list(/obj/item/sticky_pad/random)
	cost = 25
	containername = "\improper sticky notes crate"

/datum/supply_pack/supply/adhesive_posters
	name = "adhesive Poster Set (50)"
	contains = list(/obj/item/sticky_pad/poster/random)
	cost = 50
	containername = "\improper adhesive poster crate"

/datum/supply_pack/supply/pen_set
	name = "assorted pen set"
	contains = list(/obj/item/weapon/pen = 5,
	/obj/item/weapon/pen/red = 5,
	/obj/item/weapon/pen/blue = 5,
	/obj/item/weapon/pen/fountain = 2)
	cost = 10
	containername = "assorted Pen Set"


/datum/supply_pack/supply/lights
	name = "light replacement set"
	contains = list(/obj/item/weapon/storage/box/lights = 2)
	cost = 75
	containername = "light replacement set"

/datum/supply_pack/supply/dye_refills
	name = "photochromatic dye refills"
	contains = list(/obj/item/photochromatic_dye_refill = 5)
	cost = 175
	containername = "photochromatic dye refills"
	spend_type = SPEND_GROOMING



