
/datum/persistent_option/value_list/national_security
	portal_category = "National Security"
	portal_grouping = "Law and Order"
	max_list_items = 20
	compact_listing = 0
	required_access_edit = access_president
	required_access_view = access_security

/datum/persistent_option/number_value/national_security/security_level
	name = "Security Level"
	description = "The current security level of the colony."
	id = "security_level"
	min_value = 0
	max_value = 3
	value = 0

	portal_category = "National Security"
	portal_grouping = "Law and Order"


/datum/persistent_option/number_value/national_security/on_option_change(newvalue, skip)
	set_security_level(num2seclevel(newvalue), change_persistent_option = FALSE)
	return TRUE

/datum/persistent_option/number_value/national_security/get_formatted_value(fake_value)
	var/the_value = get_value()
	if(fake_value)
		the_value = fake_value
	return num2seclevel(the_value)

/datum/persistent_option/value_list/national_security
	max_list_items = 10

/datum/persistent_option/value_list/national_security/terror_list
	name = "Terrorist Groups List"
	description = "List of organisations and groups that are officially recognised by the government as a terror group."
	id = "sec_terror_list"

/datum/persistent_option/value_list/national_security/watchlist
	name = "Official Watchlist"
	description = "List of people who are on the official watchlist by government."
	id = "sec_watchlist"

/datum/persistent_option/value_list/national_security/sec_company
	name = "Approved Security Companies"
	description = "List of security companies that approved for presidential watch, or are licensed by the government to operate in the public sector."
	id = "sec_seccompany"

/datum/persistent_option/value_list/national_security/sec_medical
	name = "Approved Medical Companies"
	description = "List of medical companies that approved for presidential use, or are licensed by the government to operate in the public sector."
	id = "sec_medical"

/datum/persistent_option/value_list/national_security/sec_engineering
	name = "Approved Engineering Companies"
	description = "List of engineering and construction companies that approved to work on public buildings."
	id = "sec_engineer"