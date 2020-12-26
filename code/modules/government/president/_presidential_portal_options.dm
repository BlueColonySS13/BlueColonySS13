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

	var/min_value_text = 0 // min length
	var/max_value_text = 100 // max length of a value_text

	var/list/value_options = list()
	var/list/value_list = list()

	var/department_cost = 0 // If this costs something per payroll, how much? (Works with toggle_status var)
	var/charged_department = DEPT_COUNCIL // If this charges money, which department will it pull money from?
	var/department_recieving = DEPT_NANOTRASEN // If this charges money, which department gets the money?

	var/make_referendum = FALSE // If this is enabled, it will require a referendum

	var/portal_grouping = PORTAL_GENERIC

	var/var_to_edit = "value_text" // this points to the var we're editing in this datum

	var/value_type = 0 // 0 = text, 1 = message
	var/bbcode_value = FALSE // if this is enabled, value_text filled fields will convert to BBcode

	var/edit_text = "" // If set, this string shows when you are editing an option. It will replace the default message.

	var/allow_blank = TRUE // allow text values on this to be blank?

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
	sanitize_integer(toggle_status, FALSE, TRUE, initial(toggle_status))

	if(!islist(value_options))
		value_options = list()
	if(!islist(value_list))
		value_list = list()
	if(!istext(value_text))
		value_text = initial(value_text)

	if(!isnum(department_cost))
		department_cost = initial(department_cost)

	return 1

//proc wrappers
/datum/persistent_option/proc/get_value()
	return vars[var_to_edit]

/datum/persistent_option/number_value
	var_to_edit = "value"

/datum/persistent_option/toggle
	var_to_edit = "toggle_status"

/proc/update_pesistent_option_value(id, new_value)
	var/datum/persistent_option/PO = get_portal_option(id)
	if(!PO)
		return

	PO.vars[PO.var_to_edit] = new_value

/datum/persistent_option/proc/show_value_updater(mob/user)
	if(!vars[var_to_edit])
		return FALSE

	switch(var_to_edit)

		if("value_text")
			var/new_text_value = value_text
			if(value_type == 0)
				new_text_value = sanitize(copytext(input(user, "[edit_text ? edit_text : "Please enter a new value for [name]"] ([max_value_text] chars max) [bbcode_value ? "(BBcode Enabled)" : ""]", "[name]", new_text_value)  as text, min_value_text, max_value_text))
			else
				new_text_value = sanitize(copytext(input(user, "[edit_text ? edit_text : "Please enter a new value for [name]"] ([max_value_text] chars max) [bbcode_value ? "(BBcode Enabled)" : ""]", "[name]", new_text_value)  as message, min_value_text, max_value_text))

			if(!new_text_value && !allow_blank)
				return FALSE

			value_text = new_text_value
			return TRUE

		if("value")
			var/age = input(usr, "Please select the minimum age for criminal sentencing. (Min: 13. Max: 25.)", "[name]") as num|null


		if("toggle_status")
			var/new_toggle = input(user, "[edit_text ? edit_text : "Please choose from the following options."]", "[name]") as null|anything in list("Yes", "No", "Cancel")

			if(!new_toggle || new_toggle == "Cancel")
				return FALSE

			toggle_status = (new_toggle == "Yes") ? TRUE : FALSE

			return TRUE


