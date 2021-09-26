/obj/turbolift_map_holder/subway
	name = "Abandoned Subway Elevator"
	depth = 2
	lift_size_x = 4
	lift_size_y = 4
	icon = 'icons/obj/turbolift_preview_5x5.dmi'

	areas_to_use = list(
		/area/turbolift/geminus_subway_ground,
		/area/turbolift/geminus_subway_top
		)

/obj/turbolift_map_holder/geminusmining
	name = "Mining Elevator"
	depth = 2
	lift_size_x = 4
	lift_size_y = 4
	icon = 'icons/obj/turbolift_preview_5x5.dmi'

	areas_to_use = list(
		/area/turbolift/geminus_ground_mining,
		/area/turbolift/geminus_top_mining
		)

/obj/turbolift_map_holder/geminushospital
	name = "City Hospital Elevator"
	depth = 2
	lift_size_x = 3
	lift_size_y = 3
	icon = 'icons/obj/turbolift_preview_3x3.dmi'

	areas_to_use = list(
		/area/turbolift/geminus_overground_hospital,
		/area/turbolift/geminus_ground_hospital
		)


/obj/turbolift_map_holder/geminuscourt
	name = "Courtroom Elevator"
	depth = 2
	lift_size_x = 3
	lift_size_y = 3
	icon = 'icons/obj/turbolift_preview_3x3.dmi'

	wall_type =  /turf/simulated/wall/walnut
	floor_type = /turf/simulated/floor/wood

	areas_to_use = list(
		/area/turbolift/geminus_court_top,
		/area/turbolift/geminus_court_ground
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
		/area/turbolift/geminus_mall_ground,
		/area/turbolift/geminus_mall_top
		)


/obj/turbolift_map_holder/science
	name = "Science Elevator"
	depth = 2
	lift_size_x = 3
	lift_size_y = 3
	icon = 'icons/obj/turbolift_preview_3x3.dmi'

	areas_to_use = list(
		/area/turbolift/geminus_ground_science,
		/area/turbolift/geminus_top_science
		)

/obj/turbolift_map_holder/police
	name = "Police Station Elevator"
	depth = 3
	lift_size_x = 3
	lift_size_y = 3
	icon = 'icons/obj/turbolift_preview_3x3.dmi'

	areas_to_use = list(
		/area/turbolift/police_lower_ground,
		/area/turbolift/police_ground,
		/area/turbolift/police_top
		)