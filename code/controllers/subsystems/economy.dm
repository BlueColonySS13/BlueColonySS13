SUBSYSTEM_DEF(economy)
	name = "Economy"
	init_order = INIT_ORDER_ECONOMY
	flags = SS_NO_FIRE

	var/list/all_departments = list()

/datum/controller/subsystem/economy/Initialize(timeofday)
	setup_economy()
	link_economy_accounts()

	all_departments = GLOB.departments

	load_economy()
	init_expenses()
	persistent_economy.load_accounts()

	. = ..()

/datum/controller/subsystem/economy/proc/setup_economy()
	for(var/instance in subtypesof(/datum/department))
		new instance

	GLOB.current_date_string = "[get_game_day()] [get_month_from_num(get_game_month())], [get_game_year()]"

/datum/controller/subsystem/economy/proc/init_expenses()
	for(var/E in subtypesof(/datum/expense/nanotrasen) - list(/datum/expense/nanotrasen/pest_control,
	 /datum/expense/nanotrasen/tech_support, /datum/expense/nanotrasen/external_defense
	 ))
		var/datum/expense/new_expense = new E
		persistent_economy.city_expenses += new_expense

		new_expense.do_effect()

/datum/controller/subsystem/economy/proc/link_economy_accounts()
	for(var/obj/item/device/retail_scanner/RS in GLOB.transaction_devices)
		if(RS.account_to_connect)
			RS.linked_account = dept_acc_by_id(RS.account_to_connect)

	for(var/obj/machinery/cash_register/CR in GLOB.transaction_devices)
		if(CR.account_to_connect)
			CR.linked_account = dept_acc_by_id(CR.account_to_connect)

	for(var/obj/machinery/status_display/money_display/MD in GLOB.money_displays)
		MD.link_to_account()

/datum/controller/subsystem/economy/proc/charge_head_department(amount, purpose)
	if(!using_map || !HEAD_DEPARTMENT) // shouldn't happen, but just in case
		return

	var/datum/department/head_account = using_map.get_head_department()

	if(head_account.adjust_funds(amount))
		if(purpose)
			head_account.bank_account.add_transaction_log(head_account.name, purpose, amount, "[head_account.name] Funding Account")
		return TRUE

/datum/controller/subsystem/economy/proc/charge_main_department(amount, purpose)
	if(!using_map || !MAIN_DEPARTMENT) // shouldn't happen, but just in case
		return

	var/datum/department/main_account = using_map.get_main_department()

	if(main_account.adjust_funds(amount))
		if(purpose)
			main_account.bank_account.add_transaction_log(main_account.name, purpose, amount, "[main_account.name] Funding Account")
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

/datum/controller/subsystem/economy/proc/collect_all_earnings()
	// collects money from all cash registers and puts 'em in their relavent accounts
	for(var/obj/machinery/cash_register/CR in GLOB.transaction_devices)
		if(CR.linked_account)
			CR.linked_account.money += CR.cash_stored
			CR.cash_stored = 0


/datum/controller/subsystem/economy/proc/prepare_economy_save()
	// put anything here that you want to run just before saving happens.
	collect_all_earnings()

	return TRUE

/datum/controller/subsystem/economy/proc/save_economy()
	prepare_economy_save()

	if(isemptylist(GLOB.departments))
		message_admins("Economy Subsystem error: No department accounts found. Unable to save.", 1)
		return FALSE

	// save each department to a save file.
	for(var/datum/department/D in GLOB.departments)

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
			D.bank_account.sanitize_values()

			S["money"] << D.bank_account.money
			S["account_number"] << D.bank_account.account_number
			S["remote_access_pin"] << D.bank_account.remote_access_pin
			S["transaction_log"] << D.bank_account.transaction_log

		S["blacklisted_employees"] << D.blacklisted_employees

	return TRUE


/datum/controller/subsystem/economy/proc/load_economy()
	if(isemptylist(GLOB.departments))
		message_admins("Economy Subsystem error: No department accounts found. Unable to load.", 1)
		return FALSE

	// save each department to a save file.
	for(var/datum/department/D in GLOB.departments)

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




