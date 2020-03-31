/datum/business_person
	var/name = "Unknown Business Person"
	var/unique_id = " "
	var/bank_id = " "
	var/email = " "

/datum/business_person/New(n_name, uid, bid, mail)

	if(n_name)
		name = n_name
	if(uid)
		unique_id = uid
	if(bid)
		bank_id = bid
	if(mail)
		email = mail


	..()