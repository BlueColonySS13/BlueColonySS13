// Persistent lots are saved to /maps/persistent/lots by default, the id is the filename	~ Cassie

/datum/lot
	var/name = "Empty Lot"
	var/id = "emptylot"
	var/desc = "A generic lot you can buy."
	var/price = 20000
	var/rent = 300

	//owner related
	var/datum/tenant/landlord
	var/list/tenants = list()

	var/list/applied_tenants = list()	//people who have applied to become a tenant, for rejection or for approval

//	var/company_name						// if owned by a company. (not implemented)

	var/service_light_warning = 5000
	var/service_charge_warning = 15000			// how much debt landlord is in before letters start arriving.
	var/service_charge_possession = 20000  		//how much debt landlord is in with service charges before council come be a bitch.

	var/required_deposit = 200

	var/list/landlord_checkbook = list()		//changes every payroll

	var/list/licenses = list(LICENSE_LANDLORD_COMMERCIAL)

	var/held = FALSE
	var/tenants_wanted = FALSE
	var/for_sale = FALSE

	var/tmp/turf/top_left			//turf of top left
	var/tmp/turf/bottom_right		//turf of bottom right
	var/tmp/area/lot_area

	var/path = "data/persistent/lots/"

	var/reason_held = ""

	var/max_tenants = 3

	var/list/notes = list()


/datum/lot/New()
	SSlots.all_lots += src
	get_coordinates()

	..()


/datum/lot/proc/get_coordinates()
	for(var/obj/effect/landmark/lot_data/lot_data)
		if(lot_data.lot_id == id)
			if( istype(lot_data, /obj/effect/landmark/lot_data/top_left) )
				top_left = lot_data.loc
			else if( istype(lot_data,/obj/effect/landmark/lot_data/bottom_right) )
				bottom_right = lot_data.loc

	lot_area = get_area(top_left)

	if(top_left && bottom_right && lot_area)
		return 1

	return 0


/datum/lot/proc/map_file()
	var/complete_map = map_to_file(test_map_write(), path, id)

	return complete_map


/datum/lot/proc/test_map_write()
	var/CHUNK = make_chunk()

	var/e_map = map_write(CHUNK, 1, 0)

	return e_map

/datum/lot/proc/make_chunk()
	var/map_turfs = get_map_turfs(top_left, bottom_right)

	return map_turfs

/datum/lot/proc/maptofile()
	var/mfile = map_to_file(mapwrite())
	return mfile

/datum/lot/proc/mapwrite()
	var/mapw = map_write(make_chunk(), 1, 1)
	return mapw

/datum/lot/proc/save_lot_data()
	if(!top_left || !bottom_right)
		return 0
//	var/map = SSmapping.maploader.save_map(top_left, bottom_right, id, path, DMM_IGNORE_MOBS)
	var/map = save_map(top_left, bottom_right, id, path, TRUE, FALSE)

	return map

/datum/lot/proc/load_lot()
	if(!top_left || !bottom_right)
		return 0

	var/full_path = "[path][id].sav"
	if(fexists(full_path))
		for(var/obj/O in lot_area)
			QDEL_NULL(O)

		// one more time, as some things that delete leave things behind.
		for(var/obj/O in lot_area)
			QDEL_NULL(O)
//		SSmapping.maploader.load_map_tg(file(full_path), top_left.x, bottom_right.y, top_left.z, 1, 0)
//		SSmapping.maploader.load_map(file(full_path), top_left.x, bottom_right.y, top_left.z, 1, 0)
		restore_map(id, path)
		for(var/obj/O in lot_area)
			O.on_persistence_load()

/*
		// Some things don't initialize at all after being loaded, it's weird, but this is needed too.
		for(var/obj/O in lot_area)
			O.persistence_save = FALSE
			sleep(1)
			if(!O.initialized || istype(O,/obj/structure))
				O.initialize()
		return 1
*/
	return 1


// Lot signs, if a lot is vacant, it'll spawn a for rent sign on round start. Else, it'll delete itself. It'll copy the pixel_x and pixel_y of itself to the for rent sign, too.

/obj/effect/landmark/lotsign
	name = "rent sign spawner"
	icon = 'icons/obj/signs.dmi'
	desc = "Spawns a rent sign."
	icon_state = "rent"

	var/lot_id		//associated lot ID
	dont_save = FALSE

/obj/effect/landmark/lotsign/initialize()
	SSlots.lotsigns += src

/obj/effect/landmark/lotsign/proc/get_lot_data()
	if(!lot_id)
		var/area/_area = loc.loc
		lot_id = _area.lot_id

	var/datum/lot/lot = SSlots.get_lot_by_id(lot_id)

	if(lot && !(lot.get_status() == RENTED))
		var/obj/structure/sign/rent/R = new /obj/structure/sign/rent (src.loc)

		if(lot.get_status() == FOR_RENT)
			R.icon_state = "rent"

			R.name = "[lot.name] - For Rent ([lot.rent]cr per month)"
			R.desc = "This rent sign says <b>[lot.name] - For Rent ([lot.price]cr)</b><br>\
			Underneath, the sign notes the housing is owned by <b>[lot.get_landlord_name()]</b>. Contact them for more details or buy from the Landlord Management Program on the computers in the library."

		if(lot.get_status() == FOR_SALE)
			R.icon_state = "sale"

			R.name = "[lot.name] - For Sale ([lot.price]cr)"
			R.desc = "This rent sign says <b>[lot.name] - For Sale ([lot.price]cr)</b><br>\
			Underneath, the sign notes the housing is owned by <b>[lot.get_landlord_name()]</b>. Contact them for more details or buy from the Landlord Management Program on the computers in the library."

		if(lot.get_status() == LOT_HELD)
			R.icon_state = "held"

			R.name = "[lot.name] - Held"
			R.desc = "This lot has been seized by City Council."
			if(lot.reason_held)
				R.desc += " Reason: [lot.reason_held]"


		//copy over mapping values.
		R.pixel_z = pixel_z
		R.pixel_x = pixel_x
		R.pixel_y = pixel_y

	delete_me = 1
	qdel(src)
