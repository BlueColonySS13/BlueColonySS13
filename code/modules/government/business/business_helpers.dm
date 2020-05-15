/proc/get_business_by_name(name) //Compares a business 'B' to the master list and returns the business if found.
	for(var/datum/business/B in GLOB.all_businesses)
		if(B.name == name)
			return B

/proc/get_business_by_biz_uid(uid)
	for(var/datum/business/B in GLOB.all_businesses)
		if(B.business_uid == uid)
			return B

/proc/get_business_by_owner_uid(uid)
	for(var/datum/business/B in GLOB.all_businesses)
		if(!B.owner)
			continue
		if(B.owner.unique_id == uid)
			return B

/datum/business/proc/try_auth_business(pass)
	if(access_password == pass)
		return 1
	return 0

/datum/business/proc/get_owner_bank_id()
	if(!owner)
		return

	return owner.bank_id

/datum/business/proc/get_owner_name()
	if(!owner)
		return "No Owner"

	return owner.name

/datum/business/proc/get_owner()
	return owner

/datum/business/proc/get_status()
	if(suspended)
		return BUSINESS_SUSPENDED

	return BUSINESS_ACTIVE

/datum/business/proc/get_department()
	return dept_by_id(department)

/proc/businesses_by_category(cat)
	var/list/biz = list()
	for(var/datum/business/B in GLOB.all_businesses)
		if(cat in B.categories)
			biz += B

	return biz