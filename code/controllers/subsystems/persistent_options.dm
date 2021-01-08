SUBSYSTEM_DEF(persistent_options)
	name = "Persistent Options"
	init_order = INIT_ORDER_PERSISTENT_OPTIONS
	flags = SS_NO_FIRE
	var/list/all_portal_options = list()
	var/list/all_generic_portal_options = list()
	var/list/all_president_portal_options = list()
	var/list/all_council_portal_options = list()

	var/list/all_voting_ballots = list()

/datum/controller/subsystem/persistent_options/Initialize(timeofday)
	for(var/instance in subtypesof(/datum/persistent_option))
		new instance()

	all_portal_options = GLOB.persistent_options
	all_generic_portal_options = GLOB.generic_portal_options
	all_president_portal_options = GLOB.president_portal_options
	all_council_portal_options = GLOB.council_portal_options

	. = ..()

/datum/controller/subsystem/persistent_options/proc/check_ballot_exists(id)
	if(all_voting_ballots[id])
		return all_voting_ballots[id]

	return FALSE

/datum/controller/subsystem/persistent_options/proc/get_persistent_option(id)
	return GLOB.persistent_options[id]

/datum/controller/subsystem/persistent_options/proc/get_persistent_option_value(id)
	var/datum/persistent_option/PO = get_persistent_option(id)
	if(!PO)
		return
	return PO.get_value()

/datum/controller/subsystem/persistent_options/proc/update_pesistent_option_value(id, new_value)
	var/datum/persistent_option/PO = get_persistent_option(id)
	if(!PO)
		return

	PO.vars[PO.var_to_edit] = new_value

	return PO.vars[PO.var_to_edit]




/datum/controller/subsystem/persistent_options/proc/make_new_option_ballot(option_id, proposed_change, list/custom_options, new_title, new_desc, new_author, new_ballot_type = /datum/voting_ballot/referendum)
	var/datum/persistent_option/ps_option = SSpersistent_options.get_persistent_option(option_id)

	if(!ps_option)
		return FALSE

	var/datum/voting_ballot/new_referendum = new new_ballot_type()

	new_referendum.id = option_id

	new_referendum.persistent_option_id = option_id

	if(new_title)
		new_referendum.name = new_title

	if(new_author)
		new_referendum.author = new_author

	if(new_desc)
		new_referendum.desc = new_desc

	if(custom_options)
		new_referendum.options = custom_options

	if(proposed_change)
		new_referendum.new_change = proposed_change


	new_referendum.creation_date = full_real_time()


	new_referendum.sanitize_ballot()

	return new_referendum

/datum/controller/subsystem/persistent_options/proc/find_proposed_value_ballot(the_id)
	var/datum/voting_ballot/B = check_ballot_exists(the_id)

	if(!B)
		return

	return B.new_change