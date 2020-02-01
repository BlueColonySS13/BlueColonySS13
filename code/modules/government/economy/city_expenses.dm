



/datum/expense/nanotrasen
	name = "NanoTrasen Income"	// nanotrasen's base expense cannot be removed. sorry!
	cost_per_payroll = 500
	comments = "Nanotrasen will recieve an allowance from the city's earnings."
	can_remove = FALSE
	direct_debit = TRUE
	charge_department = "Nanotrasen"

/datum/expense/nanotrasen/New()
	..()
	department = "[station_name()] Funds"

/datum/expense/nanotrasen/is_active()
	return persistent_economy.NT_charge

/*
/datum/expense/nanotrasen/cleaning
	name = "City Cleaning Fund"
	cost_per_payroll = 400
	comments = "The city will hire a private contractor cleaning group to free the \
	city from grime, blood and filth."

/datum/expense/nanotrasen/pest_control/mice
	name = "Pest Control Fund: Mice"
	cost_per_payroll = 150
	comments = "The city will hire a pest control service that deals with mice."
*/

/datum/expense/nanotrasen/pest_control/carp
	name = "Pest Control: Carp"
	cost_per_payroll = 250
	comments = "The city will hire a specialized contractor to contain the carp menace. A repellent will be provided to prevent carp from migrating."

/datum/expense/nanotrasen/pest_control/carp/do_effect()
	if(!active)
		persistent_economy.carp_control = FALSE
	else
		persistent_economy.carp_control = TRUE

	return 1


/datum/expense/nanotrasen/tech_support/prison_break
	name = "Network Anti-Virus - Gr3y.T1d3 Firewall"
	cost_per_payroll = 150
	comments = "This will protect the city from the Gr3y.T1d3 trojan that causes jailbreaks and other city chaos. \
	 Covers upgrades that combats the latest versions of this exploit."

/datum/expense/nanotrasen/tech_support/prison_break/do_effect()
	if(!active)
		persistent_economy.antivirus = FALSE
	else
		persistent_economy.antivirus = TRUE

	return 1

/*
/datum/expense/nanotrasen/pest_control/spiders
	name = "Pest Control Fund: Spiders"
	cost_per_payroll = 1000
	comments = "The city will hire a very robust pest control specialist that will remove spiders from the sewers."

/datum/expense/nanotrasen/social_service/food_stamps
	name = "Food Stamps"
	cost_per_payroll = 350
	comments = "The city will provide food stamps to people under a certain income."

/datum/expense/nanotrasen/department_supply/water_coolers
	name = "Water Coolers"
	cost_per_payroll = 10
	comments = "Free water for all departments, this will provide."

/datum/expense/nanotrasen/department_supply/securitron
	name = "Rented Securitrons"
	cost_per_payroll = 400
	comments = "This will rent five little securitrons that will be placed in various corners of the city."

/datum/expense/nanotrasen/department_supply/ed209
	name = "Rented ED-209 Security Robot"
	cost_per_payroll = 600
	comments = "ED-209 Security Robots will patrol the city, you will recieve three of them..."

/datum/expense/nanotrasen/department_supply/odysseus
	name = "Rented ED-209 Security Robot"
	cost_per_payroll = 600
	comments = "This will rent 3x extra securitrons that will be placed in various corners of the city."

*/