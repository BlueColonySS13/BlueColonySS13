// This will save things to a sav file, sadly can't be a map export. But I may make a converter for that in-game to help out. ~Cass

/datum/map_turf
	var/turf_type
	var/x
	var/y
	var/z
	var/turf_vars = list()
	var/list/map_objects = list()
	var/list/decals = list()

/datum/map_object
	var/savedtype
	var/object_vars = list()

	var/contents = list()
	var/list/reagent_data = list()
	var/metadata
	var/x
	var/y
	var/z

/datum/map_reagent_data
	var/id
	var/amount
	var/data

/proc/save_map(var/turf/t1, var/turf/t2, var/id, var/path, var/save_obj = 1)
	var/block = get_map_turfs(t1, t2)

	var/full_map = map_write(block, save_obj)
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
	if(!O)
		return FALSE

	var/datum/map_object/MO = new/datum/map_object
	O.on_persistence_save()
	O.sanitize_for_saving()
	MO.savedtype = O.type

	for(var/V in O.vars_to_save() )
		if(!(V in O.vars))
			continue
		if(!(O.vars[V] == initial(O.vars[V])))
			if(!istext(O.vars[V]) && !isnum(O.vars[V]))	// make sure all references to mobs/objs/turfs etc, are fully cut!
				continue
			MO.object_vars[V] = O.vars[V]

	if(O.save_reagents)
		if(istype(O, /obj/item/weapon/reagent_containers))
			var/obj/item/weapon/reagent_containers/container = O
			MO.reagent_data = container.pack_persistence_data()

	var/turf/obj_turf = get_turf(O)

	MO.x = obj_turf.x
	MO.y = obj_turf.y
	MO.z = obj_turf.z

	MO.metadata = O.get_persistent_metadata()

	return MO

/datum/map_object/proc/unpack_object_data(obj/O, obj/containing_obj)
	O.x = x
	O.y = y
	O.z = z

	if(containing_obj)
		O.forceMove(containing_obj)

	if(!O.initialized)
		O.initialize()

	clearlist(O.contents)

	for(var/V in O.vars_to_save())
		if(object_vars[V])
			O.vars[V] = object_vars[V]

	if(!isemptylist(reagent_data) && istype(O, /obj/item/weapon/reagent_containers))
		var/obj/item/weapon/reagent_containers/container = O
		container.unpack_persistence_data(reagent_data)
	O.load_persistent_metadata(metadata)
	O.on_persistence_load()

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

		var/list/decal_list = list()

		for(var/image/I in T.decals)
			var/icon/dcl_icon = getFlatIcon(I, defdir=I.dir)
			var/image/new_decl = image(dcl_icon)

			decal_list += new_decl

		MT.decals = decal_list


		for(var/V in T.vars_to_save() )
			if(!(V in T.vars))
				continue
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
				if(saved_obj_1)
					full_map += saved_obj_1
					CHECK_TICK

				if(!O.save_contents)
					continue

				//first loop, to get all objects inside closets
				for(var/obj/A in O.contents)
					if(A.dont_save) continue

					var/datum/map_object/saved_obj_2 = get_object_data(A)
					if(saved_obj_2)
						saved_obj_1.contents += saved_obj_2
						CHECK_TICK

					if(!A.save_contents)
						continue

					//second loop, let's say you had a backpack inside the closet with it's own things.
					for(var/obj/B in A.contents)
						if(B.dont_save) continue

						var/datum/map_object/saved_obj_3 = get_object_data(B)
						if(saved_obj_3)
							saved_obj_2.contents += saved_obj_3
							CHECK_TICK

						if(!B.save_contents)
							continue

						//third loop. for getting things like cigarette packets inside backpacks.
						for(var/obj/C in B.contents)
							if(C.dont_save) continue

							var/datum/map_object/saved_obj_4 = get_object_data(C)
							if(saved_obj_4)
								saved_obj_3.contents += saved_obj_4
								CHECK_TICK

							if(!C.save_contents)
								continue


							//fourth loop. let's say the cigarettes need saving inside these packets. Honestly I don't think we'll need a fourth loop.
							for(var/obj/D in C.contents)
								if(D.dont_save) continue

								var/datum/map_object/saved_obj_5 = get_object_data(D)
								if(saved_obj_5)
									saved_obj_4.contents += saved_obj_5
									CHECK_TICK

				MT.map_objects += saved_obj_1


	return full_map


/proc/get_map_data(var/list/full_map)
	if(!full_map) return 0

	for(var/datum/map_turf/MT in full_map)
		var/change_turf = TRUE
		if(!ispath(MT.turf_type))
			error("Undefined save type [MT.turf_type]")
			change_turf = FALSE

		var/turf/newturf = locate(MT.x,MT.y,MT.z)

		if(!newturf)
			continue

		if(change_turf)
			newturf.ChangeTurf(MT.turf_type, 0, 1)

		newturf.decals = MT.decals
		newturf.update_icon()

		newturf.on_persistence_load()
		for(var/V in newturf.vars_to_save())
			if(MT.turf_vars[V])
				newturf.vars[V] = MT.turf_vars[V]


		for(var/datum/map_object/MO in MT.map_objects)
			if(!ispath(MO.savedtype))
				error("Undefined save type [MO.savedtype]")
				continue

			var/obj/O = new MO.savedtype ( newturf.loc )
			CHECK_TICK
			MO.unpack_object_data(O)

			// first loop
			for(var/datum/map_object/MO_2 in MO.contents)
				if(!ispath(MO_2.savedtype))
					error("Undefined save type [MO_2.savedtype] (in [MO])")
					continue
				var/obj/A = new MO_2.savedtype (O)
				CHECK_TICK
				MO_2.unpack_object_data(A, O)

				// second loop
				for(var/datum/map_object/MO_3 in MO_2.contents)
					if(!ispath(MO_3.savedtype))
						error("Undefined save type [MO_3.savedtype] (in [MO_2])")
						continue
					var/obj/B = new MO_3.savedtype (A)
					CHECK_TICK
					MO_3.unpack_object_data(B, A)

					// third loop
					for(var/datum/map_object/MO_4 in MO_3.contents)
						if(!ispath(MO_4.savedtype))
							error("Undefined save type [MO_4.savedtype] (in [MO_3])")
							continue
						var/obj/C = new MO_4.savedtype (B)
						CHECK_TICK
						MO_4.unpack_object_data(C, B)

						// third loop
						for(var/datum/map_object/MO_5 in MO_4.contents)
							if(!ispath(MO_5.savedtype))
								error("Undefined save type [MO_5.savedtype] (in [MO_4])")
								continue
							var/obj/D = new MO_5.savedtype (C)
							CHECK_TICK
							MO_5.unpack_object_data(D, C)

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

