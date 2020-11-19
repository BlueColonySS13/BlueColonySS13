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
	wage = 500
	allows_synths = FALSE

	access = list(access_judge, access_warrant, access_sec_doors, access_maint_tunnels, access_heads, access_legal)
	minimal_access = list(access_judge, access_warrant, access_sec_doors, access_heads, access_legal)
	minimal_player_age = 14
	minimum_character_age = 34
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
	wage = 270
	allows_synths = FALSE

	access = list(access_prosecutor, access_sec_doors, access_maint_tunnels, access_heads, access_legal, access_warrant)
	minimal_access = list(access_prosecutor, access_sec_doors, access_heads, access_legal, access_warrant)
	minimal_player_age = 14
	minimum_character_age = 28

	alt_titles = list("Prosecutor","Prosecuting Attorney","Prosecution Officer","Prosecuting Lawyer")

	outfit_type = /decl/hierarchy/outfit/job/prosecution

	clean_record_required = TRUE

/datum/job/prosecutor/get_job_email()
	return using_map.court_email
