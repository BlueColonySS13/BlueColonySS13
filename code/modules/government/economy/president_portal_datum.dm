//Presidential Portal Options Refactor - Datum Edition


/datum/portal_option
	var/name = ""
	var/description = "Portal Option description here."
	var/id = ""	// id for reference
	var/toggle_status = TRUE
	var/value_text = ""
	var/value = 0.10	// 10%

	var/min_value = 0	// 0%
	var/max_value = 1	// 100%

	var/list/value_options = list()

	var/department_cost = 0 // If this costs something per payroll, how much? (Works with toggle_status var)
	var/charged_department = DEPT_COUNCIL // If this charges money, which department will it pull money from?
	var/department_recieving = DEPT_NANOTRASEN // If this charges money, which department gets the money?

	var/make_referendum = FALSE // If this is enabled, it will require a referendum


/proc/get_portal_option(id)
	return GLOB.president_portal_options[id]

//proc wrappers
/datum/portal_option/proc/get_value_text()
	return value_text

/datum/portal_option/proc/get_value_number()
	return value

/datum/portal_option/proc/get_value_options()
	return value_options

