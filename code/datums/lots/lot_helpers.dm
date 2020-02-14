// Check procs

/datum/lot/proc/get_landlord()
	return landlord

/datum/lot/proc/get_landlord_name()
	if(!landlord)
		return "City Council"

	return landlord.name

/datum/lot/proc/has_tenants()
	if(!isemptylist(tenants))
		return TRUE

/datum/lot/proc/get_tenants()
	return tenants

/datum/lot/proc/get_status()
	if(held)
		return LOT_HELD

	if(!get_landlord())
		return FOR_SALE

	if(get_landlord() && tenants_wanted)
		return FOR_RENT

	if(get_landlord() && !tenants_wanted && !has_tenants())
		return OWNED

	if(get_landlord() && !tenants_wanted && has_tenants())
		return RENTED

	return LOT_HELD


// Price procs

/datum/lot/proc/get_default_price()
	return initial(price)

/datum/lot/proc/get_price()
	return price

// Rent procs

/datum/lot/proc/get_default_rent()
	return initial(rent)

/datum/lot/proc/get_rent()
	return rent

//tenant procs

/datum/lot/proc/get_tenant_by_uid(uid)
	for(var/datum/tenant/T in tenants)
		if(T.unique_id == uid)
			return T

/datum/lot/proc/make_tenant(uid, t_name, bank_id, email)
	var/datum/tenant/tenant = new()

	tenant.name = t_name
	tenant.unique_id = uid
	tenant.bank
	tenant.email = email
	tenant.associated_lot = src

	return tenant

/datum/lot/proc/remove_tenant(uid)
	var/datum/tenant/tenant = get_tenant_by_uid(uid)

	tenants -= tenant
	QDEL_NULL(tenant)

	return TRUE

/datum/lot/proc/remove_all_tenants()
	QDEL_NULL(tenants)
	tenants = list()

/datum/lot/proc/buy_from_council(uid, t_name, bank_id, email)
	if(!uid || !t_name || !bank_id || !email)
		return FALSE

	if(!charge_to_account(bank_id, "Housing Sell", "[name] Lot Sell", "Landlord Management", get_price()))
		return FALSE

	landlord = make_tenant(uid, t_name, bank_id, email)
	department_accounts["City Council"].money += price

	return TRUE

/datum/lot/proc/sell_to_council()
	landlord = null
	price = get_default_price()
	rent = get_default_rent()

	department_accounts["City Council"].money -= price


/datum/lot/proc/repossess_lot()
	remove_all_tenants()
	sell_to_council()
	return 1

/datum/lot/proc/hold_lot(why, mob/user)
	reason_held = why
	held = TRUE
	tenants_wanted = FALSE

	return 1



/datum/lot/proc/get_service_charge()
	var/full_charge = 0

	if(persistent_economy)
		full_charge += persistent_economy.base_service_charge

	// to be expanded. services could be added here in future.

	return full_charge
