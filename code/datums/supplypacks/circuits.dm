/*
*	Here is where any supply packs
*	that supply circuits go - a bit pricier than RnD prices, but that's how it goes.
*/

/datum/supply_pack/circuits
	group = "Circuits"
	containertype = /obj/structure/closet/crate





/datum/supply_pack/circuits/kitchen
	contains = list(/obj/item/weapon/circuitboard/microwave,
	/obj/item/weapon/circuitboard/oven,
	/obj/item/weapon/circuitboard/grill,
	/obj/item/weapon/circuitboard/candy_maker,
	/obj/item/weapon/circuitboard/deepfryer,
	/obj/item/weapon/circuitboard/gibber,
	/obj/item/weapon/circuitboard/cereal,
	/obj/item/weapon/circuitboard/icecream_vat)
	name = "Kitchen Circuit Set"
	cost = 1000
	containertype = /obj/structure/closet/crate
	containername = "Kitchen Circuit Set"


/datum/supply_pack/circuits/entertainment_center
	contains = list(/obj/item/weapon/circuitboard/jukebox,
	/obj/machinery/computer/coin_machine,
	/obj/item/weapon/circuitboard/vr_sleeper,
	)
	name = "Entertainment Circuit Set"
	cost = 200
	containertype = /obj/structure/closet/crate
	containername = "Entertainment Circuit Set"


/datum/supply_pack/circuits/botany
	contains = list(/obj/item/weapon/circuitboard/biogenerator,
	/obj/item/weapon/circuitboard/botany_extractor,
	/obj/item/weapon/circuitboard/botany_editor,
	/obj/item/weapon/circuitboard/seed_extractor,
	/obj/item/weapon/circuitboard/honey_extractor)
	name = "Kitchen Circuit Set"
	cost = 400
	containertype = /obj/structure/closet/crate
	containername = "Kitchen Circuit Set"

/datum/supply_pack/circuits/tailoring
	contains = list(/obj/item/weapon/circuitboard/dye_generator)
	name = "Tailoring Circuit Set"
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "Tailoring Circuit Set"

/datum/supply_pack/circuits/display_case
	contains = list(/obj/item/weapon/circuitboard/display_case)
	name = "Tailoring Circuit Set"
	cost = 1200
	containertype = /obj/structure/closet/crate
	containername = "Display Case Circuit)"
