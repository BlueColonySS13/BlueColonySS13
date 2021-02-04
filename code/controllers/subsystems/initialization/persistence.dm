SUBSYSTEM_DEF(persistence)
	name = "Persistence"
	init_order = INIT_ORDER_PERSISTENCE
	flags = SS_NO_FIRE
	var/list/tracking_values = list()
	var/list/persistence_datums = list()

/datum/controller/subsystem/persistence/Initialize(timeofday)
	for(var/thing in subtypesof(/datum/persistent))
		var/datum/persistent/P = new thing
		persistence_datums[thing] = P
		P.Initialize()
	. = ..()

/datum/controller/subsystem/persistence/Shutdown()
	for(var/thing in persistence_datums)
		var/datum/persistent/P = persistence_datums[thing]
		P.Shutdown()

/datum/controller/subsystem/persistence/proc/track_value(var/atom/value, var/track_type)
	var/turf/T = get_turf(value)
	if(!T)
		return

	var/area/A = get_area(T)
	if(!A || (A.flags & AREA_FLAG_IS_NOT_PERSISTENT))
		return

//	if((!T.z in GLOB.using_map.station_levels) || !initialized)
	if(!(T.z in using_map.station_levels))
		return

	if(!tracking_values[track_type])
		tracking_values[track_type] = list()
	tracking_values[track_type] += value

/datum/controller/subsystem/persistence/proc/forget_value(var/atom/value, var/track_type)
	if(tracking_values[track_type])
		tracking_values[track_type] -= value


/datum/controller/subsystem/persistence/proc/show_info(var/mob/user)
	if(!user.client.holder)
		return

	var/list/dat = list("<table width = '100%'>")
	var/can_modify = check_rights(R_ADMIN, 0, user)
	for(var/thing in persistence_datums)
		var/datum/persistent/P = persistence_datums[thing]
		if(P.has_admin_data)
			dat += P.GetAdminSummary(user, can_modify)
	dat += "</table>"
	var/datum/browser/popup = new(user, "admin_persistence", "Persistence Data")
	popup.set_content(jointext(dat, null))
	popup.open()


// Persistent images.
// Used for things like photos, and the Case DB. All files are `.png`.

// Make sure `image_id` is unique or else images will be overwritten.

// Saves an image file to disk outside of the cache, so it gets perserved.
/datum/controller/subsystem/persistence/proc/save_image(image, image_id, image_directory, forcedir = SOUTH)
	var/full_path = "[image_directory][image_id].png"
	var/icon/image_to_save = icon(image, forcedir, frame = 1)
	fcopy(image_to_save, full_path)

// Loads an image from disk to an icon object.
// Avoid repeatively calling this if possible.
/datum/controller/subsystem/persistence/proc/load_image(image_id, image_directory)
	var/full_path = "[image_directory][image_id].png"
	if(!fexists(full_path))
		CRASH("Asked to load a nonexistent image file '[full_path]'.")
	var/icon/loaded_image = icon(file(full_path))
	return loaded_image



// Deletes an image from disk.
/datum/controller/subsystem/persistence/proc/delete_image(image_id, image_directory)
	var/full_path = "[image_directory][image_id].png"
	if(fexists(full_path))
		fdel(full_path)
		return TRUE
	CRASH("Asked to delete a nonexistent image file '[full_path]'.")

// Checks if the full path actually exists.
// Use if you're not sure if `load_image` or `delete_image` will succeed for whatever reason.
/datum/controller/subsystem/persistence/proc/image_exists(image_id, image_directory)
	var/full_path = "[image_directory][image_id].png"
	return fexists(full_path)