/datum/job/chief_engineer
	title = "Maintenance Director"
	flag = CHIEF
	faction = "City"
	head_position = 1
	department_flag = ENGSEC
	department = DEPT_COUNCIL
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Mayor"
	subordinates = "the maintenance department"
	selection_color = "#7F6E2C"
	idtype = /obj/item/weapon/card/id/engineering/head
	req_admin_notify = 1

	wage = 350
	allows_synths = FALSE


	minimum_character_age = 25
	ideal_character_age = 50


	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_janitor, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload, access_medical, access_medical_equip)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
			            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
			            access_heads, access_construction, access_sec_doors,
			            access_ce, access_janitor, access_RC_announce, access_keycard_auth, access_tcomsat, access_ai_upload, access_medical, access_medical_equip)
	alt_titles = list("Public Works Director", "Chief Engineer")
	minimal_player_age = 7

	outfit_type = /decl/hierarchy/outfit/job/engineering/chief_engineer
	clean_record_required = TRUE

/datum/job/chief_engineer/get_job_email()	// whatever this is set to will be the job's communal email. should be persistent.
	return using_map.council_email
/*
/datum/job/engineer
	title = "Firefighter"
	email_domain = "fire.cityworks.gov.nt"
	flag = ENGINEER
	department_flag = ENGSEC
	faction = "City"
	department = "Emergency and Maintenance"
	total_positions = 5
	spawn_positions = 5
	supervisors = "the fire chief"
	selection_color = "#5B4D20"
	idtype = /obj/item/weapon/card/id/engineering/engineer
	wage = 60
	access = list(access_engine, access_engine_equip, access_tech_storage, access_construction, access_atmospherics, access_external_airlocks, access_medical, access_medical_equip, access_morgue, access_eva, access_maint_tunnels, access_external_airlocks)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_construction, access_atmospherics, access_external_airlocks, access_medical, access_medical_equip, access_morgue, access_eva, access_maint_tunnels, access_external_airlocks)
	alt_titles = list("Firefighter/EMT")
	minimum_character_age = 18
	minimal_player_age = 3
	outfit_type = /decl/hierarchy/outfit/job/engineering/engineer
*/
/datum/job/atmos
	title = "Maintenance Worker"

	flag = ATMOSTECH
	department_flag = ENGSEC
	faction = "City"

	department = DEPT_MAINTENANCE
	total_positions = 3
	spawn_positions = 2
	supervisors = "the maintenance director"
	selection_color = "#5B4D20"
	idtype = /obj/item/weapon/card/id/engineering/atmos
	wage = 50
	synth_wage = 25

	access = list(access_engine, access_engine_equip, access_janitor, access_tech_storage, access_construction, access_atmospherics, access_external_airlocks, access_eva, access_maint_tunnels, access_external_airlocks)
	minimal_access = list(access_engine, access_engine_equip, access_janitor, access_tech_storage, access_construction, access_atmospherics, access_external_airlocks, access_medical, access_medical_equip, access_morgue, access_eva, access_maint_tunnels, access_external_airlocks)

	minimal_player_age = 3
	minimum_character_age = 18

	outfit_type = /decl/hierarchy/outfit/job/engineering/atmos
	alt_titles = list("Civil Engineer", "Public Works Staff", "Electrician")

// Popping Paramedic In right here.

/datum/job/janitor
	title = "Sanitation Technician"
	flag = JANITOR
	faction = "City"
	department_flag = CIVILIAN
	department = DEPT_MAINTENANCE
	total_positions = 2
	spawn_positions = 2
	supervisors = "the maintenance director"
	selection_color = "#515151"

	idtype = /obj/item/weapon/card/id/civilian/janitor
	access = list(access_engine, access_engine_equip, access_external_airlocks, access_janitor, access_maint_tunnels)
	minimal_access = list(access_janitor, access_maint_tunnels)
	minimum_character_age = 16 //Not making it any younger because being a janitor requires a lot of labor, or maybe it just means I'm very lazy? Oh well
	wage = 40
	synth_wage = 25

	outfit_type = /decl/hierarchy/outfit/job/service/janitor
	alt_titles = list("Recycling Technician", "Sanitation Engineer")
