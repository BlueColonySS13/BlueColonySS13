
//Food
/datum/job/bartender
	title = "Bartender"
	flag = BARTENDER
//	faction = "City"
	department = DEPT_BAR
	department_flag = CIVILIAN
	total_positions = 2
	spawn_positions = 2

	supervisors = "the bar manager"
	selection_color = "#515151"
	idtype = /obj/item/weapon/card/id/civilian/bartender
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_bar)
	minimum_character_age = 18
	wage = 45
//	outfit_type = /decl/hierarchy/outfit/job/service/bartender
	alt_titles = list("Waiting Staff","Barkeep","Mixologist","Barista")


/datum/job/chef
	title = "Chef"
	flag = CHEF
//	faction = "City"
	department = DEPT_BAR
	department_flag = CIVILIAN
	total_positions = 2
	spawn_positions = 2

	supervisors = "the bar manager"
	selection_color = "#515151"
	idtype = /obj/item/weapon/card/id/civilian/chef
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_kitchen)
	minimum_character_age = 15 //Those kids better serve some good burgers or I'll ask for the manager
	wage = 45
//	outfit_type = /decl/hierarchy/outfit/job/service/chef
	alt_titles = list("Restaurant Cashier","Cook","Restaurant Host")

/datum/job/hydro
	title = "Botanist"
	flag = BOTANIST
//	faction = "City"
	department_flag = CIVILIAN
	department = DEPT_BOTANY
	total_positions = 2
	spawn_positions = 1
	supervisors = "the bar manager"

	selection_color = "#515151"
	idtype = /obj/item/weapon/card/id/civilian/botanist
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_hydroponics)
	minimum_character_age = 16 //Eh, I can see it happening
	wage = 29
//	outfit_type = /decl/hierarchy/outfit/job/service/gardener
	alt_titles = list("Hydroponicist", "Gardener","Farmer")

/datum/job/bargm
	title = "Bar Manager"
	flag = MANAGER
//	faction = "City"
	department_flag = CIVILIAN
	department = DEPT_BAR
	total_positions = 1
	spawn_positions = 1
	supervisors = "the bar owner"
	subordinates = "the bar employees"
	selection_color = "#515151"
	idtype = /obj/item/weapon/card/id/civilian/bartender
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_hydroponics)
	minimum_character_age = 23 // They have some standards
	wage = 50
	outfit_type = /decl/hierarchy/outfit/job/service/bartender
	alt_titles = list("Executive Chef", "Diner Manager", "Bar Supervisor")

//Service


//More or less assistants
/datum/job/journalist
	title = "Journalist"
	flag = JOURNALIST
//	faction = "City"
	department_flag = CIVILIAN
	department = DEPT_PUBLIC
	total_positions = 4
	spawn_positions = 2
	supervisors = "the city clerk"
	selection_color = "#515151"
	idtype = /obj/item/weapon/card/id/civilian/journalist
	access = list(access_library, access_maint_tunnels)
	minimal_access = list(access_library)
	minimum_character_age = 16
	wage = 36
//	outfit_type = /decl/hierarchy/outfit/job/civilian/journalist
	alt_titles = list("Archivist", "Librarian", "Radio Host")

/datum/job/defense
	title = "Defense Attorney"
	flag = LAWYER
	faction = "City"
	department_flag = CIVILIAN
	department = DEPT_PUBLIC
	total_positions = 4
	spawn_positions = 1
	supervisors = "the Judge"
	selection_color = "#515151"
	idtype = /obj/item/weapon/card/id/civilian/defense
	wage = 100
	synth_wage = 50

	req_admin_notify = 1
	access = list(access_lawyer, access_sec_doors, access_maint_tunnels, access_heads, access_legal)
	minimal_access = list(access_lawyer, access_sec_doors, access_heads, access_legal)
//	minimal_player_age = 7 (More lawyers please.)
	minimum_character_age = 20
	alt_titles = list("Defense Lawyer","Defense Attorney","Barrister", "Legal Advisor", "Private Attorney")

	outfit_type = /decl/hierarchy/outfit/job/civilian/defense/defense

	clean_record_required = TRUE

/datum/job/barber
	title = "Barber"
	flag = BARBER
//	faction = "City"
	department_flag = CIVILIAN
	department = DEPT_PUBLIC
	total_positions = 2
	spawn_positions = 2
	supervisors = "the city clerk"
	selection_color = "#515151"
	idtype = /obj/item/weapon/card/id/civilian/barber
	minimum_character_age = 16
	access = list(access_barber, access_maint_tunnels)
	minimal_access = list(access_barber)
	wage = 47
//	outfit_type = /decl/hierarchy/outfit/job/civilian/barber
	alt_titles = list("Hairdresser", "Stylist", "Beautician")

//Cargo
/datum/job/qm
	title = "Factory Manager"
	flag = QUARTERMASTER
	department = DEPT_FACTORY
	department_flag = CIVILIAN
	faction = "City"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the factory owners"
	subordinates = "the factory workers"
	selection_color = "#7a4f33"
	idtype = /obj/item/weapon/card/id/cargo/head
	wage = 150
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimum_character_age = 20
	ideal_character_age = 35

	allows_synths = FALSE

	outfit_type = /decl/hierarchy/outfit/job/cargo/qm
	alt_titles = list("Supply Chief", "Factory Foreman")

/datum/job/cargo_tech
	title = "Factory Worker"
	flag = CARGOTECH
	faction = "City"
	department = DEPT_FACTORY
	department_flag = CIVILIAN
	total_positions = 4

	spawn_positions = 4
	supervisors = "the factory manager"
	selection_color = "#9b633e"
	idtype = /obj/item/weapon/card/id/cargo/cargo_tech
	wage = 70
	synth_wage = 40

	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_cargo, access_cargo_bot, access_mailsorting)
	minimum_character_age = 13

	outfit_type = /decl/hierarchy/outfit/job/cargo/cargo_tech
	alt_titles = list("Delivery Assistant")

/datum/job/mining
	title = "Miner"
	flag = MINER
//	faction = "City"
	department = DEPT_FACTORY
	department_flag = CIVILIAN
	total_positions = 3
	spawn_positions = 3
	supervisors = "the factory manager"

	selection_color = "#9b633e"
	idtype = /obj/item/weapon/card/id/cargo/mining
	wage = 40
	synth_wage = 20

	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_mining, access_mining_station)
	minimal_access = list(access_mining, access_mining_station, access_mailsorting)
	minimum_character_age = 18

	outfit_type = /decl/hierarchy/outfit/job/cargo/mining
	alt_titles = list("Drill Technician","Prospector")
