/datum/computer_file/program/gov_application
	filename = "gov_apply"
	filedesc = "Government Job Applications"
	extended_desc = "Allows you to apply for a position in government such as vice president, advisory board positions, and so on."
	requires_ntnet = 1
	size = 3
	nanomodule_path = /datum/nano_module/program/gov_application/
	required_access = access_president

/datum/nano_module/program/gov_application/
	name = "Government Job Applications"

	var/full_name
	var/unique_id
	var/pitch
	var/slogan
	var/index = 1
	var/page_msg = " "
	var/error_msg = " "
	var/reg_error = "*Fields marked with an asterisk are required."

	var/datum/president_candidate/registered

	var/applied_title

var/list/advisor_positions = list(
	"Defense Advisor",
	"Justice Advisor",
	"Innovation Advisor",
	"Health Advisor",
	"Finance Advisor"
)


/datum/nano_module/program/gov_application/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = list()
	if(program)
		data = program.get_header_data()

	var/can_use

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		full_name =	H.real_name
		unique_id = H.client.prefs.unique_id

		can_use = 1

	if(!can_use)
		show_error("You are not authorized to use this system.")


	if(index == 0)
		page_msg = "[reg_error]"

	if(index == 1)
		if(registered)
			pitch = registered.pitch
			slogan = registered.slogan
		page_msg = "This is your control panel. You can edit your details, as well as withdraw from candidacy if you wish."

	if(index == 2)
		page_msg = "Here's a list of available vacancies:"


		//vice president
		page_msg += "<b>Vice President:</b> "
		if(SSelections.vice_president)
			page_msg += "TAKEN"
		else
			page_msg += "<a href='?src=\ref[src];choice=apply_job;title=\ref["Vice President"]'>Vice President</a>"

		// advisor
		for(var/A in advisor_positions)
			page_msg += "<b>[V]:</b> "
			if(SSelections.presidential_advisors[A])
				page_msg += "TAKEN"
			else
				page_msg += "<a href='?src=\ref[src];choice=apply_job;title=\ref[A]'>[A]</a>"


	if(index == 3)
		page_msg = "This is your control panel. You can edit your details, as well as withdraw from candidacy if you wish."

	data["full_name"] = full_name
	data["unique_id"] = unique_id
	data["pitch"] = pitch
	data["slogan"] = slogan
	data["index"] = index
	data["page_msg"] = page_msg
	data["reg_error"] = reg_error
	data["reg_error"] = reg_error

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "gov_application.tmpl", "Government Job Applications", 690, 680, state = state)
		if(program.update_layout())
			ui.auto_update_layout = 1
		ui.set_auto_update(1)
		ui.set_initial_data(data)
		ui.open()

/datum/nano_module/program/candidate_registration/proc/show_error(error_text)
	reg_error = "[error_text]"
	index = 0

/datum/nano_module/program/candidate_registration/proc/clear_data()
	full_name = initial(full_name)
	unique_id = initial(unique_id)
	pitch = initial(pitch)
	slogan = initial(slogan)
	page_msg = " "
	error_msg = " "
	reg_error = initial(reg_error)

	registered = initial(registered)
	applied_title = initial(applied_title)

/datum/nano_module/program/candidate_registration/Topic(href, href_list)
	if(..()) return 1

	if(href_list["back"])
		. = 1
		index = 1
		clear_data()

	if(href_list["edit_application"])
		. = 1

		registered = null

		for(var/datum/president_candidate/P in SSelections.government_applications)
			if(unique_id == P.unique_id)
				registered = P

		if(!registered)
			show_error("No candidate data found, please register for candidacy before using the control panel.")
			return

		pitch = registered.pitch
		slogan = registered.slogan



	if(href_list["choice"])
		switch(href_list["choice"])

			if("apply_job")
				var/title = locate(href_list["title"])
				applied_title = title

				switch(applied_title)
					if("Vice President")


	if(href_list["register_new"])
		. = 1
		if(!SSelections.can_register())
			index = 7
			return

		var/old_enough = 0
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			var/datum/job/presjob = job_master.GetJob("President")
			if(H.age > presjob.minimum_character_age - 1)
				old_enough = 1
		if(is_voting_ineligible(usr) || !old_enough)
			index = 8
			return
		index = 2


	if(href_list["enter_pitch"])
		. = 1

		var/pitch_e = sanitize(copytext(input(usr, "Enter your pitch (300 chars max)", "Candidacy Manager", pitch)  as message,1,300))
		if(!pitch_e)
			return
		pitch = pitch_e

	if(href_list["enter_slogan"])
		. = 1
		var/slogan_e = sanitize(copytext(input(usr, "Enter your slogan (50 chars max)", "Candidacy Manager", slogan)  as text,1,50))
		if(!slogan_e)
			return
		slogan = slogan_e


	if(href_list["update_pitch"])
		. = 1
		if(!registered)
			return

		var/pitch_e = sanitize(copytext(input(usr, "Enter your pitch (300 chars max)", "Candidacy Manager", pitch)  as message,1,300))
		if(!pitch_e)
			return
		registered.pitch = pitch_e

	if(href_list["update_slogan"])
		. = 1
		if(!registered)
			return

		var/slogan_e = sanitize(copytext(input(usr, "Enter your slogan (50 chars max)", "Candidacy Manager", slogan)  as text,1,50))
		if(!slogan_e)
			return
		registered.slogan = slogan_e


