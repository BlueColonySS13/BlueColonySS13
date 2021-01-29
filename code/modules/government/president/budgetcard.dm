/datum/persistent_option/number_value/budgetcard
	min_value = 0
	max_value = 50000
	description = "This is limit that budgetcards currently utilise."

	var_to_edit = "value"
	portal_category = "Spending And Budget"
	portal_grouping = "Economy Settings"
	value_is_money = TRUE

// Gun Permits
/datum/persistent_option/number_value/budgetcard/nanotrasen
	name = "Nanotrasen Budgetcard Limit"
	description = "This is limit that nanotrasen budgetcards currently utilise."
	id = "budgetcard_nt"
	value = 30000
	required_access_edit = access_ceo

/datum/persistent_option/number_value/budgetcard/colony
	name = "Colony Budgetcard Limit"
	description = "This is limit that colony budgetcards currently utilise."
	id = "budgetcard_colony"
	value = 2000

/datum/persistent_option/number_value/budgetcard/council
	name = "Council Budgetcard Limit"
	description = "This is limit that council budgetcards currently utilise."
	id = "budgetcard_council"
	value = 2000

/datum/persistent_option/number_value/budgetcard/public
	name = "Public Budgetcard Limit"
	description = "This is limit that public budgetcards currently utilise."
	id = "budgetcard_public"
	value = 2000

/datum/persistent_option/number_value/budgetcard/legal
	name = "Legal Budgetcard Limit"
	description = "This is limit that public budgetcards currently utilise."
	id = "budgetcard_legal"
	value = 2000

/datum/persistent_option/number_value/budgetcard/police
	name = "Police Budgetcard Limit"
	description = "This is limit that council budgetcards currently utilise."
	id = "budgetcard_police"
	value = 20000

/datum/persistent_option/number_value/budgetcard/medical
	name = "Medical Budgetcard Limit"
	description = "This is limit that council budgetcards currently utilise."
	id = "budgetcard_medical"
	value = 8000

/datum/persistent_option/number_value/budgetcard/research
	name = "Research Budgetcard Limit"
	description = "This is limit that council budgetcards currently utilise."
	id = "budgetcard_research"
	value = 8000

/datum/persistent_option/number_value/budgetcard/maintenance
	name = "Maintenance Budgetcard Limit"
	description = "This is limit that maintenance budgetcards currently utilise."
	id = "budgetcard_maintenance"
	value = 8000

/datum/persistent_option/number_value/budgetcard/pdf
	name = "PDF Budgetcard Limit"
	description = "This is limit that PDF budgetcards currently utilise."
	id = "budgetcard_pdf"
	value = 8000

/datum/persistent_option/number_value/budgetcard/factory
	name = "Factory Budgetcard Limit"
	description = "This is limit that factory budgetcards currently utilise."
	id = "budgetcard_factory"
	value = 8000