#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif




/obj/item/weapon/circuitboard/microwave
	name = T_BOARD("microwave")
	build_path = /obj/machinery/microwave
	board_type = new /datum/frame/frame_types/microwave
	req_components = list(
							/obj/item/weapon/stock_parts/console_screen = 1,
							/obj/item/weapon/stock_parts/motor = 1,
							/obj/item/weapon/stock_parts/capacitor = 1)

/obj/item/weapon/circuitboard/oven
	name = "circuit board (Oven)"
	build_path = /obj/machinery/cooker/oven
	board_type = new /datum/frame/frame_types/machine

	origin_tech = list(TECH_POWER = 1, TECH_ENGINEERING = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/micro_laser = 2,
							/obj/item/stack/cable_coil = 5,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/circuitboard/grill
	name = "circuit board (Grill)"
	build_path = /obj/machinery/cooker/grill
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_POWER = 1, TECH_ENGINEERING = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/micro_laser = 2,
							/obj/item/stack/cable_coil = 5,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/circuitboard/candy_maker
	name = "circuit board (Candy Maker)"
	build_path = /obj/machinery/cooker/candy
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_ENGINEERING = 2)
	req_components = list(
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/stack/cable_coil = 5,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/circuitboard/deepfryer
	name = "circuit board (Deep Fryer)"
	build_path = /obj/machinery/cooker/fryer/
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_ENGINEERING = 2)
	req_components = list(
							/obj/item/weapon/stock_parts/micro_laser = 2,
							/obj/item/stack/cable_coil = 5)

/obj/item/weapon/circuitboard/gibber
	name = "circuit board (Gibber)"
	build_path = /obj/machinery/gibber
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_ENGINEERING = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/matter_bin = 1,
							/obj/item/weapon/stock_parts/manipulator = 1)

/obj/item/weapon/circuitboard/cereal
	name = "circuit board (cereal maker)"
	build_path = /obj/machinery/cooker/cereal
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_POWER = 1, TECH_ENGINEERING = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/micro_laser = 2,
							/obj/item/stack/cable_coil = 5,
							/obj/item/weapon/stock_parts/console_screen = 1)


/obj/item/weapon/circuitboard/icecream_vat
	name = T_BOARD("icecream vat")
	build_path = /obj/machinery/icecream_vat
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_POWER = 1, TECH_ENGINEERING = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/manipulator = 2,
							/obj/item/weapon/stock_parts/matter_bin = 2,
							/obj/item/weapon/reagent_containers/glass/bucket = 2)

/obj/item/weapon/circuitboard/popcorn_machine
	name = "circuit board (Popcorn Machine)"
	build_path = /obj/machinery/food_machine
	board_type = new /datum/frame/frame_types/machine
	origin_tech = list(TECH_ENGINEERING = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/micro_laser = 1,
							/obj/item/stack/cable_coil = 2,
							/obj/item/weapon/stock_parts/console_screen = 1)