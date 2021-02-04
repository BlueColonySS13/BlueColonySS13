/*
*	Here is where any supply packs
*	related to robotics tasks live.
*/


/datum/supply_pack/robotics
	group = "Robotics"
	spend_type = SPEND_ROBOTICS

/datum/supply_pack/randomised/robotics
	group = "Robotics"
	access = access_robotics
	spend_type = SPEND_ROBOTICS

/datum/supply_pack/robotics/robotics_assembly
	name = "Robotics assembly crate"
	contains = list(
			/obj/item/device/assembly/prox_sensor = 3,
			/obj/item/weapon/storage/toolbox/electrical,
			/obj/item/device/flash = 4,
			/obj/item/weapon/cell/high = 2
			)
	cost = 250
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robotics assembly"
	access = access_robotics

/*/datum/supply_pack/robotics/robolimbs_basic
	name = "Basic robolimb blueprints"
	contains = list(
			/obj/item/weapon/disk/limb/morpheus,
			/obj/item/weapon/disk/limb/xion
			)
	cost = 15
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "Robolimb blueprints (basic)"
	access = access_robotics

/datum/supply_pack/robotics/robolimbs_adv
	name = "All robolimb blueprints"
	contains = list(
	/obj/item/weapon/disk/limb/bishop,
	/obj/item/weapon/disk/limb/hephaestus,
	/obj/item/weapon/disk/limb/morpheus,
	/obj/item/weapon/disk/limb/veymed,
	/obj/item/weapon/disk/limb/wardtakahashi,
	/obj/item/weapon/disk/limb/xion,
	/obj/item/weapon/disk/limb/zenghu,
			)
	cost = 40
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "Robolimb blueprints (adv)"
	access = access_robotics
*/

/datum/supply_pack/robotics/robolimbs/morpheus
	name = "Morpheus robolimb blueprints"
	contains = list(/obj/item/weapon/disk/limb/morpheus,
					/obj/item/weapon/disk/limb/morpheus/zenith,
					/obj/item/weapon/disk/limb/morpheus/skeletoncrew,)
	cost = 2000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robolimb blueprints (Morpheus)"

/datum/supply_pack/robotics/robolimbs/cybersolutions
	name = "Cyber Solutions robolimb blueprints"
	contains = list(/obj/item/weapon/disk/limb/cybersolutions,
					/obj/item/weapon/disk/limb/cybersolutions/array,
					/obj/item/weapon/disk/limb/cybersolutions/wight)
	cost = 6000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robolimb blueprints (Cyber Solutions)"

/datum/supply_pack/robotics/robolimbs/xion
	name = "Xion robolimb blueprints"
	contains = list(/obj/item/weapon/disk/limb/xion,
					/obj/item/weapon/disk/limb/xion/hull,
					/obj/item/weapon/disk/limb/xion/whiteout,
					/obj/item/weapon/disk/limb/xion/breach,
					/obj/item/weapon/disk/limb/xion/breach_whiteout)
	cost = 8000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robolimb blueprints (Xion)"

/datum/supply_pack/robotics/robolimbs/grayson
	name = "Grayson robolimb blueprints"
	contains = list(/obj/item/weapon/disk/limb/grayson,
					/obj/item/weapon/disk/limb/grayson/reinforced,
					/obj/item/weapon/disk/limb/grayson/monitor)
	cost = 9000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robolimb blueprints (Grayson)"

/datum/supply_pack/robotics/robolimbs/hephaestus
	name = "Hephaestus robolimb blueprints"
	contains = list(/obj/item/weapon/disk/limb/hephaestus,
					/obj/item/weapon/disk/limb/hephaestus/athena,
					/obj/item/weapon/disk/limb/hephaestus/frontier,
					/obj/item/weapon/disk/limb/hephaestus/monitor)
	cost = 14000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robolimb blueprints (Hephaestus)"

/datum/supply_pack/robotics/robolimbs/wardtakahashi
	name = "Ward-Takahashi robolimb blueprints"
	contains = list(/obj/item/weapon/disk/limb/wardtakahashi,
					/obj/item/weapon/disk/limb/wardtakahashi/shroud,
					/obj/item/weapon/disk/limb/wardtakahashi/spirit,
					/obj/item/weapon/disk/limb/wardtakahashi/monitor)
	cost = 14000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robolimb blueprints (Ward-Takahashi)"

/datum/supply_pack/robotics/robolimbs/zenghu
	name = "Zeng Hu robolimb blueprints"
	contains = list(/obj/item/weapon/disk/limb/zenghu)
	cost = 4000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robolimb blueprints (Zeng Hu)"

/datum/supply_pack/robotics/robolimbs/bishop
	name = "Bishop robolimb blueprints"
	contains = list(/obj/item/weapon/disk/limb/bishop,
					/obj/item/weapon/disk/limb/bishop/rook,
					/obj/item/weapon/disk/limb/bishop/rook_red)
	cost = 21000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robolimb blueprints (Bishop)"

/datum/supply_pack/robotics/robolimbs/veymed
	name = "Veymed robolimb blueprints + Installation Licensing"
	contains = list(/obj/item/weapon/disk/limb/veymed)
	cost = 1000000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Robolimb blueprints (Veymed)"

/datum/supply_pack/robotics/mecha_ripley
	name = "Circuit Crate (\"Ripley\" APLU)"
	contains = list(
			/obj/item/weapon/book/manual/ripley_build_and_repair,
			/obj/item/weapon/circuitboard/mecha/ripley/main,
			/obj/item/weapon/circuitboard/mecha/ripley/peripherals
			)
	cost = 35000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "APLU \"Ripley\" Circuit Crate"
	access = access_robotics

/datum/supply_pack/robotics/mecha_odysseus
	name = "Circuit Crate (\"Odysseus\")"
	contains = list(
			/obj/item/weapon/circuitboard/mecha/odysseus/peripherals,
			/obj/item/weapon/circuitboard/mecha/odysseus/main
			)
	cost = 30000
	containertype = /obj/structure/closet/crate/secure/science
	containername = "\"Odysseus\" Circuit Crate"
	access = access_robotics

/datum/supply_pack/randomised/robotics/exosuit_mod
	num_contained = 1
	contains = list(
			/obj/item/device/kit/paint/ripley,
			/obj/item/device/kit/paint/ripley/death,
			/obj/item/device/kit/paint/ripley/flames_red,
			/obj/item/device/kit/paint/ripley/flames_blue
			)
	name = "Random APLU modkit"
	cost = 1000
	containertype = /obj/structure/closet/crate/science
	containername = "heavy crate"

/datum/supply_pack/randomised/robotics/exosuit_mod/durand
	contains = list(
			/obj/item/device/kit/paint/durand,
			/obj/item/device/kit/paint/durand/seraph,
			/obj/item/device/kit/paint/durand/phazon
			)
	name = "Random Durand exosuit modkit"

/datum/supply_pack/randomised/robotics/exosuit_mod/gygax
	contains = list(
			/obj/item/device/kit/paint/gygax,
			/obj/item/device/kit/paint/gygax/darkgygax,
			/obj/item/device/kit/paint/gygax/recitence
			)
	name = "Random Gygax exosuit modkit"

/datum/supply_pack/robotics/jumper_cables
	name = "Jumper kit crate"
	contains = list(
			/obj/item/device/defib_kit/jumper_kit = 2
			)
	cost = 500
	containertype = /obj/structure/closet/crate/secure/science
	containername = "Jumper kit crate"
	access = access_robotics


/datum/supply_pack/robotics/hoverpod
	name = "Hoverpod Shipment"
	contains = list()
	cost = 45000
	containertype = /obj/structure/largecrate/hoverpod
	containername = "Hoverpod Crate"