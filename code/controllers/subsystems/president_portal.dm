SUBSYSTEM_DEF(president_portal)
	name = "President Portal"
	init_order = INIT_ORDER_PRESIDENT_PORTAL
	flags = SS_NO_FIRE
	var/list/portal_options = list()

/datum/controller/subsystem/president_portal/Initialize(timeofday)
	for(var/instance in subtypesof(/datum/portal_option))
		var/datum/portal_option/P = new instance()
		if(P.id && P.name)
			GLOB.president_portal_options[P.id] = P
		else
			qdel(P)


		portal_options = GLOB.president_portal_options
	. = ..()


