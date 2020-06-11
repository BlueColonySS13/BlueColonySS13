/datum/controller/subsystem/economy/proc/save_business_departments()
	var/path = "data/persistent/departments/business_departments.sav"

	var/savefile/S = new /savefile(path)
	if(!fexists(path))
		return 0
	if(!S)
		return 0
	S.cd = "/"

	for(var/datum/department/D in GLOB.business_departments)
		D.sanitize_values()

	S << GLOB.business_departments

	return 1

/datum/controller/subsystem/economy/proc/load_business_departments()
	var/path = "data/persistent/departments/business_departments.sav"

	var/savefile/S = new /savefile(path)
	if(!fexists(path))
		save_economy()
		return 0
	if(!S)
		return 0
	S.cd = "/"

	S >> GLOB.business_departments

	if(!S || !GLOB.business_departments)
		GLOB.business_departments = list()
		return

	for(var/datum/department/D in GLOB.business_departments)
		D.sanitize_values()

	return 1

/datum/controller/subsystem/economy/proc/save_economy()
	prepare_economy_save()

	if(isemptylist(GLOB.departments))
		message_admins("Economy Subsystem error: No department accounts found. Unable to save.", 1)
		return FALSE

	// save each department to a save file.
	for(var/datum/department/D in GLOB.departments)

		if(!D.name || !D.id || !D.bank_account)
			continue

		if(D.dept_type == BUSINESS_DEPARTMENT)
			continue

		D.sanitize_values()

		var/sav_folder = "public_departments"

		if(D.dept_type == PUBLIC_DEPARTMENT)
			sav_folder = "public_departments"
		if(D.dept_type == PRIVATE_DEPARTMENT)
			sav_folder = "private_departments"
		if(D.dept_type == EXTERNAL_DEPARTMENT)
			sav_folder = "external_departments"
		if(D.dept_type == HIDDEN_DEPARTMENT)
			sav_folder = "hidden_departments"

		var/path = "data/persistent/departments/[sav_folder]/[D.id].sav"

		var/savefile/S = new /savefile(path)
		if(!fexists(path))
			return 0
		if(!S)
			return 0
		S.cd = "/"

		if(D.has_bank && D.bank_account)
			D.bank_account.sanitize_values()

			S["money"] << D.bank_account.money
			S["account_number"] << D.bank_account.account_number
			S["remote_access_pin"] << D.bank_account.remote_access_pin
			S["transaction_log"] << D.bank_account.transaction_log

	save_business_departments()	// saved separately, for reasons

	return TRUE


/datum/controller/subsystem/economy/proc/load_economy()
	if(isemptylist(GLOB.departments))
		message_admins("Economy Subsystem error: No department accounts found. Unable to load.", 1)
		return FALSE

	// save each department to a save file.
	for(var/datum/department/D in GLOB.departments)


		if(!D.name || !D.id || !D.bank_account)
			continue

		var/sav_folder = "public_departments"

		if(D.dept_type == PUBLIC_DEPARTMENT)
			sav_folder = "public_departments"
		if(D.dept_type == PRIVATE_DEPARTMENT)
			sav_folder = "private_departments"
		if(D.dept_type == EXTERNAL_DEPARTMENT)
			sav_folder = "external_departments"
		if(D.dept_type == HIDDEN_DEPARTMENT)
			sav_folder = "hidden_departments"


		var/path = "data/persistent/departments/[sav_folder]/[D.id].sav"

		var/savefile/S = new /savefile(path)
		if(!fexists(path))
			var/new_path = "data/persistent/departments/[sav_folder]/[D.name].sav" //legacy loading
			if(!fexists(new_path))
				return 0
		if(!S)
			return 0
		S.cd = "/"

		if(D.has_bank && D.bank_account)
			S["money"] >> D.bank_account.money
			S["account_number"] >> D.bank_account.account_number
			S["remote_access_pin"] >> D.bank_account.remote_access_pin
			S["transaction_log"] >> D.bank_account.transaction_log


		D.sanitize_values()

	return TRUE


