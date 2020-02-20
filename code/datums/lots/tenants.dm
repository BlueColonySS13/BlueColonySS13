/datum/tenant
	var/name = "Unknown Tenant"
	var/unique_id = " "
	var/bank_id
	var/email

	var/account_balance = 0
	var/last_payment = "None"
	var/tmp/recieved_email = 0

	//applicant stuff
	var/agreed_deposit

// Future: Allow landlords to discriminate against their tenants.
/*
	var/has_criminal_record = FALSE
	var/home_system = "Vetra"
	var/is_synthetic = FALSE
*/

/datum/tenant/New()

/datum/tenant/proc/get_balance()
	return account_balance

/datum/tenant/proc/adjust_balance(amount)
	account_balance += amount

/datum/tenant/proc/pay_balance(amount)
	adjust_balance(amount)
	last_payment = full_game_time()