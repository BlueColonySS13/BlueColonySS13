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

	var/value_is_money = FALSE // if true, value is converted into cash format
	var/round_value = 1 // if set above 0, value is rounded up to this amount

	var/max_value_text = 100 // max length of a value_text

	var/list/value_list = list()
	var/list/value_options = list() // options to choose from, if empty, people can use text to add values
	var/value_select = ""	// select a value from a list.
	var/max_list_items = 0	// if set to any number above 0, this will be the max items that can be in value_list when sanitized

	var/list/select_person = list() // selects a person from civilian records, saves their uid and name

	var/department_cost = 0 // If this costs something per payroll, how much? (Works with toggle_status var)
	var/charged_department = DEPT_COUNCIL // If this charges money, which department will it pull money from? Do in negative numbers.
	var/department_recieving = DEPT_NANOTRASEN // If this charges money, which department gets the money? Do in positive numbers.

	var/make_referendum = FALSE // If this is enabled, it will require a referendum

	var/portal_category = "General"
	var/portal_grouping = ""

	var/var_to_edit = "value_text" // this points to the var we're editing in this datum

	var/value_type = 0 // 0 = text, 1 = message
	var/bbcode_value = FALSE // if this is enabled, value_text filled fields will convert to BBcode

	var/edit_text = "" // If set, this string shows when you are editing an option. It will replace the default message.

	var/allow_blank = TRUE // allow text values on this to be blank?

	var/referendum_type = /datum/voting_ballot/referendum
	var/create_log = TRUE
	var/log_id = "president_logging" //which persistent id it logs to

	var/override_changes = FALSE // use traditional input type or custom?

	var/compact_listing = 400 // if this is set, it will shrink to text preview to this number. leave to 0 to disable


	var/creation_text = "A new referendum for \"%NAME\" has been raised! \
	This will change it from %VALUE to %PROPOSEDVALUE. \
	Please go to your local ballot box to cast your votes. Your voice matters!"

	var/on_ballot_pass = "The referendum for %NAME has passed! It has changed from %VALUE to %PROPOSEDVALUE, this will take place immediately."
	var/on_ballot_fail = "The referendum for %NAME has failed. Check the GovPortal for more details."

	var/required_access_view = null
	var/required_access_edit = access_president

	var/saveable = TRUE

	var/path = "data/persistent/persistent_options/govportal/"

/datum/persistent_option/New()
	..()
	if(id)
		GLOB.persistent_options[id] = src

/datum/persistent_option/proc/can_edit(list/access_list)
	if(required_access_edit && !(required_access_edit in access_list))
		return FALSE

	return TRUE

/datum/persistent_option/proc/charge_department()
	if(!department_cost || !toggle_status)
		return FALSE

	if(charged_department)
		var/datum/money_account/M = dept_acc_by_id(charged_department)
		if(M && !(department_cost > M.money))
			charge_to_account(M.account_number, "Nanotrasen Fund Transfer", "[name] ([cash2text( department_cost, FALSE, TRUE, TRUE )] PH) expenses", "Government Expenses", department_cost)
		else
			toggle_status() // turn it off.

	if(department_recieving)
		var/datum/money_account/M = dept_acc_by_id(department_recieving)
		if(M)
			charge_to_account(M.account_number, "Nanotrasen Fund Transfer", "[name]", "Government Expenses", -department_cost)

	return TRUE

/datum/persistent_option/proc/on_option_change(newvalue, skip = 0) // is called when an option is adjusted
	if(skip)
		return

	return TRUE

/datum/persistent_option/proc/get_option_values()
	return value_options

/datum/persistent_option/proc/sanitize_options()
	if(round_value)
		value = round(value, round_value)

	sanitize_integer(value, min_value, max_value, initial(value))
	sanitize_integer(toggle_status, FALSE, TRUE, initial(toggle_status))

	sanitize(value_text)

	if(!islist(value_options))
		value_options = list()
	if(!islist(value_list))
		value_list = list()

	value_options = SANITIZE_LIST(value_options)
	value_list = SANITIZE_LIST(value_list)

	if(!istext(value_text))
		value_text = initial(value_text)

	if(!isnum(department_cost))
		department_cost = initial(department_cost)

	if(max_list_items)
		truncate_oldest(value_list, max_list_items)
		truncate_oldest(select_person, max_list_items)

	if(SSpersistent_options.find_proposed_value_ballot(id))
		on_ballot_pass = initial(on_ballot_pass)
		on_ballot_fail = initial(on_ballot_fail)

		on_ballot_pass = replacetext(on_ballot_pass, "%NAME", name)
		on_ballot_pass = replacetext(on_ballot_pass, "%VALUE", get_formatted_value())
		on_ballot_pass = replacetext(on_ballot_pass, "%PROPOSEDVALUE", SSpersistent_options.find_proposed_value_ballot(id))

		on_ballot_fail = replacetext(on_ballot_fail, "%NAME", name)
		on_ballot_fail = replacetext(on_ballot_fail, "%VALUE", get_formatted_value())
		on_ballot_fail = replacetext(on_ballot_fail, "%PROPOSEDVALUE", SSpersistent_options.find_proposed_value_ballot(id))
	return 1

/datum/persistent_option/proc/get_linked_ballot()
	return SSpersistent_options.check_ballot_exists(id)

//proc wrappers
/datum/persistent_option/proc/get_value(fake_value)
	return (fake_value ? fake_value : vars[var_to_edit])

/datum/persistent_option/proc/get_formatted_value(fake_value)
	var/the_value = get_value(fake_value)
	if(bbcode_value)
		the_value = pencode2html(the_value)
	return "[the_value]"


/datum/persistent_option/proc/get_proposed_value()
	return SSpersistent_options.find_proposed_value_ballot(id)

/datum/persistent_option/proc/get_proposed_value_formatting()
	return get_formatted_value(SSpersistent_options.find_proposed_value_ballot(id))

/datum/persistent_option/number_value
	var_to_edit = "value"

/datum/persistent_option/toggle
	var_to_edit = "toggle_status"
	compact_listing = 0

/datum/persistent_option/select_person
	var_to_edit = "select_person"
	compact_listing = 0

/datum/persistent_option/select_list
	var_to_edit = "value_select"

/datum/persistent_option/value_list
	var_to_edit = "value_list"


//formating
/datum/persistent_option/number_value/get_formatted_value(fake_value)
	return ( value_is_money ? cash2text( get_value(fake_value) , FALSE, TRUE, TRUE ) : get_value(fake_value) )

/datum/persistent_option/select_person/get_formatted_value() // for use in UIs
	if(LAZYLEN(select_person))
		var/text_list = ""
		for(var/V in select_person)
			text_list += "- [select_person[V]] ([V])<br>"

		return text_list
	else
		return "None"

/datum/persistent_option/toggle/get_formatted_value(fake_value) // for use in UIs
	var/the_value = (!isnull(fake_value) ? fake_value : get_value())
	return (the_value ? "Yes" : "No")

/datum/persistent_option/value_list/get_formatted_value()
	var/text_list = ""
	for(var/V in value_list)
		text_list += "[V]<br>"

	return text_list

/datum/persistent_option/proc/show_value_updater(mob/user, var/the_new_value = null, custom_override = FALSE)
	if(make_referendum)
		if(get_linked_ballot())
			alert(user, "A referendum already exists for this option. Please withdraw it before proposing one again.")
			return FALSE

		var/response = alert(user, "Changing \"[name]\" requires a referendum. Please confirm if you want to make one take place.", "Referendum Confirmation", "I'm Aware", "Cancel")
		if(!response || response == "Cancel")
			return FALSE

	if(override_changes)
		custom_override = TRUE

	if(custom_override)
		the_new_value = custom_checks(user)
		if(isnull(the_new_value))
			return FALSE

	if(!custom_override)
		if(var_to_edit == "value_text") // updates a string text for text based values.
			var/new_text_value = value_text
			if(value_type == 0)

				new_text_value = sanitize(input(user,"[edit_text ? edit_text : "Please enter a new value for [name]."] ([max_value_text] chars max) [bbcode_value ? "(BBcode Enabled)" : ""]","[name]", html_decode(value_text)) as text, max_value_text, extra = 0)

			else
				new_text_value = sanitize(input(user,"[edit_text ? edit_text : "Please enter a new value for [name]."] ([max_value_text] chars max) [bbcode_value ? "(BBcode Enabled)" : ""]","[name]", html_decode(value_text)) as message|null, max_value_text, extra = 0)


			if(!new_text_value && !allow_blank)
				return FALSE

			the_new_value = new_text_value


		if(var_to_edit == "value") // updates the number for number based values
			var/new_value = input(usr, "[edit_text ? edit_text : "Please enter a new value for [name]."] (Min: [min_value]. Max: [max_value].)", "[name]", value) as num|null

			sanitize_integer(new_value, min_value, max_value, initial(value))
			the_new_value = Clamp(new_value, min_value, max_value)


		if(var_to_edit == "toggle_status") //updates the TRUE/FALSE or ON/OFF status
			var/new_toggle = input(user, "This setting is currently [toggle_status ? "Enabled." : "Disabled."] [edit_text ? edit_text : "Please choose from the following options."]", "[name]") as null|anything in list("Yes", "No", "Cancel")

			if(!new_toggle || new_toggle == "Cancel")
				return FALSE

			the_new_value = (new_toggle == "Yes") ? TRUE : FALSE
			sanitize_integer(the_new_value, FALSE, TRUE, initial(toggle_status))


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
				if(!LAZYLEN(value_list))
					alert("Nothing to remove!")
					return
				var/to_remove = input(user, "Which option would you like to remove?", "[name]") as null|anything in value_list

				if(!(to_remove in the_list))
					return FALSE

				the_new_value = (new_list - to_remove)


		if(var_to_edit == "value_select") // select a value from a list (sole option)
			if(!LAZYLEN(get_option_values()))
				return FALSE // shouldn't happen technically

			var/to_change = input(user, "Which option would you like to update \"[name]\" to?", "[name]") as null|anything in get_option_values()
			if(!to_change)
				return FALSE

			the_new_value = to_change


		if(var_to_edit == "select_person") // updates the name and unique ID into a list
			var/list/selected_person = list()

			var/person_list = list()

			for(var/datum/data/record/R in data_core.general)
				if(!R.fields["name"])
					continue
				person_list += R.fields["name"]

			if(!LAZYLEN(person_list))
				alert("No civilian records exist on the system to select from!")
				return

			var/person = input(usr, "Please select a person to add to this job's listings.", "Add People") as null|anything in person_list

			if(!person)
				return

			var/unique_id_empl = ""

			for(var/datum/data/record/C in data_core.general)
				if(C.fields["name"] == person)
					unique_id_empl = C.fields["unique_id"]

			selected_person[unique_id_empl] = person

			the_new_value = selected_person


	if(isnull(the_new_value))
		return FALSE

	if(the_new_value == get_value())
		alert("ERROR: Value is the same as current. No changes will be performed.")
		return

	if(!make_referendum)
		return perform_edit_outcome(the_new_value, user)

	else
		var/response = alert(user, "Would you like to submit the referendum for \"[name]\"?", "Final Referendum Confirmation", "Yes", "No")
		if(!response || response == "No")
			return FALSE

		if(get_linked_ballot())
			alert("Cannot create ballot: This ballot already appears on the system.")
			return FALSE


		return perform_edit_outcome(the_new_value, user)

/datum/persistent_option/proc/perform_edit_outcome(the_new_value, mob/user)
	if(!make_referendum)
		return SSpersistent_options.update_pesistent_option_value(id, the_new_value, user.real_name)
	else
		var/datum/voting_ballot/referendum/new_referendum = SSpersistent_options.make_new_option_ballot(id, the_new_value, null, "[name] Referendum", description, user.real_name, user.client.ckey, /datum/voting_ballot/referendum)
		if(new_referendum && creation_text)
			creation_text = replacetext(creation_text, "%NAME", name)
			creation_text = replacetext(creation_text, "%VALUE", get_formatted_value())
			creation_text = replacetext(creation_text, "%PROPOSEDVALUE", get_proposed_value_formatting())
			command_announcement.Announce(creation_text, "[name]")
			creation_text = initial(creation_text)
		else
			alert("There has been an issue with processing this referendum, please try again later or contact Nanotrasen technical support.")

		SSpersistent_options.make_log(id, author = user.real_name, custom_text = "Referendum raised by [user.real_name]. - [stationdate2text()] @ [stationtime2text()]")
		return new_referendum

/datum/persistent_option/proc/custom_checks()

	return TRUE

/datum/persistent_option/proc/edit_value(mob/user)
	if(show_value_updater(user))
		sanitize_options()

/datum/persistent_option/proc/add_value(new_value)
	if(!new_value)
		return
	value_list.Add(new_value)
	sanitize_options()

/datum/persistent_option/proc/toggle_status()
	toggle_status = !toggle_status