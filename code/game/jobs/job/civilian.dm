/datum/job/assistant
	var/hide_on_manifest = 1
	title = "Civilian"
	flag = ASSISTANT
	department = DEPT_PUBLIC
	department_flag = CIVILIAN
	faction = "City"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the police, government, and city council"
	selection_color = "#515151"
	minimum_character_age = 1
	hide_on_manifest = 0
	wage = 5 // Ha-ha poor people (tm)
	synth_wage = 0 // no payment for you
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit_type = /decl/hierarchy/outfit/job/assistant
	alt_titles = list(
					"Tourist",
					"Expat",
					"Socialite",
					"Investor",
					"Traveller",
					"Entrepreneur",
					"Visitor" = /decl/hierarchy/outfit/job/assistant/visitor,
					"Resident" = /decl/hierarchy/outfit/job/assistant/resident)

	description = "You are a normal, average citizen. You can be many things - someone who lives in the city, an investor, a tourist, a socialite, \
	even an aspiring businessman. You recieve a small stipend from the government to fund your living expenses until you find a job. \
	Every civilian is important as your spending is what keeps this colony thriving. You might be better off being straight and steady if you're \
	new to the colony instead of jumping right into crime if you want to avoid becoming a prisoner."

	duties = list("Get to know people in the city", "Be a good, moral citizen and gain a good reputation", "Or not")

/datum/job/assistant/get_access()
	if(config.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()

/datum/job/prisoner
	title = "Prisoner"
	flag = PRISONER
	department = DEPT_PUBLIC
	department_flag = CIVILIAN
	faction = "City"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the police department holding you"
	selection_color = "#515151"
	wage = 0 // oof
	outfit_type = /decl/hierarchy/outfit/job/civilian/prisoner

	description = "You find yourself behind bars in the colony with no means of escape. How did you get here? There's not much to do as a prisoner \
	but it's not forever. Hire a lawyer to try get yourself out of there, or attempt to get on the police's good side so they give you a lighter \
	sentence."

	duties = list("Attempt to bribe the warden", "Try to escape", "Get caught again", "Become the latest haute cuisine to the sewer spiders")
