
// ## Public Presets ## //

/datum/department/colony
	name = "Colony Funds"
	id = DEPT_COLONY
	desc = "This is the colony's funding account. Taxes go here."

	starting_money = 8000

/datum/department/city_council
	name = "City Council"
	id = DEPT_COUNCIL
	desc = "City Council are paid from this account. Money from lots and permit sales are also paid into this account."

	starting_money = 5000

/datum/department/law
	name = "Legal"
	id = DEPT_LEGAL
	starting_money = 3000
	desc = "The publicly funded legal department is paid from this account. Money that is spent on court cases go here and is withdrawn from here."

/datum/department/maintenance
	name = "Maintenance"
	id = DEPT_MAINTENANCE
	starting_money = 3000

	desc = "The maintenance department is paid from this budget. Any city works fees are also paid into this account."

/datum/department/research
	name = "Research"
	id = DEPT_RESEARCH
	starting_money = 2000

	desc = "Science and research employees are paid from this account. Any money made by Research is paid into this account."

/datum/department/police
	name = "Police"
	id = DEPT_POLICE
	starting_money = 3000
	desc = "The police department is funded by this account. Money made from fines are paid into this account."

/datum/department/healthcare
	name = "Healthcare"
	id = DEPT_HEALTHCARE
	starting_money = 3000
	desc = "The hospital and its employees are paid from this account. Any publicly provided medical vendors, medications, treatments and surgeries are income for this department."

/datum/department/public
	name = "Public Funds"
	id = DEPT_PUBLIC
	starting_money = 300
	desc = "The public funding account. This pays welfare to unemployed, disabled or providing vacation pay to off-duty coucil members, also may fund any jobs that are government supported."

// ## Private Presets ## //

// These are to be removed to be honest. But we'll keep 'em here until they are.

/datum/department/factory
	name = "Factory Funds"
	id = DEPT_FACTORY
	desc = "The factory and its employees are paid from this account."
	starting_money = 500
	dept_type = PRIVATE_DEPARTMENT

/datum/department/botany
	name = "Botany Funds"
	id = DEPT_BOTANY
	desc = "The factory and its employees are paid from this account."
	starting_money = 500
	dept_type = PRIVATE_DEPARTMENT

/datum/department/bar
	name = "Bar Funds"
	id = DEPT_BAR
	desc = "The factory and its employees are paid from this account."
	starting_money = 500
	dept_type = PRIVATE_DEPARTMENT

// ## External Presets

/datum/department/solgov
	name = "SolGov"
	id = DEPT_SOLGOV
	desc = "The official bank account of the United Sol Government"
	starting_money = 1000000

	dept_type = EXTERNAL_DEPARTMENT

/datum/department/nanotrasen
	name = "Nanotrasen"
	id = DEPT_NANOTRASEN
	desc = "Nanotrasen's money account, this money account is owned by the Nanotrasen Board of Directors and should not be touched without express permission."
	starting_money = 1000000

	dept_type = EXTERNAL_DEPARTMENT