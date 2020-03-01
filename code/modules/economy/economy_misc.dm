var/global/current_date_string
var/global/datum/economy/bank_accounts/persistent_economy

/datum/money_account/proc/charge(var/transaction_amount,var/datum/money_account/dest,var/transaction_purpose, var/terminal_name="", var/terminal_id=0, var/dest_name = "UNKNOWN")
	if(transaction_amount <= money)
		//transfer the money
		money -= transaction_amount
		if(dest)
			dest.money += transaction_amount

		//create entries in the two account transaction logs
		var/datum/transaction/T
		if(dest)
			T = new()
			T.target_name = owner_name
			if(terminal_name!="")
				T.target_name += " (via [terminal_name])"
			T.purpose = transaction_purpose
			T.amount = "[transaction_amount]"
			T.source_terminal = terminal_name
			T.date = current_date_string
			T.time = stationtime2text()
			dest.transaction_log.Add(T)
		//
		T = new()
		T.target_name = (!dest) ? dest_name : dest.owner_name
		if(terminal_name!="")
			T.target_name += " (via [terminal_name])"
		T.purpose = transaction_purpose
		if(transaction_amount < 0)
			T.amount = "[-1*transaction_amount]"
		else
			T.amount = "-[transaction_amount]"
		T.source_terminal = terminal_name
		T.date = current_date_string
		T.time = stationtime2text()
		transaction_log.Add(T)
		return 1
	else
		to_chat(usr, "\icon[src]<span class='warning'>You don't have that much money!</span>")
		return 0



