SUBSYSTEM_DEF(lots)
	name = "Lots"
	init_order = INIT_ORDER_LOTS
	flags = SS_NO_FIRE
	var/list/datum/lot/all_lots = list()
	var/list/obj/effect/landmark/lotsign/lotsigns = list()

/datum/controller/subsystem/lots/Initialize(timeofday)
	for(var/instance in subtypesof(/datum/lot))
		new instance

	if(config.lot_saving)
		load_all_lots()

	for(var/obj/effect/landmark/lotsign/ls in lotsigns)
		ls.get_lot_data()
		lotsigns = list()

	. = ..()


/datum/controller/subsystem/lots/proc/backup_all_lots()
	for(var/datum/lot/lots in all_lots)
		lots.backup_lot()
		CHECK_TICK

	return 1


/datum/controller/subsystem/lots/proc/save_all_lots()
	set background = 1

	if(!config.lot_saving)
		return FALSE

	for(var/datum/lot/lots in all_lots)
		if(!lots.allow_saving)
			continue
		lots.save_lot_data()
		CHECK_TICK

	return 1

/datum/controller/subsystem/lots/proc/load_all_lots()
	for(var/datum/lot/lots in all_lots)
		lots.load_lot()
		CHECK_TICK

	return 1

/datum/controller/subsystem/lots/proc/refresh_all_lot_turfs()
	for(var/datum/lot/lots in all_lots)
		for(var/turf/simulated/wall/T in lots.make_chunk())
			T.update_icon()

/datum/controller/subsystem/lots/proc/get_lot_by_id(id)
	for(var/datum/lot/lot in all_lots)
		if(lot.id == id)
			return lot
	return 0

/datum/controller/subsystem/lots/proc/get_lots_by_owner_uid(uid)
	var/list/sale_lots = list()
	for(var/datum/lot/L in all_lots)
		if(L.get_landlord_uid() == uid)
			sale_lots += L
	return sale_lots

/datum/controller/subsystem/lots/proc/get_lots_by_tenant_uid(uid)
	var/list/rent_lots = list()
	for(var/datum/lot/L in all_lots)
		for(var/datum/tenant/T in L.get_tenants())
			if(T.unique_id == uid)
				rent_lots += L
	return rent_lots

/datum/controller/subsystem/lots/proc/get_lots_for_sale()
	var/list/sale_lots = list()
	for(var/datum/lot/L in all_lots)
		if(L.get_status() == FOR_SALE)
			sale_lots += L
	return sale_lots

/datum/controller/subsystem/lots/proc/get_lots_for_rent()
	var/list/rent_lots = list()
	for(var/datum/lot/L in all_lots)
		if(L.get_status() == FOR_RENT)
			rent_lots += L
	return rent_lots