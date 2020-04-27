//
// Handles the internet and websites.
//



SUBSYSTEM_DEF(websites)
	name = "Website"
	init_order = INIT_ORDER_WEBSITES
	flags = SS_NO_FIRE
	var/list/all_websites = list()	// for debugging


/datum/controller/subsystem/websites/Initialize(timeofday)
	instantiate_websites()
	all_websites = GLOB.websites

	return ..()

/datum/controller/subsystem/websites/proc/instantiate_websites()	// load preset websites
	for(var/instance in subtypesof(/datum/website))
		new instance


/datum/controller/subsystem/websites/proc/get_error_page()
	var/target = locate(/datum/website/browser/error) in GLOB.websites
	return target

/datum/controller/subsystem/websites/proc/get_denied_page()
	var/target = locate(/datum/website/browser/denied) in GLOB.websites
	return target