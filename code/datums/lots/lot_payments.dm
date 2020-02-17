
// see economy.dm for placement of this. for each payroll, this proc runs to charge the landlord their service charges, and adds to the tenant balance.

/datum/lot/proc/add_balances()

	landlord_checkbook = list()

	for(var/datum/tenant/tenant in get_tenants())

		tenant.pay_balance(-get_rent())

		if(landlord)
				// if tenant's balance is below 0, landlord isn't being paid, obviously
			if(get_rent() > tenant.account_balance)
				landlord_checkbook += "[full_game_time()] - [tenant.name] for [name]: Unable to clear payment. Balance under rent charge."
			else
				if(landlord)
					landlord.account_balance += get_rent()
					landlord_checkbook += "[full_game_time()] - [tenant.name] for [name]: Payment of [get_rent()]CR successfully paid to landlord account."


	if(landlord)
		landlord.pay_balance(-get_service_charge())
		landlord_checkbook += "[full_game_time()] - Landlord Payment for [name]: [get_rent()]CR successfully paid to City Council."


/datum/lot/proc/pay_landlord_balance(amount)	// for adding funds to the account
	landlord.pay_balance(amount)

/datum/lot/proc/pay_tenant_balance(uid, amount)	// for adding funds to the account
	var/datum/tenant/tnt = get_tenant_by_uid(uid)
	tnt.pay_balance(amount)

/datum/lot/proc/send_arrears_letter(uid)	// for adding funds to the account
	var/datum/tenant/resident
	var/type = "TENANT"

	if(get_tenant_by_uid(uid))
		resident = get_tenant_by_uid(uid)
	else if(landlord.unique_id == uid)
		resident = landlord
		type = "LEASEHOLDER"

	if(!resident)
		return

	var/severity

	if(resident.account_balance > service_charge_warning)
		severity = "\[b\]WARNING\[/b\]"
	else if(resident.account_balance > service_light_warning)
		severity = "Reminder"


	var/datum/computer_file/data/email_account/council_email = get_email(using_map.council_email)
	var/datum/computer_file/data/email_message/message = new/datum/computer_file/data/email_message()
	var/eml_cnt = "Dear [resident.name], \[br\]Your account balance is currently at [resident.get_balance()]CR (credits). Severity: [severity].\[br\]"


	if(type == "LEASEHOLDER")
		eml_cnt += "You must bring your bring your account into credit to prevent reposesstion of your lot. The council may \
		repossess your lot if your balance reaches [service_charge_possession]CR in debt."

	if(type == "TENANT")
		eml_cnt += "You must bring your bring your account into credit to avoid risking eviction. Your landlord may evict you if your \
		repossession your lot if you remain in debt."

	message.stored_data = eml_cnt
	message.title = "[severity]: [name] Balance Due: [resident.get_balance()]CR"
	message.source = "noreply@nanotrasen.gov.nt"

	resident.recieved_email = 1
	council_email.send_mail(resident.email, message)
