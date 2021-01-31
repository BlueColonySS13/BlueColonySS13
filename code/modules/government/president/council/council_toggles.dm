
/datum/persistent_option/toggle/council
	charged_department = DEPT_COUNCIL
	department_recieving = DEPT_NANOTRASEN
	portal_grouping = "Social Services"
	portal_category = "Council Programmes"

	required_access_edit = access_heads

// ############ TOGGLE OPTIONS ############ //

// Quality of life services

/datum/persistent_option/toggle/council/quality_of_life/water_coolers
	name = "Water Coolers"
	description = "Supplied by Water-A-Coolers Inc. This enables water coolers in every public department."
	id = "qol_water_coolers"
	charged_department = DEPT_COUNCIL
	department_cost = -30

/datum/persistent_option/toggle/council/quality_of_life/food_stamps
	name = "Food Stamps"
	description = "MREs provided in city hall all around Pollux for civilians who have under a certain amount in capital."
	id = "qol_food_stamps"
	charged_department = DEPT_COUNCIL
	department_cost = -500	// technically you're feeding the entire planet, so this is expensive.

/datum/persistent_option/toggle/council/quality_of_life/cleanbots
	name = "Cleaning Bots"
	description = "Cleaning bots are supplied around the city to keep the streets cleaner."
	id = "qol_cleaning_bots"
	charged_department = DEPT_COUNCIL
	department_cost = -100

// Security Services

/datum/persistent_option/toggle/council/security/securitrons
	name = "Securitrons"
	description = "Securitrons are placed around the city to combat crime and cover patrol routes."
	id = "sec_securitrons"
	charged_department = DEPT_POLICE
	department_cost = -700

// City Protection Services

/datum/persistent_option/toggle/council/protection/carp_shield
	name = "Pest Control: Carp"
	description = "The city will hire a specialized contractor to contain the carp menace. A net will be provided to prevent carp from migrating."
	id = "protect_carpshield"
	charged_department = DEPT_COUNCIL
	department_cost = -1000

/*
/datum/persistent_option/toggle/council/protection/mice_control
	name = "Pest Control: Mice"
	description = "The city will hire a specialized contractor to eradicate mice. A repellent will be provided to prevent mice from infesting the city."
	id = "protect_mice"
	charged_department = DEPT_COUNCIL
	department_cost = -200
*/

/datum/persistent_option/toggle/council/protection/network_antivirus
	name = "Network Anti-Virus - Gr3y.T1d3 Firewall"
	description = "This will protect the city from the Gr3y.T1d3 trojan that causes jailbreaks and other city chaos. \
	 Covers upgrades that combats the latest versions of this exploit."
	id = "protect_network_antivirus"
	charged_department = DEPT_COUNCIL
	department_cost = -2000

/datum/persistent_option/toggle/council/protection/meteor_proof
	name = "Meteor Proofing"
	description = "This will protect the city from meteor attacks that consistently affect the colony. Helps protect properties."
	id = "protect_meteor_proofing"
	charged_department = DEPT_COUNCIL
	department_cost = -2000
