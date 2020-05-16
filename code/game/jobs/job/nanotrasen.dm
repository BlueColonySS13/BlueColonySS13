/datum/job/nanotrasen
	title = "Government Representative"
	flag = NANOTRASEN
	department = DEPT_NANOTRASEN
	head_position = 0
	department_flag = GOVLAW
	faction = "City"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Nanotrasen and the President"
	selection_color = "#0F0F6F"
	idtype = /obj/item/weapon/card/id/nanotrasen/ntrep
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	outfit_type = /decl/hierarchy/outfit/job/nanotrasen/representative

	alt_titles = list("Electoral Assistant" = /decl/hierarchy/outfit/job/nanotrasen/electoral,
                      "Nanotrasen Officer" = /decl/hierarchy/outfit/job/nanotrasen/officer)

	wage = 1000
	minimum_character_age = 25 // Pushing it I guess, but possible
	ideal_character_age = 40
	req_admin_notify = 1

	hard_whitelisted = 1

	no_shuttle = TRUE


	description = "You represent Nanotrasen as a member of the democratic government project the charter brought forth - \
	this comes with various roles. \

	We're not quite sure why a huge megacorporation needs a democratic government, but perhaps it makes the \
	people feel safe. Because of this you are expected to keep a good image in public as you drain the funds. \
	What you represent? Getting paid for absolutely nothing, that's what."

	duties = list("Drain colony funds", "Pretend to be important", "Go home and roll in your money")


/datum/job/nanotrasen/get_job_email()	// whatever this is set to will be the job's communal email. should be persistent.
	return using_map.rep_email


/datum/job/nanotrasen/get_access()
	return get_all_centcom_access()

/datum/job/nanotrasen/ceo
	title = "Governor"
	total_positions = 1
	spawn_positions = 1
	flag = CEO
	alt_titles = list("Advisor" = /decl/hierarchy/outfit/job/nanotrasen/minister,
	 "Vice President" = /decl/hierarchy/outfit/job/heads/vpresident,
	  "Supreme Justice" = /decl/hierarchy/outfit/job/nanotrasen/justice)
	wage = 10000
	outfit_type = /decl/hierarchy/outfit/job/nanotrasen/governor
	idtype = /obj/item/weapon/card/id/nanotrasen/ceo
	minimum_character_age = 30

	description = "As governor, you act as a bridge between the president and the colony. You'd be assigned your own continent, in this case - \
	Blue Colony."

	duties = list("Drain colony funds", "Pretend to be important", "Go home and roll in your money")


/datum/job/nanotrasen/ceo/get_job_email()	// whatever this is set to will be the job's communal email. should be persistent.
	return using_map.director_email

/datum/job/nanotrasen/cbia
	title = "PDSI Agent"
	flag = CBIA
	alt_titles = list(
		"PDSI Director", "PDSI Supervisory Agent", "PDSI Senior Agent")
	head_position = 0
	department_flag = GOVLAW
	faction = "City"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the PDSI Director"

	selection_color = "#0F0F6F"
	idtype = /obj/item/weapon/card/id/nanotrasen/cbia
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	alt_titles = list()


	outfit_type = /decl/hierarchy/outfit/job/nanotrasen/cbia

	wage = 1000
	minimum_character_age = 25 // Pushing it I guess, but possible
	ideal_character_age = 37
	req_admin_notify = 1

	description = "PDSI agents are a bit like the FBI, but less cool. They exist to control the corruption in the city council and the police."

	duties = list("Get police reports instead of corruption reports", "Drink coffee", "Roll eyes at reports")


/datum/job/nanotrasen/cbia/get_job_email()	// whatever this is set to will be the job's communal email. should be persistent.
	return using_map.investigation_email

/datum/job/nanotrasen/president
	title = "President"
	flag = PRESIDENT
	department_flag = GOVLAW
	faction = "City"
	total_positions = 1
	spawn_positions = 1
	supervisors = "NanoTrasen"
	subordinates = "the Governor"

	selection_color = "#1D1D4F"
	idtype = /obj/item/weapon/card/id/nanotrasen/president
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14

	wage = 9000
	alt_titles = list()

	minimum_character_age = 30
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/heads/president


/datum/job/nanotrasen/president/get_job_email()	// whatever this is set to will be the job's communal email. should be persistent.
	return using_map.president_email