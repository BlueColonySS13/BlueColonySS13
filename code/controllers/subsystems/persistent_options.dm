SUBSYSTEM_DEF(persistent_options)
	name = "Persistent Options"
	init_order = INIT_ORDER_PERSISTENT_OPTIONS
	flags = SS_NO_FIRE
	var/list/all_portal_options = list()
	var/list/all_voting_ballots = list()

	wait = 1200 //Ticks once per 2 minutes
	var/referendum_interval = 1 HOUR
	var/next_referendum_check = 1 HOUR

/datum/controller/subsystem/persistent_options/Initialize(timeofday)
	for(var/instance in subtypesof(/datum/persistent_option))
		new instance()

	all_portal_options = GLOB.persistent_options

	all_voting_ballots = GLOB.all_voting_ballots

	load_all_options()
	load_ballots()

	. = ..()

/datum/controller/subsystem/persistent_options/proc/save_all_options()
	for(var/datum/persistent_option/PO in get_persistent_options())
		PO.save_option()
	return TRUE

/datum/controller/subsystem/persistent_options/proc/load_all_options()
	for(var/datum/persistent_option/PO in get_persistent_options())
		PO.load_option()

/datum/controller/subsystem/persistent_options/fire()
	if (world.time >= next_referendum_check)
		next_referendum_check = world.time + referendum_interval
		check_all_ballots()


/datum/controller/subsystem/persistent_options/proc/check_all_ballots()
	for(var/datum/voting_ballot/VB in get_ballots(active_only = TRUE))
		VB.sanitize_ballot()


/datum/controller/subsystem/persistent_options/proc/check_ballot_exists(id)
	if(all_voting_ballots[id])
		return all_voting_ballots[id]

	return FALSE

/datum/controller/subsystem/persistent_options/proc/get_persistent_option(id)
	return GLOB.persistent_options[id]

/datum/controller/subsystem/persistent_options/proc/get_persistent_option_name(id)
	var/datum/persistent_option/PO = get_persistent_option(id)
	if(!PO)
		return

	return PO.name

/datum/controller/subsystem/persistent_options/proc/get_persistent_option_value(id)
	var/datum/persistent_option/PO = get_persistent_option(id)
	if(!PO)
		return
	return PO.get_value()

/datum/controller/subsystem/persistent_options/proc/get_persistent_formatted_value(id)
	var/datum/persistent_option/PO = get_persistent_option(id)
	if(!PO)
		return
	return PO.get_formatted_value()


/datum/controller/subsystem/persistent_options/proc/update_pesistent_option_value(id, new_value, author, skip = FALSE)
	var/datum/persistent_option/PO = get_persistent_option(id)
	if(!PO)
		return

	PO.on_option_change(new_value, skip)

	PO.vars[PO.var_to_edit] = new_value

	var/change = new_value
	if(!istext(change) && !isnum(change))
		change = null

	make_log(PO.id, change, author)

	return PO.vars[PO.var_to_edit]


/datum/controller/subsystem/persistent_options/proc/make_new_option_ballot(option_id, proposed_change = null, list/custom_options, new_title, new_desc, new_author, new_author_ckey, new_ballot_type = /datum/voting_ballot/referendum)
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

	if(new_author_ckey)
		new_referendum.author_ckey = new_author_ckey

	if(new_desc)
		new_referendum.desc = new_desc

	if(custom_options)
		new_referendum.options = custom_options

	new_referendum.new_change = proposed_change

	new_referendum.creation_date = full_game_time()

	new_referendum.active = TRUE

	new_referendum.sanitize_ballot()
	ps_option.sanitize_options()

	return new_referendum

/datum/controller/subsystem/persistent_options/proc/find_proposed_value_ballot(the_id)
	var/datum/voting_ballot/B = check_ballot_exists(the_id)

	if(!B)
		return

	return B.new_change

/datum/controller/subsystem/persistent_options/proc/get_persistent_options(wanted_cat, list/access_list)
	var/list/wanted_options = list()
	for(var/P in GLOB.persistent_options)
		var/datum/persistent_option/ps_option = all_portal_options[P]
		if(!ps_option)
			continue
		if(wanted_cat && !(ps_option.portal_category == wanted_cat))
			continue
		if(ps_option.required_access_view && !(ps_option.required_access_view in access_list))
			continue
		wanted_options += ps_option

	return wanted_options

/datum/controller/subsystem/persistent_options/proc/get_ballots(active_only = FALSE)
	var/list/fetched_ballots = list()
	for(var/B in all_voting_ballots)
		var/datum/voting_ballot/VB = all_voting_ballots[B]
		if(!VB)
			continue

		if(active_only && !VB.get_status())
			continue

		fetched_ballots += VB

	return fetched_ballots


/datum/controller/subsystem/persistent_options/proc/make_log(option_id, changed = "Update", author = "Unknown", custom_text = "", override_log_check = FALSE)
	var/datum/persistent_option/ps_option = SSpersistent_options.get_persistent_option(option_id)

	if(!ps_option || (!override_log_check && !ps_option.create_log))
		return

	var/datum/persistent_option/log_option = SSpersistent_options.get_persistent_option(ps_option.log_id)

	if(!log_option)
		return

	var/new_log_text = "<b>[ps_option.name]</b>:"

	if(custom_text)
		new_log_text += " [custom_text]"
	else
		if(length(changed) > 100)
			new_log_text += "Updated by [author]. Updated - [stationdate2text()] @ [stationtime2text()]."
		else
			new_log_text += "Updated by [author].[changed ? " Change: [changed]" : ""] - [stationdate2text()] @ [stationtime2text()]."

	log_option.add_value(new_log_text)



