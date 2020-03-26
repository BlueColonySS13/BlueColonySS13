#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

//Stuff that doesn't fit into any category goes here

/obj/item/weapon/circuitboard/aicore
	name = T_BOARD("AI core")
	origin_tech = list(TECH_DATA = 4, TECH_BIO = 2)
	board_type = "other"

/obj/item/weapon/circuitboard/chem_master
	name = T_BOARD("ChemMaster 3000")
	build_path = /obj/machinery/chem_master
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_DATA = 3, TECH_MAGNET = 2)
	req_components = list()

/obj/item/weapon/circuitboard/dye_generator
	name = T_BOARD("Dye Generator")
	build_path = /obj/machinery/dye_generator
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_DATA = 2)
	req_components = list()

/obj/item/weapon/circuitboard/display_case
	name = T_BOARD("Electronic Display Case")
	build_path = /obj/machinery/electronic_display_case
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_DATA = 2)
	req_components = list()


/obj/item/weapon/circuitboard/jukebox
	name = T_BOARD("Jukebox")
	build_path = /obj/machinery/media/jukebox
	board_type = "machine"
	origin_tech = list(TECH_DATA = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/capacitor = 1,
							/obj/item/weapon/stock_parts/console_screen = 1,
							/obj/item/stack/cable_coil = 1)

/obj/item/weapon/circuitboard/reagentgrinder
	name = T_BOARD("All-in-one Grinder")
	build_path = /obj/machinery/reagentgrinder
	board_type = "machine"
	origin_tech = list(TECH_MATERIAL = 2, TECH_ENGINEERING = 1, TECH_BIO = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/matter_bin = 1,
							/obj/item/weapon/stock_parts/capacitor = 1,
							/obj/item/weapon/stock_parts/manipulator = 1,)


