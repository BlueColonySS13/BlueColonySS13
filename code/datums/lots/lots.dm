//STATUSES
#define FOR_RENT "for rent"
#define FOR_SALE "for sale"
#define RENTED "rented"
#define OWNED "owned"
#define LOT_HELD "seized"
#define LOT_LAWSUIT
//SERVICES
#define CLEANING_SERVICE "cleaning service"
#define PEST_CONTROL "pest control"
#define WATER_BILLS "water bills"
#define ELECTRICITY_BILLS "electricity bills"

// Persistent lots are saved to /maps/persistent/lots by default, the id is the filename	~ Cassie

/datum/lot
	var/name = "Empty Lot"
	var/id = "emptylot"
	var/desc = "A generic lot you can buy."
	var/price = 20000
	var/rent = 300

	//owner related
	var/landlord_name = ""
	var/tenant_name
	var/company_name	// if owned by a company. (not implemented)

	var/tenant_uid
	var/landlord_uid
	var/company_uid	// not in use yet

	var/company_email	// if a company has an email for contact (not implemented)
	var/landlord_email
	var/tenant_email

	var/last_payment			// date of last time the lots were charged, this is done monthly, goes from landlord
	var/last_payment_tnt		// last time tenant paid their bills

	var/service_charge_warning = 15000	// how much debt landlord is in before letters start arriving. (not implemented)
	var/service_charge_possession = 20000  //how much debt landlord is in with service charges before NT come be a bitch. (not implemented)

	var/landlord_balance = 0
	var/tenant_balance = 0

	var/required_deposit = 200

	//money related
	var/landlord_bank	// account id of who gets charged monthly for this
	var/tenant_bank	// account id of tenant who is the landlord bitch mon

	var/electricity_bill = 0 // this increases when lights are used.
	var/water_bill = 0			// this increases when water is used.

	var/electricity_service = TRUE
	var/electricity_cost = 20

	var/water_service = TRUE
	var/water_cost = 10

	var/cleaning_service = FALSE	// is this place cleaned on roundstart? (not implemented)
	var/cleaning_service_cost = 120 // (not implemented)

	var/pest_control = FALSE // (not implemented)
	var/pest_control_cost = 25 // (not implemented)

	/*
	// possible descriptors (for now):
	-	pest control
	-	cleaning service
	*/
	var/list/landlord_does = list()

	var/status = FOR_SALE

	var/turf/top_left			//turf of top left
	var/turf/bottom_right		//turf of bottom right
	var/area/lot_area

	var/path = "data/persistent/lots/"


/datum/lot/New()
	SSlots.all_lots += src
	get_coordinates()

	..()

/datum/lot/proc/get_lot_price()
	if(HOUSING_TAX)
		return get_tax_price(HOUSING_TAX, price)

	return price

/datum/lot/proc/get_lot_tax_diff()
	return (HOUSING_TAX * price)

/datum/lot/proc/get_lot_tax()
	if(HOUSING_TAX)
		return HOUSING_TAX

	return 0


/datum/lot/proc/get_rent()
	var/total_rent = 0

	total_rent = (get_tenant_charge() + rent)

	return total_rent

/datum/lot/proc/has_tenant()
	if(tenant_uid)
		return TRUE


/datum/lot/proc/get_service_charge()
	var/service_charge = 0

	if(has_tenant())
		//if they pay for cleaning, pest, etc, charge em.
		if(cleaning_service && (CLEANING_SERVICE in landlord_does))
			service_charge += cleaning_service_cost

		if(pest_control && (PEST_CONTROL in landlord_does)) // no mice or lizards here, no suree.
			service_charge += pest_control_cost

		if(water_service && (WATER_BILLS in landlord_does))
			service_charge += water_cost

		if(electricity_service && (ELECTRICITY_BILLS in landlord_does))
			service_charge += electricity_cost

	else
		if(cleaning_service)
			service_charge += cleaning_service_cost

		if(pest_control)
			service_charge += pest_control_cost

		if(water_service)
			service_charge += water_cost

		if(electricity_service)
			service_charge += electricity_cost

	return service_charge

/datum/lot/proc/get_tenant_charge()
	var/tnt_charge = 0

	//if they pay for cleaning, pest, etc, charge em.
	if(cleaning_service && !(CLEANING_SERVICE in landlord_does))
		tnt_charge += cleaning_service_cost

	if(pest_control && !(PEST_CONTROL in landlord_does)) // no mice or lizards here, no suree.
		tnt_charge += pest_control_cost

	return tnt_charge

/datum/lot/proc/set_new_ownership(uid, l_name, bank, email)
	//transfer price of lot to old owner's bank account
	if(landlord_bank)
		charge_to_account(landlord_bank, "Landlord Management", "Payment for [name]", "Landlord Management Console", get_lot_price())
		department_accounts["[station_name()] Funds"].money += get_lot_price()

	// Buying a lot as a landlord anew.
	landlord_uid = uid
	landlord_name = l_name

	if(bank)
		landlord_bank = bank
	else
		var/datum/money_account/CC_acc = department_accounts["City Council"]
		landlord_bank = CC_acc.account_number


	if(email)
		landlord_email = email
	else
		landlord_email = using_map.council_email

	landlord_balance = 0

	if(!tenant_uid)
		status = OWNED

	water_bill = 0

/datum/lot/proc/make_tenant(uid, l_name, bank, email)
	// Selling a property as a landlord, to a tenant
	//transfer price of lot to old owner's bank account

	// Buying a lot as a landlord anew.
	tenant_uid = uid
	tenant_name = l_name


	if(bank)
		tenant_bank = bank

	if(email)
		tenant_email = email
	else
		tenant_email = using_map.council_email

	status = RENTED

	return 1

/datum/lot/proc/sell_to_council()
	// Aka reset lot. Selling a property back to the bad boys
	set_new_ownership()
	status = FOR_SALE

/datum/lot/proc/remove_tenant()

	// removes a tenant from the lot
	tenant_uid = null
	tenant_name = null
	tenant_bank = null
	tenant_email = null
	tenant_email = null

	// Resets lot status
	if(landlord_uid)
		status = OWNED
	else
		status = FOR_SALE

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

/datum/lot/proc/save_lot_data()
	if(!top_left || !bottom_right)
		return 0
	var/map = SSmapping.maploader.save_map(top_left, bottom_right, id, path, DMM_IGNORE_MOBS)

	return map

/datum/lot/proc/load_lot()
	if(!top_left || !bottom_right)
		return 0

	var/full_path = "[path][id].dmm"
	if(fexists(full_path))
		for(var/obj/O in lot_area)
			QDEL_NULL(O)

		// one more time, as some things that delete leave things behind.
		for(var/obj/O in lot_area)
			QDEL_NULL(O)
//		SSmapping.maploader.load_map_tg(file(full_path), top_left.x, bottom_right.y, top_left.z, 1, 0)
		SSmapping.maploader.load_map(file(full_path), top_left.x, bottom_right.y, top_left.z, 1, 0)

		// Some things don't initialize at all after being loaded, it's weird, but this is needed too.
		for(var/obj/O in lot_area)
			O.persistence_save = FALSE
			sleep(1)
			if(!O.initialized || istype(O,/obj/structure))
				O.initialize()
		return 1

	return 0


/datum/controller/subsystem/lots/proc/monthly_payroll()
	for(var/datum/lot/L in all_lots)
		if(!(Days_Difference(L.last_payment , full_game_time() ) > 30 ) )
			if(!L.status == FOR_SALE)
				if(L.status == RENTED)
					L.tenant_balance += L.rent
			L.landlord_balance += L.get_service_charge()

			L.last_payment = full_game_time()

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

	if(lot && !(lot.status == RENTED))
		var/obj/structure/sign/rent/R = new /obj/structure/sign/rent (src.loc)

		if(lot.status == FOR_RENT)
			R.icon_state = "rent"

			R.name = "[lot.name] - For Rent ([lot.rent]cr per month)"
			R.desc = "This rent sign says <b>[lot.name] - For Rent ([lot.price]cr)</b><br>\
			Underneath, the sign notes the housing is owned by <b>[lot.landlord_name ? lot.landlord_name : "City Council"]</b>. Contact them for more details or buy from the Landlord Management Program on the computers in the library."

		if(lot.status == FOR_SALE)
			R.icon_state = "sale"

			R.name = "[lot.name] - For Sale ([lot.price]cr)"
			R.desc = "This rent sign says <b>[lot.name] - For Sale ([lot.price]cr)</b><br>\
			Underneath, the sign notes the housing is owned by <b>[lot.landlord_name ? lot.landlord_name : "City Council"]</b>. Contact them for more details or buy from the Landlord Management Program on the computers in the library."

		if(lot.status == LOT_HELD)
			R.icon_state = "held"

			R.name = "[lot.name] - Held"
			R.desc = "This lot has been seized by city council."


		//copy over mapping values.
		R.pixel_z = pixel_z
		R.pixel_x = pixel_x
		R.pixel_y = pixel_y

	delete_me = 1
	qdel(src)