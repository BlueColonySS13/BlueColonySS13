/obj/machinery/case_database
	name = "\improper Case Database"
	desc = "A large database of legal cases can be accessed through this computer."
	unacidable = 1
	light_range = 4
	light_power = 2
	light_color = "#ebf7fe"  //white blue
	density = 1
	anchored = 1
	bounds = "64,32"

	icon = 'icons/obj/buysell.dmi' // placeholder
	icon_state = "sell" // placeholder

	var/page = 1
	var/search_type = "All"

	// Types: "Archived", "Own", "ID", "Search", otherwise it will search all CASES

	var/datum/court_case/current_case
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

	var/obj/item/device/taperecorder/empty/tape_player


	//case creation

	var/case_desc
	var/case_type

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

/obj/machinery/case_database/attack_hand(mob/user)
	interact(user)

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

		//6 - Add New Case Confirmation
		//7 - [CASE ACTIVE] Case notes screen
		//8 - [CASE ACTIVE] Add Evidence Screen
		//9 - [CASE ACTIVE] Add tape recordings
		//10 - [CASE ACTIVE] Add witnesses

		// HOMEPAGE
		if(1)
			dat += "<b>Select an option:</b><br>"
			dat += "<a href='?src=\ref[src];create_case=1'>Create a New Case</a><br>"
			dat += "<a href='?src=\ref[src];case_list=view_all'>View Ongoing Public Cases</a><br>"
			dat += "<a href='?src=\ref[src];case_list=archived'>Archived Cases</a><br>"
			dat += "<a href='?src=\ref[src];case_list=search'>Find Case By ID</a><br>"
			dat += "<a href='?src=\ref[src];case_list=lawyer_rep'>Cases Requiring Lawyer Representation</a><br>"
			dat += "<a href='?src=\ref[src];case_list=own'>View My Cases</a><br>"

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

			dat += "<a href=''>View Case Notes Log[current_case.case_logs ? " ([current_case.case_logs.len])" : ""]</a><br>"
			dat += "<a href=''>View Evidence List[current_case.case_evidence ? " ([current_case.case_evidence.len])" : ""]</a><br>"
			dat += "<a href=''>View Case Logs[current_case.case_logs ? " ([current_case.case_logs.len])" : ""]</a><br>"
			dat += "<a href=''>Tape Recording List[current_case.evidence_recordings ? " ([current_case.evidence_recordings.len])" : ""]</a><br>"

			dat += "<br><a href='?src=\ref[src];print_case=1'>Print Case File</a>"



		if(4)

			if(missing_case())
				return

			var/total_cases = list()

			switch(case_type)
				if("All")
					total_cases = get_public_open_cases()

				else if("archived")
					total_cases = get_public_archived_cases()
				else if("own")
					total_cases = find_case_by_char_uid(user_id.unique_ID)

				else if("search")

					var/search = sanitize(input("Search case by unique ID", "Case Search") as text)

					total_cases = find_case_by_UID(search)

				else if("lawyer_rep")
					total_cases = cases_need_lawyer()


			if(isemptylist(total_cases))
				for(var/datum/court_case/C in total_cases)
					dat += "<a href='?src=\ref[src];select_case=choose_case;case=\ref[C]''>[C.name]</a><br>"
			else
				dat += "<i>No cases found.</i>"


	if(!(page = 1))
		dat += "<br><a href='?src=\ref[src];back=1'>Back</a>"


	var/datum/browser/popup = new(user, "court_case_db", "[src]", 550, 650, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "court_case_db")


/obj/machinery/case_database/proc/clear_data()
	case_desc = initial(case_desc)
	case_type = initial(case_type)
	current_case = initial(current_case)
	search_type = initial(search_type)
	return

/obj/machinery/case_database/proc/create_case(mob/user)
	var/list/case_types = list("I want to contest my criminal charges", "Sue the Police Department", "Open a civil dispute")

	if(prosecutor_access)
		case_types += "Prosecute a criminal as part of Police Force"

	var/case_subject = input(user, "What kind of case do you wish to open?", "Edit Criminal Records") as null|anything in case_types

	if(!case_subject) return

	var/datum/court_case/case = new /datum/court_case()

	case.author = user_id.registered_name

	var/user_details = list("name" = user_id.registered_name, "unique_id" = user_id.unique_ID)
	var/prosecuting = FALSE

	switch(case_subject)
		if("I want to contest my criminal charges")
			case.defendant = user_details
			case.plaintiff = list("name" = "[using_map.name] Police Department", "unique_id" = "")
			case.case_type = CRIMINAL_CASE

		else if("Prosecute a criminal as part of Police Force")
			case.plaintiff = user_details
			case.case_type = CRIMINAL_CASE
			prosecuting = TRUE

		else if("Sue the Police Department")
			case.plaintiff = user_details
			case.defendant = list("name" = "[using_map.name] Police Department", "unique_id" = "")
			case.case_type = CRIMINAL_CASE

		else if("Open a civil dispute")
			case.plaintiff = user_details
			case.case_type = CIVIL_CASE
			prosecuting = TRUE


	case.name = "[case.plaintiff["name"]] vs. [case.defendant["name"]]"

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

	if(href_list["create_case"])
		create_case(usr)

	if(href_list["view_case"])
		page = 3

	if(href_list["print_case"])
		print_case()

	if(href_list["select_case"])
		switch(href_list["select_case"])

			if("choose_case")
				var/E = locate(href_list["case"])

				if(!E)
					return

				current_case = E
				page = 3

	if(href_list["case_list"])
		switch(href_list["case_list"])
			if("view_all")
				search_type = "All"
			if("archived")
				search_type = "Archived"
			if("own")
				search_type = "Own"
			if("search")
				search_type = "Search"

			if("lawyer_rep")
				search_type = "Lawyer Rep"

		page = 4

	if(href_list["delete_case"])
		page = 5

	if(href_list["add_confirm"])
		page = 6

	if(href_list["case_notes"])
		page = 7

	if(href_list["evidence_screen"])
		page = 8

	if(href_list["add_tape_recordings"])
		page = 9

	if(href_list["add_witnesses"])
		page = 10
	updateDialog()

