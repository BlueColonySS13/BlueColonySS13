/*
*	Here is where any supply packs
*	related to decorative items go
*/

/datum/supply_pack/decoration
	group = "Decoration"
	containertype = /obj/structure/closet/crate

/datum/supply_pack/decoration/floor_painter
	name = "Paint Gun Kit"
	contains = list(
			/obj/item/device/floor_painter = 1,
			/obj/item/device/closet_painter = 1,
			/obj/item/device/pipe_painter = 1

			)
	cost = 150
	containername = "Paint Gun Kit"


/datum/supply_pack/decoration/spraycans
	name = "Spraycan Set"
	contains = list(
			/obj/item/weapon/pen/crayon/spraycan = 5
			)
	cost = 30
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
	cost = 25
	containertype = /obj/structure/closet/crate/large
	containername = "Assorted Flowering Plants"

/datum/supply_pack/decoration/leafpots
	name = "Assorted Leafy Plants"
	contains = list(/obj/structure/flora/pottedplant/decorative = 2,
	/obj/structure/flora/pottedplant/largebush = 2,
	/obj/structure/flora/pottedplant/minitree = 2,
	/obj/structure/flora/pottedplant/stoutbush = 2)
	cost = 25
	containertype = /obj/structure/closet/crate/large
	containername = "Assorted Leafy Plants"

