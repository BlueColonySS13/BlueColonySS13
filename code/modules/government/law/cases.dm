var/global/court_cases = list()

/datum/court_case
	var/name = "Unnamed Case"
	var/UID												// The unique identifier for this incident
	var/game_id_created										// The game-id this was created in. This should be obvious from the case id but w/e

	var/description

	var/list/evidence_recordings = list()						// Takes tape recorders for recordings. These are tapes.
	var/list/case_logs = list()								// Court logs for this particular case.
	var/list/case_notes	= list()								// List of notes left by people who commented on crap.
	var/list/case_evidence = list()							// Case evidence

	var/list/admin_case_logs = list()							// OOC log of ckeys and "who dids" and stuff.



	var/charges = list()									// Charges by name, if any.
	var/charges_applied = list()								// Charges Applied after court is concluded. Shows up as "none" if unsuccessful

	var/case_type = CRIMINAL_CASE
	var/case_outcome = CASE_ONGOING
	var/case_status = CASE_STATUS_ACTIVE
	var/case_visibility = CASE_PUBLIC
	var/case_rep_status = CASE_REPRESENTATION_NEEDED

	var/author = "Unknown"									// Who originally opened this case?
	var/desired_outcome = ""							// Desired outcome of the case


	// People involved / Litigants
	var/list/witnesses = list()
	var/list/defendant = list("name" = "", "unique_id" = "")				// Needs a CID, always.
	var/list/plaintiff = list("name" = "", "unique_id" = "")				// Needs a CID, always
	var/list/involved_parties = list()

	//Lawyer stuff
	var/representative = list("name" = "", "unique_id" = "")

	var/lawyer_offers = list()

	var/creation_date										// What day this case was opened.
	var/court_date											// Day of the next trial, if any.
	var/expiry_date										// The date that this case starts to smell/gets expired.

/datum/court_case/New()
	..()
	if(!UID)
		UID = "[game_id]-[rand(111, 999)]"

	if(!game_id_created)
		game_id_created = game_id

	if(!creation_date)
		creation_date = full_game_time()

	court_cases += src

	expiry_date = AddDays(creation_date, 7)

/datum/court_case/proc/is_lawyer(obj/item/weapon/card/id/I)
	if(!I || !I.registered_name || !I.unique_ID)
		return FALSE

	if((representative["name"] == I.registered_name) && (representative["unique_id"] == I.unique_ID))
		return TRUE

	return FALSE

/datum/court_case/proc/is_plaintiff(obj/item/weapon/card/id/I)
	if(!I || !I.registered_name || !I.unique_ID)
		return FALSE

	if((plaintiff["name"] == I.registered_name) && (plaintiff["unique_id"] == I.unique_ID))
		return TRUE

	return FALSE

/datum/court_case/proc/is_defendant(obj/item/weapon/card/id/I)
	if(!I || !I.registered_name || !I.unique_ID)
		return FALSE

	if((defendant["name"] == I.registered_name) && (defendant["unique_id"] == I.unique_ID))
		return TRUE

	return FALSE

/datum/case_evidence
	var/UID 												// The unique identifier for this incident
	var/name												// name of the item scanned
	var/description										// description copied from the actual item
	var/comments
	var/icon												// actual photo taken of the evidence.
	var/icon_state
	var/object_type										// the obj type
	var/list/fingerprints = list()							// fingerprints of the evidence
	var/list/fingerprints_hidden = list()						// same thing, but admin side
	var/fingerprints_last
	var/list/suit_fibers = list()

	var/blood_color
	var/list/blood_DNA = list()
	var/was_bloodied = FALSE

	var/game_id_created										// The game-id this was created in. This should be obvious from the case id but w/e
	var/date_added
	var/added_by = list("name" = "", "unique_id" = "")

	var/icon/photo											// photos only

	var/paper_content

/datum/case_evidence/New()
	..()
	if(!UID)
		UID = "[game_id]-[rand(111, 999)]"
	if(!game_id_created)
		game_id_created = game_id
	if(!date_added)
		date_added = full_game_time()


/datum/case_evidence/proc/obj_record(var/obj/O, name, uid)
	if(!O)
		return

	name = O.name
	description = O.desc
	icon = O.icon
	icon_state = O.icon_state
	object_type = O.type
	fingerprints = O.fingerprints
	fingerprints_hidden = O.fingerprintshidden
	fingerprints_last = O.fingerprintslast
	suit_fibers = O.suit_fibers

	blood_color = O.blood_color
	blood_DNA = O.blood_DNA
	was_bloodied = O.was_bloodied

	added_by = list("name" = name, "unique_id" = uid)
	if(istype(O, /obj/item/weapon/photo))
		var/obj/item/weapon/photo/foto = O
		photo = foto.img


	if(istype(O, /obj/item/weapon/paper))
		var/obj/item/weapon/paper/sheet = O
		paper_content = sheet.info


	if(istype(O, /obj/item/weapon/forensics/swab))
		var/obj/item/weapon/forensics/swab/swabs = O
		description += "<br><b>Found on Swab:<b>"

		if(swabs.gsr)
			description += "Residue from a [swabs.gsr] bullet detected."
		else
			description += "No gunpowder residue found."


	if(istype(O, /obj/item/weapon/sample/fibers))
		var/obj/item/weapon/sample/fibers/fibre = O
		description += "<br><p>Fibers Collected:<p>"
		for(var/fiber in fibre.evidence)
			description += "<li>[fiber]</li>"


	if(istype(O, /obj/item/weapon/sample/print))
		var/obj/item/weapon/sample/print/prints = O
		description += "<br><p>Fibers Collected:<p>"
		for(var/print in prints.evidence)
			description += "<li>[print]</li>"


	return 1

/proc/all_public_cases()
	var/all_cases
	all_cases += get_public_open_cases()
	all_cases += get_public_archived_cases()
	return all_cases

/proc/get_public_open_cases()
	var/list/court_case_list = list()
	for(var/datum/court_case/C in court_cases)
		if(C.case_status == CASE_STATUS_ACTIVE && C.case_visibility == CASE_PUBLIC)
			court_case_list += C

	return court_case_list

/proc/get_public_archived_cases()
	var/list/court_case_list = list()
	for(var/datum/court_case/C in court_cases)
		if(C.case_status == CASE_STATUS_ARCHIVED && C.case_visibility == CASE_PUBLIC)
			court_case_list += C

	return court_case_list


/proc/find_case_by_char_uid(UID)
	var/list/court_case_list = list()


	for(var/datum/court_case/C in all_public_cases() )

		if(C.defendant["unique_id"] == UID)
			court_case_list += C

		if(C.plaintiff["unique_id"] == UID)
			court_case_list += C

	return court_case_list


/proc/find_case_by_UID(UID)
	for(var/datum/court_case/C in all_public_cases() )
		if(C.UID == UID)
			return C



/proc/cases_need_lawyer()
	var/list/court_case_list = list()
	for(var/datum/court_case/C in all_public_cases() )
		if(C.case_rep_status == CASE_REPRESENTATION_NEEDED)
			court_case_list += C

	return court_case_list