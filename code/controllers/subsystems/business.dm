//
// Handles business related things.
//

SUBSYSTEM_DEF(business)
	name = "Business"
	init_order = INIT_ORDER_BUSINESS
	flags = SS_NO_FIRE
	var/list/businesses = list()
	var/list/business_access_list = list()

/datum/controller/subsystem/business/Initialize(timeofday)
	load_all_businesses()

	businesses = GLOB.all_businesses
	business_access_list = GLOB.all_business_accesses


	. = ..()