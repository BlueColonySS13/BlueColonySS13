/*
*	Here is where any supply packs
*	that supply circuits go - a bit pricier than RnD prices, but that's how it goes.
*/

/datum/supply_pack/circuits
	group = "Business Circuits"
	containertype = /obj/structure/closet/crate
	spend_type = SPEND_BUSINESS




/datum/supply_pack/circuits/kitchen
	contains = list(/obj/item/weapon/circuitboard/microwave,
	/obj/item/weapon/circuitboard/oven,
	/obj/item/weapon/circuitboard/grill,
	/obj/item/weapon/circuitboard/candy_maker,
	/obj/item/weapon/circuitboard/deepfryer,
	/obj/item/weapon/circuitboard/gibber,
	/obj/item/weapon/circuitboard/cereal,
	/obj/item/weapon/circuitboard/icecream_vat,
	/obj/item/weapon/circuitboard/grinder,
	/obj/item/weapon/circuitboard/condimaster)
	name = "Kitchen Circuit Set"
	cost = 2000
	containertype = /obj/structure/closet/crate
	containername = "Kitchen Circuit Set"


/datum/supply_pack/circuits/entertainment_center
	contains = list(/obj/item/weapon/circuitboard/jukebox,
	/obj/item/weapon/circuitboard/coin_machine,
	/obj/item/weapon/circuitboard/vr_sleeper/business,
	)
	name = "Entertainment Circuit Set"
	cost = 300
	containertype = /obj/structure/closet/crate
	containername = "Entertainment Circuit Set"

/datum/supply_pack/circuits/arcade_set
	contains = list(/obj/item/weapon/circuitboard/arcade/battle,
	/obj/item/weapon/circuitboard/arcade/orion_trail,
	)
	name = "Arcade Circuit Set"
	cost = 400
	containertype = /obj/structure/closet/crate
	containername = "Arcade Circuit Set"

/datum/supply_pack/circuits/recharge_set
	contains = list(/obj/item/weapon/circuitboard/recharger,
	/obj/item/weapon/circuitboard/recharger/wrecharger,
	)
	name = "Recharger Set"
	cost = 400
	containertype = /obj/structure/closet/crate
	containername = "Recharger Set"

/datum/supply_pack/circuits/washing_machine
	contains = list(/obj/item/weapon/circuitboard/washing
	)
	name = "Washing Machine"
	cost = 150
	containertype = /obj/structure/closet/crate
	containername = "Washing Machine"


/datum/supply_pack/circuits/botany
	contains = list(/obj/item/weapon/circuitboard/biogenerator,
	/obj/item/weapon/circuitboard/botany_extractor,
	/obj/item/weapon/circuitboard/botany_editor,
	/obj/item/weapon/circuitboard/seed_extractor,
	/obj/item/weapon/circuitboard/honey_extractor)
	name = "Botany Circuit Set"
	cost = 2350
	containertype = /obj/structure/closet/crate
	containername = "Botany Circuit Set"

/datum/supply_pack/circuits/tailoring
	contains = list(/obj/item/weapon/circuitboard/dye_generator,
	/obj/item/weapon/circuitboard/dye_generator/commercial)
	name = "Tailoring Circuit Set"
	cost = 500
	containertype = /obj/structure/closet/crate
	containername = "Tailoring Circuit Set"

/datum/supply_pack/circuits/popcorn_machine
	contains = list(/obj/item/weapon/circuitboard/popcorn_machine)
	name = "Popcorn Vendor Circuit"
	cost = 200
	containertype = /obj/structure/closet/crate
	containername = "Popcorn Vendor Circuit"

/datum/supply_pack/circuits/smartfridge
	contains = list(/obj/item/weapon/circuitboard/smartfridge)
	name = "Smartfridge Circuit"
	cost = 750
	containertype = /obj/structure/closet/crate
	containername = "Smartfridge Circuit"

/datum/supply_pack/circuits/smartfridge/food
	contains = list(/obj/item/weapon/circuitboard/smartfridge/food)
	name = "Food Smartfridge Circuit"
	cost = 750
	containertype = /obj/structure/closet/crate
	containername = "Food Smartfridge Circuit"


/datum/supply_pack/circuits/token_machine
	contains = list(/obj/item/weapon/circuitboard/token_machine)
	name = "Token Dispenser Circuit"
	cost = 200
	containertype = /obj/structure/closet/crate
	containername = "Token Dispenser Circuit"

/datum/supply_pack/circuits/bounty_machine
	contains = list(/obj/item/weapon/circuitboard/bounty_machine)
	name = "bounty-T Circuit"
	cost = 10000
	containertype = /obj/structure/closet/crate
	containername = "Bounty Machine Circuit"

/datum/supply_pack/circuits/forensics
	contains = list(
	/obj/item/weapon/circuitboard/dna_analyzer,
	/obj/item/weapon/circuitboard/microscope,
	)
	name = "Forensics Circuits"
	cost = 4000
	containertype = /obj/structure/closet/crate
	containername = "Forensics Circuits"

/datum/supply_pack/circuits/inventory_box
	contains = list(/obj/item/weapon/circuitboard/inventory_box)
	name = "Inventory box Circuit"
	cost = 10000
	containertype = /obj/structure/closet/crate
	containername = "Inventory Box Circuit"

/datum/supply_pack/circuits/science
	contains = list(/obj/item/weapon/circuitboard/rdconsole/business,
					/obj/item/weapon/circuitboard/rdserver/business,
					/obj/item/weapon/circuitboard/protolathe,
					/obj/item/weapon/circuitboard/circuit_imprinter,
					/obj/item/weapon/circuitboard/destructive_analyzer)

	name = "Research Circuits"
	cost = 2000000 // a huge profit maker, so should be expensive. the entirety of research in one crate. has science gone too far?
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Research Circuits"

/datum/supply_pack/circuits/robotics
	contains = list(/obj/item/weapon/circuitboard/prosthetics/business,
					/obj/item/weapon/circuitboard/mechfab/business)

	name = "Robotics Circuits"
	cost = 250000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robotics Circuits"

/datum/supply_pack/circuits/autolathe
	contains = list(/obj/item/weapon/circuitboard/autolathe)

	name = "Autolathe Circuit"
	cost = 7500
	containertype = /obj/structure/closet/crate/secure
	containername = "Autolathe Circuit"

/datum/supply_pack/circuits/sewing_machine
	contains = list(/obj/item/weapon/circuitboard/autolathe/sewing_machine)

	name = "Sewing Machine Circuit"
	cost = 3000
	containertype = /obj/structure/closet/crate/secure
	containername = "Sewing Machine Circuit"

/datum/supply_pack/circuits/autolathe/commercial
	contains = list(/obj/item/weapon/circuitboard/autolathe/commercial)

	name = "Fabri-Mate Circuit"
	cost = 100000
	containertype = /obj/structure/closet/crate/secure
	containername = "Fabri-Mate Circuit"

/datum/supply_pack/circuits/sewing_machine/commercial
	contains = list(/obj/item/weapon/circuitboard/autolathe/sewing_machine/commercial)

	name = "Sew-Mate Circuit"
	cost = 100000
	containertype = /obj/structure/closet/crate/secure
	containername = "Sew-Mate Circuit"


/datum/supply_pack/circuits/expense_manager
	contains = list(/obj/item/weapon/circuitboard/expense_manager)

	name = "Expense Manager Circuit"
	cost = 1000
	containertype = /obj/structure/closet/crate/secure
	containername = "Business Expense Manager Circuit"

/datum/supply_pack/med/distillery
	name = "Chemical Distiller Circuit"
	contains = list(/obj/item/weapon/circuitboard/distiller = 1)
	cost = 7500
	containertype = /obj/structure/largecrate
	containername = "Chemical Distiller Circuit crate"