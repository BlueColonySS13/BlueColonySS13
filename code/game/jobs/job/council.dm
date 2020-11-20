var/datum/announcement/minor/captain_announcement = new(do_newscast = 1)

/datum/job/captain
	title = "Mayor"
	flag = CAPTAIN
	department = DEPT_COUNCIL
	head_position = 1
	department_flag = ENGSEC
	faction = "City"
	total_positions = 1
	spawn_positions = 1

	supervisors = "government officials and the president"
	subordinates = "the City Council"
	selection_color = "#1D1D4F"
	idtype = /obj/item/weapon/card/id/gold
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14
	wage = 500

	allows_synths = FALSE

	minimum_character_age = 30
	ideal_character_age = 50

	outfit_type = /decl/hierarchy/outfit/job/heads/captain

	clean_record_required = TRUE

	description = "Mayors are expected to keep the city council in line - you don't really get to call all the shots, but you can call most of them. \
	Usually if you're a good mayor you'll let council members do their jobs and only step in when needed. \
	Alternatively, you can just disable carp control and thin the herd."

	duties = list("Fire council members for incompetence", "Smoke cigars", "Get arrested for corruption")


/datum/job/captain/get_job_email()	// whatever this is set to will be the job's communal email. should be persistent.
	return using_map.council_email


//	alt_titles = list("Site Manager", "Overseer")

/*
/datum/job/heads/captain/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(src)
*/
/datum/job/captain/get_access()
	return get_all_station_access()

/datum/job/hop
	title = "City Clerk"
	flag = HOP
	department = DEPT_COUNCIL
	head_position = 1
	department_flag = CIVILIAN
	faction = "City"
	total_positions = 1
	spawn_positions = 1

	supervisors = "the Mayor"
	subordinates = "the city hall staff"

	selection_color = "#1D1D4F"
	idtype = /obj/item/weapon/card/id/silver/hop
	req_admin_notify = 1
	minimal_player_age = 10
	wage = 350

	allows_synths = FALSE

	minimum_character_age = 26
	alt_titles = list("City Manager")
	ideal_character_age = 40

	outfit_type = /decl/hierarchy/outfit/job/heads/hop

	access = list(access_security, access_bodyguard, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway)
	minimal_access = list(access_security, access_bodyguard, access_sec_doors, access_brig, access_forensics_lockers,
			            access_medical, access_engine, access_change_ids, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue,
			            access_crematorium, access_kitchen, access_cargo, access_cargo_bot, access_mailsorting, access_qm, access_hydroponics, access_lawyer,
			            access_chapel_office, access_library, access_research, access_mining, access_heads_vault, access_mining_station,
			            access_hop, access_RC_announce, access_keycard_auth, access_gateway)

	clean_record_required = TRUE

/datum/job/hop/get_job_email()	// whatever this is set to will be the job's communal email. should be persistent.
	return using_map.council_email


/datum/job/secretary //Paperwork monkey
	title = "City Hall Secretary"
	flag = SECRETARY
	department = DEPT_PUBLIC
	department_flag = CIVILIAN
	faction = "City"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the City Clerk"
	selection_color = "#515151"
	idtype = /obj/item/weapon/card/id/civilian/secretary
	wage = 100
	synth_wage = 50

	access = list(access_heads, access_hop, access_maint_tunnels, access_legal)
	minimal_access = list(access_heads, access_hop, access_maint_tunnels, access_legal)

	minimum_character_age = 20

	alt_titles = list("Assistant Clerk")

	outfit_type = /decl/hierarchy/outfit/job/civilian/secretary

	clean_record_required = TRUE



/datum/job/bguard
	title = "City Hall Guard"

	flag = BRIDGE
	department = DEPT_PUBLIC
	department_flag = ENGSEC
	faction = "City"
	total_positions = 2
	spawn_positions = 3
	supervisors = "the City Clerk"
	selection_color = "#601C1C"
	idtype = /obj/item/weapon/card/id/silver/secretary
	minimal_player_age = 5
	wage = 100
	synth_wage = 60

	minimum_character_age = 21
	access = list(access_heads, access_bodyguard, access_keycard_auth, access_security, access_legal)
	minimal_access = list(access_heads, access_bodyguard, access_keycard_auth, access_security, access_legal)

	outfit_type = /decl/hierarchy/outfit/job/heads/secretary
	alt_titles = list("Council Bodyguard", "City Hall Security", "Bailiff")

	clean_record_required = TRUE
