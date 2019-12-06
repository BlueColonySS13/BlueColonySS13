SUBSYSTEM_DEF(lots)
	name = "Lots"
	init_order = INIT_ORDER_LOTS
	flags = SS_NO_FIRE
	var/list/datum/lot/all_lots = list()
	var/list/obj/effect/landmark/lotsign/lotsigns = list()

/datum/controller/subsystem/lots/Initialize()
	. = ..()
	for(var/instance in subtypesof(/datum/lot))
		var/datum/lot/P = new instance
		P.load_lot()

	for(var/obj/effect/landmark/lotsign/ls in lotsigns)
		ls.get_lot_data()



/datum/controller/subsystem/lots/proc/save_all_lots()
	for(var/datum/lot/lots in all_lots)
		lots.save_lot_data()


/datum/controller/subsystem/lots/proc/get_lot_by_id(id)
	for(var/datum/lot/lot in all_lots)
		if(lot.id == id)
			return lot
	return 0

/datum/controller/subsystem/lots/proc/get_lots_by_owner_uid(uid)
	var/list/sale_lots = list()
	for(var/datum/lot/L in all_lots)
		if(L.landlord_uid == uid)
			sale_lots += L
	return sale_lots

/datum/controller/subsystem/lots/proc/get_lots_for_sale()
	var/list/sale_lots = list()
	for(var/datum/lot/L in all_lots)
		if(L.status == FOR_SALE)
			sale_lots += L
	return sale_lots

/datum/controller/subsystem/lots/proc/get_lots_for_rent()
	var/list/rent_lots = list()
	for(var/datum/lot/L in all_lots)
		if(L.status == FOR_RENT)
			rent_lots += L
	return rent_lots