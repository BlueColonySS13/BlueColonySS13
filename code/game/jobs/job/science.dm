/datum/job/rd
	title = "Research Director"

	flag = RD
	faction = "City"
	department = DEPT_COUNCIL
	department_flag = MEDSCI
	head_position = 1
	total_positions = 1
	spawn_positions = 1
	supervisors = "the mayor"
	subordinates = "the research department"
	selection_color = "#AD6BAD"
	idtype = /obj/item/weapon/card/id/science/head
	req_admin_notify = 1
	wage = 340
	access = list(access_rd, access_heads, access_tox, access_morgue,
			            access_tox_storage, access_teleporter, access_sec_doors,
			            access_research, access_robotics, access_xenobiology, access_ai_upload, access_tech_storage,
			            access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_xenoarch, access_network)
	minimal_access = list(access_rd, access_heads, access_tox, access_morgue,
			            access_tox_storage, access_teleporter, access_sec_doors,
			            access_research, access_robotics, access_xenobiology, access_ai_upload, access_tech_storage,
			            access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_xenoarch, access_network)

	minimum_character_age = 30
	minimal_player_age = 10
	ideal_character_age = 50

	outfit_type = /decl/hierarchy/outfit/job/science/rd
	alt_titles = list("Research Supervisor")

	description = "As the Research Director, your job is to make sure that your staff don't destroy the city on accident or on purpose. \
	Your goal is to keep science productive and profitable as this is a great source of revenue for the city."

	duties = list("Stop that odd guy from making bombs",
	"Make sure the roboticist doesn't build a death mech and go play homebrew titanfall",
	"Make sure the anomaly lab doesn't release aliens, robots, alien robots, interdimensional horrors, or anything else",
	"Make sure the R&D staff don't sell contraband to people",
	"Secure important artifacts and specimens")

/datum/job/rd/get_job_email()	// whatever this is set to will be the job's communal email. should be persistent.
	return using_map.council_email

/datum/job/scientist
	title = "Scientist"

	flag = SCIENTIST
	faction = "City"
	department = DEPT_RESEARCH
	department_flag = MEDSCI
	total_positions = 5
	spawn_positions = 3
	supervisors = "the research director"
	selection_color = "#633D63"
	idtype = /obj/item/weapon/card/id/science/scientist
	wage = 90
	access = list(access_robotics, access_tox, access_tox_storage, access_research, access_xenobiology, access_xenoarch)
	minimal_access = list(access_tox, access_tox_storage, access_research, access_xenoarch)
	minimum_character_age = 20
	minimal_player_age = 3

	outfit_type = /decl/hierarchy/outfit/job/science/scientist
	alt_titles = list("Xenoarchaeologist" = /decl/hierarchy/outfit/job/science/xenoarchaeologist, "Anomalist", "Phoron Researcher")

/datum/job/xenobiologist
	title = "Xenobiologist"

	flag = XENOBIOLOGIST
	faction = "City"
	department = DEPT_RESEARCH
	department_flag = MEDSCI
	total_positions = 3
	spawn_positions = 2
	supervisors = "the research director"
	selection_color = "#633D63"
	idtype = /obj/item/weapon/card/id/science/xenobiologist
	wage = 90
	access = list(access_robotics, access_tox, access_tox_storage, access_research, access_xenobiology, access_hydroponics)
	minimal_access = list(access_research, access_xenobiology, access_hydroponics, access_tox_storage)
	minimum_character_age = 20
	minimal_player_age = 3

	outfit_type = /decl/hierarchy/outfit/job/science/xenobiologist
	alt_titles = list("Xenobotanist")

/datum/job/roboticist
	title = "Roboticist"

	flag = ROBOTICIST
	faction = "City"
	department = DEPT_RESEARCH
	department_flag = MEDSCI
	total_positions = 2
	spawn_positions = 2
	supervisors = "research director"
	selection_color = "#633D63"
	idtype = /obj/item/weapon/card/id/science/roboticist
	wage = 90
	access = list(access_robotics, access_tox, access_tox_storage, access_tech_storage, access_morgue, access_research) //As a job that handles so many corpses, it makes sense for them to have morgue access.
	minimal_access = list(access_robotics, access_tech_storage, access_morgue, access_research) //As a job that handles so many corpses, it makes sense for them to have morgue access.
	minimum_character_age = 20
	minimal_player_age = 3

	outfit_type = /decl/hierarchy/outfit/job/science/roboticist
	alt_titles = list("Biomechanical Engineer","Mechatronic Engineer","Car Engineer")

/datum/job/scienceintern
	title = "Research Assistant"

	flag = SCIENCEINTERN
	faction = "City"
	department = DEPT_RESEARCH
	department_flag = MEDSCI
	total_positions = 5
	spawn_positions = 3
	supervisors = "the research director"
	selection_color = "#633D63"
	idtype = /obj/item/weapon/card/id/science/intern
	wage = 20
	access = list(access_research, access_maint_tunnels)
	minimal_access = list(access_research, access_maint_tunnels)
	minimum_character_age = 16
	minimal_player_age = 0

	outfit_type = /decl/hierarchy/outfit/job/science/intern

/datum/job/rguard
	title = "Research Security"

	flag = SCIGUARD
	department = DEPT_RESEARCH
	department_flag = MEDSCI
	faction = "City"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the research director and other research staff"
	selection_color = "#601C1C"
	idtype = /obj/item/weapon/card/id/science/rguard
	minimal_player_age = 5
	wage = 60
	minimum_character_age = 25
	access = list(access_robotics, access_tox, access_tox_storage, access_research, access_xenobiology, access_xenoarch)
	minimal_access = list(access_tox, access_tox_storage, access_research, access_xenoarch)

	outfit_type = /decl/hierarchy/outfit/job/science/rguard
	alt_titles = list("Containment Specialist")

	clean_record_required = TRUE
