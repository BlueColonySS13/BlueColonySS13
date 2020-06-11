SUBSYSTEM_DEF(economy)
	name = "Economy"
	init_order = INIT_ORDER_ECONOMY
	flags = SS_NO_FIRE

	var/list/all_departments = list()

/datum/controller/subsystem/economy/Initialize(timeofday)
	setup_economy()
	all_departments = GLOB.departments
	load_economy()
	load_business_departments()
	init_expenses()
	persistent_economy.load_accounts()
	link_economy_accounts()
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
			var/datum/money_account/M = dept_acc_by_id(CR.account_to_connect)
			if(!M)
				continue
			CR.linked_account = M.account_number

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



