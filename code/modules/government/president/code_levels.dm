
/datum/persistent_option/value/code_level
	var_to_edit = "value_text"
	bbcode_value = TRUE
	value_type = 1
	portal_category = "Emergency Procedures"
	portal_grouping = "Communications"
	max_value_text = 1000
	bbcode_value = TRUE

	creation_text = "A new ballot for \"%NAME\" has been raised! \
	Please go to your local ballot box to cast your votes. Your voice matters!"

	on_ballot_pass = "The ballot for %NAME has passed! The changes will take place immediately."


/datum/persistent_option/value/code_level/code_green
	name = "Code Green Announcement Text"
	description = "You can set the message that displays the code green procedure."
	id = "code_green"
	value_text = "All threats to the city have passed. Police Officials may not have weapons visible, privacy laws are once again fully enforced."

/datum/persistent_option/value/code_level/code_blue
	name = "Code Blue Announcement Text"
	description = "This is the message that displays when code blue is escalated from code green."
	id = "code_blue"
	value_text = "The city has received reliable information about possible hostile activity in the city. \
	Police Officials may have weapons visible, random searches are permitted."

/datum/persistent_option/value/code_level/code_blue/down
	name = "Code Blue De-escalation Announcement Text"
	description = "When you de-escalate from code blue to code red, this message is shown."
	id = "code_blue_down"
	value_text = "The immediate threat has passed. Police may no longer have weapons drawn at all times, \
	but may continue to have them visible. Random searches are still allowed."

/datum/persistent_option/value/code_level/code_red
	name = "Code Red Announcement Text"
	description = "This is the message that shows when code red is escalated from code blue."
	id = "code_red"
	value_text = "There is an immediate serious threat to the city. Police may have weapons unholstered at all times. \
	Random searches are allowed and advised."

/datum/persistent_option/value/code_level/code_red/down
	name = "Code Red De-escalation Announcement Text"
	description = "This is the message that shows when you de-escalate code red down from delta."
	id = "code_red_down"
	value_text = "The self-destruct mechanism has been deactivated, there is still however an immediate serious threat to the city. \
	Police may have weapons unholstered at all times, random searches are allowed and advised."

/datum/persistent_option/value/code_level/code_delta
	name = "Code Delta Announcement Text"
	description = "This message is shown when the city enters delta, also known as martial law. This is used in a state of dire emergency, use it wisely."
	id = "code_delta"
	value_text = "The city is now under martial law. All citizens are instructed to obey all instructions given by city officials, \
	following chain of command. Any violations of these orders can be punished by death. This is not a drill."


