var/global/current_date_string
var/global/datum/economy/bank_accounts/persistent_economy = new()

/datum/money_account/proc/charge(var/transaction_amount,var/datum/money_account/dest,var/transaction_purpose, var/terminal_name="", var/terminal_id=0, var/dest_name = "UNKNOWN")
	if(transaction_amount <= money)
		//transfer the money
		money -= transaction_amount
		if(dest)
			dest.money += transaction_amount

		//create entries in the two account transaction logs

		if(dest)
			dest.add_transaction_log(owner_name, transaction_purpose, transaction_amount, terminal_name)

		add_transaction_log(owner_name, transaction_purpose, transaction_amount, terminal_name)

		return 1
	else
		to_chat(usr, "\icon[src]<span class='warning'>You don't have that much money!</span>")
		return 0



