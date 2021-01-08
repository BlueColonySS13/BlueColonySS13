
/datum/persistent_option/toggle/council
	portal_grouping = PORTAL_COUNCIL

// ############ TOGGLE OPTIONS ############ //

// Quality of life services

/datum/persistent_option/toggle/council/quality_of_life/water_coolers
	name = "Water Coolers"
	description = "Supplied by Water-A-Coolers Inc. This enables water coolers in every public department."
	id = "water_coolers"
	charged_department = DEPT_COUNCIL
	department_cost = 200

/datum/persistent_option/toggle/council/quality_of_life/food_stamps
	name = "Food Stamps"
	description = "MREs provided in city hall all around Pollux for civilians who have under a certain amount in capital."
	id = "food_stamps"
	charged_department = DEPT_COUNCIL
	department_cost = 8000	// technically you're feeding the entire planet, so this is expensive.

/datum/persistent_option/toggle/council/quality_of_life/cleanbots
	name = "Cleaning Bots"
	description = "Cleaning bots are supplied around the city to keep the streets cleaner."
	id = "cleaning_bots"
	charged_department = DEPT_COUNCIL
	department_cost = 900

// Security Services

/datum/persistent_option/toggle/council/security/securitrons
	name = "Securitrons"
	description = "Securitrons are placed around the city to combat crime and cover patrol routes."
	id = "securitrons"
	charged_department = DEPT_POLICE
	department_cost = 900

// City Protection Services

/datum/persistent_option/toggle/council/protection/carp_shield
	name = "Pest Control: Carp"
	description = "The city will hire a specialized contractor to contain the carp menace. A repellent will be provided to prevent carp from migrating."
	id = "carpshield"
	charged_department = DEPT_COUNCIL
	department_cost = 6000

/datum/persistent_option/toggle/council/protection/network_antivirus
	name = "Network Anti-Virus - Gr3y.T1d3 Firewall"
	description = "This will protect the city from the Gr3y.T1d3 trojan that causes jailbreaks and other city chaos. \
	 Covers upgrades that combats the latest versions of this exploit."
	id = "network_antivirus"
	charged_department = DEPT_COUNCIL
	department_cost = 4000

/datum/persistent_option/toggle/council/protection/meteor_proof
	name = "Meteor Proofing"
	description = "This will protect the city from meteor attacks that consistently affect the colony. Helps protect properties."
	id = "meteor_proofing"
	charged_department = DEPT_COUNCIL
	department_cost = 7000