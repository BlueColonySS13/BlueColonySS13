/datum/money_account/proc/charge(var/transaction_amount, var/datum/money_account/dest, var/purpose, var/terminal="NtNet Terminal")
	if(transaction_amount <= money)
		//transfer the money

		if(0 > transaction_amount)
			// if negative, takes money to this account and adds money from the other.
			money += transaction_amount
			add_transaction_log(owner_name, purpose, transaction_amount, terminal)

			if(dest)
				dest.money -= transaction_amount
				dest.add_transaction_log(owner_name, purpose, -transaction_amount, terminal)

			return 1

		else
			// if positive, adds money to this account and subtracts money from the other.
			money -= transaction_amount
			add_transaction_log(owner_name, purpose, -transaction_amount, terminal)

			if(dest)
				dest.money += transaction_amount
				dest.add_transaction_log(owner_name, purpose, transaction_amount, terminal)

			return 1
	else
		to_chat(usr, "\icon[src]<span class='warning'>You don't have that much money!</span>")
		return 0



