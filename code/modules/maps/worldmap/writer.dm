// Lightweight World Server map writer and reader, loosely based off the /tg/ map writer.

/proc/get_map_turfs(var/turf/t1 as turf, var/turf/t2 as turf)
	//Check for valid turfs.
	if(!isturf(t1) || !isturf(t2))
		CRASH("Invalid arguments supplied to proc write_map, arguments were not turfs.")

	var/turf/ne = locate(max(t1.x,t2.x),max(t1.y,t2.y),max(t1.z,t2.z)) // Outer corner
	var/turf/sw = locate(min(t1.x,t2.x),min(t1.y,t2.y),min(t1.z,t2.z)) // Inner corner

	var/list/map_area

	for(var/turf/T in block(ne, sw) )
		map_area += T

	return map_area

