//
// Handles current president set laws, contraband and other player-persistent data relating to the colon.
//



SUBSYSTEM_DEF(law)
	name = "Law"
	init_order = INIT_ORDER_LAW
	flags = SS_NO_FIRE
	var/list/laws = list()
	var/list/all_warrants = list()

/datum/controller/subsystem/law/Initialize(timeofday)
	instantiate_laws()
	load_warrants()

	return ..()

/datum/controller/subsystem/law/proc/instantiate_laws()
	//This proc loads all laws, if they don't exist already.

	for(var/instance in subtypesof(/datum/law) - list(/datum/law/misdemeanor, /datum/law/major, /datum/law/criminal, /datum/law/capital))
		var/datum/law/I = new instance
		presidential_laws += I

	for(var/datum/law/misdemeanor/M in presidential_laws)
		misdemeanor_laws += M

	for(var/datum/law/criminal/C in presidential_laws)
		criminal_laws += C

	for(var/datum/law/major/P in presidential_laws)
		major_laws += P

	for(var/datum/law/capital/K in presidential_laws)
		capital_laws += K

	rebuild_law_ids()

	laws = presidential_laws

/datum/controller/subsystem/law/proc/rebuild_law_ids() //rebuilds entire law list IDs.

	var/n //misdemeanor number
	var/d //criminal number
	var/o //major number
	var/x //capital number

	for(var/datum/law/misdemeanor/M in presidential_laws)
		n += 1
		if(n < 10)
			M.id = "i[M.prefix]0[n]"
		else
			M.id = "i[M.prefix][n]"


	for(var/datum/law/criminal/C in presidential_laws)
		d += 1
		if(d < 10)
			C.id = "i[C.prefix]0[d]"
		else
			C.id = "i[C.prefix][d]"

	for(var/datum/law/major/P in presidential_laws)
		o += 1
		if(o < 10)
			P.id = "i[P.prefix]0[o]"
		else
			P.id = "i[P.prefix][o]"

	for(var/datum/law/capital/K in presidential_laws)
		x += 1
		if(x < 10)
			K.id = "i[K.prefix]0[x]"
		else
			K.id = "i[K.prefix][x]"


/datum/controller/subsystem/law/proc/save_warrants()
	var/list/warrant_list = list()

	for(var/datum/data/record/warrant/W in data_core.warrants)
		warrant_list += W

	truncate_oldest(warrant_list, MAX_WARRANTS)

	var/path = "data/persistent/law/warrants.sav"

	var/savefile/S = new /savefile(path)
	if(!fexists(path))
		return 0
	if(!S)
		return 0
	S.cd = "/"

	S << warrant_list

	return TRUE

/datum/controller/subsystem/law/proc/load_warrants()
	var/path = "data/persistent/law/warrants.sav"

	var/savefile/S = new /savefile(path)
	if(!fexists(path))
		save_warrants()
		return 0
	if(!S)
		return 0
	S.cd = "/"

	S >> data_core.warrants

	if(!data_core.warrants)
		data_core.warrants = list()

	all_warrants = data_core.warrants

	truncate_oldest(data_core.warrants, MAX_WARRANTS)

	return TRUE