/datum/persistent_option/value/president
	var_to_edit = "value_text"
	bbcode_value = TRUE
	value_type = 1
	portal_category = "Broadcast and Communications"
	portal_grouping = "Communications"
	max_value_text = 1500


/datum/persistent_option/value/president/presidential_broadcast
	name = "Presidential Broadcast"
	description = "You can set a general presidential message that will be shown to all citizens."
	id = "president_msg"

	value_text = "Greetings citizens, we hope you have a safe and productive day."


/datum/persistent_option/value/president/presidential_broadcast/on_option_change(newvalue, skip)
	command_announcement.Announce(newvalue, "[name]")
	return TRUE