/datum/department
	var/name = "Department"
	var/id
	var/desc = "This is a generic department. Technically you shouldn't see this."

	//money related
	var/has_bank = TRUE
	var/starting_money = 7500
	var/datum/money_account/department/bank_account

	var/dept_type = PUBLIC_DEPARTMENT

	var/list/blacklisted_employees = list()	// employees are added here by UID (unique id)


/datum/money_account/department
	var/datum/department/department
	max_transaction_logs = DEPARTMENT_TRANSACTION_LIMIT

/datum/department/New()
	..()
	make_bank_account()
	GLOB.departments += src

	switch(dept_type)
		if(PUBLIC_DEPARTMENT)
			GLOB.public_departments += src
		if(PRIVATE_DEPARTMENT)
			GLOB.private_departments += src
		if(EXTERNAL_DEPARTMENT)
			GLOB.external_departments += src

/datum/department/proc/sanitize_values()	// juuuust in case shittery happens.
	if(!blacklisted_employees)
		blacklisted_employees = list()

	if(has_bank && !bank_account)
		make_bank_account()

	return TRUE

/proc/dept_name_by_id(id)
	for(var/datum/department/D in GLOB.departments)
		if(id == D.id)
			return D.name


/proc/dept_acc_by_id(id)
	for(var/datum/department/D in GLOB.departments)
		if((id == D.id) && D.bank_account)
			return D.bank_account

/proc/dept_by_id(id)
	for(var/datum/department/D in GLOB.departments)
		if(id == D.id)
			return D


/proc/dept_by_name(name)
	for(var/datum/department/D in GLOB.departments)
		if(name == D.name)
			return D

/proc/adjust_dept_funds(id, amount)
	var/datum/money_account/M = dept_acc_by_id(id)

	if(!M)
		return FALSE

	M.money += amount
	return TRUE

/proc/dept_balance(id)
	var/datum/money_account/M = dept_acc_by_id(id)
	if(!M)
		return FALSE

	return M.money

/datum/department/proc/make_bank_account()
	if(!id)
		return FALSE

	if(!has_bank)
		return FALSE

	bank_account = create_account(name, starting_money, null, department = TRUE)
	bank_account.department = src
	GLOB.department_accounts += bank_account

	switch(dept_type)
		if(PUBLIC_DEPARTMENT)
			GLOB.public_department_accounts += bank_account
		if(PRIVATE_DEPARTMENT)
			GLOB.private_department_accounts += bank_account
		if(EXTERNAL_DEPARTMENT)
			GLOB.external_department_accounts += bank_account

	return bank_account

/datum/department/proc/get_balance()
	if(!bank_account)
		return FALSE

	return bank_account.money

/datum/department/proc/get_text_balance()
	return cash2text(get_balance())

/datum/department/proc/get_account()
	return bank_account

/datum/department/proc/adjust_funds(amount, purpose)	//hard editing mostly. don't use in most circumstances. Use direct_charge_money() instead for trans logs
	if(!bank_account)
		return FALSE

	bank_account.money += amount
	if(purpose)
		bank_account.add_transaction_log(name, purpose, amount, "Department Funds Transfer")

	return bank_account.money

/datum/department/proc/direct_charge_money(acc_no, name, amount, purpose, terminal)
// same as above, you're charging an external bank acc for money here.
	if(!bank_account)
		return FALSE

	if(!terminal)
		terminal = "Department Funds Transfer"

	if(charge_to_account(acc_no, name, purpose, terminal, amount))
		//create an entry in the account transaction log
		if(amount > 0)
			bank_account.money -= amount
			bank_account.add_transaction_log("Account #[acc_no]", purpose, -amount, terminal)
		else
			bank_account.money += amount
			bank_account.add_transaction_log("Account #[acc_no]", purpose, amount, terminal)
		return TRUE

	return FALSE
