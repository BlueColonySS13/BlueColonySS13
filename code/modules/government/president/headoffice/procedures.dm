/datum/persistent_option/value/procedure
	portal_category = "Standard Operating Procedures"
	portal_grouping = "Records"
	portal_category = "Procedures"
	var_to_edit = "value_text"
	max_value_text = 19000


	value_type = 1

	bbcode_value = FALSE

	required_access_edit = access_ceo
	log_id = "nanotrasen_logging"

	creation_text = "A new ballot for \"%NAME\" has been raised! \
	Please go to your local ballot box to cast your votes. Your voice matters!"

	on_ballot_pass = "The ballot for %NAME has passed! The changes will take place immediately."


// charter

/datum/persistent_option/value/procedure/department/charter
	name = "Polluxian Charter"
	description = "The is the official charter provided by Nanotrasen, it cannot be directly edited by presidents but can have amendments suggested. \
	It is used as reference for legal matters."
	id = "pollux_charter"
	value_text = "Placeholder."
	value_type = 1
	bbcode_value = TRUE

	var_to_edit = "value_text"

/*

/datum/persistent_option/value/procedure/head_office/sol
	name = "Sol Charter"
	description = "The is the official charter provided by SolGov."
	id = "sol_charter"
	value_text = "Placeholder."

/datum/persistent_option/value/procedure/head_office/andro
	name = "Andromeda Charter"
	description = "The is the official charter provided by AndroGov."
	id = "andro_charter"
	value_text = "Placeholder."

*/


// department SOP

/datum/persistent_option/value/procedure/department/council/directives
	name = "Council Directives"
	description = "This is the general directives that council members are expected to follow."
	id = "council_directives"
	value_text = "Placeholder."


/datum/persistent_option/value/procedure/department/council/martial_law
	name = "Martial Law Procedure"
	description = "This is the martial law procedure to be followed during martial law."
	id = "martial_law_procedure"
	value_text = "Placeholder."


/datum/persistent_option/value/procedure/department/police
	name = "Police Standard Operating Procedure"
	description = "This is the police's standard operating procedure, it is expected to be followed at all times by police officers."
	id = "police_sop"
	value_text = "If you can, talk to suspect first - gauge their responses - attempt to get them to cooperate peacefully with you without \
	resorting to a fight.\[br\] \
	If they are in a group, hostile, refuse to come with you, or run away, you are permitted to use non-lethals. \
	If you are dealing with a group of hostiles or are dealing with synthetics or a mecha, a flashbang or EMP may be permitted. \
	Lethals are permitted in a last case scenario if non-lethals are not adequate in subduing a resisting suspect. This is not an authorization to kill."

/datum/persistent_option/value/procedure/department/prisoner_handling
	name = "Prisoner Handling Procedures"
	description = "This is the prisoner rights procedure, it must be followed by the police department at all time. Please view the charter \
	before editing this to ensure that it does not violate it."
	id = "prisoner_handling_sop"
	value_text = "Placeholder."

/datum/persistent_option/value/procedure/department/science
	name = "Research Standard Operating Procedure"
	description = "This is the standard operating procedure for research, it is expected to be followed at all times by research staff."
	id = "research_sop"
	value_text = "Placeholder."

/datum/persistent_option/value/procedure/department/medical
	name = "Medical Standard Operating Procedure"
	description = "This is the standard operating procedure for medical, it is expected to be followed at all times by medical staff."
	id = "medical_sop"
	value_text = "Placeholder."

/datum/persistent_option/value/procedure/department/court
	name = "Court Standard Operating Procedure"
	description = "This is the standard operating procedure for courtrooms, it is expected to be followed at all times during legal procedures."
	id = "legal_sop"
	value_text = "Placeholder."

/datum/persistent_option/value/procedure/department/execution
	name = "Execution Procedure"
	description = "This is the execution procedure. Ensure that it does not conflict with the charter before continuing."
	id = "execution_procedure"
	value_text = "Placeholder."


// Regulations
/datum/persistent_option/value/procedure/regulation
	portal_category = "Regulations"

/datum/persistent_option/value/procedure/regulation/food_safety
	name = "Food Health and Safety Regulations"
	description = "Health and safety regulations can be set here for the colony to look up and research."
	id = "regs_food_safety"
	value_text = "Placeholder."

/datum/persistent_option/value/procedure/regulation/weapon_sales
	name = "Weapon Sales Regulations"
	description = "Regulations in the regard of selling weapons."
	id = "regs_weapon_sales"
	value_text = "Placeholder."

/datum/persistent_option/value/procedure/regulation/anomalous
	name = "Anomalous Material Handling"
	description = "Regulations in the regards to handling anomalous materials and lab equipment."
	id = "regs_anomalous_material"
	value_text = "Placeholder."

/datum/persistent_option/value/procedure/regulation/private_security
	name = "Private Security Regulations"
	description = "Regulations in the regards to private security."
	id = "regs_private_security"
	value_text = "Placeholder."

/datum/persistent_option/value/procedure/regulation/landlord
	name = "Landlord Regulations"
	description = "Regulations in the regards to landownership."
	id = "regs_private_landlord"
	value_text = "Placeholder."


