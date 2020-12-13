//Presidential Portal Options Refactor - Datum Edition
GLOBAL_LIST_EMPTY(persistent_options)
GLOBAL_LIST_EMPTY(president_portal_options)

//ids
GLOBAL_LIST_EMPTY(president_portal_)


/datum/persistent_option
	var/name = ""
	var/description = "Portal Option description here."
	var/id = ""	// id for reference
	var/toggle_status = TRUE
	var/value_text = ""
	var/value = 0.10	// 10%

	var/min_value = 0	// 0%
	var/max_value = 1	// 100%

	var/list/value_options = list()
	var/list/value_list = list()

	var/department_cost = 0 // If this costs something per payroll, how much? (Works with toggle_status var)
	var/charged_department = DEPT_COUNCIL // If this charges money, which department will it pull money from?
	var/department_recieving = DEPT_NANOTRASEN // If this charges money, which department gets the money?

	var/make_referendum = FALSE // If this is enabled, it will require a referendum

	var/portal_grouping = PORTAL_GENERIC

/datum/persistent_option/New()
	..()
	if(id)
		GLOB.persistent_options[id] = src

/datum/persistent_option/portal
	portal_grouping = PORTAL_PRESIDENT

/datum/persistent_option/portal/New()
	..()
	if(id)
		GLOB.president_portal_options[id]  = src

/proc/get_persistent_option(id)
	return GLOB.persistent_options[id]

/proc/get_persistent_option_value(id)
	var/datum/persistent_option/PO = get_portal_option(id)
	if(!PO)
		return
	return PO.get_value

/datum/persistent_option/proc/sanitize_options()
	sanitize_integer(value, min_value, max_value, initial(value))
	return 1

//proc wrappers
/datum/persistent_option/proc/get_value()
	return value_text

/datum/persistent_option/number_value/get_value()
	return value

/datum/persistent_option/toggle/get_value()
	return toggle_status