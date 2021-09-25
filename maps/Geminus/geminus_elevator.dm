/obj/turbolift_map_holder/opheliaspaceport
	name = "Abandoned Subway Elevator"
	depth = 2
	lift_size_x = 4
	lift_size_y = 4
	icon = 'icons/obj/turbolift_preview_5x5.dmi'

	areas_to_use = list(
		/area/turbolift/ophelia_ground,
		/area/turbolift/ophelia_top
		)

/obj/turbolift_map_holder/opheliamining
	name = "Mining Elevator"
	depth = 2
	lift_size_x = 4
	lift_size_y = 4
	icon = 'icons/obj/turbolift_preview_5x5.dmi'

	areas_to_use = list(
		/area/turbolift/ophelia_ground_mining,
		/area/turbolift/ophelia_top_mining
		)

/obj/turbolift_map_holder/opheliahospital
	name = "City Hospital Elevator"
	depth = 2
	lift_size_x = 3
	lift_size_y = 3
	icon = 'icons/obj/turbolift_preview_3x3.dmi'

	areas_to_use = list(
		/area/turbolift/ophelia_ground_hospital,
		/area/turbolift/ophelia_top_hospital
		)


/obj/turbolift_map_holder/opheliacourt
	name = "Courtroom Elevator"
	depth = 2
	lift_size_x = 3
	lift_size_y = 3
	icon = 'icons/obj/turbolift_preview_3x3.dmi'

	wall_type =  /turf/simulated/wall/walnut
	floor_type = /turf/simulated/floor/wood

	areas_to_use = list(
		/area/turbolift/ophelia_court_ground,
		/area/turbolift/ophelia_court_top
		)


/obj/turbolift_map_holder/shoppingmall
	name = "Shopping Mall Elevator"
	depth = 2
	lift_size_x = 3
	lift_size_y = 3
	icon = 'icons/obj/turbolift_preview_3x3.dmi'

	wall_type =  /turf/simulated/wall/disco/blue
	floor_type = /turf/simulated/floor/tiled/dark

	areas_to_use = list(
		/area/turbolift/ophelia_mall_ground,
		/area/turbolift/ophelia_mall_top
		)