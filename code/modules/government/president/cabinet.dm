/datum/persistent_option/select_person/cabinet
	description = "You can select people for your cabinet positions."
	portal_category = "Assign Cabinet"

	var_to_edit = "select_person"
	max_list_items = 1
	portal_grouping = "Government"

/datum/persistent_option/select_person/cabinet/ceo
	name = "Nanotrasen CEO"
	id = "cabinet_ceo"

	required_access_edit = access_ceo

/datum/persistent_option/select_person/cabinet/govrep
	name = "Government Representative"
	id = "cabinet_govrep"

	required_access_edit = access_ceo

/datum/persistent_option/select_person/cabinet/president
	name = "President"
	id = "cabinet_president"

	required_access_edit = access_ceo

/datum/persistent_option/select_person/cabinet/vice
	name = "Vice President"
	id = "cabinet_vice"

/datum/persistent_option/select_person/cabinet/governor
	name = "Governor"
	id = "cabinet_governor"

/datum/persistent_option/select_person/cabinet/supreme_justice
	name = "Supreme Justice"
	id = "cabinet_supremejustice"

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