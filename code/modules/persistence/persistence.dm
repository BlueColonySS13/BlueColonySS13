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

/atom/proc/on_persistence_load()
	persistence_loaded = FALSE	// turns this off.
	return

/atom/proc/on_persistence_save()
	persistence_loaded = TRUE
	return

// This is so specific atoms can override these, and ignore certain ones
/atom/proc/vars_to_save()
 	return list("x","y","z","color","dir","name","pixel_x","pixel_y","contents")

/atom/proc/map_important_vars()
	// A list of important things to save in the map editor
 	return list("x","y","z","color","dir","icon","icon_state","layer","name","pixel_x","pixel_y")

/area/map_important_vars()
	// Keep the area default icons, to keep things nice and legible
	return list("name")

// No need to save any state of an area by default
/area/vars_to_save()
	return list("name")

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
 	 "suit_fibers"
 	 )

/obj/item/weapon/paper/vars_to_save()
 	return list("x","y","z","color","dir","icon","icon_state","layer","name","pixel_x","pixel_y","fingerprints","fingerprintshidden","fingerprintslast","info")

/obj/structure/closet/vars_to_save()
	return list("x","y","z","anchored","color","dir","icon","icon_state","layer","name","pixel_x","pixel_y","opened","welded","contents")

/obj/structure/safe/vars_to_save()
 	 return list("x","y","z","anchored","color","dir","icon_state","name","pixel_x","pixel_y","contents","fingerprints","fingerprintshidden","fingerprintslast",\
 	 "suit_fibers","open","tumbler_1_pos","tumbler_1_open","tumbler_2_pos","tumbler_2_open","dial",
 	 )
/obj/structure/on_persistence_load()
	..()
	update_connections()
	update_icon()


// Don't save list - Better to keep a track of things here.

/mob
	dont_save = TRUE

/obj/item/weapon/card/id/gold/captain/spare
	dont_save = TRUE

/atom/movable/lighting_overlay
	dont_save = TRUE

/obj/item/device/communicator
	dont_save = TRUE

/obj/item/weapon/card/id/gold/captain/spare
	dont_save = TRUE