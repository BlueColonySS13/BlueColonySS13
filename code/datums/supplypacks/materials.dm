/*
*	Here is where any supply packs
*	related to materials live.
*/


/datum/supply_pack/materials
	group = "Materials"
	containertype = /obj/structure/closet/crate
	spend_type = SPEND_MATERIALS

/datum/supply_pack/materials/metal50
	name = "150 metal sheets"
	contains = list(/obj/fiftyspawner/steel = 3)
	cost = 60
	containertype = /obj/structure/closet/crate
	containername = "Metal sheets crate"

/datum/supply_pack/materials/glass50
	name = "150 glass sheets"
	contains = list(/obj/fiftyspawner/glass = 3)
	cost = 60
	containertype = /obj/structure/closet/crate
	containername = "Glass sheets crate"

/datum/supply_pack/materials/plastic50
	name = "150 plastic sheets"
	contains = list(/obj/fiftyspawner/plastic = 3)
	cost = 60
	containertype = /obj/structure/closet/crate
	containername = "Plastic sheets crate"

/datum/supply_pack/materials/cardboard_sheets
	contains = list(/obj/fiftyspawner/cardboard = 3)
	name = "150 cardboard sheets"
	cost = 60
	containertype = /obj/structure/closet/crate
	containername = "Cardboard sheets crate"

/datum/supply_pack/materials/marble
	name = "50 marble slabs"
	contains = list(/obj/fiftyspawner/marble = 3)
	cost = 120
	containername = "marble slabs crate"

/datum/supply_pack/materials/carpet
	name = "Imported carpet"
	containertype = /obj/structure/closet/crate
	containername = "Imported carpet crate"
	cost = 50
	contains = list(
					/obj/fiftyspawner/carpet,
					/obj/fiftyspawner/tealcarpet,
					/obj/fiftyspawner/blucarpet,
					/obj/fiftyspawner/turcarpet,
					/obj/fiftyspawner/sblucarpet,
					/obj/fiftyspawner/gaycarpet,
					/obj/fiftyspawner/purcarpet,
					/obj/fiftyspawner/oracarpet
					)

//wood zone
/datum/supply_pack/materials/wood
	name = "50 wooden planks"
	contains = list(/obj/item/stack/material/wood/fifty)
	cost = 30
	containername = "wooden planks crate"

/datum/supply_pack/materials/mahogany
	name = "50 mahogany planks"
	contains = list(/obj/fiftyspawner/wood/mahogany)
	cost = 50
	containername = "wooden planks crate"

/datum/supply_pack/materials/maple
	name = "50 maple planks"
	contains = list(/obj/fiftyspawner/wood/maple)
	cost = 50
	containername = "maple planks crate"

/datum/supply_pack/materials/walnut
	name = "50 walnut planks"
	contains = list(/obj/fiftyspawner/wood/walnut)
	cost = 50
	containername = "walnut planks crate"

/datum/supply_pack/materials/ebony
	name = "50 ebony planks"
	contains = list(/obj/fiftyspawner/wood/ebony)
	cost = 60 //luxury tax
	containername = "ebony planks crate"

/datum/supply_pack/materials/bamboo
	name = "50 bamboo planks"
	contains = list(/obj/fiftyspawner/wood/bamboo)
	cost = 50
	containername = "bamboo planks crate"

/datum/supply_pack/materials/yew
	name = "50 yew planks"
	contains = list(/obj/fiftyspawner/wood/yew)
	cost = 60 //luxury tax
	containername = "bamboo planks crate"

/datum/supply_pack/misc/linoleum
	name = "linoleum"
	containertype = /obj/structure/closet/crate
	containername = "Linoleum crate"
	cost = 15
	contains = list(/obj/fiftyspawner/linoleum)

/datum/supply_pack/misc/diamond_tiles
	name = "diamond design tiles"
	containertype = /obj/structure/closet/crate
	containername = "diamond design tiles crate"
	cost = 25
	contains = list(/obj/fiftyspawner/diamond_tiles)

/datum/supply_pack/materials/road50
	name = "50 road tiles"
	contains = list(/obj/fiftyspawner/road)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "Road tiles crate"

/datum/supply_pack/materials/pavement50
	name = "50 pavement tiles"
	contains = list(/obj/fiftyspawner/pavement)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "Pavement tiles crate"

/datum/supply_pack/materials/sewingset
	name = "Sewing Set"
	contains = list(/obj/item/device/threadneedle = 2)
	cost = 5
	containertype = /obj/structure/closet/crate
	containername = "Sewing Set"

/datum/supply_pack/materials/tailor_materials
	name = "Tailoring Materials"
	contains = list(/obj/fiftyspawner/silk = 2,
	/obj/fiftyspawner/cotton = 3,
	/obj/fiftyspawner/leather = 3,
	/obj/fiftyspawner/denim = 4)
	cost = 800
	containertype = /obj/structure/closet/crate
	containername = "Fine Tailoring Materials"



