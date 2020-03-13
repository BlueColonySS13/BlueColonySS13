// This will save things to a sav file, sadly can't be a map export. But I may make a converter for that in-game to help out. ~Cass

/datum/map_turf
	var/turf_type
	var/x
	var/y
	var/z
	var/turf_vars = list()

	var/list/map_objects = list()

/datum/map_object
	var/savedtype
	var/object_vars = list()

	var/contents = list()
	var/reagent_data = list()

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
	if(get_map_data(map_data))
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

/proc/get_object_data(obj/O)
	var/datum/map_object/MO = new/datum/map_object
	O.on_persistence_save()
	MO.savedtype = O.type

	for(var/V in O.vars_to_save() )
		if(!(O.vars[V] == initial(O.vars[V])))
			MO.object_vars[V] = O.vars[V]

	if(istype(O, /obj/item/weapon/reagent_containers))
		var/obj/item/weapon/reagent_containers/container = O
		MO.reagent_data = container.pack_persistence_data()

	MO.object_vars["x"] = O.vars["x"]
	MO.object_vars["y"] = O.vars["y"]
	MO.object_vars["z"] = O.vars["z"]

	return MO

/datum/map_object/proc/unpack_object_data(obj/O)
	for(var/V in O.vars_to_save())
		if(object_vars[V])
			O.vars[V] = object_vars[V]

	O.vars["x"] = object_vars["x"]
	O.vars["y"] = object_vars["y"]
	O.vars["z"] = object_vars["z"]

	if(!isemptylist(reagent_data) && istype(O, /obj/item/weapon/reagent_containers))
		var/obj/item/weapon/reagent_containers/container = O
		container.unpack_persistence_data(reagent_data)

	if(!O.on_persistence_load())
		throw EXCEPTION("[O] failed persistence load.")

	return TRUE

/proc/map_write(var/list/CHUNK, var/save_obj)
	var/list/full_map = list()
	var/list/all_objs = list()

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

		full_map += MT

		if(save_obj)
				// get all objects in a area. I hate the method that's about to follow, but after finding exploits and potential shitcode that's in the game right now
				// actually worried we'd get the bad reference juju happening (like syringes containing blood and that blood having the actual mob reference in its data
				// which caused an infinite loop) - or items non-existing causing broken loading. because of this, the saving process has to be manually filtered for all the loops.
			for(var/obj/O in T.loc)
				if(O.dont_save) continue
				if(O in all_objs) continue // to prevent multi-loc  duplicates. it's a thing.

				all_objs += O

				var/datum/map_object/saved_obj_1 = get_object_data(O)
				full_map += saved_obj_1

				//first loop, to get all objects inside closets
				for(var/obj/A in O.contents)
					if(A.dont_save) continue

					var/datum/map_object/saved_obj_2 = get_object_data(A)
					saved_obj_1.contents += saved_obj_2

					//second loop, let's say you had a backpack inside the closet with it's own things.
					for(var/obj/B in A.contents)
						if(B.dont_save) continue

						var/datum/map_object/saved_obj_3 = get_object_data(B)
						saved_obj_2.contents += saved_obj_3

						//third and final loop. for getting things like cigarette packets inside backpacks. Honestly I don't think we'll need a fourth loop.
						for(var/obj/C in B.contents)
							if(C.dont_save) continue

							var/datum/map_object/saved_obj_4 = get_object_data(C)
							saved_obj_3.contents += saved_obj_4

				MT.map_objects += saved_obj_1


	return full_map


/proc/get_map_data(var/list/full_map)
	if(!full_map) return 0

	for(var/datum/map_turf/MT in full_map)
		if(!ispath(MT.turf_type))
			throw EXCEPTION("Undefined save type [MT.turf_type]")
			continue
		var/turf/newturf = locate(MT.x,MT.y,MT.z)

		if(!newturf)
			continue

		newturf.ChangeTurf(MT.turf_type, 0, 1)
		newturf.on_persistence_load()
		if(!newturf.on_persistence_load())
			throw EXCEPTION("[newturf] failed persistence load.")
		for(var/V in newturf.vars_to_save())
			if(MT.turf_vars[V])
				newturf.vars[V] = MT.turf_vars[V]


		for(var/datum/map_object/MO in MT.map_objects)
			if(!ispath(MO.savedtype))
				throw EXCEPTION("Undefined save type [MO.savedtype]")
				continue

			var/obj/O = new MO.savedtype ( newturf.loc )

			MO.unpack_object_data(O)

			// first loop
			for(var/datum/map_object/MO_2 in MO.contents)
				if(!ispath(MO_2.savedtype))
					throw EXCEPTION("Undefined save type [MO_2.savedtype] (in [MO])")
					continue
				var/obj/A = new MO_2.savedtype (O.contents)
				MO_2.unpack_object_data(A)

				// second loop
				for(var/datum/map_object/MO_3 in MO_2.contents)
					if(!ispath(MO_3.savedtype))
						throw EXCEPTION("Undefined save type [MO_3.savedtype] (in [MO_2])")
						continue
					var/obj/B = new MO_3.savedtype (A.contents)
					MO_3.unpack_object_data(B)

					// third and final loop
					for(var/datum/map_object/MO_4 in MO_3.contents)
						if(!ispath(MO_4.savedtype))
							throw EXCEPTION("Undefined save type [MO_4.savedtype] (in [MO_3])")
							continue
						var/obj/C = new MO_4.savedtype (B.contents)
						MO_4.unpack_object_data(C)


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

