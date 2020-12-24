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
	contains = list(/obj/item/stack/material/steel/full = 3)
	cost = 225
	containertype = /obj/structure/closet/crate
	containername = "Metal sheets crate"

/datum/supply_pack/materials/glass50
	name = "150 glass sheets"
	contains = list(/obj/item/stack/material/glass/full = 3)
	cost = 175
	containertype = /obj/structure/closet/crate
	containername = "Glass sheets crate"

/datum/supply_pack/materials/plastic50
	name = "150 plastic sheets"
	contains = list(/obj/item/stack/material/plastic/full = 3)
	cost = 150
	containertype = /obj/structure/closet/crate
	containername = "Plastic sheets crate"

/datum/supply_pack/materials/cardboard_sheets
	contains = list(/obj/item/stack/material/cardboard/full = 3)
	name = "150 cardboard sheets"
	cost = 100
	containertype = /obj/structure/closet/crate
	containername = "Cardboard sheets crate"

/datum/supply_pack/materials/marble
	name = "50 marble slabs"
	contains = list(/obj/fiftyspawner/marble = 3)
	cost = 500
	containername = "marble slabs crate"

/datum/supply_pack/materials/carpet
	name = "Imported carpet"
	containertype = /obj/structure/closet/crate
	containername = "Imported carpet crate"
	cost = 500
	contains = list(
					/obj/fiftyspawner/carpet,
					/obj/fiftyspawner/tealcarpet,
					/obj/fiftyspawner/blucarpet,
					/obj/fiftyspawner/turcarpet,
					/obj/fiftyspawner/sblucarpet,
					/obj/fiftyspawner/gaycarpet,
					/obj/fiftyspawner/purcarpet,
					/obj/fiftyspawner/oracarpet,
					/obj/fiftyspawner/blackcarpet
					)

//wood zone
/datum/supply_pack/materials/wood
	name = "50 wooden planks"
	contains = list(/obj/item/stack/material/wood/fifty)
	cost = 80
	containername = "wooden planks crate"

/datum/supply_pack/materials/mahogany
	name = "50 mahogany planks"
	contains = list(/obj/fiftyspawner/wood/mahogany)
	cost = 100
	containername = "wooden planks crate"

/datum/supply_pack/materials/maple
	name = "50 maple planks"
	contains = list(/obj/fiftyspawner/wood/maple)
	cost = 100
	containername = "maple planks crate"

/datum/supply_pack/materials/walnut
	name = "50 walnut planks"
	contains = list(/obj/fiftyspawner/wood/walnut)
	cost = 100
	containername = "walnut planks crate"

/datum/supply_pack/materials/ebony
	name = "50 ebony planks"
	contains = list(/obj/fiftyspawner/wood/ebony)
	cost = 120 //luxury tax
	containername = "ebony planks crate"

/datum/supply_pack/materials/bamboo
	name = "50 bamboo planks"
	contains = list(/obj/fiftyspawner/wood/bamboo)
	cost = 90
	containername = "bamboo planks crate"

/datum/supply_pack/materials/yew
	name = "50 yew planks"
	contains = list(/obj/fiftyspawner/wood/yew)
	cost = 120 //luxury tax
	containername = "bamboo planks crate"

/datum/supply_pack/misc/linoleum
	name = "linoleum"
	containertype = /obj/structure/closet/crate
	containername = "Linoleum crate"
	cost = 80
	contains = list(/obj/fiftyspawner/linoleum)

/datum/supply_pack/misc/diamond_tiles
	name = "diamond design tiles"
	containertype = /obj/structure/closet/crate
	containername = "diamond design tiles crate"
	cost = 80
	contains = list(/obj/fiftyspawner/diamond_tiles)

/datum/supply_pack/materials/road50
	name = "50 road tiles"
	contains = list(/obj/fiftyspawner/road)
	cost = 80
	containertype = /obj/structure/closet/crate
	containername = "Road tiles crate"

/datum/supply_pack/materials/pavement50
	name = "50 pavement tiles"
	contains = list(/obj/fiftyspawner/pavement)
	cost = 80
	containertype = /obj/structure/closet/crate
	containername = "Pavement tiles crate"

/datum/supply_pack/materials/sewingset
	name = "Sewing Set"
	contains = list(/obj/item/device/threadneedle = 5)
	cost = 30
	containertype = /obj/structure/closet/crate
	containername = "Sewing Set"

/datum/supply_pack/materials/silk
	name = "150 silk sheets"
	contains = list(/obj/fiftyspawner/silk = 3)
	cost = 1200
	containertype = /obj/structure/closet/crate
	containername = "150 silk sheets"

/datum/supply_pack/materials/cotton
	name = "150 cotton sheets"
	contains = list(/obj/fiftyspawner/cotton = 3)
	cost = 300
	containertype = /obj/structure/closet/crate
	containername = "150 cotton sheets"

/datum/supply_pack/materials/leather
	name = "150 leather sheets"
	contains = list(/obj/fiftyspawner/leather = 3)
	cost = 600
	containertype = /obj/structure/closet/crate
	containername = "150 leather sheets"

/datum/supply_pack/materials/denim
	name = "150 denim sheets"
	contains = list(/obj/fiftyspawner/denim = 3)
	cost = 400
	containertype = /obj/structure/closet/crate
	containername = "150 denim sheets"

/datum/supply_pack/materials/wool
	name = "150 wool sheets"
	contains = list(/obj/fiftyspawner/wool = 3)
	cost = 400
	containertype = /obj/structure/closet/crate
	containername = "150 wool sheets"

/datum/supply_pack/materials/polychrome
	name = "150 polychromatic thread sheets"
	contains = list(/obj/fiftyspawner/polychrome = 3)
	cost = 1000
	containertype = /obj/structure/closet/crate
	containername = "150 polychromatic thread sheets"


