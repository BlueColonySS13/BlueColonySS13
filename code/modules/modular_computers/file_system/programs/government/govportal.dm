/datum/computer_file/program/govportal
	filename = "govportal"
	filedesc = "GovPortal"
	extended_desc = "The control panel to the entire colony. Use with care. Restricted access."
	requires_ntnet = 1
	size = 4
	nanomodule_path = /datum/nano_module/program/govportal/
	required_access = access_president
	available_on_ntnet = 1

/datum/nano_module/program/govportal/
	name = "GovPortal"

	var/portal_type = PORTAL_PRESIDENT
	var/current_grouping = ""
	var/index = 1

	var/allow_modification = TRUE
	var/admin_edit = FALSE


	var/list/available_groupings = list("Government" = list("Assign Cabinet"), \
	"Law and Order" = list("Emergency Procedures", "Contraband and Restricted Materials", "Contraband Control Measures"), \
	"Social Law" = list("Discrimination Policies", "Voting Rights", "Minimum Wages", "Leasehold and Tenancy"), \
	"Economy and Taxes" = list("Spending And Budget", "Public Healthcare Pricing", "Public Legal Pricing", "Permit Pricing", "Social Costs", "Economic Bracket Taxes"), \
	"Communications" = list("Broadcast and Communications"), \
	)

/datum/nano_module/program/govportal/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = list()
	if(program)
		data = program.get_header_data()

	var/page_msg = "<h2>[using_map.company_name] [name]</h2>"

	if(!(index == 1))
		page_msg += "<a href='?src=\ref[src];action=sw_menu;target=1'>Main Menu</a><br>"

	if(index == 0)
		page_msg = "You are not authorized to use this system."

	else if(index == 1) // Main Portal Page
		page_msg += "Welcome to the new and improved GovPortal!<br>\
		[using_map.company_name] head office email is headoffice@nanotrasen.gov.nt. This can be used [using_map.company_name] for official corrospondence.<br><br>\
		Here you can control aspects of law, colony life, and taxes and also keep in contact with officials and the general public. \
		If you have any questions or concerns do not hesistate to contact NT directorate.<br>"

		page_msg += "<br><a href='?src=\ref[src];action=sw_menu;target=3'>View/Create Referendums</a><br>"

		for(var/C in available_groupings)
			var/list/all_options = available_groupings[C]
			if(!LAZYLEN(all_options))
				continue
			page_msg += "<fieldset style='width: 80%; border: 2px solid #515151; display: inline'>"
			page_msg += "<legend align='left' style='color: #fff'><h4>[C]:</h4></legend>"
			for(var/L in all_options)
				page_msg += "<a href='?src=\ref[src];action=select_grouping;new_cat=[L]'>[L]</a>"
			page_msg += "</fieldset><br><br>"

	else if(index == 2) // Persistent Option Viewing Page
		if(!current_grouping)
			page_msg += "There appears to be an issue with this option."
		else
			page_msg += "<h3></h3><hr>"

			page_msg += "<legend align='left' style='color: #fff'><h4>[current_grouping]:</h4></legend>"

			for(var/datum/persistent_option/PO in SSpersistent_options.get_persistent_options(current_grouping, portal_type))

				page_msg += "<fieldset style='width: 80%; border: 2px solid #515151; display: inline'>"
				page_msg += "<legend align='left' style='color: #fff'><h4>[PO.name]:</h4></legend>"
				page_msg += "<b>Description:</b> [PO.description]<br>"
				var/preview_text = PO.get_formatted_value()
				page_msg += "<div class='statusDisplay'>[TextPreview(preview_text,100)]<br> \
				[(length(preview_text) > 99) ? " <a href='?src=\ref[src];action=view_full;option=\ref[PO]'>View Full</a>" : ""]</div><br><br>"
				page_msg += "<b>Requires Referendum:</b> [PO.make_referendum ? "Yes" : "No"]<br>"
				if(allow_modification)
					page_msg += "<a href='?src=\ref[src];action=edit_portal;option=\ref[PO]'>[PO.make_referendum ? "Make Referendum" : "Change Setting"]</a>"

				page_msg += "</fieldset><br><br>"

	else if(index == 3) // Referendums Viewing Page
		page_msg += "This is a list of all available referendums."

		for(var/datum/voting_ballot/VO in SSpersistent_options.get_ballots())
			var/already_voted = FALSE
			if(lowertext(user.ckey) in VO.ckeys_voted)
				already_voted = TRUE

			page_msg += "<fieldset style='width: 80%; border: 2px solid #515151; display: inline'>"
			page_msg += "<legend align='left' style='color: #fff'><h4>[VO.name]:</h4></legend>"

			var/status = VO.get_status()
			var/winner = VO.check_winner()

			page_msg += "<b>Description:</b> [VO.desc]<br>"

			page_msg += "<b>Status:</b> [VO.get_status_text()][admin_edit ? " <a href='?src=\ref[src];action=referendum_toggle;ballot=\ref[VO]'> Toggle</a><br>" : ""]<br> "
			page_msg += "<b>Author:</b> [VO.author] [admin_edit ? VO.author_ckey : ""]<br>"

			var/preview_text1 = VO.get_current_option_formatted_value()
			page_msg += "<b>Current Value:</b><br> <div class='statusDisplay'>[TextPreview(preview_text1,100)] \
			[(length(preview_text1) > 99) ? " <a href='?src=\ref[src];action=view_ref_full;ballot=\ref[VO]'>View Full</a>" : ""]</div><br><br>"

			var/preview_text2 = VO.get_formatted_proposed_value()
			page_msg += "<b>Proposed Value:</b><br> <div class='statusDisplay'>[TextPreview(preview_text2,100)] \
			[(length(preview_text2) > 99) ? " <a href='?src=\ref[src];action=view_ref_full;ballot=\ref[VO]'>View Full</a>" : ""]</div><br><br>"


			if(status)
				page_msg += "<b>Expires:</b> [VO.expiry_days()] day(s)<br>"

			page_msg += "<b>Creation Date:</b> [VO.creation_date]<br>"

			page_msg += "<b>Current Votes</b><br><ul>"

			for(var/O in VO.options)
				page_msg += "<li> - <b>[O]</b>: [VO.get_option_amount(O)] vote(s)"
				if(!already_voted)
					page_msg += " <a href='?src=\ref[src];action=add_vote;ballot=\ref[VO];vote=[O]'>Vote</a>"

				page_msg += "</li>"

			page_msg += "</ul>"

			if(admin_edit || !VO.get_status())
				page_msg += " <a href='?src=\ref[src];action=conclude_ballot;ballot=\ref[VO]'>Conclude Early</a>"
				page_msg += " <a href='?src=\ref[src];action=delete_ballot;ballot=\ref[VO]'>Delete Ballot</a>"
				page_msg += "<br>"

			if(already_voted)
				page_msg += "<br><b>You have already voted in this referendum, thanks for participating!</b>"

			if(winner)
				page_msg += "<br><br>The <b>[status ? "projected winner" : "winner"]</b> is: \"[winner]\"."


			page_msg += "</fieldset><br><br>"
	data["page_msg"] = page_msg

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "govportal.tmpl", "GovPortal", 1000, 1000, state = state)
		if(program.update_layout())
			ui.auto_update_layout = 1
		ui.set_auto_update(1)
		ui.set_initial_data(data)
		ui.open()


/datum/nano_module/program/govportal/proc/reset_fields()
	current_grouping = initial(current_grouping)


/datum/nano_module/program/govportal/Topic(href, href_list)
	if(..()) return 1

	switch(href_list["action"])
		if("sw_menu")
			. = 1
			index = text2num(href_list["target"])


		if("edit_portal")
			var/O = locate(href_list["option"])
			var/datum/persistent_option/PO = O

			if(!O)
				return

			PO.edit_value(usr)
			return

		if("select_grouping")
			. = 1
			current_grouping = href_list["new_cat"]
			index = 2

		if("add_vote")
			. = 1

			var/datum/voting_ballot/VO = locate(href_list["ballot"])
			var/vote = href_list["vote"]

			if(!VO || !VO.active || (lowertext(usr.ckey) in VO.ckeys_voted))
				return

			var/response = alert(usr, "Please confirm that you want to vote [vote] on \"[VO.name]\"? This cannot be undone.", "Final Referendum Confirmation", "Yes", "No")
			if(!response || response == "No")
				return FALSE

			VO.add_vote(vote, usr)

		if("referendum_toggle")
			. = 1

			var/datum/voting_ballot/VO = locate(href_list["ballot"])

			if(!VO)
				return

			VO.active = !VO.active


		if("conclude_ballot")
			. = 1

			var/datum/voting_ballot/VO = locate(href_list["ballot"])

			if(!VO)
				return

			VO.expire_ballot()

		if("delete_ballot")
			. = 1

			var/datum/voting_ballot/VO = locate(href_list["ballot"])

			if(!VO)
				return

			VO.delete_ballot()

		if("view_full")

			var/O = locate(href_list["option"])
			var/datum/persistent_option/PO = O

			if(!O)
				return

			var/dat = PO.get_formatted_value()

			var/datum/browser/popup = new(usr, "option_view", "[src]", 350, 500, src)
			popup.set_content(jointext(dat,null))
			popup.open()

			onclose(usr, "option_view")

		if("view_ref_full")

			var/datum/voting_ballot/VO = locate(href_list["ballot"])

			if(!VO)
				return

			var/dat = VO.get_formatted_proposed_value()

			var/datum/browser/popup = new(usr, "option_ref_view", "[src]", 350, 500, src)
			popup.set_content(jointext(dat,null))
			popup.open()

			onclose(usr, "option_ref_view")



	if(href_list["main_menu"])
		. = 1
		index = 1
		reset_fields()