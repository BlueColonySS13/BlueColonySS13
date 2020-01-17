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
	var/desired_outcome = list()							// Desired outcome of the case


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


/datum/case_evidence
	var/UID 												// The unique identifier for this incident
	var/name												// name of the item scanned
	var/description										// description copied from the actual item
	var/icon												// actual photo taken of the evidence.
	var/icon_state
	var/list/fingerprints									// fingerprints of the evidence
	var/list/fingerprints_hidden								// same thing, but admin side
	var/game_id_created										// The game-id this was created in. This should be obvious from the case id but w/e

/datum/case_evidence/New()
	..()
	if(!UID)
		UID = "[game_id]-[rand(111, 999)]"
	if(!game_id_created)
		game_id_created = game_id



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
	for(var/datum/court_case/C in (get_public_open_cases() || get_public_archived_cases()))

		if(C.defendant["unique_id"] == UID)
			court_case_list += C

		if(C.plaintiff["unique_id"] == UID)
			court_case_list += C

	return court_case_list


/proc/find_case_by_UID(UID)
	for(var/datum/court_case/C in (get_public_open_cases() || get_public_archived_cases()))
		if(C.UID == UID)
			return C



/proc/cases_need_lawyer()
	var/list/court_case_list = list()
	for(var/datum/court_case/C in (get_public_open_cases() || get_public_archived_cases()) )
		if(C.case_rep_status == CASE_REPRESENTATION_NEEDED)
			court_case_list += C

	return court_case_list