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
	set_security_level(num2seclevel(newvalue))
	..()


/datum/persistent_option/value_list/national_security
	portal_category = "National Security"
	portal_grouping = "Law and Order"
	max_list_items = 20

	required_access_edit = access_president
	required_access_view = access_security


/datum/persistent_option/value_list/national_security/terror_list
	name = "Terrorist Groups List"
	description = "List of organisations and groups that are officially recognised by the government as a terror group."
	id = "sec_terror_list"


/datum/persistent_option/value_list/national_security/watchlist
	name = "Official Watchlist"
	description = "List of people who are on the official watchlist by government."
	id = "sec_watchlist"
