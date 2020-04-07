/datum/property_service
	var/name = "Untitled property service"
	var/desc = "You shouldn't be seeing this."

	var/id

	var/cost = 200

	var/active = TRUE
	var/datum/lot/associated_lot

/datum/property_service/proc/do_effect()
	return

/proc/get_all_lot_services()	// gets paths of all services
	var/list/service_list = list()
	for(var/E in subtypesof(/datum/property_service))
		service_list += E

	return service_list
