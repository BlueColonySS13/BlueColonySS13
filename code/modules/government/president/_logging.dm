/datum/persistent_option/value_list/logging
	max_list_items = 50
	create_log = FALSE

	portal_category = "Logging"
	portal_grouping = "Records"

	required_access_edit = access_ceo
	required_access_view = access_ceo

	compact_listing = FALSE

	log_id = "nanotrasen_logging"

/datum/persistent_option/value_list/logging/get_formatted_value()
	var/text_list = ""
	for(var/V in value_list)
		text_list += "[V]<br>"

	return text_list

/datum/persistent_option/value_list/logging/president
	name = "President Logging"
	description = "A log of all presidential actions."

	id = "president_logging"
	required_access_view = null

/datum/persistent_option/value_list/logging/nanotrasen
	name = "Nanotrasen Logging"
	description = "A log of all nanotrasen actions."

	id = "nanotrasen_logging"