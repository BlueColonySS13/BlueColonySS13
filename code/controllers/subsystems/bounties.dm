SUBSYSTEM_DEF(bounties)
	name = "Bounties"
	init_order = INIT_ORDER_BOUNTIES

	var/list/bounty_types = list()
	var/list/active_bounties = list()

	var/bounty_interval = 1 HOUR
	var/next_bounties = 1 HOUR


/datum/controller/subsystem/bounties/Initialize(timeofday)
	initialize_bounties()

	// get some new round start bounties.
	distribute_bounties()

	return ..()


/datum/controller/subsystem/bounties/fire()
	if (world.time >= next_bounties)
		next_bounties = world.time + bounty_interval

		distribute_bounties()
		check_bounties()

/datum/controller/subsystem/bounties/proc/check_bounties()
	for(var/datum/bounty/B in active_bounties)
		if(!B.expiry_days())
			B.expire_bounty()

	return TRUE


/datum/controller/subsystem/bounties/proc/distribute_bounties()
	for(var/datum/department/D in GLOB.departments)
		if(config.allow_business_bounties && D.get_business())
			continue

		assign_new_bounty(D)

	return TRUE

/datum/controller/subsystem/bounties/proc/initialize_bounties()
	for(var/instance in subtypesof(/datum/bounty))
		var/datum/bounty/B = new instance(add_active_bounty_list = FALSE)
		if(B.category && B.name)
			bounty_types |= B
		else
			qdel(B)

/datum/controller/subsystem/bounties/proc/find_bounties_by_cats(cat) // picks a random bounty from categories. returns false if none
	var/all_cats = list()
	if(!islist(cat))
		all_cats += cat
	else
		all_cats = cat

	var/list/compatible_bounties = list()
	for(var/datum/bounty/V in bounty_types)
		if(V.category in all_cats)
			compatible_bounties += V

	return compatible_bounties

/datum/controller/subsystem/bounties/proc/add_bounty(bounty_type, var/datum/department/D)
	if(!ispath(bounty_type) || !D)
		return

	var/datum/bounty/B = new bounty_type

	D.bounties += B
	B.source_department = D.id

	return TRUE


/datum/controller/subsystem/bounties/proc/assign_new_bounty(var/datum/department/D)
	if(!D || !D.has_bank)
		return FALSE

	if(!D.allow_bounties)
		return FALSE

	if(LAZYLEN(D.bounties) >= D.max_bounties)
		return FALSE

	var/list/cats = D.get_categories()

	if(!LAZYLEN(cats))
		return FALSE

	var/list/potential_bounties = find_bounties_by_cats(cats)

	for(var/datum/bounty/B in potential_bounties) // unique bounties only
		if(B.type in get_bounty_types(D))
			potential_bounties -= B

	if(!LAZYLEN(potential_bounties))
		return FALSE

	var/datum/bounty/new_bounty = pick(potential_bounties)
	add_bounty(new_bounty.type, D)

	return TRUE



/datum/controller/subsystem/bounties/proc/get_bounty_types(var/datum/department/D)
	if(!D)
		return

	var/list/all_bounties_types = list()
	for(var/datum/bounty/B in D.bounties)
		all_bounties_types += B.type


	return all_bounties_types


