SUBSYSTEM_DEF(economy)
	name = "Economy"
	init_order = INIT_ORDER_ECONOMY
	flags = SS_NO_FIRE

	var/list/all_departments = list()
	var/list/all_department_accounts = list()
	var/list/all_public_depts = list()
	var/list/all_private_depts = list()
	var/list/all_hidden_depts = list()
	var/list/all_business_depts = list()
	var/list/all_money_accounts_list = list()

/datum/controller/subsystem/economy/Initialize(timeofday)
	setup_economy()
	load_economy()
	load_business_departments()
	link_economy_accounts()

	all_departments = GLOB.departments
	all_department_accounts = GLOB.department_accounts
	all_public_depts = GLOB.public_departments
	all_private_depts = GLOB.private_departments
	all_hidden_depts = GLOB.hidden_departments
	all_business_depts = GLOB.business_departments
	all_money_accounts_list = GLOB.all_money_accounts
	. = ..()

/datum/controller/subsystem/economy/proc/get_all_nonbusiness_departments()
	var/list/depts = list()
	for(var/datum/department/D in all_departments)
		if(D.dept_type == BUSINESS_DEPARTMENT)
			continue
		depts |= D

	return depts

/datum/controller/subsystem/economy/proc/get_all_business_departments()
	var/list/depts = list()
	for(var/datum/department/D in all_departments)
		if(D.dept_type != BUSINESS_DEPARTMENT)
			continue
		depts |= D

	return depts

/datum/controller/subsystem/economy/proc/setup_economy()
	for(var/instance in subtypesof(/datum/department))
		new instance

	GLOB.current_date_string = "[get_game_day()] [get_month_from_num(get_game_month())], [get_game_year()]"

/datum/controller/subsystem/economy/proc/link_economy_accounts()
	for(var/obj/item/device/retail_scanner/RS in GLOB.transaction_devices)
		if(RS.account_to_connect)
			RS.linked_account = dept_acc_by_id(RS.account_to_connect)

	for(var/obj/machinery/cash_register/CR in GLOB.transaction_devices)
		if(CR.account_to_connect)
			CR.connect_to_dept()

	for(var/obj/machinery/status_display/money_display/MD in GLOB.money_displays)
		MD.link_to_account()

	for(var/obj/machinery/inventory_machine/nanotrasen/NTBOX in GLOB.inventory_boxes)
		NTBOX.link_nt_account()

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
		if(CR.linked_account && CR.account_to_connect && CR.cash_stored)
			charge_to_account(CR.linked_account, "Money Collection", "Money Left in Till", CR.machine_id, CR.cash_stored)
			CR.cash_stored = 0


/datum/controller/subsystem/economy/proc/prepare_economy_save()
	// put anything here that you want to run just before saving happens.
	collect_all_earnings()

	return TRUE



