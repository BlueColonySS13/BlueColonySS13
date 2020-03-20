/*
*	Here is where any supply packs
*	related to business go
*/

/datum/supply_pack/business
	group = "Business"
	containertype = /obj/structure/closet/crate

/datum/supply_pack/business/eftpos
	contains = list(/obj/item/device/eftpos)
	name = "EFTPOS scanner"
	cost = 50
	containertype = /obj/structure/closet/crate
	containername = "EFTPOS crate"

/datum/supply_pack/business/cash_register
	contains = list(/obj/machinery/cash_register)
	name = "Cash Register"
	cost = 150
	containertype = /obj/structure/closet/crate
	containername = "Cash Register crate"

/datum/supply_pack/business/retail_scanner
	contains = list(/obj/item/device/retail_scanner)
	name = "Retail Scanner"
	cost = 60
	containertype = /obj/structure/closet/crate
	containername = "Retail Scanner crate"

/datum/supply_pack/business/price_tagger
	contains = list(/obj/item/device/price_tagger)
	name = "Price Tagger"
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "Price Tagger crate"