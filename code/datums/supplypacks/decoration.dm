/*
*	Here is where any supply packs
*	related to decorative items go
*/

/datum/supply_pack/decoration
	group = "Decoration"
	containertype = /obj/structure/closet/crate


/datum/supply_pack/decoration/painters
	name = "Painting Supplies"
	cost = 30
	containername = "city painting supplies crate"
	containertype = /obj/structure/closet/crate
	contains = list(
			/obj/item/device/pipe_painter = 2,
			/obj/item/device/floor_painter = 2,
			/obj/item/device/closet_painter = 2
			)

	spend_type = SPEND_MAINTENANCE

/datum/supply_pack/decoration/spraycans
	name = "Spraycan Set"
	contains = list(
			/obj/item/weapon/pen/crayon/spraycan = 5
			)
	cost = 25
	containername = "Spraycan Set"

/datum/supply_pack/decoration/holoplant
	name = "Holoplant Pot"
	contains = list(/obj/machinery/holoplant/shipped)
	cost = 15
	containertype = /obj/structure/closet/crate
	containername = "Holoplant crate"

/datum/supply_pack/decoration/flowerpots
	name = "Assorted Flowering Plants"
	contains = list(/obj/structure/flora/pottedplant/flower = 2,
	/obj/structure/flora/pottedplant/small = 2,
	/obj/structure/flora/pottedplant/orientaltree = 2,
	/obj/structure/flora/pottedplant/sticky = 2)
	cost = 50
	containertype = /obj/structure/closet/crate/large
	containername = "Assorted Flowering Plants"

/datum/supply_pack/decoration/leafpots
	name = "Assorted Leafy Plants"
	contains = list(/obj/structure/flora/pottedplant/decorative = 2,
	/obj/structure/flora/pottedplant/largebush = 2,
	/obj/structure/flora/pottedplant/minitree = 2,
	/obj/structure/flora/pottedplant/stoutbush = 2)
	cost = 50
	containertype = /obj/structure/closet/crate/large
	containername = "Assorted Leafy Plants"


/datum/supply_pack/decoration/llamps
	contains = list(/obj/item/device/flashlight/lamp/lava,
					/obj/item/device/flashlight/lamp/lava/red = 3,
					/obj/item/device/flashlight/lamp/lava/orange = 3,
					/obj/item/device/flashlight/lamp/lava/yellow = 3,
					/obj/item/device/flashlight/lamp/lava/green = 3,
					/obj/item/device/flashlight/lamp/lava/cyan = 3,
					/obj/item/device/flashlight/lamp/lava/blue = 3,
					/obj/item/device/flashlight/lamp/lava/purple = 3,
					/obj/item/device/flashlight/lamp/lava/pink = 3)
	name = "Set of Lava lamps"
	cost = 150
	containername = "lava lamp crate"

/datum/supply_pack/decoration/candles
	name = "Candles Set"
	contains = list(
		/obj/item/weapon/storage/box/candle_box,
		/obj/item/weapon/storage/box/candle_box/random,
		/obj/item/weapon/storage/box/candle_box/candelabra,
		/obj/item/weapon/storage/box/candle_box/candelabra/random)
	cost = 100
	containername = "candles crate"

/datum/supply_pack/decoration/venus_statue
	name = "Venus Statue"
	contains = list(
		/obj/structure/sculpting_block/sculpted/large/venus)
	cost = 2000
	containername = "venus statue"

/datum/supply_pack/decoration/lion_statue
	name = "Lion Statue"
	contains = list(
		/obj/structure/sculpting_block/sculpted/large/lion)
	cost = 2500
	containername = "lion statue"

/datum/supply_pack/decoration/bust
	name = "Greek Bust"
	contains = list(
		/obj/structure/sculpting_block/sculpted/bust)
	cost = 800
	containername = "greek bust"

/datum/supply_pack/decoration/balloons
	name = "Assorted Balloons"
	contains = list(/obj/item/toy/colorballoon/random = 10)
	cost = 30
	containertype = /obj/structure/closet/crate
	containername = "Assorted Balloons"

/datum/supply_pack/decoration/halloween_balloons
	name = "Halloween Balloons"
	contains = list(/obj/structure/balloon/bat = 5,
	/obj/structure/balloon/ghost = 5,
	/obj/structure/balloon/random = 5)
	cost = 40
	containername = "Halloween Balloons"


/datum/supply_pack/decoration/christmas_tree
	name = "Large Christmas Tree"
	contains = list(/obj/structure/flora/pottedplant/xmas/large)
	cost = 1000
	containername = "Large Christmas Tree"

/datum/supply_pack/decoration/christmas_tree_mini
	name = "Mini Christmas Tree"
	contains = list(/obj/structure/flora/pottedplant/xmas)
	cost = 200
	containername = "Mini Christmas Tree"


