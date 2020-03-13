/*
* Returns a byond list that can be passed to the "deserialize" proc
* to bring a new instance of this atom to its original state
*
* If we want to store this info, we can pass it to `json_encode` or some other
* interface that suits our fancy, to make it into an easily-handled string
*/
/datum/proc/serialize()
	var/data = list("type" = "[type]")
	return data

/*
* This is given the byond list from above, to bring this atom to the state
* described in the list.
* This will be called after `New` but before `initialize`, so linking and stuff
* would probably be handled in `initialize`
*
* Also, this should only be called by `json_to_object` in persistence.dm - at least
* with current plans - that way it can actually initialize the type from the list
*/
/datum/proc/deserialize(var/list/data)
	return

/atom
	// This var isn't actually used for anything, but is present so that
	// DM's map reader doesn't forfeit on reading a JSON-serialized map
	var/map_json_data
	var/persistence_loaded = FALSE

	var/save_contents = FALSE
	var/save_reagents = FALSE

	var/unique_save_vars = list()
	var/dont_save = 0 // For atoms that are temporary by necessity - like lighting overlays

/atom/proc/on_persistence_load()
	persistence_loaded = FALSE	// turns this off.
	return TRUE

/atom/proc/on_persistence_save()
	persistence_loaded = TRUE
	return TRUE



/obj/item/weapon/reagent_containers/proc/pack_persistence_data()
	var/list/all_reagents = reagents.reagent_list
	var/reagent_data_persistence = list("viruses", "species", "blood_DNA", "blood_type", "blood_colour", "resistances", "trace_chem", "antibodies")
	var/list/reagents_to_save = list()

	if(reagents)
		for(var/datum/reagent/R in all_reagents)
			var/reagent_data = list(
			"id" = R.id,
			"volume" = R.volume,
			"data" = null)

			if(R.data)


				if(ismob(R.data) || isatom(R.data))
					continue

				if(islist(R.data))
					var/list/metadata = list()
					for(var/V in reagent_data_persistence)
						metadata += V
						reagent_data["data"] = metadata
				else
					reagent_data["data"] = R.data

				reagents_to_save["data"] = reagent_data

	return reagents_to_save

/obj/item/weapon/reagent_containers/proc/unpack_persistence_data(var/list/saved_reagents)
	if(isemptylist(saved_reagents))
		return FALSE

	reagents.reagent_list = list()

	for(var/list/V in saved_reagents)
		var/datum/reagent/new_reagent = reagents.add_reagent(V["id"], V["volume"])
		if(V["data"])
			new_reagent.data = V["data"]

	return TRUE

// This is so specific atoms can override these, and ignore certain ones
/atom/proc/vars_to_save()
 	return list("x","y","z","color","dir","name","pixel_x","pixel_y")+unique_save_vars

/atom/proc/map_important_vars()
	// A list of important things to save in the map editor
 	return list("x","y","z","color","dir","layer","name","pixel_x","pixel_y")+unique_save_vars

/area/
	unique_save_vars = list("name", "decals")

/atom/serialize()
	var/list/data = ..()
	for(var/thing in vars_to_save())
		if(vars[thing] != initial(vars[thing]))
			data[thing] = vars[thing]

	return data


/atom/deserialize(var/list/data)
	for(var/thing in vars_to_save())
		if(thing in data)
			vars[thing] = data[thing]
	..()


/proc/json_to_object(var/json_data, var/loc)
	var/data = json_decode(json_data)
	return list_to_object(data, loc)

/proc/list_to_object(var/list/data, var/loc)
	if(!islist(data))
		throw EXCEPTION("You didn't give me a list, bucko")
	if(!("type" in data))
		throw EXCEPTION("No 'type' field in the data")
	var/path = text2path(data["type"])
	if(!path)
		throw EXCEPTION("Path not found: [path]")

	var/atom/movable/thing = new path(loc)
	thing.deserialize(data)
	return thing


// Custom vars-to-save/persistence load list

/obj/vars_to_save()
 	 return list("x","y","z","anchored","color","dir","icon_state","name","pixel_x","pixel_y","contents","fingerprints","fingerprintshidden","fingerprintslast",\
 	 "suit_fibers")+unique_save_vars

/obj/item/weapon/paper
	unique_save_vars = list("info")

/obj/structure/closet
	unique_save_vars = list("opened","welded")

/obj/item/weapon/clipboard
	unique_save_vars = list("haspen","toppaper")

/obj/structure/safe
	unique_save_vars = list("open","tumbler_1_pos","tumbler_1_open","tumbler_2_pos","tumbler_2_open","dial")


/obj/structure/on_persistence_load()
	update_connections()
	update_icon()
	return TRUE

// Don't save list - Better to keep a track of things here.

/mob
	dont_save = TRUE

/obj/item/weapon/card/id
	dont_save = TRUE

/obj/item/weapon/card/id/gold/captain/spare
	dont_save = TRUE

/atom/movable/lighting_overlay
	dont_save = TRUE

/obj/item/device/communicator
	dont_save = TRUE

/obj/singularity		// lmao just in case
	dont_save = TRUE

/obj/effect
	dont_save = TRUE

/obj/screen
	dont_save = TRUE 	// what?