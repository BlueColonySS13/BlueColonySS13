
/datum/controller/subsystem/business/proc/save_all_businesses()
	save_bizlist()

	for(var/datum/business/B in GLOB.all_businesses)
		B.save_business()

	return 1

/datum/controller/subsystem/business/proc/load_all_businesses()
	load_bizlist()

	for(var/V in GLOB.business_ids)
		if(!V || isnull(V))
			continue
		var/datum/business/B = new /datum/business(dept = "[V]")
		B.business_uid = V
		B.load_business()

	return 1


/proc/save_bizlist()
	for(var/datum/business/B in GLOB.all_businesses)
		GLOB.business_ids |= B.business_uid

	var/full_path = "data/persistent/businesslist.sav"
	if(!full_path) return 0
	var/savefile/S = new /savefile(full_path)
	if(!fexists(full_path)) return 0

	listclearnulls(GLOB.business_ids)

	S << GLOB.business_ids


	return 1

/proc/load_bizlist()
	var/full_path = "data/persistent/businesslist.sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0

	S >> GLOB.business_ids

	if(!GLOB.business_ids)
		GLOB.business_ids = list()

	listclearnulls(GLOB.business_ids)

	return 1

/datum/business/proc/save_business()
	var/full_path = "[path][business_uid].sav"
	if(!full_path)			return 0

	var/savefile/S = new /savefile(full_path)
	if(!fexists(full_path)) return 0


	if(!S)					return 0
	S.cd = "/"

	sanitize_business()

	S["name"] 				<<		name
	S["description"] 			<<		description
	S["categories"] 			<< 		categories
	S["creation_date"] 			<< 		creation_date
	S["business_uid"] 			<<		business_uid
	S["suspended"] 			<<		suspended
	S["suspended_reason"] 		<<		suspended_reason
	S["blacklisted_employees"] 	<<		blacklisted_employees
	S["blacklisted_ckeys"] 		<<		blacklisted_ckeys
	S["owner"] 				<<		owner
	S["access_password"] 		<<		access_password
	S["department"] 			<<		department
	S["business_jobs"] 			<<		business_jobs
	S["business_accesses"] 		<<		business_accesses

	return 1

/datum/business/proc/load_business()
	var/full_path = "[path][business_uid].sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	S["name"] 				>>		name
	S["description"] 			>>		description
	S["categories"] 			>> 		categories
	S["creation_date"] 			>> 		creation_date
	S["business_uid"] 			>>		business_uid
	S["suspended"] 			>>		suspended
	S["suspended_reason"] 		>>		suspended_reason
	S["blacklisted_employees"] 	>>		blacklisted_employees
	S["blacklisted_ckeys"] 		>>		blacklisted_ckeys
	S["owner"] 				>>		owner
	S["access_password"] 		>>		access_password
	S["department"] 			>>		department
	S["business_jobs"] 			>>		business_jobs
	S["business_accesses"] 		>>		business_accesses

	sanitize_business(business_uid)

	return 1