/datum/computer_file/program/govportal
	filename = "govportal"
	filedesc = "GovPortal"
	extended_desc = "The control panel to the entire colony. Use with care. Restricted access."
	requires_ntnet = 1
	size = 4
	nanomodule_path = /datum/nano_module/program/govportal/
	available_on_ntnet = 1

/datum/nano_module/program/govportal/
	name = "GovPortal"

	var/current_grouping = ""
	var/index = 1

	var/allow_modification = TRUE
	var/admin_edit = FALSE

/datum/nano_module/program/govportal/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = list()
	if(program)
		data = program.get_header_data()

	var/obj/item/weapon/card/id/I = user.GetIdCard()
	if(!I)
		index = 0

	var/page_msg = "<h2>[using_map.company_name] [name]</h2>"

	if(!(index == 1))
		page_msg += "<a href='?src=\ref[src];action=sw_menu;target=1'>Main Menu</a><br>"

	if(index == 0)
		page_msg += "You are not authorized to use this system. Please check if you have a valid ID card."

	else if(index == 1) // Main Portal Page
		page_msg += "Welcome to the new and improved GovPortal!<br>\
		[using_map.company_name] head office email is headoffice@nanotrasen.gov.nt. This can be used [using_map.company_name] for official corrospondence.<br><br>\
		Here you can control aspects of law, colony life, and taxes and also keep in contact with officials and the general public. \
		If you have any questions or concerns do not hesistate to contact NT directorate.<br><br>"

		page_msg += "<a href='?src=\ref[src];action=sw_menu;target=3'>View Referendums</a>"
		if(access_president in I.access)
			page_msg += "<a href='?src=\ref[src];action=sw_menu;target=5'>Resign As President</a>"
		if(access_governor in I.access)
			page_msg += "<a href='?src=\ref[src];action=sw_menu;target=4'>Transfer Funds</a>"

		var/list/available_groupings = list()
		for(var/datum/persistent_option/PO in SSpersistent_options.get_persistent_options(null, I.access))
			if(!PO.portal_grouping)
				continue
			var/list/L = available_groupings["[PO.portal_grouping]"]
			if(!islist(L))
				available_groupings["[PO.portal_grouping]"] = list()
				L = available_groupings["[PO.portal_grouping]"]

			if(PO.portal_category && !(PO.portal_category in L))
				L += PO.portal_category

		for(var/C in available_groupings)
			var/list/all_options = available_groupings[C]
			if(!LAZYLEN(all_options))
				continue
			page_msg += "<br><fieldset style='width: 80%; border: 2px solid #515151; display: inline'>"
			page_msg += "<legend align='left' style='color: #fff'><h4>[C]:</h4></legend>"
			for(var/L in all_options)
				page_msg += "<a href='?src=\ref[src];action=select_grouping;new_cat=[L]'>[L]</a>"
			page_msg += "</fieldset><br><br>"

	else if(index == 2) // Persistent Option Viewing Page
		if(!current_grouping)
			page_msg += "There appears to be an issue with this option."
		else
			// Show Portal Options
			page_msg += "<h3></h3><hr>"
			page_msg += "<legend align='left' style='color: #fff'><h4>[current_grouping]:</h4></legend>"

			for(var/datum/persistent_option/PO in SSpersistent_options.get_persistent_options(current_grouping, I.access)) // only gets things you can view
				page_msg += "<fieldset style='width: 80%; border: 2px solid #515151; display: inline'>"
				page_msg += "<legend align='left' style='color: #fff'><h4>[PO.name]:</h4></legend>"
				page_msg += "<b>Description:</b> [PO.description]<br>"
				var/preview_text = PO.get_formatted_value()
				if(PO.compact_listing)
					page_msg += "<div class='statusDisplay'>[TextPreview(preview_text,400)]<br> \
					[(length(preview_text) > 99) ? " <a href='?src=\ref[src];action=view_full;option=\ref[PO]'>View Full</a>" : ""]</div><br><br>"
				else
					page_msg += "<div class='statusDisplay'>[preview_text]</div><br><br>"
				page_msg += "<b>Requires Referendum:</b> [PO.make_referendum ? "Yes" : "No"]<br>"
				if(allow_modification && PO.can_edit(I.access))
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
			var/datum/persistent_option/PO = VO.get_persistent_option()

			page_msg += "<b>Description:</b> [VO.desc]<br>"

			page_msg += "<b>Status:</b> [VO.get_status_text()][admin_edit ? " <a href='?src=\ref[src];action=referendum_toggle;ballot=\ref[VO]'> Toggle</a><br>" : ""]<br> "
			page_msg += "<b>Author:</b> [VO.author] [admin_edit ? VO.author_ckey : ""]<br>"


			var/preview_text_one = VO.get_current_option_formatted_value()

			if(PO.compact_listing)
				page_msg += "<b>Current Value:</b><br> <div class='statusDisplay'>[TextPreview(preview_text_one,PO.compact_listing)] \
				[(length(preview_text_one) > PO.compact_listing) ? " <a href='?src=\ref[src];action=view_full;ballot=\ref[PO]'>View Full</a>" : ""]</div><br><br>"
			else
				page_msg += "<b>Current Value:</b><br> <div class='statusDisplay'>[preview_text_one]</div><br><br>"

			if(VO.get_status())
				var/preview_text_two = PO.get_proposed_value_formatting()
				if(PO.compact_listing)
					page_msg += "<b>Proposed Value:</b><br> <div class='statusDisplay'>[TextPreview(preview_text_two,PO.compact_listing)] \
					[(length(preview_text_two) > PO.compact_listing) ? " <a href='?src=\ref[src];action=view_ref_full;ballot=\ref[VO]'>View Full</a>" : ""]</div><br><br>"
				else
					page_msg += "<b>Proposed Value:</b><br> <div class='statusDisplay'>[preview_text_two]</div><br><br>"


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

			if(admin_edit)
				page_msg += " <a href='?src=\ref[src];action=conclude_ballot;ballot=\ref[VO]'>Conclude Early</a>"

			if(!VO.get_status() || admin_edit)

				page_msg += " <a href='?src=\ref[src];action=delete_ballot;ballot=\ref[VO]'>Delete Ballot</a>"
				page_msg += "<br>"

			if(already_voted)
				page_msg += "<br><b>You have already voted in this referendum, thanks for participating!</b>"

			if(winner)
				page_msg += "<br><br>The <b>[status ? "projected winner" : "winner"]</b> is: \"[winner]\"."


			page_msg += "</fieldset><br><br>"
	else if(index == 4) // Transfer Funds

		for(var/datum/department/D in SSeconomy.get_all_nonbusiness_departments())
			if(!D.has_bank || !D.bank_account || D.dept_type == HIDDEN_DEPARTMENT)
				continue
			var/datum/money_account/M = D.bank_account
			var/display_color = "green"
			if(1500 > M.money)
				display_color = "yellow"
			if(100 > M.money)
				display_color = "red"

			page_msg += "<a href='?src=\ref[src];send_money=1;transfer_funds=\ref[M]'>Send Money</a> "
			page_msg += "<a href='?src=\ref[src];manage_transfer=1;transfer_funds=\ref[M]'>Transfer Money From</a> <b>[D.name]</b> (<font color=\"[display_color]\">[M.money]</font>CR)<br>"
	else if(index == 5) // Resign as President
		// Resign as President
		page_msg += "This will allow you to resign from the presidency. Once you do this, it <b>cannot</b> be undone. Resign?<br>"
		page_msg += "<a href='?src=\ref[src];resign_president=1'>Resign as President</a> "

	else
		page_msg += "An error has occured. Please try again<br>"


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

			var/datum/browser/popup = new(usr, "option_view", "[PO.name]", 350, 500, src)
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

	if(href_list["send_money"])
		. = 1
		var/datum/money_account/department/A = locate(href_list["transfer_funds"]) in GLOB.public_department_accounts
		if(!A)
			return


		var/account_id = sanitize(copytext(input(usr, "Please enter the bank id of the account you are sending money to.", "Business Management Utility", null)  as text,1,70))

		if(!account_id)
			return

		var/datum/money_account/account_to_send = get_account(account_id)

		if(!account_to_send)
			alert("This account does not appear to exist.")
			return

		var/amount = input(usr, "How much would you like to transfer?.", "Transfer Amount")  as num

		if(!amount || (0 > amount))
			alert("Please enter a valid amount.")
			return

		if(amount > A.money)
			alert("Not enough funds in [A.owner_name] to transfer to this account.")
			return

		A.charge(amount, account_to_send, "GovPortal Transfer from [A.owner_name] Department")

		alert("[cash2text( amount, FALSE, TRUE, TRUE )] successfully sent to account id #[account_id] ([account_to_send.owner_name])")


	if(href_list["manage_transfer"])
		. = 1
		var/datum/money_account/department/A = locate(href_list["transfer_funds"]) in GLOB.public_department_accounts

		if(!A)
			return

		var/list/dept_acc_names = list()
		var/datum/department/target_department

		for(var/datum/department/D in GLOB.public_departments)
			if(!D.has_bank || !D.bank_account || D.dept_type == HIDDEN_DEPARTMENT)
				continue

			dept_acc_names += D.name

		var/category = input(usr, "Select a department to transfer to.", "Departmental Transfer")  as null|anything in dept_acc_names + "Cancel"
		if(!category || category == "Cancel")
			return

		var/datum/money_account/account_recieving
		target_department = dept_by_name(category)

		if(!target_department)
			return

		account_recieving = target_department.bank_account
		if(!account_recieving)
			return

		var/amount = input(usr, "How much would you like to transfer?.", "Transfer Amount")  as num

		if(!amount || (0 > amount))
			alert("Please enter a valid amount.")
			return

		if(amount > A.money)
			alert("Not enough funds in [A.owner_name] to transfer to [category].")
			return

		A.charge(amount, account_recieving, "GovPortal Transfer from [A.owner_name]")


	if(href_list["resign_president"])
		. = 1

		if("No" == alert("Are you sure you would like to resign as president?", "Resign as President", "No", "Yes"))
			return

		if("No" == alert("Just making sure, do you want to resign as president? This CANNOT be undone.", "Resign as President", "No", "Yes"))
			return

		SSelections.clear_president()

		command_announcement.Announce("The current president of the Polluxian colonies has officially stepped down, Nanotrasen will reorganise the cabinet shortly.", "Presidential Resignition")

		index = 1
