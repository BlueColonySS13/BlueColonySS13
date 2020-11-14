SUBSYSTEM_DEF(payroll)
	name = "Payroll"
	init_order = INIT_ORDER_PAYROLL

	wait = 1200 //Ticks once per 2 minutes
	var/payday_interval = 1 HOUR
	var/next_payday = 1 HOUR

/datum/controller/subsystem/payroll/Initialize()
	.=..()

/datum/controller/subsystem/payroll/fire()
	if (world.time >= next_payday)
		next_payday = world.time + payday_interval

		//Search general records, and process payroll for all those that have bank numbers.
		city_charges()



/datum/controller/subsystem/payroll/proc/city_charges()
	for(var/datum/expense/E in persistent_economy.city_expenses)
		E.charge_department(E.cost_per_payroll)

	for(var/datum/data/record/R in data_core.general)
		payroll(R)

	for(var/datum/lot/L in SSlots.all_lots)
		L.add_balances()

	command_announcement.Announce("Hourly payroll has been processed. Please check your bank accounts for your latest payment.", "Payroll")


/datum/controller/subsystem/payroll/proc/payroll(var/datum/data/record/G)
	var/bank_number = G.fields["bank_account"]
	var/datum/job/job = SSjobs.GetJob(G.fields["real_rank"])
	var/department
	var/class = G.fields["economic_status"]
	var/name = G.fields["name"]
	var/age = G.fields["age"]
	var/datum/money_account/bank_account
	var/wage
	var/calculated_tax
	var/tax

	var/unique_id = G.fields["unique_id"]

	var/mob/living/carbon/human/linked_person



	//let's find the relevent person.
	for(var/mob/living/carbon/human/H in mob_list)
		if(unique_id == H.unique_id)
			linked_person = H

	if(!bank_number)
//		message_admins("ERROR: No bank number found for field. Returned [bank_number].", 1)
		return


	bank_account = get_account(bank_number)

	if(!bank_account)
//		message_admins("ERROR: Could not find a bank account for [bank_number].", 1)
		return

	if(!job)
		return

	department = job.department

	var/datum/department/department_account = dept_by_id(department)

	if(!department_account)
//		message_admins("ERROR: No department account found for [job]'s department: [department].", 1)
		return

	if(bank_account.suspended)
//		message_admins("ERROR: Bank account [bank_number] is suspended.", 1)
		// If there's no money in the department account, tough luck. Not getting paid.
		bank_account.add_transaction_log("Payroll Machine", "[department] Payroll: Failed (Payment Bounced Due to Suspension)", 0, "[department] Funding Account")

		return

	if((!class) || (!(class in ECONOMIC_CLASS)) )
		class = CLASS_WORKING
//		message_admins("ERROR: Could not find class. Assigned working class.", 1)

	if(!unique_id) // shouldn't happen, but you know.
		return

	if(linked_person && linked_person.client)
		var/client/linked_client = linked_person.client

		if(linked_client.inactivity > 18000) // About 30 minutes inactivity.
			return // inactive people don't get paid, sorry.
	else
//		message_admins("ERROR: Not paid due to inactivity.", 1)
		return		// person's not in the round? welp.

	switch(class)
		if(CLASS_UPPER)
			tax = persistent_economy.tax_rate_upper
		if(CLASS_MIDDLE)
			tax = persistent_economy.tax_rate_middle
		if(CLASS_WORKING)
			tax = persistent_economy.tax_rate_lower


	wage = job.wage

//	message_admins("Wage set to [job.wage].", 1)

	if(!wage)
//		message_admins("ERROR: Job does not have wage.", 1)
		return


	if(wage > department_account.get_balance())
		// If there's no money in the department account, tough luck. Not getting paid.
		bank_account.add_transaction_log(bank_account.owner_name, "[department_account.name] Payroll: Failed (Inadequate Department Funds)", 0, "[department] Funding Account")
		return

	if(age > 17) // Do they pay tax?
		calculated_tax = round(tax * wage, 1)

	//Tax goes to the treasury. Mh-hm.
	SSeconomy.charge_main_department(calculated_tax, "[department] Payroll Tax: [name] ([cash2text( calculated_tax, FALSE, TRUE, TRUE )])")

	var/final_amount = (wage - calculated_tax)

	//You get paid by your bank department's account.
	department_account.direct_charge_money(bank_account.account_number, bank_account.owner_name, final_amount, "[department_account.name] Payroll: [name] ([calculated_tax] credit tax)", "[department_account.name] Funding Account")

	//if you owe anything, let's deduct your ownings.
	for(var/datum/expense/E in bank_account.expenses)
		E.payroll_expense(bank_account)

	//Complete
