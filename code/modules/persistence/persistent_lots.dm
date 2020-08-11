/datum/lot/proc/save_metadata(new_path)
	set background = 1

	var/taken_path = path

	if(new_path)
		taken_path = new_path

	var/full_path = "[taken_path][id]_meta.sav"

	if(!full_path)			return 0

	var/savefile/S = new /savefile(full_path)
	if(!fexists(full_path)) return 0


	if(!S)					return 0
	S.cd = "/"

	sanitize_lot()

	S["name"] 				<<		name
	S["desc"] 				<<		desc
	S["price"] 				<< 		price
	S["rent"] 				<< 		rent
	S["landlord"] 				<<		landlord
	S["tenants"] 				<<		tenants
	S["applied_tenants"] 		<<		applied_tenants
	S["required_deposit"] 		<<		required_deposit
	S["landlord_checkbook"] 		<<		landlord_checkbook
	S["held"] 				<<		held
	S["tenants_wanted"] 		<<		tenants_wanted
	S["for_sale"] 				<<		for_sale
	S["reason_held"] 			<<		reason_held
	S["notes"] 				<<		notes

	return 1

/datum/lot/proc/load_metadata()
	var/full_path = "[path][id]_meta.sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	S["name"] 				>>		name
	S["desc"] 				>>		desc
	S["price"] 				>> 		price
	S["rent"] 				>> 		rent
	S["landlord"] 				>>		landlord
	S["tenants"] 				>>		tenants
	S["applied_tenants"] 		>>		applied_tenants
	S["required_deposit"] 		>>		required_deposit
	S["landlord_checkbook"] 		>>		landlord_checkbook
	S["held"] 				>>		held
	S["tenants_wanted"] 		>>		tenants_wanted
	S["for_sale"] 				>>		for_sale
	S["reason_held"] 			>>		reason_held
	S["notes"] 				>>		notes

	sanitize_lot()

	return 1


/datum/lot/proc/sanitize_lot()
	if(!name)
		name = initial(name)
	if(!price)
		price = initial(price)
	if(!tenants)
		tenants = list()
	if(!applied_tenants)
		applied_tenants = list()
	if(!landlord_checkbook)
		landlord_checkbook = list()
	if(!notes)
		notes = list()

	for(var/datum/tenant/T in tenants)
		T.account_balance = round(T.account_balance)

	if(landlord)
		landlord.account_balance = round(landlord.account_balance)

	lot_area.name = name

	truncate_oldest(landlord_checkbook, MAX_LANDLORD_LOGS)
	truncate_oldest(notes, MAX_LANDLORD_LOGS)


/datum/lot/proc/save_lot_data()
	set background = 1

	if(!lot_area)
		message_admins("SAVE: [id] Issue with finding lot area for [name].", 1)
		return FALSE

	if(!save_metadata())
		message_admins("SAVE: [name] Could not save lot metadata - ownership details and payments may not be saved! Continuing...", 1)


	if(!save_map(id, path, TRUE, FALSE))
		to_chat(world, "<B>SAVE: [name] Could not save map data. Call developers!</B>")
		return FALSE

	to_chat(world, "<B>SAVE: Successfully saved lot ID: '[id]'</B>")

	return TRUE

/datum/lot/proc/backup_lot()
	set background = 1

	if(!lot_area)
		message_admins("SAVE: [id] Issue with finding lot area for [name].", 1)
		return FALSE

	if(!save_metadata("data/persistent/lots/backup/[get_real_year()]/[NumMonth2TextMonth(get_real_month())]/[get_real_day()]/"))
		message_admins("SAVE: [id] Could not save lot metadata - ownership details and payments may not be saved! Continuing...", 1)

	if(!save_map(id, "data/persistent/lots/backup/[get_real_year()]/[NumMonth2TextMonth(get_real_month())]/[get_real_day()]/", TRUE, FALSE))
		message_admins("SAVE: [id] Could not backup map data. Call developers!", 1)
		return FALSE

	return TRUE


/datum/lot/proc/load_lot()
	if(!lot_area)
		return FALSE

	if(!config.lot_saving)
		return FALSE

	var/full_path = "[path][id].sav"
	if(fexists(full_path))
		for(var/obj/O in lot_area)
			if(O.dont_save)
				continue

			QDEL_NULL(O)

		// one more time, as some things that delete leave things behind. Sigh.
		for(var/obj/O in lot_area)
			if(O.dont_save)
				continue

			QDEL_NULL(O)

		allow_saving = FALSE
		if(restore_map(id, path) && load_metadata())
			allow_saving = TRUE

		for(var/obj/O in lot_area)
			O.on_persistence_load()
			CHECK_TICK
		for(var/turf/simulated/wall/T in lot_area)
			T.on_persistence_load()
			T.update_material()
			CHECK_TICK
	return 1


// debug procs. in case they're needed.
/datum/lot/proc/map_file()
	var/complete_map = map_to_file(test_map_write(), path, id)

	return complete_map


/datum/lot/proc/test_map_write()
	var/CHUNK = make_chunk()

	var/e_map = map_write(CHUNK, 1, 0)

	return e_map

/datum/lot/proc/make_chunk()
	var/list/map_turfs = get_area_turfs(lot_area)

	return map_turfs

/datum/lot/proc/maptofile()
	var/mfile = map_to_file(mapwrite())
	return mfile

/datum/lot/proc/mapwrite()
	var/mapw = map_write(make_chunk(), 1, 1)
	return mapw
