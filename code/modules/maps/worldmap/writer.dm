// Lightweight and simple World Server map writer and reader, loosely based off the /tg/ map writer.
// Designed in this way so we can save any var we want without major issues.



///// backend code

/proc/save_map_portion(map_name, path, var/turf/t1 as turf, var/turf/t2 as turf, save_mobs = 0, save_simplemobs = 1, save_objs = 1)
	var/mapturfs = get_map_turfs(t1, t2)	//top left to bottom right
	var/map_img = make_map_image(mapturfs, save_mobs = 0, save_simplemobs = 1, save_objs = 1)
	var/map_path = "data/maps/map.sav"
	if(path || map_name)
		map_path = "[path][map_name].sav"

	save_map_image(map_img, map_path)

	return 1

/proc/load_map_portion(path)
	var/map = get_map_image(path)
	create_loaded_map(map)

	return 1

/proc/get_map_turfs(var/turf/t1 as turf, var/turf/t2 as turf)
	//Check for valid turfs.
	if(!isturf(t1) || !isturf(t2))
		CRASH("Invalid arguments supplied to proc write_map, arguments were not turfs.")

	var/turf/ne = locate(max(t1.x,t2.x),max(t1.y,t2.y),max(t1.z,t2.z)) // Outer corner
	var/turf/sw = locate(min(t1.x,t2.x),min(t1.y,t2.y),min(t1.z,t2.z)) // Inner corner

	var/list/map_area = list()

	for(var/turf/T in block(ne, sw) )
		map_area += T

	return map_area

/proc/copy_instance(atom/A)
	if(A.dont_save)
		return 0

	var/atom/N = new A.type(A.loc)
	var/list/copyvar = A.vars_to_save()	// also ensure that x and y are set or this will break (in vars_to_save)
	// list of variables which should be changed
	for(var/i in A.vars)
		if(!(i in copyvar))
			continue
	// don't copy variables which can effect the object in a way we don't want to
		N.vars[i] = A.vars[i] // set the variable of "A" to the new atom's var

	return N

/proc/make_map_image(var/list/turf/map_area, save_mobs = 0, save_simplemobs = 1, save_objs = 1)
	var/list/full_map = list()

	//copy basic turf to a new turf, this will be used for saving.
	for(var/turf/T in map_area)
		full_map += copy_instance(T)

	var/list/will_save = list()
	//get all mobs so we can decide what to do with them
	if(save_mobs || save_simplemobs)
		for(var/mob/M in full_map)
			if(M.dont_save)
				continue

			if(save_mobs)
				if(!M in will_save)
					will_save += M

			if(save_simplemobs)
				if(istype(M,/mob/living/simple_animal))
					if(!M in will_save)
						will_save += M

	if(save_objs)
		for(var/obj/O in full_map)
			if(O.dont_save)
				continue

			if(!O in will_save)
				will_save += O


	for(var/atom/A in will_save)
		full_map += copy_instance(A)

	return full_map



/proc/save_map_image(var/list/full_map, path)
	if(!path)				return 0
	var/savefile/S = new /savefile(path)
	if(!fexists(path))		return 0
	if(!S)					return 0

	S.cd = "/"

	S << full_map

	message_admins("Saved map to [path]", 1)

/proc/get_map_image(path)
	if(!path)				return 0
	if(!fexists(path))	return 0
	var/savefile/S = new /savefile(path)
	if(!S)	return 0
	var/list/full_map

	S.cd = "/"

	S >> full_map

	message_admins("Loaded map", 1)

	return full_map

/proc/create_loaded_map(var/list/full_map)
	for(var/A in full_map)

		if(istype(A, /turf))
			var/turf/T = A
			var/c_x = T.x
			var/c_y = T.y
			var/c_z = T.z

			var/turf/to_replace = locate(c_x,c_y,c_z)

			to_replace.ChangeTurf(T.type)

	message_admins("Map Applied", 1)

	return 1
