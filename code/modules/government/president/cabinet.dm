/datum/persistent_option/select_person/cabinet
	description = "You can select people for your cabinet positions."
	portal_category = "Assign Cabinet"

	var_to_edit = "select_person"
	max_list_items = 1

/datum/persistent_option/select_person/cabinet/president
	name = "President"
	id = "cabinet_president"

	portal_grouping = PORTAL_HEAD_OFFICE

/datum/persistent_option/select_person/cabinet/vice
	name = "Vice President"
	id = "cabinet_vice"

/datum/persistent_option/select_person/cabinet/defense
	name = "Advisor of Defense"
	id = "cabinet_defense"

/datum/persistent_option/select_person/cabinet/justice
	name = "Advisor of Justice"
	id = "cabinet_justice"

/datum/persistent_option/select_person/cabinet/innovation
	name = "Advisor of Innovation"
	id = "cabinet_innovation"

/datum/persistent_option/select_person/cabinet/health
	name = "Advisor of Health"
	id = "cabinet_health"

/datum/persistent_option/select_person/cabinet/finance
	name = "Advisor of Finance"
	id = "cabinet_finance"