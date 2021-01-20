/datum/department
	var/name = "Department"
	var/id
	var/desc = "This is a generic department. Technically you shouldn't see this."

	//money related
	var/has_bank = TRUE
	var/starting_money = 0
	var/datum/money_account/department/bank_account
	var/business_taxed = FALSE  // no one is safe.

	var/dept_type = PUBLIC_DEPARTMENT

	var/dept_color = COLOR_GRAY

	var/list/blacklisted_employees = list()	// employees are added here by UID (unique id)

	// paths of items types of what their department cards can buy (for heads)

	var/allowed_buy_types = list()

	var/portal_card_id = null // if set, instead of pulling costs from card_spending_limit var it will use the linked portal value here
	var/card_spending_limit = 15000 // max you can spend from this card. only applies to private businesses

	var/max_bounties = 15

	var/list/bounties = list()

	var/allow_bounties = TRUE

	var/list/categories = list()

/datum/department/proc/get_categories()
	var/datum/business/B = get_business()

	if(!B)
		return categories

	return B.categories

/datum/money_account/department
	var/datum/department/department
	max_transaction_logs = DEPARTMENT_TRANSACTION_LIMIT

/datum/department/New(d_name, d_type, d_id, d_desc, d_hasbank = TRUE, d_starting_money)
	..()
	if(d_name)
		name = d_name
	if(d_type)
		dept_type = d_type
	if(d_id)
		id = d_id
	if(d_desc)
		desc = d_desc
	if(d_hasbank)
		has_bank = d_hasbank
	if(d_starting_money)
		starting_money = d_starting_money

	make_bank_account()

	sanitize_values()

/datum/department/proc/sanitize_values()	// juuuust in case shittery happens.
	if(!blacklisted_employees)
		blacklisted_employees = list()

	if(has_bank && !bank_account)
		make_bank_account()

	if(bank_account)
		bank_account.sanitize_values()

	if(!categories)
		categories = list()

	if(!bounties)
		bounties = list()

	if(get_business())
		dept_type = BUSINESS_DEPARTMENT

	GLOB.departments |= src

	switch(dept_type)
		if(PUBLIC_DEPARTMENT)
			GLOB.public_departments |= src
		if(PRIVATE_DEPARTMENT)
			GLOB.private_departments |= src
		if(EXTERNAL_DEPARTMENT)
			GLOB.external_departments |= src
		if(HIDDEN_DEPARTMENT)
			GLOB.hidden_departments |= src
		if(BUSINESS_DEPARTMENT)
			GLOB.business_departments |= src
			business_taxed = TRUE

	if(bank_account)
		switch(dept_type)
			if(PUBLIC_DEPARTMENT)
				GLOB.public_department_accounts |= bank_account
			if(PRIVATE_DEPARTMENT)
				GLOB.private_department_accounts |= bank_account
			if(EXTERNAL_DEPARTMENT)
				GLOB.external_department_accounts |= bank_account
			if(HIDDEN_DEPARTMENT)
				GLOB.hidden_department_accounts |= bank_account
				bank_account.hidden = TRUE
			if(BUSINESS_DEPARTMENT)
				GLOB.business_department_accounts |= bank_account

		if(!(bank_account in GLOB.department_accounts))
			GLOB.department_accounts |= bank_account

		if(!(bank_account in GLOB.all_money_accounts))
			GLOB.all_money_accounts.Add(bank_account)



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

/proc/adjust_dept_funds(id, amount, purpose)
	var/datum/money_account/M = dept_acc_by_id(id)

	if(!M)
		return FALSE

	M.money += amount

	if(purpose)
		M.add_transaction_log(M.owner_name, purpose, amount, "Department Funds Transfer")

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
	bank_account.department = id


	return bank_account

/datum/department/proc/get_balance()
	if(!bank_account)
		return FALSE

	return bank_account.money

/datum/department/proc/get_bank_id()
	if(!bank_account)
		return FALSE

	return bank_account.account_number

/datum/department/proc/get_text_balance()
	return cash2text(get_balance())

/datum/department/proc/get_account()
	return bank_account

/datum/department/proc/adjust_funds(amount, purpose)
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

/datum/department/proc/get_all_jobs()
	var/list/dept_jobs = list()
	for(var/datum/job/J in SSjobs.occupations)
		if(J.department == id)
			dept_jobs += J

	return dept_jobs

/datum/department/proc/get_available_jobs(mob/new_player/np)
	var/list/all_jobs = list()
	for(var/datum/job/J in get_all_jobs())
		if(!np.IsJobAvailable(J.title))
			continue
		all_jobs += J

	return all_jobs

/datum/department/proc/get_business()
	for(var/datum/business/B in GLOB.all_businesses)
		if(B.business_uid == id)
			return B
