SUBSYSTEM_DEF(economy)
	name = "Economy"
	init_order = INIT_ORDER_ECONOMY
	flags = SS_NO_FIRE

/datum/controller/subsystem/economy/Initialize()
	.=..()
	setup_economy()
	link_economy_accounts()

/datum/controller/subsystem/economy/proc/setup_economy()
	for(var/instance in subtypesof(/datum/department))
		new instance

/datum/controller/subsystem/economy/proc/link_economy_accounts()
	for(var/obj/item/device/retail_scanner/RS in GLOB.transaction_devices)
		if(RS.account_to_connect)
			RS.linked_account = dept_acc_by_id(RS.account_to_connect)

	for(var/obj/machinery/cash_register/CR in GLOB.transaction_devices)
		if(CR.account_to_connect)
			CR.linked_account = dept_acc_by_id(CR.account_to_connect)

	for(var/obj/machinery/status_display/money_display/MD in GLOB.money_displays)
		MD.link_to_account()

/datum/controller/subsystem/economy/proc/charge_head_department(amount)
	if(!using_map || !HEAD_DEPARTMENT) // shouldn't happen, but just in case
		return

	var/datum/department/head_account = HEAD_DEPARTMENT

	if(head_account.adjust_funds(amount))
		return TRUE

/datum/controller/subsystem/economy/proc/get_all_dept_names(var/needs_bank = FALSE, var/type)
	var/list/dept_names = list()
	for(var/datum/department/D in GLOB.departments)
		if(needs_bank && !D.has_bank)
			continue
		if(type && !(D.dept_type == type))
			continue
		dept_names += D.name

	return dept_names


/datum/controller/subsystem/economy/proc/save_economy()
	if(isemptylist(GLOB.department_accounts))
		message_admins("Economy Subsystem error: No department accounts found. Unable to save.", 1)
		return FALSE

	// save each department to a save file.
	for(var/datum/department/D in GLOB.department_accounts)

		D.sanitize_values()

		if(!D.name || !D.id || !D.bank_account)
			continue

		var/sav_folder = "public_departments"

		if(D.dept_type == PUBLIC_DEPARTMENT)
			sav_folder = "public_departments"
		if(D.dept_type == PRIVATE_DEPARTMENT)
			sav_folder = "private_departments"
		if(D.dept_type == EXTERNAL_DEPARTMENT)
			sav_folder = "external_departments"

		var/path = "data/persistent/departments/[sav_folder]/[D.name].sav"

		var/savefile/S = new /savefile(path)
		if(!fexists(path))
			return 0
		if(!S)
			return 0
		S.cd = "/"

		if(D.has_bank && D.bank_account)
			S["money"] << D.bank_account.money
			S["account_number"] << D.bank_account.account_number
			S["remote_access_pin"] << D.bank_account.remote_access_pin
			S["transaction_log"] << D.bank_account.transaction_log

		S["blacklisted_employees"] << D.blacklisted_employees

	return TRUE


/datum/controller/subsystem/economy/proc/load_economy()
	if(isemptylist(GLOB.department_accounts))
		message_admins("Economy Subsystem error: No department accounts found. Unable to load.", 1)
		return FALSE

	// save each department to a save file.
	for(var/datum/department/D in GLOB.department_accounts)

		D.sanitize_values()

		if(!D.name || !D.id || !D.bank_account)
			continue

		var/sav_folder = "public_departments"

		if(D.dept_type == PUBLIC_DEPARTMENT)
			sav_folder = "public_departments"
		if(D.dept_type == PRIVATE_DEPARTMENT)
			sav_folder = "private_departments"
		if(D.dept_type == EXTERNAL_DEPARTMENT)
			sav_folder = "external_departments"


		var/path = "data/persistent/departments/[sav_folder]/[D.name].sav"

		var/savefile/S = new /savefile(path)
		if(!fexists(path))
			save_economy()
			return 0
		if(!S)
			return 0
		S.cd = "/"

		if(D.has_bank && D.bank_account)
			S["money"] >> D.bank_account.money
			S["account_number"] >> D.bank_account.account_number
			S["remote_access_pin"] >> D.bank_account.remote_access_pin
			S["transaction_log"] >> D.bank_account.transaction_log

		S["blacklisted_employees"] >> D.blacklisted_employees

	return TRUE




