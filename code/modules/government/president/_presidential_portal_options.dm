//Presidential Portal Options Refactor - Datum Edition
GLOBAL_LIST_EMPTY(persistent_options)
GLOBAL_LIST_EMPTY(generic_portal_options)
GLOBAL_LIST_EMPTY(president_portal_options)
GLOBAL_LIST_EMPTY(council_portal_options)

//ids
GLOBAL_LIST_EMPTY(president_portal_ids)

/datum/persistent_option
	var/name = ""
	var/description = "Portal Option description here."
	var/id = ""	// id for reference
	var/toggle_status = TRUE
	var/value_text = ""
	var/value = 0.10	// 10%

	var/min_value = 0	// 0%
	var/max_value = 1	// 100%

	var/max_value_text = 100 // max length of a value_text

	var/list/value_list = list()
	var/list/value_options = list() // options to choose from, if empty, people can use text to add values

	var/value_select = ""	// select a value from a list.

	var/max_list_items = 0	// if set to a number, this will be the max items that can be in value_list

	var/department_cost = 0 // If this costs something per payroll, how much? (Works with toggle_status var)
	var/charged_department = DEPT_COUNCIL // If this charges money, which department will it pull money from?
	var/department_recieving = DEPT_NANOTRASEN // If this charges money, which department gets the money?

	var/make_referendum = FALSE // If this is enabled, it will require a referendum

	var/portal_grouping = PORTAL_PRESIDENT
	var/portal_category = "General"

	var/var_to_edit = "value_text" // this points to the var we're editing in this datum

	var/value_type = 0 // 0 = text, 1 = message
	var/bbcode_value = FALSE // if this is enabled, value_text filled fields will convert to BBcode

	var/edit_text = "" // If set, this string shows when you are editing an option. It will replace the default message.

	var/allow_blank = TRUE // allow text values on this to be blank?

	var/referendum_type = /datum/voting_ballot/referendum

	var/creation_text = "A new ballot for \"%NAME\" has been raised! \
	This will change it from %VALUE to %PROPOSEDVALUE. \
	Please go to your local ballot box to cast your votes. Your voice matters!"

	var/on_ballot_pass = "The ballot for %NAME has passed! It has changed from %VALUE to %PROPOSEDVALUE, this will take place immediately."




/datum/persistent_option/New()
	..()
	if(id)
		GLOB.persistent_options[id] = src

		switch(portal_grouping)
			if(PORTAL_GENERIC)
				GLOB.generic_portal_options[id] = src
			if(PORTAL_PRESIDENT)
				GLOB.president_portal_options[id] = src
			if(PORTAL_COUNCIL)
				GLOB.council_portal_options[id] = src


	creation_text = replacetext(creation_text, "%NAME", name)
	creation_text = replacetext(creation_text, "%VALUE", get_formatted_value())
	creation_text = replacetext(creation_text, "%PROPOSEDVALUE", SSpersistent_options.find_proposed_value_ballot(id))

	on_ballot_pass = replacetext(on_ballot_pass, "%NAME", name)
	on_ballot_pass = replacetext(on_ballot_pass, "%VALUE", get_formatted_value())
	on_ballot_pass = replacetext(on_ballot_pass, "%PROPOSEDVALUE", SSpersistent_options.find_proposed_value_ballot(id))

/datum/persistent_option/proc/get_option_values()
	return value_options

/datum/persistent_option/proc/sanitize_options()
	sanitize_integer(value, min_value, max_value, initial(value))
	sanitize_integer(toggle_status, FALSE, TRUE, initial(toggle_status))

	sanitize(value_text)


	if(!islist(value_options))
		value_options = list()
	if(!islist(value_list))
		value_list = list()
	if(!istext(value_text))
		value_text = initial(value_text)

	if(!isnum(department_cost))
		department_cost = initial(department_cost)


	return 1

/datum/persistent_option/proc/get_linked_ballot()
	return SSpersistent_options.check_ballot_exists(id)

//proc wrappers
/datum/persistent_option/proc/get_value()
	return vars[var_to_edit]

/datum/persistent_option/proc/get_formatted_value()
	return get_value()

/datum/persistent_option/proc/get_proposed_value()
	return SSpersistent_options.find_proposed_value_ballot(id)

/datum/persistent_option/number_value
	var_to_edit = "value"

/datum/persistent_option/toggle
	var_to_edit = "toggle_status"


/datum/persistent_option/toggle/get_formatted_value() // for use in UIs
	return (toggle_status ? "enable" : "disable")

/datum/persistent_option/select_list
	var_to_edit = "value_select"


/datum/persistent_option/proc/show_value_updater(mob/user)
	if(make_referendum)
		if(get_linked_ballot())
			alert(user, "A referendum already exists for this option. Please withdraw it before proposing one again.")
			return FALSE

		var/response = alert(user, "Changing \"[name]\" requires a referendum. Please confirm if you want to make one take place.", "Referendum Confirmation", "I'm Aware", "Cancel")
		if(!response || response == "Cancel")
			return FALSE

	var/the_new_value = null

	if(var_to_edit == "value_text") // updates a string text for text based values.
		var/new_text_value = value_text
		if(value_type == 0)

			new_text_value = sanitize(input(user,"[edit_text ? edit_text : "Please enter a new value for [name]."] ([max_value_text] chars max) [bbcode_value ? "(BBcode Enabled)" : ""]","[name]", html_decode(value_text)) as text, max_value_text, extra = 0)

		else
			new_text_value = sanitize(input(user,"[edit_text ? edit_text : "Please enter a new value for [name]."] ([max_value_text] chars max) [bbcode_value ? "(BBcode Enabled)" : ""]","[name]", html_decode(value_text)) as message|null, max_value_text, extra = 0)


		if(!new_text_value && !allow_blank)
			return FALSE

		the_new_value = new_text_value

		alert("value is [the_new_value]")


	if(var_to_edit == "value") // updates the number for number based values
		var/new_value = input(usr, "[edit_text ? edit_text : "Please enter a new value for [name]."] (Min: [min_value]. Max: [max_value].)", "[name]", value) as num|null

		sanitize_integer(new_value, min_value, max_value, initial(value))
		the_new_value = new_value

		alert("value is [the_new_value]")


	if(var_to_edit == "toggle_status") //updates the TRUE/FALSE or ON/OFF status
		var/new_toggle = input(user, "This setting is currently [toggle_status ? "Enabled." : "Disabled."] [edit_text ? edit_text : "Please choose from the following options."]", "[name]") as null|anything in list("Yes", "No", "Cancel")

		if(!new_toggle || new_toggle == "Cancel")
			return FALSE

		the_new_value = (new_toggle == "Yes") ? TRUE : FALSE
		sanitize_integer(the_new_value, FALSE, TRUE, initial(toggle_status))

		alert("value is [the_new_value]")


	if(var_to_edit == "value_list") // adds or removes a list from a set of values
		var/list/the_list = value_list
		var/list/new_list = the_list.Copy()

		var/removeadd = alert(user, "Would you like to remove from the list or add?", "[name]", "Add", "Remove", "Cancel")

		if(!removeadd || removeadd == "Cancel")
			return FALSE

		if(removeadd == "Add")
			if(max_list_items && (LAZYLEN(the_list) >= max_list_items))
				alert("You may add no more than [max_list_items]")
				return FALSE
			if(LAZYLEN(get_option_values()))

				var/to_add = input(user, "Which option would you like to add?", "[name]") as null|anything in get_option_values()
				if(!to_add)
					return FALSE

				the_new_value = (new_list + to_add)
			else
				var/text_add = sanitize(input(user,"[edit_text ? edit_text : "Please enter a new list item for [name]."] ([max_value_text] chars max) [bbcode_value ? "(BBcode Enabled)" : ""]", "[name]", null), max_value_text)

				if(!text_add)
					return FALSE

				the_new_value	= (new_list + text_add)

		else
			var/to_remove = input(user, "Which option would you like to remove", "[name]") as null|anything in value_list

			if(!(to_remove in the_list))
				return FALSE

			the_new_value = (new_list - to_remove)

		alert("value is [the_new_value]")


	if(var_to_edit == "value_select") // select a value from a list (sole option)
		if(!LAZYLEN(get_option_values()))
			return FALSE // shouldn't happen technically

		var/to_change = input(user, "Which option would you like to update \"[name]\" to?", "[name]") as null|anything in get_option_values()
		if(!to_change)
			return FALSE

		the_new_value = to_change

		alert("value is [the_new_value]")


	if(isnull(the_new_value))
		alert("No value provided")
		return FALSE

	if(!make_referendum)
		return SSpersistent_options.update_pesistent_option_value(id, the_new_value)

	else
		var/response = alert(user, "Would you like to submit the referendum for \"[name]\"?", "Final Referendum Confirmation", "Yes", "No")
		if(!response || response == "No")
			return FALSE

		if(get_linked_ballot())
			alert("Cannot create ballot: This ballot already appears on the system.")
			return FALSE

		var/datum/voting_ballot/referendum/new_referendum = SSpersistent_options.make_new_option_ballot(id, the_new_value, null, "[name] Referendum", description, user.real_name, /datum/voting_ballot/referendum)
		if(new_referendum && creation_text)
			command_announcement.Announce(creation_text, "[name]")
		else
			alert("There has been an issue with processing this referendum, please try again later or contact Nanotrasen technical support.")

		return new_referendum

/datum/persistent_option/proc/edit_value(mob/user)
	if(show_value_updater(user))
		sanitize_options()