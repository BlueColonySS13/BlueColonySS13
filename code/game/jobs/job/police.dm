/datum/job/hos
	title = "Chief of Police"

	flag = HOS
	faction = "City"
	department = DEPT_COUNCIL
	department_flag = ENGSEC
	head_position = 1
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Mayor"
	subordinates = "the police department"
	selection_color = "#8E2929"
	idtype = /obj/item/weapon/card/id/security/head
	req_admin_notify = 1
	wage = 400
	access = list(access_security, access_medical, access_warrant, access_bodyguard, access_eva, access_sec_doors, access_brig, access_armory,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	minimal_access = list(access_security, access_warrant, access_eva, access_sec_doors, access_brig, access_armory,
			            access_forensics_lockers, access_morgue, access_maint_tunnels, access_all_personal_lockers,
			            access_heads, access_hos, access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	minimum_character_age = 30
	minimal_player_age = 14


	outfit_type = /decl/hierarchy/outfit/job/security/hos
	alt_titles = list("Head of Police", "Police Commander", "Police Commissioner", "Police Chief")

	clean_record_required = TRUE
	allows_synths = FALSE

	description = "Your job is to ensure the police unit runs correctly, you should make sure that police officers are enforcing the law correctly and \
	not breaking SOP. You authorize warrants and make sure that the police departments runs like a well-oiled cog."

	duties = list("Keep the police officers in line", "Communicate with the warden", "Try not to get caught drinking")

/datum/job/hos/get_job_email()
	return using_map.police_email

/datum/job/warden
	title = "Prison Warden"

	flag = WARDEN
	faction = "City"
	department = DEPT_POLICE
	department_flag = ENGSEC
	total_positions = 1
	spawn_positions = 1
	supervisors = "the chief of police"
	selection_color = "#601C1C"
	idtype = /obj/item/weapon/card/id/security/warden
	wage = 175
	access = list(access_security, access_bodyguard, access_warrant, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_warrant, access_eva, access_sec_doors, access_brig, access_armory, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 5
	minimum_character_age = 28

	outfit_type = /decl/hierarchy/outfit/job/security/warden
	alt_titles = list("Correctional Officer", "Brig Attendant", "Police Sergeant")

	clean_record_required = TRUE
	allows_synths = FALSE


	description = "Your job? Look after the criminals of this society. Keep an eye on them and try not to leave the prison area unless you really, really need \
	to. Your responsibility to also maintain the prison and make sure no one is breaking in or out, You make sure prisoners are fed, get their visitation met, \
	and aren't being abused by police while in your custody. (Or not.)"

	duties = list("Stop prisoners from breaking out", "Fall asleep", "Chase after escaped prisoners")

/datum/job/warden/get_job_email()
	return using_map.police_email

/datum/job/detective
	title = "Detective"

	flag = DETECTIVE
	faction = "City"
	department = DEPT_POLICE
	department_flag = ENGSEC
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief of police"
	selection_color = "#601C1C"
	idtype = /obj/item/weapon/card/id/security/detective
	access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers, access_medical, access_morgue, access_maint_tunnels, access_eva, access_external_airlocks)
	minimal_access = list(access_security, access_sec_doors, access_brig, access_forensics_lockers, access_medical, access_morgue, access_maint_tunnels, access_eva, access_external_airlocks)
	wage = 150
	synth_wage = 80

	minimal_player_age = 3
	minimum_character_age = 25

	outfit_type = /decl/hierarchy/outfit/job/security/detective
	alt_titles = list("Forensic Technician" = /decl/hierarchy/outfit/job/security/detective/forensic, "Investigator")

	clean_record_required = TRUE

	description = "Theoretically, you're somewhat smarter than the average cop considering your forensics degree, \
	but in reality that's rarely the case. The job is simple enough, just wait for any crime that needs some physical evidence, \
	investigate the evidence and scene and compile it for the courts, even if it takes multiple shifts to get it done. \
	You also have a gun meant for self-defence, what a meme."

	duties = list("Investigate crimes", "Don't get your own prints and fibers on the evidence", "Drink whiskey", "Compile reports", "Blotch the entire thing anyway")


/datum/job/detective/get_job_email()
	return using_map.police_email

/datum/job/officer
	title = "Police Officer"

	flag = OFFICER
	faction = "City"
	department = DEPT_POLICE
	department_flag = ENGSEC
	total_positions = 8
	spawn_positions = 8
	supervisors = "the chief of police"
	selection_color = "#601C1C"
	idtype = /obj/item/weapon/card/id/security/officer
	wage = 125
	synth_wage = 60

	access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 3
	minimum_character_age = 23

	outfit_type = /decl/hierarchy/outfit/job/security/officer
	alt_titles = list("Police Cadet" = /decl/hierarchy/outfit/job/security/cadet,"Traffic Officer" = /decl/hierarchy/outfit/job/security/traffic)

	clean_record_required = TRUE

	description = "Welcome to hell. Between the actual criminals and the criminally insane, \
	this is the first day on your trip downhill into a meltdown, so have fun! \
	Your duties are simple, just read Pollux Law, and any relevant procedures and regulations, \
	and enforce them within reason, or don't."

	duties = list("Arrest criminals", "Beg higher-ups for warrants", "Cry over arrest reports", "Empty the donut box", "Survive")


/datum/job/officer/get_job_email()
	return using_map.police_email

