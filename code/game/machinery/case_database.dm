/obj/machinery/case_database
	name = "Case Database Machine"
	desc = "A large database of legal cases can be accessed through this computer."
	unacidable = 1
	light_range = 4
	light_power = 2
	light_color = "#ebf7fe"  //white blue
	density = 1
	anchored = 1
	bounds = "64,32"
	pixel_y = 25
	pixel_x = -15		// it's intended to be centered into the courtroom
	plane = ABOVE_PLANE
	layer = ABOVE_MOB_LAYER

	icon = 'icons/obj/large_machinery.dmi'
	icon_state = "case_computer"

	var/page = 1
	var/search_type = "All"
	var/search_query

	// Types: "Archived", "Own", "ID", "Search", otherwise it will search all CASES

	var/datum/court_case/current_case
	var/datum/case_evidence/current_evidence
	var/obj/item/device/tape/current_recording
	var/obj/item/weapon/card/id/user_id

	var/judge_access = FALSE
	var/judical_access = FALSE
	var/police_access = FALSE
	var/prosecutor_access = FALSE
	var/defendant_access = FALSE
	var/plaintiff_access = FALSE
	var/rep_access = FALSE
	var/nt_access = FALSE
	var/high_court_access = FALSE

	var/evidence_access = FALSE

	var/obj/item/device/taperecorder/empty/tape_player


	//case creation

	var/case_desc
	var/case_type

	var/busy = FALSE

/obj/machinery/case_database/initialize()
	..()
	if(!tape_player)
		tape_player = new /obj/item/device/taperecorder/empty(src)

/obj/machinery/case_database/proc/check_for_id(mob/user)
	var/obj/item/weapon/card/id/I = user.GetIdCard()

	if(!I)
		user_id = null
		return FALSE

	user_id = I

	return TRUE

/obj/machinery/case_database/proc/check_for_access(mob/user)
	if(access_lawyer in user_id.access)
		judical_access = TRUE
	if(access_prosecutor in user_id.access)
		prosecutor_access = TRUE
	if(access_judge in user_id.access)
		judge_access = TRUE
	if(access_sec_doors in user_id.access)
		police_access = TRUE

	if(current_case)
		if(user_id.unique_ID == current_case.defendant["unique_id"])
			defendant_access = TRUE
		if(user_id.unique_ID == current_case.plaintiff["unique_id"])
			plaintiff_access = TRUE
		if(user_id.unique_ID == current_case.representative["unique_id"])
			rep_access = TRUE

	if(access_cbia in user_id.access)
		nt_access = TRUE

	if(high_court_access in user_id.access)
		nt_access = TRUE

	if(prosecutor_access || judge_access || police_access || access_cbia || nt_access || rep_access || plaintiff_access || defendant_access)
		evidence_access = TRUE

/obj/machinery/case_database/attack_hand(mob/user)
	interact(user)

/obj/machinery/case_database/attackby(obj/item/weapon/W, mob/user)
	if(missing_case())
		return

	if(busy)
		to_chat(user, "<b>The machine is busy, please wait!</b>")
		return

	if(istype(W, /obj/item/device/tape))
		var/obj/item/device/tape/input_tape = W
		if(!isemptylist(input_tape.storedinfo))
			busy = TRUE
			add_tape(input_tape, user)
			busy = FALSE
			return

	if(istype(W, /obj/item))
		busy = TRUE
		add_evidence(W, user)
		busy = FALSE
		return

	..()

/obj/machinery/case_database/proc/add_evidence(obj/item/held_item, mob/user)
	if("No" == alert("Add [held_item] to the case: [current_case.name]?", "Add Evidence", "No", "Yes"))
		return

	var/datum/case_evidence/evidence = new()

	if(!evidence.obj_record(held_item, user_id.registered_name, user_id.unique_ID) || !current_case)
		return

	current_case.case_evidence += evidence

	user.drop_from_inventory(held_item, src)
	held_item.forceMove(src)
	spawn(30)
		held_item.forceMove(loc)

	playsound(loc, pick('sound/items/polaroid1.ogg', 'sound/items/polaroid2.ogg'), 75, 1, -3)
	to_chat(user, "You add [held_item] to the case evidence storage, the system takes a photograph and scans the item for evidence.")


/obj/machinery/case_database/proc/add_tape(obj/item/device/tape/heldtape, mob/user)
	if(!heldtape)
		return

	user.drop_from_inventory(heldtape, src)
	heldtape.forceMove(src)
	playsound(loc, 'sound/items/penclick.ogg', 5, 1, 5)

	if(heldtape.ruined)
		to_chat(user, "[src]'s monitor beeps, \"Error: Data corrupted\" as it ejects the tape.")
		heldtape.forceMove(loc)
		return

	var/obj/item/device/tape/newtape = new(loc)
	newtape.storedinfo = heldtape.storedinfo
	newtape.timestamp = heldtape.timestamp
	current_case.evidence_recordings += newtape

	var/tapename = input(user, "What would you like to label this tape as? (Leave blank for no label)", "Label Tape Entry") as text
	newtape.name = tapename

	if(!tapename)
		newtape.name = "Evidence Recording #[current_case.evidence_recordings.len]"

	spawn(30)
		heldtape.forceMove(loc)

	to_chat(user, "You add [heldtape] to the case files, the system whirrs as it makes a copy of the tape.")


/obj/machinery/case_database/proc/missing_case()
	if(!current_case)
		page = 1
		return TRUE

	return FALSE


/obj/machinery/case_database/interact(mob/user)
	var/dat
	if(!check_for_id(user))
		dat += "Due to security reasons, an ID card is required for viewing this system. Please ask an administrator for assistance.<br>"

	if(user_id)
		check_for_access(user)

	dat += "<h1>[name]</h1><br>"
	dat += "Greetings, [user.name]. Welcome to the [name], this database stores cases within the [using_map.name] colony. Please select from the following options."
	dat += "<hr>"


	switch(page)

		//PAGES:
		//1 - Homepage
		//2 - Created Case
		//3 - View Case (Shows Case Info)
		//4 - View Cases List (Will show depending on option)
		//5 - Delete Case Confirmation

		//6 - [CASE ACTIVE] Case Logger
		//7 - [CASE ACTIVE] Case notes screen
		//8 - [CASE ACTIVE] Add Evidence Screen
		//9 - [CASE ACTIVE] Add tape recordings
		//10 - [CASE ACTIVE] Add witnesses

		//11 - [EVIDENCE ACTIVE] View Evidence
		//12 - [RECORDING SELECTED] View/Play Recording

		// HOMEPAGE
		if(1)
			dat += "<b>Select an option:</b><br>"
			dat += "<a href='?src=\ref[src];create_case=1'>Create a New Case</a><br>"
			dat += "<a href='?src=\ref[src];view_all=1'>View Ongoing Public Cases</a><br>"
			dat += "<a href='?src=\ref[src];archived=1'>Archived Cases</a><br>"
			dat += "<a href='?src=\ref[src];search=1'>Find Case By ID</a><br>"
			dat += "<a href='?src=\ref[src];lawyer_rep=1'>Cases Requiring Lawyer Representation</a><br>"
			dat += "<a href='?src=\ref[src];own=1'>View My Cases</a><br>"

		if(2)
			if(missing_case())
				return

			dat += "Your case <b>[current_case.UID]: [current_case.name]</b> has now been created.<br>"

		if(3)
			if(missing_case())
				return

			dat += "<h1>Case View: [current_case.UID]: [current_case.name]</h1><br>"
			dat += "<a href=''>Link to Courtroom Projector</a><br><hr>"

			//table style set
			dat += "<table style=\"width: 90%; color: white; border-color: white; background-color: black;\" border=\"1px\" cellspacing=\"3\" cellpadding=\"2\"><tbody>"
			//table style end

			//Case name
			dat += "<tr><td><strong>Case Name:</strong></td><td>[current_case.UID]: [current_case.name]</td></tr>"

			//Creation Date
			dat += "<tr><td><strong>Creation Date:</strong></td><td>[current_case.creation_date ? "[current_case.creation_date]" : "<i>No data.</i>"]</td></tr>"

			//Case description
			dat += "<tr><td><strong>Description:</strong></td><td>[current_case.description]</td></tr>"

			//Case Type
			dat += "<tr><td><strong>Case Type:</strong></td><td>[current_case.case_type]</td></tr>"

			//Outcome (Determined)
			dat += "<tr><td><strong>Outcome:</strong></td><td>[current_case.case_outcome]</td></tr>"

			//Case Author
			dat += "<tr><td><strong>Author:</strong></td><td>[current_case.author]</td></tr>"

			//Defendant: (Defaults to the City if no defendant specified.)
			if(current_case.defendant["name"])
				dat += "<tr><td><strong>Defendant:</strong></td><td>[current_case.defendant["name"]]</td></tr>"

			//Plaintiff: (Defaults to the City if no plaintiff specified.)
			if(current_case.plaintiff["name"])
				dat += "<tr><td><strong>Plaintiff:</strong></td><td>[current_case.plaintiff["name"]]</td></tr>"

			//Representation: If not specified, explains why with case_rep_status var
			if(current_case.representative["unique_id"])
				dat += "<tr><td><strong>Representative:</strong></td><td>[current_case.representative["name"]]</td></tr>"
			else
				dat += "<tr><td><strong>Representative:</strong></td><td>[current_case.case_rep_status]</td></tr>"

			//Desired Outcome
			dat += "<tr><td><strong>Desired Outcome:</strong></td><td>[current_case.desired_outcome]</td></tr>"

			//Charges Held
			dat += "<tr><td><strong>Charges Tried:</strong></td><td><ul>"

			if(isemptylist(current_case.charges))
				dat += "<i>No charges applied.</i>"
			else
				for(var/C in current_case.charges)
					dat += "<li>[C]</li>"

			dat += "</ul></td></tr>"

			//Charges Applied (only shows up if case is archived.
			if(current_case.case_status == CASE_STATUS_ARCHIVED)
				dat += "<tr><td><strong>Applied Charges:</strong></td><td><ul>"

				if(isemptylist(current_case.charges_applied))
					dat += "<i>No charges applied.</i>"
				else
					for(var/C in current_case.charges_applied)
						dat += "<li>[C]</li>"

				dat += "</ul></td></tr>"

			//Witnesses List

			dat += "<tr><td><strong>Witnesses:</strong></td><td><ul>"
			if(isemptylist(current_case.witnesses))
				dat += "<i>No witnesses supplied.</i>"
			else
				for(var/W in current_case.witnesses)
					dat += "<li>[W]</li>"
			dat += "</ul></td></tr>"

			//Involved Parties
			dat += "<tr><td><strong>Other Parties:</strong></td><td><ul>"

			if(isemptylist(current_case.involved_parties))
				dat += "<i>No supplied parties.</i>"
			else
				for(var/P in current_case.involved_parties)
					dat += "<li>[P]</li>"

			dat += "</ul></td></tr>"

			//Court Date
			dat += "<tr><td><strong>Next Court Date:</strong></td><td>[current_case.court_date ? "[current_case.court_date]" : "<i>To be confirmed.</i>"]</td></tr>"

			//Trial Expiry Date
			dat += "<tr><td><strong>Trial Expiry Date:</strong></td><td>[current_case.expiry_date ? "[current_case.expiry_date]" : "<i>No expiry date</i>"]</td></tr>"


			/////// OPTIONS FOR CURRENT CASE ///////
			if(evidence_access)
				dat += "<a href='?src=\ref[src];case_notes=1'>View Case Notes Log[current_case.case_notes ? " ([current_case.case_notes.len])" : ""]</a> "
				dat += "<a href='?src=\ref[src];evidence_screen=1'>View Evidence List[current_case.case_evidence ? " ([current_case.case_evidence.len])" : ""]</a> "
				dat += "<a href='?src=\ref[src];view_case_log=1'>View Case Logs[current_case.case_logs ? " ([current_case.case_logs.len])" : ""]</a> "
				dat += "<a href='?src=\ref[src];add_tape_recordings=1'>Tape Recording List[current_case.evidence_recordings ? " ([current_case.evidence_recordings.len])" : ""]</a><br>"

			dat += "<br><a href='?src=\ref[src];print_case=1'>Print Case File</a>"

		if(4)

			if(missing_case())
				return

			var/total_cases = list()

			switch(search_type)
				if("All")
					total_cases += get_public_open_cases()

				if("Archived")
					total_cases += get_public_archived_cases()
				if("Own")
					total_cases += find_case_by_char_uid(user_id.unique_ID)

				if("Search")
					total_cases += find_case_by_UID(search_query)

				if("Lawyer_rep")
					total_cases += cases_need_lawyer()


			if(!isemptylist(total_cases))
				for(var/datum/court_case/C in total_cases)
					dat += "<a href='?src=\ref[src];choice=choose_case;case=\ref[C]'>[C.name]</a><br>"
			else
				dat += "<i>No cases found.</i>"

		if(5)
			dat += "You have successfully deleted the court case. Press back to return to the main menu.<br>"


		if(6)
			dat += "<h3>Case Court Log:</h3><br><br>"

			if(isemptylist(current_case.case_logs))
				dat += "<i>No case logs.</i>"
			else
				for(var/C in current_case.case_logs)
					dat += "<li>[C]</li>"

		if(7)
			dat += "<h3>Case Notes:</h3><br><br>"

			dat += "<br><a href='?src=\ref[src];add_case_note=1'>Add Case Note</a>"

			if(isemptylist(current_case.case_notes))
				dat += "<i>No case notes.</i>"
			else
				for(var/C in current_case.case_notes)
					dat += "<li>[C]</li>"



		if(8)
			dat += "<h3>Evidence List:</h3><br><br>"

			if(isemptylist(current_case.case_evidence))
				dat += "<i>No evidence added. You can add new evidence by scanning it into the machine.</i><br>"
			else
				for(var/datum/case_evidence/E in current_case.case_evidence)
					dat += "<li><a href='?src=\ref[src];view_evidence=1;evidence=\ref[E]'>[E.name]</a></li>"

		if(9)
			dat += "<h3>Tape Recording List:</h3><br><br>"

			if(isemptylist(current_case.evidence_recordings))
				dat += "<i>No tape recordings found. You can add a new tape by inserting a tape into the machine.</i><br>"
			else
				for(var/obj/item/device/tape/T in current_case.evidence_recordings)
					dat += "<li><a href='?src=\ref[src];view_evidence=1;recording=\ref[T]'>[T.name]</a></li>"

		if(10)
			return // TODO

		if(11)
			if(!current_evidence)
				dat += "<b>ERROR:</b> <i>This evidence piece cannot be found on the system.</i><br>"
			else
				dat += "<h3>Evidence: [current_evidence.name]</h3><br>"


				if(current_evidence.icon && current_evidence.icon_state)
					var/icon/i = new(current_evidence.icon, current_evidence.icon_state)
					user << browse_rsc(i, "evidence_[current_evidence.UID].png")
					dat += "<img src='evidence_[current_evidence.UID].png' style='width: 64px; height: 64px; style='-ms-interpolation-mode:nearest-neighbor'><br>"

				dat += "<b>Name:</b> [current_evidence.name]<br>"


				if(current_evidence.description)
					dat += "<b>Description:</b><br>"
					dat += "[current_evidence.description]<br>"

				dat += "<b>Added By:</b> [current_evidence.added_by["name"]]<br>"

				dat += "<b>Fingerprints:</b> "
				if(!isemptylist(current_evidence.fingerprints))
					for(var/F in current_evidence.fingerprints)
						dat += "<li>[F]</li>"
				else
					dat += "<i>No fingerprints found.</i>"

				dat += "<br>"
				dat += "<b>Fibers:</b> "
				if(!isemptylist(current_evidence.suit_fibers))
					for(var/F in current_evidence.suit_fibers)
						dat += "<li>[F]</li>"
				else
					dat += "<i>No fibers found.</i>"

				dat += "<br>"

				if(!isemptylist(current_evidence.blood_DNA))
					dat += "<b>Blood DNA Strings:</b> "
					if(current_evidence.was_bloodied)
						dat += "<i>Has traces of blood.</i>"
					for(var/B in current_evidence.blood_DNA)
						dat += "<li>[B]</li>"
				else
					dat += "<i>No blood dna found.</i>"

				if(current_evidence.photo)
					dat += "<br>"
					dat += "<b>Photo Data:</b><br>"
					user << browse_rsc(current_evidence.photo, "evidence_photo_[current_evidence.UID].png")
					dat += "<img src='evidence_photo_[current_evidence.UID].png' style='-ms-interpolation-mode:nearest-neighbor' width='[64*3]'/><br>"

				if(current_evidence.comments)
					dat += "<br>"
					dat += "<b>Comments:</b><br>"
					dat += "[current_evidence.comments]"
					dat += "<br>"
					dat += "<a href='?src=\ref[src];evidence_comments=1'>Edit Comments</a>"

				if(current_evidence.paper_content)
					dat += "<br>"
					dat += "<b>Paper Contents:</b><br>"
					dat += "[current_evidence.paper_content]"
					dat += "<br>"







		if(12)
			if(!current_recording)
				dat += "<b>ERROR:</b> <i>Recording not found on the system.</i><br>"
			else
				dat += "<h3>Recording: [current_recording.name]</h3><br>"

				dat += "<br><a href='?src=\ref[src];print_recording=1'>Print Recording Transcript</a>"

				dat += "<a href='?src=\ref[src];play_recording=1'>Play</a>"
				dat += "<a href='?src=\ref[src];pause_recording=1'>Pause</a>"

				dat += "<br>Transcript:</br>"
				if(!isemptylist(current_recording.storedinfo))
					for(var/i=1,current_recording.storedinfo.len >= i,i++)
						var/printedmessage = current_recording.storedinfo[i]
						if (findtextEx(printedmessage,"*",1,2)) //replace action sounds
							printedmessage = "\[[time2text(current_recording.timestamp[i]*10,"mm:ss")]\] (Unrecognized sound)"
						dat += "[printedmessage]<BR>"
				else
					dat += "<i>Recording is empty.</i>"



	if(!(page == 1))
		if(!current_case)
			dat += "<br><a href='?src=\ref[src];back=1'>Back</a>"
		else
			dat += "<br><a href='?src=\ref[src];view_case=1'>Back</a>"
			dat += "<br><a href='?src=\ref[src];exit_case=1'>Exit Case</a>"


	var/datum/browser/popup = new(user, "court_case_db", "[src]", 550, 650, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "court_case_db")


/obj/machinery/case_database/proc/clear_data()
	case_desc = initial(case_desc)
	case_type = initial(case_type)
	current_case = initial(current_case)
	current_evidence = initial(current_evidence)
	current_recording = initial(current_recording)
	search_type = initial(search_type)

	return

/obj/machinery/case_database/proc/create_case(mob/user)
	var/list/case_types = list("I want to contest my criminal charges", "Sue the Police Department", "Sue the City Council", "Open a civil dispute")

	if(prosecutor_access)
		case_types += "Prosecute a criminal as part of Police Force"

	var/case_subject = input(user, "What kind of case do you wish to open?", "Edit Criminal Records") as null|anything in case_types
	if(!case_subject) return

	var/purpose = sanitize(input("Required: Enter purpose and description of the case.", "Purpose") as text)
	if(!purpose) return

	var/wanted_outcome = sanitize(input("What outcome are you looking for?", "Outcome") as text)
	if(!wanted_outcome) return

	var/datum/court_case/case = new /datum/court_case()

	case.author = user_id.registered_name
	case.description = purpose
	case.desired_outcome = wanted_outcome

	var/user_details = list("name" = user_id.registered_name, "unique_id" = user_id.unique_ID)
	var/prosecuting = FALSE


	if(prosecuting)
		var/criminal_list = list()

		for(var/datum/data/record/R in data_core.security)
			criminal_list += R.fields["name"]

		if(!criminal_list)
			alert(user, "No police records exist on the system to select from!")

		var/criminal = input(user, "Who are we opening the case against?", "Edit Criminal Records") as null|anything in criminal_list

		var/unique_id_crim = ""

		for(var/datum/data/record/C in data_core.security)
			if(C.fields["name"] == criminal)
				unique_id_crim = C.fields["unique_id"]

		case.defendant = list("name" = criminal, "unique_id" = unique_id_crim)

	switch(case_subject)
		if("I want to contest my criminal charges")
			case.defendant = user_details
			case.plaintiff = list("name" = "[using_map.name] Police Department", "unique_id" = "")
			case.case_type = CRIMINAL_CASE

		if("Prosecute a criminal as part of Police Force")
			case.plaintiff = list("name" = "[using_map.name] Police Department", "unique_id" = "")
			case.case_type = CRIMINAL_CASE
			prosecuting = TRUE

		if("Sue the Police Department")
			case.plaintiff = user_details
			case.defendant = list("name" = "[using_map.name] Police Department", "unique_id" = "")
			case.case_type = CIVIL_CASE

		if("Sue the City Council")
			case.plaintiff = user_details
			case.defendant = list("name" = "[using_map.name] Police Department", "unique_id" = "")
			case.case_type = CIVIL_CASE

		if("Open a civil dispute")
			case.plaintiff = user_details
			case.case_type = CIVIL_CASE
			prosecuting = TRUE




	case.name = "[case.plaintiff["name"]] vs. [case.defendant["name"]]"
	current_case = case
	page = 3

/obj/machinery/case_database/proc/print_case()
	return



/obj/machinery/case_database/Topic(var/href, var/href_list)
	if(..())
		return 1

	if(href_list["back"])
		clear_data()
		page = 1

	if(href_list["exit_case"])
		clear_data()
		current_case = null
		page = 1

	if(href_list["create_case"])
		create_case(usr)

	if(href_list["view_case"])
		page = 3

	if(href_list["print_case"])
		print_case()

	if(href_list["choice"])
		switch(href_list["choice"])
			if("choose_case")
				var/E = locate(href_list["case"])

				if(!E)
					return

				current_case = E
				page = 3


	if(href_list["view_all"])
		search_type = "All"
		page = 4

	if(href_list["archived"])
		search_type = "Archived"
		page = 4

	if(href_list["own"])
		search_type = "Own"
		page = 4

	if(href_list["lawyer_rep"])
		search_type = "Lawyer Rep"
		page = 4

	if(href_list["search"])
		var/search = sanitize(input("Search case by unique ID", "Case Search") as text)
		if(!search)
			return
		search_type = "Search"
		page = 4


	if(href_list["add_case_note"])
		if(!current_case)
			return

		var/note = sanitize(input("Enter a note comment for this case.", "Case Notes") as message)

		note = "\"[note]\" - <i>[user_id.registered_name]</i> ([full_game_time()])"

		current_case.case_notes += note

	if(href_list["evidence_comments"])
		if(!current_evidence)
			return

		var/note = sanitize(input("You may edit the evidence commentary here.", "Case Notes", current_evidence.comments) as message)

		current_evidence.comments = note






	if(href_list["delete_case"])
		page = 5

	if(href_list["view_case_log"])
		page = 6

	if(href_list["case_notes"])
		page = 7

	if(href_list["evidence_screen"])
		page = 8

	if(href_list["add_tape_recordings"])
		page = 9

	if(href_list["add_witnesses"])
		page = 10

	if(href_list["view_evidence"])
		var/E = locate(href_list["evidence"])
		if(!E || (!(E in current_case.case_evidence)))
			return

		current_evidence = E

		page = 11

	if(href_list["view_recording"])
		var/E = locate(href_list["recording"])
		if(!E || (!(E in current_case.evidence_recordings)))
			return

		current_recording = E

		page = 12

	if(href_list["print_recording"])
		var/E = locate(href_list["recording"])
		if(!current_recording || !E || (!(E in current_case.evidence_recordings)))
			return

		tape_player.mytape = current_recording
		tape_player.print_transcript()
		tape_player.mytape = null



	updateDialog()

