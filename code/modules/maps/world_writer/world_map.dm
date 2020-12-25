// This will save things to a sav file, sadly can't be a map export. But I may make a converter for that in-game to help out. ~Cass

/datum/map_turf
	var/turf_type
	var/x
	var/y
	var/z
	var/turf_vars = list()
	var/list/map_objects = list()
	var/list/decals = list()

	//for walls
	var/material //material id goes here
	var/reinforced_material
	var/girder_material

	var/metadata

/datum/map_object
	var/savedtype
	var/object_vars = list()
	var/contents = list()
	var/list/forensic_data = list()

	var/list/reagent_data = list()
	var/metadata
	var/x
	var/y
	var/z

	var/name = ""

/datum/map_reagent_data
	var/id
	var/amount
	var/data

/proc/save_map(var/id, var/path, var/save_obj = 1)
	set background = 1

	var/area/map_area

	for(var/area/A in return_sorted_areas())
		if(A.lot_id == id)
			map_area = A
			break

	if(!map_area)
		return

	var/full_map = map_write(map_area, save_obj)
	if(!full_map)
		return 0

	map_to_file(full_map, path, id)
	return 1

/proc/restore_map(var/id, var/path)
	var/map_data = file_to_map(path, id)
	if(get_map_data(map_data))
		return 1


/proc/get_object_data(obj/O)
	set background = 1

	if(!O)
		return FALSE

	var/datum/map_object/MO = new/datum/map_object
	if(!MO)
		return
	O.on_persistence_save()
	O.sanitize_for_saving()
	MO.savedtype = O.type

	MO.name = O.name

	for(var/V in O.vars_to_save() )
		var/save_var = TRUE
		if(!(V in O.vars))
			save_var = FALSE
			continue
		if(!(O.vars[V] == initial(O.vars[V])))
			if(islist(O.vars[V]))
				var/list/M = O.vars[V]
				for(var/P in M)
					if(!istext(P) && !isnum(P) && !ispath(P))
						save_var = FALSE
						continue
					if(listgetindex(M,P))
						var/asso_var = listgetindex(M,P)
						if(asso_var && (!istext(asso_var) && !isnum(asso_var) && !ispath(asso_var)) )
							save_var = FALSE
							continue

			else
				if(!istext(O.vars[V]) && !isnum(O.vars[V]) && !ispath(O.vars[V]))	// make sure all references to mobs/objs/turfs etc, are fully cut!
					save_var = FALSE
					continue

		if(save_var)
			MO.object_vars[V] = O.vars[V]

		CHECK_TICK


	if(O.save_reagents && O.reagents)
		MO.reagent_data = O.pack_persistence_data()

	var/turf/obj_turf = get_turf(O)

	if(obj_turf)
		MO.x = obj_turf.x
		MO.y = obj_turf.y
		MO.z = obj_turf.z

	// forensic data has to be stored independently because lists don't typically save
	if(O.save_forensics)
		MO.forensic_data["fingerprints"] = O.fingerprints
		MO.forensic_data["fingerprintshidden"] = O.fingerprintshidden
		MO.forensic_data["suit_fibers"] = O.suit_fibers

	MO.metadata = O.get_persistent_metadata()

	return MO

/proc/full_item_save(obj/O)
	set background = 1

// get all objects in a area. I hate the method that's about to follow, but after finding exploits and potential shitcode that's in the game right now
// actually worried we'd get the bad reference juju happening (like syringes containing blood and that blood having the actual mob reference in its data
// which caused an infinite loop) - or items non-existing causing broken loading. because of this, the saving process has to be manually filtered for all the loops.

	if(O.dont_save) return
	var/datum/map_object/MO = get_object_data(O)
	if(!MO) return

	CHECK_TICK


	for(var/obj/A in O.get_saveable_contents())
		if(!O.save_contents)
			continue
		if(A.dont_save)
			continue
		var/datum/map_object/MO_2 = get_object_data(A)
		if(!MO_2)
			continue

		MO.contents += MO_2

		CHECK_TICK

		for(var/obj/B in A.get_saveable_contents())
			if(!A.save_contents) continue
			if(B.dont_save) continue
			var/datum/map_object/MO_3 = get_object_data(B)
			if(!MO_3) continue

			MO_2.contents += MO_3

			CHECK_TICK

			for(var/obj/C in B.get_saveable_contents())
				if(!B.save_contents) continue
				if(C.dont_save) continue
				var/datum/map_object/MO_4 = get_object_data(C)
				if(!MO_4) continue

				MO_3.contents += MO_4

				CHECK_TICK

		CHECK_TICK

	return MO

/proc/full_item_load(var/datum/map_object/MO, loc)
	if(!ispath(MO.savedtype))
		error("Undefined save type [MO.savedtype]")
		return
	var/obj/O = new MO.savedtype (loc)
	CHECK_TICK
	MO.unpack_object_data(O)
	O.forceMove(loc)

	for(var/datum/map_object/MD in MO.contents)
		if(!ispath(MD.savedtype))
			error("Undefined save type [MD.savedtype]")
			continue

		var/obj/A = new MD.savedtype (loc)
		CHECK_TICK
		MD.unpack_object_data(A)
		A.forceMove(O)

		CHECK_TICK

		for(var/datum/map_object/MF in MD.contents)
			if(!ispath(MF.savedtype))
				error("Undefined save type [MF.savedtype]")
				continue

			var/obj/B = new MF.savedtype (loc)
			CHECK_TICK
			MF.unpack_object_data(B)
			B.forceMove(A)

			CHECK_TICK

			for(var/datum/map_object/MG in MF.contents)
				if(!ispath(MG.savedtype))
					error("Undefined save type [MG.savedtype]")
					continue

				var/obj/C = new MG.savedtype (loc)
				CHECK_TICK
				MG.unpack_object_data(C)
				C.forceMove(B)

				CHECK_TICK

	return O




/datum/map_object/proc/unpack_object_data(obj/O, obj/containing_obj)
	if(!O || QDELETED(O))
		return

	O.x = x
	O.y = y
	O.z = z

	if(containing_obj)
		O.forceMove(containing_obj)

	if(!O.initialized && !QDELETED(O))
		O.initialize()

	clearlist(O.contents)

	for(var/V in O.vars_to_save())
		if(object_vars[V])
			O.vars[V] = object_vars[V]

	if(!isemptylist(reagent_data) && O.reagents)
		var/obj/item/weapon/reagent_containers/container = O
		container.unpack_persistence_data(reagent_data)

	// forensic data has to be stored independently because lists don't typically save
	if(O.save_forensics && !isemptylist(forensic_data))
		O.fingerprints = forensic_data["fingerprints"]
		O.fingerprintshidden = forensic_data["fingerprintshidden"]
		O.suit_fibers = forensic_data["suit_fibers"]


	O.load_persistent_metadata(metadata)
	O.on_persistence_load()

	var/turf/turfmoveto = locate(x,y,z)	// this should fix display sign issues
	if(turfmoveto && (turfmoveto != get_turf(O)) )
		O.forceMove(turfmoveto)

	O.persistence_loaded = TRUE

	return TRUE

/proc/map_write(var/area/map_area, var/save_obj)
	set background = 1

	var/list/full_map = list()

	var/list/all_turfs = get_area_turfs(map_area)
	var/list/all_objs = list()

	for(var/turf/T in all_turfs)
		if(T.dont_save) continue

		T.on_persistence_save()


		var/datum/map_turf/MT = new/datum/map_turf()
		MT.turf_type = T.type

		MT.x = T.x
		MT.y = T.y
		MT.z = T.z

		MT.metadata = T.get_persistent_metadata()

		var/is_wall = FALSE

		if(istype(T, /turf/simulated/wall))
			var/turf/simulated/wall/new_wall = T
			is_wall = TRUE
			if(new_wall.material)
				MT.material = new_wall.material.name
			if(new_wall.reinf_material)
				MT.reinforced_material = new_wall.reinf_material.name
			if(new_wall.girder_material)
				MT.girder_material = new_wall.girder_material.name

		if(istype(T, /turf/simulated/floor))
			if(T.decals)
				var/list/full_decals_save = list()
				var/dcl_count = 0
				for(var/image/I in T.decals)
					var/list/dcl_save = list()
					dcl_save["type"] = I.metadata
					dcl_save["color"] = I.color
					dcl_save["dir"] = I.dir
					dcl_count++
					full_decals_save["[dcl_count]"] = dcl_save

				MT.decals += full_decals_save

		for(var/V in T.vars_to_save() )
			if(!(V in T.vars))
				continue

			if(is_wall && (T.type in subtypesof(/turf/simulated/wall)) )	// reason why is because admin spawned walls actually have an /issue/ when being spawned anew + saving
				MT.turf_vars[V] = initial(T.vars[V])

			if(!(T.vars[V] == initial(T.vars[V])))	// transfer save values over
				MT.turf_vars[V] = T.vars[V]


		full_map += MT

		if(save_obj)
			for(var/obj/O in T)
				if(O.dont_save)
					continue

				if(O in all_objs)
					continue

				var/datum/map_object/saved_obj_1 = full_item_save(O)

				MT.map_objects += saved_obj_1

				all_objs += O

		CHECK_TICK

	return full_map


/proc/get_map_data(var/list/full_map)
	set background = 1

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
			if(ispath(MT.turf_type,/turf/simulated/wall))
				newturf.ChangeTurf(/turf/simulated/wall)
			else
				newturf.ChangeTurf(MT.turf_type)

		for(var/V in newturf.vars_to_save())
			if(MT.turf_vars[V])
				newturf.vars[V] = MT.turf_vars[V]

		if(MT.metadata)
			newturf.load_persistent_metadata(MT.metadata)

		if(istype(newturf, /turf/simulated/wall))
			var/turf/simulated/wall/new_wall = newturf
			new_wall.set_material(get_material_by_name(MT.material), get_material_by_name(MT.reinforced_material), get_material_by_name(MT.girder_material))

		if(istype(newturf, /turf/simulated/floor))
			if(MT.decals)
				var/no_count = 0
				for(var/V in MT.decals)
					no_count++
					var/list/L = MT.decals["[no_count]"]
					if(!L)
						continue
					var/decal_type = L["type"]
					if(!decal_type || !ispath(decal_type))
						continue
					new decal_type(newturf, L["dir"], L["color"])

					CHECK_TICK

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
	set background = 1
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

