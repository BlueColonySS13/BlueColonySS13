
/mob/living/carbon/human/proc/save_character_money()
	if(!mind)
		return 0


	mind.prefs.expenses = mind.initial_account.expenses
	mind.prefs.money_balance = mind.initial_account.money
	mind.prefs.bank_pin = mind.initial_account.remote_access_pin
	mind.initial_account.save_persistent_account()


	return 1

/datum/money_account/proc/load_persistent_account(var/mob/living/carbon/human/H)

	if(H.mind.prefs.bank_pin)
		H.mind.prefs.bank_pin = remote_access_pin

	if(H.mind.prefs.bank_account)
		account_number = H.mind.prefs.bank_account

	if(H.mind.prefs.expenses)
		H.mind.prefs.expenses = expenses

	transaction_log = get_persistent_acc_logs(account_number)

	if(H.get_full_print())
		fingerprint = H.get_full_print()

	if(check_persistent_account(account_number))
		money = get_persistent_acc_balance(account_number)
		suspended = get_persistent_acc_suspension(account_number)
		security_level = persist_acc_sec_level(account_number)

	sanitize_values()

/datum/money_account/proc/save_persistent_account()
	sanitize_values()

	var/full_path = "data/persistent/banks/[account_number].sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0

	S.cd = "/"

	S["owner_name"] << owner_name
	S["money"] << money
	S["account_number"] << account_number
	S["remote_access_pin"] << remote_access_pin
	S["expenses"] << expenses
	S["suspended"] << suspended
	S["max_transaction_logs"] << max_transaction_logs

	S["suspended"] << suspended

	truncate_oldest(transaction_log, max_transaction_logs)

	S["transaction_log"] << transaction_log

	S["security_level"] << security_level

	return 1


/datum/money_account/proc/make_persistent() // for existing accounts
	make_new_persistent_account(owner_name, money, remote_access_pin, expenses, transaction_log, suspended, security_level)

/proc/make_new_persistent_account(var/owner, var/money, var/pin, var/expenses, var/transaction_logs, var/suspend, var/security_level, trans_max)
	var/acc_no = md5("[owner][GLOB.current_date_string]")
	var/full_path = "data/persistent/banks/[acc_no].sav"
	if(!full_path)			return 0
	if(fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	if(!pin)
		pin = rand(1111,9999)

	S["owner_name"] << owner
	S["money"] << money
	S["account_number"] << acc_no
	S["remote_access_pin"] << pin
	S["expenses"] << expenses
	S["transaction_log"] << transaction_logs
	S["suspended"] << suspend
	S["security_level"] << security_level
	S["max_transaction_logs"] << trans_max

	return acc_no

/proc/del_persistent_account(var/account_id)
	var/full_path = "data/persistent/banks/[account_id].sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	if(fdel(full_path))
		return 1

	return 0

/proc/check_persistent_account(var/account_id)
	var/full_path = "data/persistent/banks/[account_id].sav"
	if(!full_path)			return 0
	if(fexists(full_path))	return 1

	return 0


/proc/persist_adjust_balance(var/acc_no, var/amount)
	var/full_path = "data/persistent/banks/[acc_no].sav"

	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	var/transferred_money

	S["money"] >> transferred_money

	transferred_money += amount

	S["money"] << transferred_money
	return 1

/proc/get_persistent_acc_balance(var/acc_no)
	var/full_path = "data/persistent/banks/[acc_no].sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	var/transferred_money

	S["money"] >> transferred_money
	return transferred_money

/proc/get_persistent_acc_name(var/acc_no)
	var/full_path = "data/persistent/banks/[acc_no].sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	var/acc_name

	S["owner_name"] >> acc_name
	return acc_name

/proc/get_persistent_acc_logs(var/acc_no)
	var/full_path = "data/persistent/banks/[acc_no].sav"

	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	var/list/acc_logs = list()

	S["transaction_log"] >> acc_logs

	return acc_logs

/proc/add_persistent_acc_logs(acc_no, transaction, max_logs)
	var/full_path = "data/persistent/banks/[acc_no].sav"

	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	var/list/acc_logs
	S["transaction_log"] >> acc_logs

	if(!max_logs)
		S["max_transaction_logs"] >> max_logs
		if(!max_logs)
			max_logs = 50

	acc_logs += transaction
	truncate_oldest(acc_logs, max_logs)

	S["transaction_log"] << acc_logs

	return 1


/proc/persist_set_balance(var/acc_no, var/amount)
	var/full_path = "data/persistent/banks/[acc_no].sav"

	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	var/transferred_money

	S["money"] >> transferred_money

	transferred_money = amount

	S["money"] << transferred_money

	return 1

/proc/persist_acc_sec_level(var/acc_no)
	var/full_path = "data/persistent/banks/[acc_no].sav"

	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	var/sec_level

	S["security_level"] >> sec_level

	return sec_level

/proc/get_persistent_acc_suspension(var/acc_no)
	var/full_path = "data/persistent/banks/[acc_no].sav"

	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	var/suspended

	S["suspended"] >> suspended

	return suspended




/proc/get_persistent_acc_pin(var/acc_no)
	var/full_path = "data/persistent/banks/[acc_no].sav"

	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	var/pin_no

	S["remote_access_pin"] >> pin_no

	return pin_no