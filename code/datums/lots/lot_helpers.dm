// Check procs

/datum/lot/proc/has_landlord()
	if(tenant_uid)
		return TRUE

/datum/lot/proc/has_tenant()
	if(landlord_uid)
		return TRUE

// Action procs