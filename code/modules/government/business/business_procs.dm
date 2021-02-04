
/proc/create_new_business(var/name, var/description, var/pass, var/category, var/owner_uid, var/owner_name, var/owner_email, var/owner_bank) // Makes a new business

	var/datum/business/B = new /datum/business(name, description, pass, category, owner_uid, owner_name, owner_email)
	var/datum/business_person/n_owner = new()

	B.owner = n_owner
	n_owner.unique_id = owner_uid
	n_owner.name = owner_name
	n_owner.email = owner_email
	n_owner.bank_id = owner_bank

	if(owner_email)
		var/datum/computer_file/data/email_account/council_email = get_email(using_map.council_email)
		var/datum/computer_file/data/email_message/message = new/datum/computer_file/data/email_message()
		var/eml_cnt = "Dear [B.owner.name], \[br\]"
		eml_cnt += "Thank you for registering your new business. \n \
		Business Name: [B.name] \[br\] \
		Business ID: [B.business_uid] \[br\] \
		Access Password: [B.access_password] \[br\] \[br\] \
		 \
		Contact City Council for any issues you may have. Alternatively, visit city hall."

		message.stored_data = eml_cnt
		message.title = "Business Registration: [B.name] - City Council"
		message.source = "noreply@nanotrasen.gov.nt"

		council_email.send_mail(owner_email, message)


	return B

/datum/business/proc/rename_business(new_name)
	name = new_name

	var/datum/department/dept = get_department()

	for(var/datum/access/B in business_accesses)
		B.department_tag = name

	if(dept)
		dept.name = new_name
		if(dept.bank_account)
			dept.bank_account.owner_name = new_name


/datum/business/proc/change_description(new_desc)
	description = new_desc

	var/datum/department/dept = get_department()

	if(dept)
		dept.desc = new_desc


/datum/business/proc/get_jobs()
	var/datum/department/dept = get_department()

	if(!dept)
		return FALSE

	return dept.get_all_jobs()


/datum/business/proc/refresh_business_support_list()
	for(var/datum/job/job in business_jobs)
		SSjobs.occupations |= job

	for(var/datum/access/access in business_accesses)
		GLOB.all_business_accesses |= access


/datum/business/proc/create_new_job(job_name)
	var/datum/job/job = new()

	//jobs started with a business start deactivated. Owner has to activate them.
	job.enabled = FALSE
	job.title = job_name
	job.department = department
	job.department_flag = CIVILIAN
	job.faction = "City"
	job.business = business_uid
	job.outfit_type = /decl/hierarchy/outfit/job/business/casual
	if(owner)
		job.supervisors = "[owner.name]"

	job.total_positions = 3
	business_jobs += job
	refresh_business_support_list()

/datum/business/proc/create_new_access(access_name)
	var/datum/access/access = new()

	access.desc = access_name
	access.id = "[business_uid][rand(1,999)][pick("A","B","C","X","Z")]"
	access.access_type = ACCESS_TYPE_BUSINESS
	access.department_tag = name

	for(var/datum/access/B in business_accesses)
		if(B.id == access.id)
			access.id = "[access.id][rand(39,100)][game_id]"

	business_accesses += access
	refresh_business_support_list()
