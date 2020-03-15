/datum/job/judge
	title = "Judge"
	flag = JUDGE
	head_position = 1
	faction = "City"
	department = DEPT_LEGAL
	total_positions = 2
	spawn_positions = 2
	department_flag = CIVILIAN
	req_admin_notify = 1
	supervisors = "government officials and the president"
	selection_color = "#1D1D4F"
	idtype = /obj/item/weapon/card/id/heads/judge
	wage = 350
	access = list(access_judge, access_warrant, access_sec_doors, access_maint_tunnels, access_heads, access_legal)
	minimal_access = list(access_judge, access_warrant, access_sec_doors, access_heads, access_legal)
	minimal_player_age = 14
	minimum_character_age = 25
	alt_titles = list("Magistrate")

	outfit_type = /decl/hierarchy/outfit/job/heads/judge


	clean_record_required = TRUE

/datum/job/judge/get_job_email()	// whatever this is set to will be the job's communal email. should be persistent.
	return using_map.court_email


/datum/job/prosecutor
	title = "District Prosecutor"
	flag = PROSECUTOR
	faction = "City"
	department = DEPT_LEGAL
	department_flag = ENGSEC
	total_positions = 2
	spawn_positions = 2
	req_admin_notify = 1
	supervisors = "the judge"
	selection_color = "#601C1C"
	idtype = /obj/item/weapon/card/id/security/prosecutor
	wage = 100
	access = list(access_prosecutor, access_sec_doors, access_maint_tunnels, access_heads, access_legal, access_warrant)
	minimal_access = list(access_prosecutor, access_sec_doors, access_heads, access_legal, access_warrant)
	minimal_player_age = 14
	minimum_character_age = 28

	alt_titles = list("Prosecutor","Prosecuting Attorney","Prosecution Officer","Prosecuting Lawyer")

	outfit_type = /decl/hierarchy/outfit/job/prosecution

	clean_record_required = TRUE

/datum/job/prosecutor/get_job_email()
	return using_map.court_email

/datum/job/nanotrasen/highjustice
	title = "High Justice"
	flag = HIGHJUSTICE
	head_position = 1
	department_flag = GOVLAW
	department = DEPT_LEGAL
	faction = "City"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Supreme Justice"
	selection_color = "#1D1D4F"
	idtype = /obj/item/weapon/card/id/nanotrasen/highjustice
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14
	wage = 7000
	alt_titles = list()

	minimum_character_age = 30
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/heads/president


/datum/job/nanotrasen/highjustice/get_job_email()
	return using_map.court_email


/datum/job/nanotrasen/supremejustice
	title = "Supreme Justice"
	flag = SUPREMEJUSTICE
	head_position = 1
	department_flag = GOVLAW
	department = DEPT_LEGAL
	faction = "City"
	total_positions = 1
	spawn_positions = 1
	supervisors = "NanoTrasen"
	selection_color = "#1D1D4F"
	idtype = /obj/item/weapon/card/id/nanotrasen/supremejustice
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14
	wage = 8900
	alt_titles = list()

	minimum_character_age = 40
	ideal_character_age = 60
	outfit_type = /decl/hierarchy/outfit/job/heads/president

/datum/job/nanotrasen/highjustice/get_job_email()
	return using_map.court_email
