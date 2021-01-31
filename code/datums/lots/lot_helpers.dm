// Check procs

/datum/lot/proc/get_landlord()
	return landlord

/datum/lot/proc/get_landlord_name()
	if(!landlord)
		return "City Council"

	return landlord.name

/datum/lot/proc/get_landlord_uid()
	if(!landlord)
		return
	return landlord.unique_id

/datum/lot/proc/has_tenants()
	if(!isemptylist(tenants))
		return TRUE

/datum/lot/proc/get_tenants()
	return tenants

/datum/lot/proc/get_status()
	if(held)
		return LOT_HELD

	if(!get_landlord() || (get_landlord() && for_sale && !tenants_wanted))
		return FOR_SALE

	if(get_landlord() && tenants_wanted)
		return FOR_RENT

	if(get_landlord() && !tenants_wanted && !has_tenants())
		return OWNED

	if(get_landlord() && !tenants_wanted && has_tenants())
		return RENTED

	return LOT_HELD

/datum/lot/proc/tenancy_no_info()
	var/list/all_tnts = get_tenants()
	return "([all_tnts.len]/[max_tenants])"

/datum/lot/proc/plain_tenant_list()
	var/text
	for(var/datum/tenant/T in get_tenants())
		text += "<li>[T.name] (<b>Account Balance:</b> [cash2text( T.get_balance(), FALSE, TRUE, TRUE )])</li>"
	return


/datum/lot/proc/get_approx_earnings() //returns approx earnings (before tax and all that jazz)
	if(!has_tenants())
		return 0

	var/tenant_rent = 0
	for(var/datum/tenant/T in tenants)
		tenant_rent += get_rent(T)

	var/earnings = tenant_rent - get_service_charge()


	return earnings

// Price procs

/datum/lot/proc/get_default_price()
	return initial(price)

/datum/lot/proc/get_price()
	return price

// Rent procs

/datum/lot/proc/get_default_rent()
	return initial(rent)

/datum/lot/proc/get_rent(var/datum/tenant/T)
	if(T && !isnull(T.get_rent()))
		return T.get_rent(T)

	return rent

/datum/lot/proc/get_rent_tax_amount(var/datum/tenant/T)
	return (get_rent(T) * get_tax())

/datum/lot/proc/get_rent_after_tax(var/datum/tenant/T)
	var/rent = get_rent(T)

	return (rent - get_rent_tax_amount(T))

/datum/lot/proc/get_landlord_balance()
	return landlord.get_balance()


//tenant procs

/datum/lot/proc/get_tenant_by_uid(uid)
	for(var/datum/tenant/T in tenants)
		if(T.unique_id == uid)
			return T

/datum/lot/proc/make_tenant(uid, t_name, bank_id, email)
	var/datum/tenant/tenant = new()

	tenant.name = t_name
	tenant.unique_id = uid
	tenant.bank_id = bank_id
	tenant.email = email

	tenant.agreed_deposit = required_deposit

	return tenant

/datum/lot/proc/set_new_ownership(uid, t_name, bank_id, email)
	add_note(t_name, "Bought [name] from [get_landlord_name()]",usr)
	if(landlord)
		charge_to_account(landlord.bank_id, "Lot [name] for [t_name]", "[name] Lot Purchase", "Landlord Management", (landlord.account_balance + price))
	else
		var/datum/department/council = dept_by_id(DEPT_COUNCIL)
		council.adjust_funds(get_price(), "[name] Lot Sell to [t_name]")

	landlord = make_tenant(uid, t_name, bank_id, email)

	return landlord

/datum/lot/proc/remove_tenant(uid)
	var/datum/tenant/tenant = get_tenant_by_uid(uid)

	charge_to_account(tenant.bank_id, "Remaining Balance", "[name] Lot Remaining Balance", "Landlord Management", tenant.account_balance)

	if(landlord && (0 > tenant.account_balance))
		landlord.pay_balance(-tenant.account_balance)

	tenants -= tenant
	QDEL_NULL(tenant)
	listclearnulls(tenants)

	return TRUE

/datum/lot/proc/remove_all_tenants()
	for(var/datum/tenant/T in get_tenants())
		if(T.account_balance)
			charge_to_account(T.bank_id, "Repossession Money", "[name] Tenant Remaining Balance", "Landlord Management", T.account_balance)
	QDEL_NULL(tenants)
	tenants = list()

/datum/lot/proc/remove_all_applicants()
	QDEL_NULL(applied_tenants)
	applied_tenants = list()

/datum/lot/proc/sell_to_council(repossess=0)
	if(landlord)
		var/reason = "Housing Sell To Council"
		if(repossess)
			reason = "Lot Repossession to City Council"
		charge_to_account(landlord.bank_id, reason, "[name] Lot Remaining Balance", "Landlord Management", landlord.account_balance)

	if(!repossess)
		var/datum/department/council = dept_by_id(DEPT_COUNCIL)
		council.adjust_funds(-get_default_price(), "[name] Lot Bought from [landlord.name]")
		add_note(get_landlord_name(), "Sold [name] to City Council",usr)

	landlord = null
	price = get_default_price()
	rent = get_default_rent()
	applied_tenants = list()
	name = initial(name)


/datum/lot/proc/repossess_lot()
	remove_all_applicants()
	remove_all_tenants()
	sell_to_council(repossess=1)
	return 1

/datum/lot/proc/hold_lot(why, mob/user)
	reason_held = why
	held = TRUE
	tenants_wanted = FALSE

	return 1



/datum/lot/proc/get_service_charge() // Base service charge is calculated by the government's fee times by number of tiles in the lot.
	if(!get_landlord() || !tile_count)
		return 0

	var/full_charge = 0
	var/base_service_charge = SSpersistent_options.get_persistent_option_value("hourly_service_charge")

	if(base_service_charge)
		full_charge = base_service_charge * tile_count

	// to be expanded. services could be added here in future.

	return round(full_charge)


// Application helps

/datum/lot/proc/add_applicant(uid, t_name, bank_id, email, offered_deposit, reason)
	var/datum/tenant/applicant = make_tenant(uid, t_name, bank_id, email)

	applicant.agreed_deposit = offered_deposit
	applicant.application_note = reason

	applied_tenants += applicant

	return applicant

/datum/lot/proc/remove_applicant(applicant)
	if(!applicant || !(applicant in applied_tenants))
		return

	applied_tenants -= applicant
	QDEL_NULL(applicant)
	listclearnulls(applied_tenants)

/datum/lot/proc/get_applicant_by_uid(uid)
	for(var/datum/tenant/applicant in applied_tenants)
		if(applicant.unique_id == uid)
			return applicant

// logging

/datum/lot/proc/add_note(full_name, action, mob/user)
	notes += "([GLOB.current_date_string] [full_game_time()]) [action] - <b>[full_name]</b>"
	log_lots(user, action)

	truncate_oldest(notes, MAX_LANDLORD_LOGS)

/datum/lot/proc/accept_rentee(var/datum/tenant/applicant)
	if(!(applicant in applied_tenants))
		return
	var/datum/computer_file/data/email_account/council_email = get_email(using_map.council_email)
	var/datum/computer_file/data/email_message/message = new/datum/computer_file/data/email_message()
	var/eml_cnt = "Dear [applicant.name], \[br\]"
	eml_cnt += "Congratulations, you been successful for your application for renting the property '[name]'. \
	You will now be able to start using the lot commencing onwards. \[br\] \
	Your rent will be [cash2text( get_rent(), FALSE, TRUE, TRUE )] per payroll. Your landlord is [get_landlord_name()] may contact them on [landlord.email] \
	for any enquiries. Best wishes,\[br\] City Council \[br\] Do not reply: This is an automated email."

	message.stored_data = eml_cnt
	message.title = "Your New Property: [name] - Acceptance"
	message.source = "noreply@nanotrasen.gov.nt"

	council_email.send_mail(applicant.email, message)

	tenants += applicant
	applied_tenants -= applicant

	applicant.account_balance = applicant.agreed_deposit

	tenants_wanted = FALSE

	add_note(landlord.name, "Accepted [name]'s tenancy application for [applicant.name]",usr)
