var/global/list/business_outfits = list(
	"Formal" = list("path" = /decl/hierarchy/outfit/job/business/formal),
	"Bartender" = list("path" = /decl/hierarchy/outfit/job/business/bartender),
	"Chef" = list("path" = /decl/hierarchy/outfit/job/business/chef),
	"Gardener" = list("path" = /decl/hierarchy/outfit/job/business/gardener),
	"Janitor" = list("path" = /decl/hierarchy/outfit/job/business/janitor),
	"Journalist" = list("path" = /decl/hierarchy/outfit/job/business/journalist),
	"Chaplain" = list("path" = /decl/hierarchy/outfit/job/business/priest),
	"Explorer" = list("path" = /decl/hierarchy/outfit/job/business/explorer),
	"Barber" = list("path" = /decl/hierarchy/outfit/job/business/barber),
	"Mailman" = list("path" = /decl/hierarchy/outfit/job/business/mailman),
	"Doctor" = list("path" = /decl/hierarchy/outfit/job/business/doctor),
	"Nurse" = list("path" = /decl/hierarchy/outfit/job/business/nurse),
	"Scientist" = list("path" = /decl/hierarchy/outfit/job/business/scientist),
	"Engineer" = list("path" = /decl/hierarchy/outfit/job/business/engineer),
	"Business Casual" = list("path" = /decl/hierarchy/outfit/job/business/casual),
	"High End Waiter (Red)" = list("path" = /decl/hierarchy/outfit/job/business/bartender/waiter/red),
	"High End Waiter (Grey)" = list("path" = /decl/hierarchy/outfit/job/business/bartender/waiter/grey),
	"High End Waiter (Brown)" = list("path" = /decl/hierarchy/outfit/job/business/bartender/waiter/brown),
	"Clown" = list("path" = /decl/hierarchy/outfit/job/business/clown),
	"Mime" = list("path" = /decl/hierarchy/outfit/job/business/mime)


)

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



/datum/business/proc/get_funds()
	var/datum/money_account/business_account = dept_acc_by_id(department)

	if(!business_account)
		return 0

	return business_account.money



/datum/business/proc/get_bank()
	var/datum/money_account/business_account = dept_acc_by_id(department)
	return business_account


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

/datum/business/proc/get_owner_uid()
	if(!owner)
		return
	return owner.unique_id

/datum/business/proc/get_status()
	if(suspended)
		return BUSINESS_SUSPENDED

	return BUSINESS_ACTIVE

/datum/business/proc/get_department()
	return dept_by_id(department)

/datum/business/proc/get_department_id()
	var/datum/department/D = get_department()
	if(D)
		return D.id

/proc/businesses_by_category(cat)
	var/list/biz = list()
	for(var/datum/business/B in GLOB.all_businesses)
		if(cat in B.categories)
			biz += B

	return biz

/proc/get_biz_access_by_id(id)
	for(var/datum/access/A in GLOB.all_business_accesses)
		if(A.id == id)
			return A

/proc/get_biz_access_name_id(id)
	for(var/datum/access/A in GLOB.all_business_accesses)
		if(A.id == id)
			return "[A.desc]"

/datum/business/proc/is_department_employee(uid, mob/living/carbon/human/H)
	for(var/datum/job/J in get_jobs())
		if(uid in J.exclusive_employees)
			return TRUE

	if(H)
		var/datum/data/record/record
		for(var/datum/data/record/R in data_core.general)
			if(H.unique_id == R.fields["unique_id"])
				record = R
		if(record)
			var/datum/job/J = SSjobs.GetJob(record.fields["real_rank"])
			if(J && (J in business_jobs))
				return TRUE

	return FALSE

