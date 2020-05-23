var/global/list/business_outfits = list(
	"Formal" = list("path" = /decl/hierarchy/outfit/job/assistant/formal),
	"Bartender" = list("path" = /decl/hierarchy/outfit/job/service/bartender),
	"Waiter" = list("path" = /decl/hierarchy/outfit/job/service/bartender/waiter),
	"Chef" = list("path" = /decl/hierarchy/outfit/job/service/chef),
	"Cook" = list("path" = /decl/hierarchy/outfit/job/service/chef/cook),
	"Gardener" = list("path" = /decl/hierarchy/outfit/job/service/gardener),
	"Janitor" = list("path" = /decl/hierarchy/outfit/job/service/janitor),
	"Journalist" = list("path" = /decl/hierarchy/outfit/job/civilian/journalist),
	"Chaplain" = list("path" = /decl/hierarchy/outfit/job/civilian/chaplain),
	"Explorer" = list("path" = /decl/hierarchy/outfit/job/explorer),
	"Barber" = list("path" = /decl/hierarchy/outfit/job/civilian/barber),
	"Secretary" = list("path" = /decl/hierarchy/outfit/job/civilian/secretary),
	"Mailman" = list("path" = /decl/hierarchy/outfit/job/assistant/mailman)

)
/*
var/global/list/business_outfits = list(
	/decl/hierarchy/outfit/job/assistant/formal = "Formal",
	/decl/hierarchy/outfit/job/service/bartender = "Bartender",
	/decl/hierarchy/outfit/job/service/bartender/waiter = "Waiter",
	/decl/hierarchy/outfit/job/service/chef = "Chef",
	/decl/hierarchy/outfit/job/service/chef/cook = "Cook",
	/decl/hierarchy/outfit/job/service/gardener = "Gardener",
	/decl/hierarchy/outfit/job/service/janitor = "Janitor",
	/decl/hierarchy/outfit/job/civilian/journalist = "Journalist",
	/decl/hierarchy/outfit/job/civilian/chaplain = "Chaplain",
	/decl/hierarchy/outfit/job/explorer = "Explorer",
	/decl/hierarchy/outfit/job/civilian/barber = "Barber",
	/decl/hierarchy/outfit/job/civilian/secretary = "Secretary",
	/decl/hierarchy/outfit/job/assistant/mailman = "Mailman",

)
*/

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

/proc/get_biz_access_by_id(id)
	for(var/datum/access/A in GLOB.all_business_accesses)
		if(A.id == id)
			return A

/proc/get_biz_access_name_id(id)
	for(var/datum/access/A in GLOB.all_business_accesses)
		if(A.id == id)
			return "[A.department_tag ? "[A.department_tag] - " : ""] - [A.desc]"
