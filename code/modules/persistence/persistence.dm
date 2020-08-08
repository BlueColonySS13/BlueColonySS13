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

	var/save_contents = TRUE
	var/save_reagents = TRUE
	var/save_forensics = FALSE

	var/unique_save_vars = list()

	var/dont_save = FALSE // For atoms that are temporary by necessity - like lighting overlays

/atom/proc/on_persistence_load()
	persistence_loaded = FALSE	// turns this off.

/atom/proc/on_persistence_save()
	persistence_loaded = TRUE

/atom/proc/make_persistent()
	dont_save = FALSE

	for(var/obj/I in get_saveable_contents())
		I.dont_save = FALSE


/atom/proc/make_nonpersistent()
	dont_save = TRUE

	for(var/obj/I in get_saveable_contents())
		I.dont_save = TRUE


/atom/proc/get_persistent_metadata()
	return

/atom/proc/load_persistent_metadata(metadata)
	return

/atom/proc/sanitize_for_saving()
	return TRUE

/atom/proc/get_saveable_contents()
	return contents

/obj/sanitize_for_saving()	// these things build up with time, so this gradually limits the amount so we don't have 5000 fingerprints or anything.
	if(!suit_fibers)
		suit_fibers = list()

	if(!fingerprints)
		fingerprints = list()

	if(!fingerprintshidden)
		fingerprintshidden = list()

	if(islist(suit_fibers) && !isemptylist(suit_fibers))
		truncate_oldest(suit_fibers, MAX_FINGERPRINTS)
	if(islist(fingerprints) && !isemptylist(fingerprints))
		truncate_oldest(fingerprints, MAX_FINGERPRINTS)
	if(islist(fingerprintshidden) && !isemptylist(fingerprintshidden))
		truncate_oldest(fingerprintshidden, MAX_FINGERPRINTS)

	return TRUE

/atom/proc/pack_persistence_data()
	var/list/all_reagents = reagents.reagent_list
	var/list/reagents_to_save = list()

	if(reagents)
		for(var/datum/reagent/R in all_reagents)
			var/datum/map_reagent_data/reagent_holder = new()

			reagent_holder.id = R.id
			reagent_holder.amount = R.volume

			if(R.get_data())
				var/list/datalist = R.get_data()

				if(islist(datalist))
					var/list/metadata = list()
					for(var/V in datalist)
						if(!istext(datalist[V]) && !isnum(datalist[V]))
							continue
						metadata[V] = datalist[V]

					reagent_holder.data = metadata
				else
					if(!istext(R.get_data()) && !isnum(R.get_data()))
						continue

					reagent_holder.data = R.get_data()

			reagents_to_save += reagent_holder

	return reagents_to_save

/obj/proc/unpack_persistence_data(var/list/saved_reagents)
	if(!reagents)
		return

	if(isemptylist(saved_reagents))
		return FALSE

	clearlist(reagents.reagent_list)

	for(var/datum/map_reagent_data/reagent_holder in saved_reagents)
		var/datum/reagent/new_reagent = reagents.add_reagent(reagent_holder.id, reagent_holder.amount)
		if(!new_reagent)
			continue
		if(reagent_holder.data)
			new_reagent.data = reagent_holder.data

	return TRUE

// This is so specific atoms can override these, and ignore certain ones
/atom/proc/vars_to_save()
 	return list("x","y","z","color","dir","name","pixel_x","pixel_y","tagged_price")+unique_save_vars

/atom/proc/map_important_vars()
	// A list of important things to save in the map editor
 	return list("x","y","z","color","dir","layer","name","pixel_x","pixel_y")+unique_save_vars

/area/
	unique_save_vars = list("name")

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

/obj
	save_forensics = TRUE

/obj/vars_to_save()
 	 return list("x","y","z","density","anchored","color","dir","name","pixel_x","pixel_y","suit_fibers","tagged_price", "fingerprintslast")+unique_save_vars

/obj/item/weapon/clipboard
	unique_save_vars = list("haspen","toppaper")

/obj/structure/safe
	unique_save_vars = list("open","tumbler_1_pos","tumbler_1_open","tumbler_2_pos","tumbler_2_open","dial")


/obj/structure/on_persistence_load()
	update_connections()
	update_icon()

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

/obj/item/weapon/passport
	dont_save = TRUE