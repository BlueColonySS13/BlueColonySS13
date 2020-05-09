/datum/business
	var/name = "Unnamed Business"
	var/description = "Generic description."

	var/categories = list()	// max 3 categories per business

	var/creation_date

	var/business_uid
	var/suspended = FALSE

	var/gets_business_tax = TRUE                // no one is safe.

	var/primary_color = "#000000"
	var/secondary_color = "#ffffff"

	var/list/blacklisted_employees = list()     // by unique id
	var/list/blacklisted_ckeys = list()		// uses ckeys

	var/datum/business_person/owner

	var/access_password = " "

	var/datum/department/department

	var/list/business_jobs = list()
	var/list/business_accesses = list()


//////////////////////////

/datum/business/New(title, var/desc, var/pass, var/cat, var/owner_uid, var/owner_name, var/owner_email) // Makes a new business
	name = title
	description = desc
	access_password = pass
	categories += cat

	sanitize_business()

	..()

/datum/business/proc/sanitize_business()
	if(!name)
		name = initial(name)
	if(!business_uid)
		business_uid = "[game_id]-[rand(1111,9999)][pick("A","B","C")]"
	if(!creation_date)
		creation_date = full_game_time()
	if(!access_password)
		access_password = GenerateKey()
	if(!department)
		department = new()
		department.name = name


/proc/create_new_business(var/name, var/description, var/pass, var/category, var/owner_uid, var/owner_name, var/owner_email) // Makes a new business

	var/datum/business/B = new()
	B.name = name
	B.description = description
	B.creation_date = get_game_time()
	B.access_password = pass

	var/datum/business_person/n_owner = new()

	B.owner = n_owner
	n_owner.unique_id = owner_uid
	n_owner.name = owner_name
	n_owner.email = owner_email



	return B

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
