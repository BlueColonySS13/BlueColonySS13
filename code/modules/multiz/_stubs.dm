/obj/effect/landmark/map_data
	name = "Unknown"
	desc = "An unknown location."
	invisibility = 101

	var/height = 1     ///< The number of Z-Levels in the map.
	var/turf/edge_type ///< What the map edge should be formed with. (null = world.turf)

// FOR THE LOVE OF GOD USE THESE.  DO NOT FUCKING SPAGHETTIFY THIS.
// Use the Has*() functions if you ONLY need to check.
// If you need to do something, use Get*().
HasAbove(var/z)
HasBelow(var/z)
// These give either the turf or null.
GetAbove(var/atom/atom)
GetBelow(var/atom/atom)


/obj/effect/landmark/lot_data
	var/lot_id
	dont_save = TRUE

/obj/effect/landmark/lot_data/initialize()
	if(!lot_id)
		var/area/_area = get_area(src)
		lot_id = _area.lot_id


/obj/effect/landmark/lot_data/top_left
	name = "Lot - Top Left"
	desc = "This is to be placed at the top left of a lot to find the turf."

/obj/effect/landmark/lot_data/bottom_right
	name = "Lot Placement - Bottom Right"
	desc = "This is to be placed at the bottom right of a turf."

