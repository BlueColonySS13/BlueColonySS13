
var/global/list/paperwork_categories = list(PAPERWORK_MISC, PAPERWORK_POLICE, PAPERWORK_COUNCIL, PAPERWORK_LEGAL, PAPERWORK_SCIENCE, \
PAPERWORK_BUSINESS, PAPERWORK_MEDICAL, PAPERWORK_GOVERNMENT)

var/global/list/all_paperwork = list()

// Check _paperwork_defines.dm for preset paperwork

/datum/paperwork_template
	var/name = "Blank Document"
	var/list/categories = PAPERWORK_MISC

	var/title = "Blank Document" // title that will be the paper's name
	var/content = "This is a blank template." // This will be the paper's contents.

	var/icon					// icon - if left blank, will revert to the paper's default icon
	var/custom_icon_state		// icon_state of the paper will be set to this unless left blank

	var/file_source	// if this is set to a path, the game will ignore the var/content and pull from the txt file instead.

/datum/paperwork_template/New()
	..()
	all_paperwork += src

/datum/paperwork_template/proc/get_content()
	if(file_source)
		var/new_content = file2text("[file_source]")
		new_content = replacetext(new_content, "\n", "\[BR\]")
		return new_content

	return content

/proc/get_paperwork_by_cat(CAT)
	var/paperwork = list()
	for(var/datum/paperwork_template/pt in all_paperwork)
		if(CAT in pt.categories)
			paperwork += pt

	return paperwork

/proc/get_paperwork_by_name(name)
	for(var/datum/paperwork_template/P in all_paperwork)
		if(P.name == name)
			return P

/proc/get_paperwork_access(var/datum/paperwork_template/PW, var/obj/item/weapon/card/id/I)
	var/list/req_access = list()

	if(PAPERWORK_POLICE in PW.categories)
		req_access += access_security
	if(PAPERWORK_COUNCIL in PW.categories)
		req_access += access_heads
	if(PAPERWORK_LEGAL in PW.categories)
		req_access += access_legal
	if(PAPERWORK_SCIENCE in PW.categories)
		req_access += access_research
	if(PAPERWORK_MEDICAL in PW.categories)
		req_access += access_medical
	if(PAPERWORK_GOVERNMENT in PW.categories)
		req_access += access_cent_general

	if(I)
		for(var/A in req_access)
			if(A in I.access)
				return TRUE

	if(isemptylist(req_access))
		return TRUE

	return FALSE


/proc/initialize_paperwork()
	for(var/instance in subtypesof(/datum/paperwork_template))
		new instance