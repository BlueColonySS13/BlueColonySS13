
/datum/money_account
	var/owner_name = ""
	var/account_number = ""
	var/remote_access_pin = 0
	var/money = 0

	var/list/transaction_log = list()
	var/max_transaction_logs = NORMAL_TRANSACTION_LIMIT

	var/suspended = 0
	var/security_level = 0	//0 - auto-identify from worn ID, require only account number
							//1 - require manual login / account number and pin
							//2 - require card and manual login

	var/list/datum/expense/expenses = list()		//list of debts and expenses
	var/fingerprint

	var/hidden = FALSE

/datum/transaction
	var/target_name = ""
	var/purpose = ""
	var/amount = 0
	var/date = ""
	var/time = ""
	var/source_terminal = ""
	var/target_ckey = "n/a" //kept on admin side, for monitoring. n/a by default.

/proc/create_account(var/new_owner_name = "Default user", var/starting_funds = 0, var/obj/machinery/account_database/source_db, fingerprint, department = FALSE)

	//create a new account
	var/datum/money_account/M

	if(!department)
		M = new()
	else
		M = new/datum/money_account/department()

	M.owner_name = new_owner_name
	M.remote_access_pin = rand(1111, 9999)
	M.money = starting_funds
	M.security_level = 1
	M.fingerprint = fingerprint
	M.account_number = md5("[M.owner_name][GLOB.current_date_string][get_game_time()]")

	var/source_terminal

	if(!source_db)
		source_terminal = "NTGalaxyNet Terminal #[rand(111,1111)]"
	else
		source_terminal = source_db.machine_id
		//create a sealed package containing the account details
		var/obj/item/smallDelivery/P = new /obj/item/smallDelivery(source_db.loc)

		var/obj/item/weapon/paper/R = new /obj/item/weapon/paper(P)
		R.forceMove(P)
		R.name = "Account information: [M.owner_name]"
		R.info = "<b>Account details (confidential)</b><br><hr><br>"
		R.info += "<i>Account holder:</i> [M.owner_name]<br>"
		R.info += "<i>Account number:</i> [M.account_number]<br>"
		R.info += "<i>Account pin:</i> [M.remote_access_pin]<br>"
		R.info += "<i>Starting balance:</i> [cash2text( M.money, FALSE, TRUE, TRUE )]<br>"
		R.info += "<i>Date and time:</i> [stationtime2text()], [stationdate2text()]<br><br>"
		R.info += "<i>Creation terminal ID:</i> [source_db.machine_id]<br>"
		R.info += "<i>Authorised NT officer overseeing creation:</i> [source_db.held_card.registered_name]<br>"

		//stamp the paper
		var/image/stampoverlay = image('icons/obj/bureaucracy.dmi')
		stampoverlay.icon_state = "paper_stamp-cent"
		if(!R.stamped)
			R.stamped = new
		R.stamped += /obj/item/weapon/stamp
		R.overlays += stampoverlay
		R.stamps += "<HR><i>This paper has been stamped by the Accounts Database.</i>"

	//add the account
	M.add_transaction_log(new_owner_name, "Account creation", starting_funds, source_terminal)
	M.sanitize_values()
	GLOB.all_money_accounts.Add(M)
	return M

/proc/charge_to_account(var/attempt_account_number, var/source_name, var/purpose, var/terminal_id, var/amount, var/leave_log = TRUE)

	for(var/datum/money_account/D in GLOB.all_money_accounts)
		if(D.account_number == attempt_account_number && !D.suspended || D.account_number == attempt_account_number && !D.suspended)
			D.money += amount
			//create a transaction log entry
			if(leave_log)
				D.add_transaction_log(source_name, purpose, amount, terminal_id)
			return 1


	if(config.canonicity)
		if(check_persistent_account(attempt_account_number) && !get_persistent_acc_suspension(attempt_account_number))

			//create a transaction log entry
			var/datum/transaction/T = create_transaction_log(source_name, purpose, amount, terminal_id)

			persist_adjust_balance(attempt_account_number, amount)
			if(leave_log)
				add_persistent_acc_logs(attempt_account_number, T)

			return 1

	return 0

//this returns the first account datum that matches the supplied accnum/pin combination, it returns null if the combination did not match any account
/proc/attempt_account_access(var/attempt_account_number, var/attempt_pin_number, var/security_level_passed = 0)
	var/datum/money_account/D = get_account(attempt_account_number)

	var/sec_level
	var/pin_no


	if(D)
		sec_level = D.security_level
		pin_no = D.remote_access_pin

	if( sec_level <= security_level_passed && (!sec_level || pin_no == attempt_pin_number) )
		return D




/proc/get_account(var/account_number)
	for(var/datum/money_account/D in GLOB.all_money_accounts)
		if(D.account_number == account_number)
			return D
	for(var/datum/money_account/D in GLOB.department_accounts)
		if(D.account_number == account_number)
			return D

/proc/get_account_name(var/account_number)
	var/datum/money_account/M = get_account(account_number)
	if(M)
		return M.owner_name

	return get_persistent_acc_name(account_number)

/proc/check_account_exists(var/account_number)
	for(var/datum/money_account/D in GLOB.all_money_accounts)
		if(D.account_number == account_number)
			return TRUE

	if(check_persistent_account(account_number))
		return TRUE

	return FALSE



/proc/check_account_suspension(var/account_number)
	var/datum/money_account/M = get_account(account_number)
	if(M)
		return M.suspended

	if(get_persistent_acc_suspension(account_number))
		return TRUE

	return FALSE

/proc/create_transaction_log(name, purpose, amount = 0, terminal_id = "Terminal #[rand(111,999)]", date = GLOB.current_date_string, time = stationtime2text())
	var/datum/transaction/T = new()

	T.target_name = name
	T.purpose = purpose

	if(!isnum(amount))
		amount = text2num(amount)

	T.amount = cash2text( amount, FALSE, TRUE, TRUE )

	T.date = date
	T.time = time
	T.source_terminal = terminal_id

	return T

// why was this never made until now?
/datum/money_account/proc/add_transaction_log(name, purpose, amount, terminal_id, date, time)
	var/T = create_transaction_log(name, purpose, amount, terminal_id, date, time)
	if(!T || !transaction_log)
		return
	transaction_log.Add(T)
	sanitize_values()

	return T

/datum/money_account/proc/sanitize_values()
	if(!account_number)
		account_number = md5("[owner_name][GLOB.current_date_string][get_game_time()]")

	if(!remote_access_pin)
		remote_access_pin = rand(1111,9999)

	money = Clamp(money, -MAX_MONEY, MAX_MONEY)
	if(!transaction_log)
		transaction_log = list()

	truncate_oldest(transaction_log, max_transaction_logs)

/proc/all_public_accounts(show_hidden = FALSE)
	var/list/m_accounts = list()
	for(var/datum/money_account/M in GLOB.all_money_accounts)
		if(!show_hidden && M.hidden)
			continue
		m_accounts += M

	return m_accounts