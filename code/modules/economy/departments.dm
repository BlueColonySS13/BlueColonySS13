#define DEPT_PUBLIC 1
#define DEPT_PRIVATE 2
#define DEPT_EXTERNAL 3

/datum/department
	var/name = "Department"
	var/id = "department"
	var/desc = "This is a generic department. Technically you shouldn't see this."

	var/starting_money = 7500

	var/dept_type = DEPT_PUBLIC
	var/datum/money_account/department/bank_account

/datum/money_account/department
	var/datum/department/department
	max_transaction_logs = DEPARTMENT_TRANSACTION_LIMIT

// ## Presets ## //

/datum/department/nanotrasen
	name = "Nanotrasen"
	id = "nanotrasen"
	desc = "Nanotrasen's money account, this money account is owned by the Nanotrasen Board of Directors and should not be touched without express permission."
	starting_money = 100000

	dept_type = DEPT_PRIVATE

/datum/department/colon
	name = "Colony Funds"
	id = "colony"
	desc = "This is the colony's funding account. Taxes go here."

	starting_money = 8000

/datum/department/city_council
	name = "City Council"
	id = "city_council"
	desc = "City Council are paid from this account. Money from lots and permit sales are also paid into this account."

	starting_money = 5000

/datum/department/law
	name = "Legal"
	id = "legal"
	starting_money = 3000
	desc = "The publicly funded legal department is paid from this account. Money that is spent on court cases go here and is withdrawn from here."

/datum/department/maintenance
	name = "Maintenance"
	id = "maintenance"
	starting_money = 3000

	desc = "The maintenance department is paid from this budget. Any city works fees are also paid into this account."

/datum/department/research
	name = "Research and Science"
	id = "research"
	starting_money = 2000

	desc = "Science and research employees are paid from this account. Any money made by Research is paid into this account."


/datum/department/police
	name = "Police"
	id = "police"
	starting_money = 3000
	desc = "The police department is funded by this account. Money made from fines are paid into this account."


/datum/department/healthcare
	name = "Public Healthcare"
	id = "healthcare"
	starting_money = 3000
	desc = "The hospital and its employees are paid from this account. Any publicly provided medical vendors, medications, treatments and surgeries are income for this department."

/datum/department/public
	name = "Public Funds"
	id = "public"
	starting_money = 300
	desc = "The public funding account. This pays welfare to unemployed, disabled or providing vacation pay to off-duty coucil members, also may fund any jobs that are government supported."

// ## Private Presets

/datum/department/solgov
	name = "United Sol Government"
	id = "solgov"
	desc = "The official bank account of the United Sol Government"
	starting_money = 100000

	dept_type = DEPT_PRIVATE