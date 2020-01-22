// This will save things to a sav file, sadly can't be a map export. But I may make a convertor for that in-game to help out.

/datum/map_turf
	var/turf_type
	var/x
	var/y
	var/z
	var/turf_vars = list()
	var/objects = list()
	var/mobs = list()

/datum/map_object
	var/savedtype
	var/object_vars = list()

/datum/map_mob
	var/savedtype
	var/mob_vars = list()


/proc/save_map(var/turf/t1, var/turf/t2, var/id, var/path, var/save_obj = 1, var/save_mob = 0)
	var/block = get_map_turfs(t1, t2)

	var/full_map = map_write(block, save_obj, save_mob)
	if(!full_map)
		return 0

	map_to_file(full_map, path, id)
	return 1

/proc/restore_map(var/id, var/path)
	var/map_data = file_to_map(path, id)
	get_map_data(map_data)
	return 1


/proc/get_map_turfs(var/turf/t1 as turf, var/turf/t2 as turf)
	//Check for valid turfs.
	if(!isturf(t1) || !isturf(t2))
		CRASH("Invalid arguments supplied to proc map_write, arguments were not turfs.")

	var/turf/ne = locate(max(t1.x,t2.x),max(t1.y,t2.y),max(t1.z,t2.z)) // Outer corner
	var/turf/sw = locate(min(t1.x,t2.x),min(t1.y,t2.y),min(t1.z,t2.z)) // Inner corner

	var/list/map_area = list()

	for(var/turf/T in block(ne, sw) )
		map_area += T

	return map_area

/proc/map_write(var/list/CHUNK, var/save_obj, var/save_mob)
	var/list/full_map = list()

	for(var/turf/T in CHUNK)
		if(T.dont_save) continue

		T.on_persistence_save()

		var/datum/map_turf/MT = new/datum/map_turf()
		MT.turf_type = T.type

		MT.x = T.x
		MT.y = T.y
		MT.z = T.z
		for(var/V in T.vars_to_save() )
			if(!(T.vars[V] == initial(T.vars[V])))
				MT.turf_vars[V] = T.vars[V]


		if(save_obj)
			for(var/obj/O in T.contents)
				if(O.dont_save) continue

				O.on_persistence_save()

				var/datum/map_object/MO = new/datum/map_object
				MO.savedtype = O.type

				for(var/V in O.vars_to_save() )
					if(!(O.vars[V] == initial(O.vars[V])))
						MO.object_vars[V] = O.vars[V]

						if(V == "contents")
							var/list/contents = MO.object_vars["contents"]
							for(var/atom/A in contents)
								if(A.dont_save)
									A -= MO.object_vars["contents"]

				MO.object_vars["x"] = O.vars["x"]
				MO.object_vars["y"] = O.vars["y"]
				MO.object_vars["z"] = O.vars["z"]

				MT.objects += MO

		if(save_mob)
			for(var/mob/living/M in T.contents)
				if(M.dont_save) continue

				M.on_persistence_save()

				var/datum/map_mob/MM = new/datum/map_mob
				MM.savedtype = M.type


				for(var/V in M.vars_to_save() )
					if(!(M.vars[V] == initial(M.vars[V])))
						MM.mob_vars[V] = M.vars[V]


				MM.mob_vars["x"] = M.vars["x"]
				MM.mob_vars["y"] = M.vars["y"]
				MM.mob_vars["z"] = M.vars["z"]

				MT.mobs += MM

		full_map += MT

	return full_map


/proc/get_map_data(var/list/full_map)
	if(!full_map) return 0

	for(var/datum/map_turf/MT in full_map)
		var/turf/newturf = locate(MT.x,MT.y,MT.z)

		if(!newturf)
			continue

		newturf.ChangeTurf(MT.turf_type, 0, 1)
		newturf.on_persistence_load()
		for(var/V in newturf.vars_to_save())
			if(MT.turf_vars[V])
				newturf.vars[V] = MT.turf_vars[V]


		for(var/datum/map_object/MO in MT.objects)
			var/obj/O = new MO.savedtype (newturf.loc)
			for(var/V in O.vars_to_save())
				if(MO.object_vars[V])
					O.vars[V] = MO.object_vars[V]

			O.vars["x"] = MO.object_vars["x"]
			O.vars["y"] = MO.object_vars["y"]
			O.vars["z"] = MO.object_vars["z"]

		for(var/datum/map_mob/MM in MT.mobs)
			var/mob/M = new MM.savedtype (newturf.loc)
			M.on_persistence_load()
			for(var/V in M.vars_to_save())
				if(MM.mob_vars[V])
					M.vars[V] = MM.mob_vars[V]

			M.vars["x"] = MM.mob_vars["x"]
			M.vars["y"] = MM.mob_vars["y"]
			M.vars["z"] = MM.mob_vars["z"]

	return 1



/proc/map_to_file(var/list/full_map, var/path, var/map_name)

	if(!full_map)
		CRASH("No full map provided.")

	var/map_path = "[path][map_name].sav"

	if(fexists(map_path))
		fdel(map_path)

	var/savefile/saved_map = new /savefile(map_path)

	saved_map << full_map

	return saved_map

/proc/file_to_map(var/path, var/map_name)
	if(!path || !map_name)				return 0

	var/map_path = "[path][map_name].sav"
	if(!fexists(map_path))
		CRASH("File does not exist.")

	var/full_map

	var/savefile/S = new /savefile(map_path)
	if(!S)					return 0

	S >> full_map

	return full_map

