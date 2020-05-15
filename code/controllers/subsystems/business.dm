//
// Handles business related things.
//

SUBSYSTEM_DEF(business)
	name = "Business"
	init_order = INIT_ORDER_BUSINESS
	flags = SS_NO_FIRE
	var/list/businesses = list()

/datum/controller/subsystem/business/Initialize(timeofday)
	businesses = GLOB.all_businesses

	. = ..()