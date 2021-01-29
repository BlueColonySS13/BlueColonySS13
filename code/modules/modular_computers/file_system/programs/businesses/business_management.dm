
/datum/computer_file/program/business_manager
	filename = "bizmgmt"
	filedesc = "Business Management Utility"
	extended_desc = "This program allows you to register a new business or manage an existing one."
	requires_ntnet = 1

	size = 4
	nanomodule_path = /datum/nano_module/program/business_manager/


/datum/nano_module/program/business_manager
	name = "Business Management Utility"
	var/index = 1
	var/page_msg = ""
	var/reg_error = "*Fields marked with an asterisk are required."
	var/error_msg = " "

	var/unique_id
	var/email
	var/full_name

	var/datum/business/current_business
	var/datum/business/selected_business


/*****************************

	Registration Variables

*****************************/
	var/b_name = ""
	var/b_desc = ""
	var/b_pass = ""
	var/list/b_categories = list()

/datum/nano_module/program/business_manager/proc/reset_fields()
	b_name = initial(b_name)
	b_desc = initial(b_desc)
	b_pass = initial(b_pass)
	reg_error = initial(reg_error)
	error_msg = initial(error_msg)
	b_categories = list()
	current_business = null

/datum/nano_module/program/business_manager/proc/show_custom_page(msg)
	page_msg = msg
	index = -1

/datum/nano_module/program/business_manager/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)

	var/list/data = list()
	if(program)
		data = program.get_header_data()

	var/obj/item/weapon/card/id/I = user.GetIdCard()

	if(I)
		full_name = I.registered_name
		unique_id = I.unique_ID
		email = I.associated_email_login["login"]


	if(!I || !I.unique_ID || !get_account(I.associated_account_number) || !get_email(email) || !config.allow_businesses)
		if(!(config.allow_businesses && current_business))
			index = 0

	if(index == 0) // invalid entry screen

		if(!config.allow_businesses)
			page_msg = "The business management utility is currently unavailable. Sorry for the inconvienience."
		else
			page_msg = "You are not authorized to use this system. Please ensure your ID is linked correctly to your citizen details, \
			bank, and email."


	else if(index == 1) // Main Portal Page

		page_msg = "Welcome to the Business Management Utility, [full_name].<br>\
		Here, you can start your business, manage staff and earnings. Choose from the following options."

	else if(index == 2) // Manage Business Page

		if(!current_business)
			current_business = get_business_by_owner_uid(unique_id)

		if(current_business)
			var/datum/department/biz_dept = dept_by_id(current_business.department)

			page_msg = "<h2>[current_business]</h2><hr>"

			if(biz_dept && biz_dept.has_bank)
				page_msg += "<b>Business Account Balance:</b> [cash2text( biz_dept.get_balance(), FALSE, TRUE, TRUE )]<br>"
				page_msg += "<b>Bank ID:</b> [biz_dept.bank_account.account_number]<br>"
				page_msg += "<b>Taxed:</b> [biz_dept.business_taxed ? "Yes" : "No"]<br>"
				page_msg += "<a href='?src=\ref[src];withdraw_balance=1'>Withdraw Balance</a>"
				page_msg += "<a href='?src=\ref[src];transfer_money=1'>Transfer Money</a>"
				page_msg += "<a href='?src=\ref[src];add_funds=1'>Add Funds</a>"

			page_msg += "<br><br><b>Business:</b> [current_business.name]<br>"
			page_msg += "<b>Creation Date:</b> [current_business.creation_date]<br>"
			page_msg += "<b>Unique Identifier:</b> [current_business.business_uid]<br>"
			page_msg += "<b>Owner:</b> [current_business.get_owner_name()]<br>"
			page_msg += "<b>Employee Password:</b> [current_business.access_password]<br>"
			page_msg += "<b>Status:</b> [current_business.get_status()]<br>"

			if(biz_dept)
				page_msg += "<b>Business Color:</b> <font face='fixedsys' size='3' color='[biz_dept.dept_color]'><table style='display:inline;' bgcolor='[biz_dept.dept_color]'><tr><td>__</td></tr></table></font> [biz_dept.dept_color]<br>"

			if(current_business.suspended)
				page_msg += "[current_business.suspended_reason ? current_business.suspended_reason : "No reason provided."]<br>"

			// Pick Categories
			page_msg += "<br><strong>Business Categories: </strong><br><ol>"
			for(var/V in current_business.categories)
				page_msg += "<li>[V]</li>"
			page_msg += "</ol><br>"


			// Business Tools

			page_msg += "<br>There are a range of settings you can utilize below:<br>"

			// : General
			page_msg += "<br><br><b>General Settings: </b><br>"
			page_msg += "<a href='?src=\ref[src];rename_business=1'>Rename Business</a>"
			page_msg += "<a href='?src=\ref[src];edit_biz_desc=1'>Edit Description</a>"
			page_msg += "<a href='?src=\ref[src];modify_category=1'>Modify Categories</a>"
			page_msg += "<a href='?src=\ref[src];change_password=1'>Change Access Password</a><br>"
			page_msg += "<a href='?src=\ref[src];edit_biz_color=1'>Edit Business Color</a>"
			page_msg += "<a href='?src=\ref[src];toggle_ceo_pay=1'>[current_business.pay_CEO ? "CEO Recieves Wages" : "CEO Doesn't Recieve Wages"]</a>"

			// : Employment
			page_msg += "<br><br><b>Employment: </b><br>"

			page_msg += "<a href='?src=\ref[src];manage_jobs=1'>Manage Jobs</a>"
			page_msg += "<a href='?src=\ref[src];manage_access=1'>Manage Accesses</a>"

		else
			page_msg = "We're very sorry, there seems to be an issue with finding your business on our database. \
			Please try again or try creating your business on our portal."

			page_msg += "<br><br><a href='?src=\ref[src];register_biz=1'>Register a New Business</a>"

	else if(index == 3) // Registration Page
		page_msg = "Registering a business is quick and easy! Before registering for a business, check the official business list to see if \
		your business idea or name already exists."

		page_msg += {"

		<h2>Terms and Conditions</h2>

		<p>All businesses must remain in accordance with Polluxian law. If a business is found to be participating in illegal activity it will be suspended pending investigation.
		The Polluxian Government & NanoTrasen reserves the right to request an audit at any given time. Failure to comply with auditing procedures may result in the termination of your company.</p>

		<h2>Disclaimer</h2>
			<p>To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our utility and the use of this utility including, without limitation, any warranties implied by law in respect of satisfactory quality, fitness for purpose and/or the use of reasonable care and skill. Nothing in this disclaimer will:</p>
			<ol>
			<li>limit or exclude our or your liability for death or personal injury resulting from negligence;</li>
			<li>limit or exclude our or your liability for fraud or fraudulent misrepresentation;</li>
			<li>limit any of our or your liabilities in any way that is not permitted under applicable law; or</li>
			<li>exclude any of our or your liabilities that may not be excluded under applicable law.</li>
			</ol>
			<p>The limitations and exclusions of liability set out in this Section and elsewhere in this disclaimer: a -
			are subject to the preceding paragraph; and b - govern all liabilities arising under the disclaimer or
			in relation to the subject matter of this disclaimer, including liabilities arising in contract, in tort
			including negligence and for breach of statutory duty.</p>
			<p>To the extent that the utility and the information and services on the utility are provided,
			we will not be liable for any loss or damage of any nature.</p>

		<p><em>Please complete the form below.</em></p><hr><br><b>Registration Form:</b><br>"}

		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"

		// Actual form //

		page_msg += "<br><span style=\"color:red\">[reg_error]</span><br>"

		// Name
		page_msg += "<br><strong>Business Name*: </strong><br>"
		page_msg += "<a href='?src=\ref[src];set_business_name=1'>[b_name ? "[b_name]" : "Change Business Name"]</a>"
		page_msg += "<br>"

		// Pick Categories
		page_msg += "<br><strong>Categories*: </strong><br><ol>"
		for(var/V in b_categories)
			page_msg += "<li>[V] <a href='?src=\ref[src];choice=remove_cat;cat=\ref[V]'>x</a></li>"
		page_msg += "</ol><br>"
		if(!(LAZYLEN(b_categories) >= 3))
			page_msg += "<a href='?src=\ref[src];set_business_cats=1'>Add Category</a><br>"

		// Business Description
		page_msg += "<br><strong>Business Description*: </strong><br>"
		page_msg += "<a href='?src=\ref[src];set_business_desc=1'>[b_desc ? "[b_desc]" : "Add Business Description"]</a>"
		page_msg += "<br>"

		// Password
		page_msg += "<br><strong>Access Password*: </strong><br>"
		page_msg += "<a href='?src=\ref[src];set_biz_pass=1'>[b_pass ? "[stars(b_pass, 0)]" : "Set Password"]</a>"
		page_msg += "<br>"

		page_msg += "</fieldset>"

		page_msg += {"<p>By pressing "Submit" you agree to the business terms and conditions and a payment of 3,500 credits charged to your bank account.</p>"}

		page_msg += "<br><a href='?src=\ref[src];submit_new_business=1'>Submit</a>"
	else if(index == 4) // Jobs Page
		if(!current_business)
			current_business = get_business_by_owner_uid(unique_id)

		if(current_business && current_business.department)

			page_msg = "<h2>[current_business]</h2><hr>"
			page_msg += "Welcome to your jobs portal. You can add or modify your business specific jobs here.<br><br>"

			page_msg += "<br><a href='?src=\ref[src];add_new_job=1'>Add Job</a>"

			var/obj/item/weapon/card/id/id_card

			if(program && program.computer && program.computer.card_slot)
				id_card = program.computer.card_slot.stored_card

			page_msg += "[id_card ? "<b>Current ID:</b> [id_card.name] <a href='?src=\ref[src];choice=eject'>Eject</a>" : "<b>To modify access, please insert an ID</b>"]<br>"

			for(var/datum/job/job in current_business.get_jobs())


				page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"
				page_msg += "<legend align='center' style='color: #fff'>[job.title]</legend>"
				page_msg += "<strong>Description:</strong> <br>[job.description ? job.description : "<i>No description provided.</i>"]<br><br>"

				page_msg +=  "<span style=\"font-size: 20px;\">[job.title]</span><br>"

				page_msg += "<a href='?src=\ref[src];choice=set_job_title;job=\ref[job]'>Change Job Title</a>"
				page_msg += "<a href='?src=\ref[src];choice=set_job_desc;job=\ref[job]'>Change Description</a>"
				page_msg += "<a href='?src=\ref[src];choice=delete_job;job=\ref[job]'>Delete Job</a>"

				if(id_card)
					if(job.title == id_card.rank)
						page_msg += "<a href='?src=\ref[src];choice=demote_job;job=\ref[job];card=\ref[id_card]'>Demote From Job</a>"
					else
						page_msg += "<a href='?src=\ref[src];choice=promote_job;job=\ref[job];card=\ref[id_card]'>Promote to Job</a>"

				page_msg += "<br><br>"
				var/job_positions = job.total_positions
				if(0 > job.total_positions)
					job_positions = "Unlimited"
				page_msg += "<strong>Max Positions:</strong> [job_positions] <a href='?src=\ref[src];choice=modify_positions;job=\ref[job]'>Change</a><br>"
				page_msg += "<strong>Wage:</strong> [job.wage] <a href='?src=\ref[src];choice=modify_wage;job=\ref[job]'>Change</a><br>"
				page_msg += "<strong>Synth Wage:</strong> [job.synth_wage] <a href='?src=\ref[src];choice=modify_synth_wage;job=\ref[job]'>Change</a><br>"
				page_msg += "<strong>Mass Produced Vatborn Wage:</strong> [job.mpv_wage] <a href='?src=\ref[src];choice=modify_vatborn_wage;job=\ref[job]'>Change</a><br>"
				page_msg += "<strong>Non-National Wage:</strong> [job.nonnational_wage] <a href='?src=\ref[src];choice=modify_nonnational_wage;job=\ref[job]'>Change</a><br>"

				page_msg += "<strong>Allow Synths?:</strong> [job.allows_synths ? "Yes" : "No"] <a href='?src=\ref[src];choice=synth_toggle;job=\ref[job]'>Toggle</a><br>"

				page_msg += "<strong>Clean Criminal Record Required:</strong> [job.clean_record_required ? "Yes" : "No"] <a href='?src=\ref[src];choice=toggle_record_req;job=\ref[job]'>Toggle</a><br>"
				page_msg += "<strong>Minimum Employee Age:</strong> [job.minimum_character_age] <a href='?src=\ref[src];choice=adjust_minimum_age;job=\ref[job]'>Adjust</a><br>"
				page_msg += "<strong>Exploitable Job*:</strong> [job.minimal_player_age ? "Yes" : "No"] <a href='?src=\ref[src];choice=exploitable_job_toggle;job=\ref[job]'>Toggle</a><br>"
				page_msg += "<strong>Supervisors:</strong> [job.supervisors ? job.supervisors : "None"] <a href='?src=\ref[src];choice=set_supervisors;job=\ref[job]'>Set Supervisors</a><br>"
				page_msg += "<strong>Subordinates:</strong> [job.subordinates ? job.subordinates : "None"] <a href='?src=\ref[src];choice=set_subordinates;job=\ref[job]'>Set Subordinates</a><br>"

				page_msg += "<strong>Accesses:</strong><br>"

				for(var/A in job.access)
					var/access_name = get_biz_access_name_id(A)
					if(!access_name) continue

					page_msg += "[access_name] <a href='?src=\ref[src];choice=remove_access_from_job;job=\ref[job];access=\ref[A]'>x</a>"

				page_msg += "<br><br><a href='?src=\ref[src];choice=add_access_to_job;job=\ref[job]'>Add Accesses</a><br>"

				page_msg += "<br><strong>Exclusive Employees:</strong><br>"
				for(var/E in job.exclusive_employees)
					page_msg += "[job.exclusive_employees[E]] ([E]) <a href='?src=\ref[src];choice=remove_exclusive_employee;job=\ref[job];employee=\ref[E]'>x</a>"

				page_msg += "<br><br><a href='?src=\ref[src];choice=add_unique_employee;job=\ref[job]'>Add Exclusive Employee</a><br>"

				var/decl/hierarchy/outfit/outfit = outfit_by_type(job.outfit_type)

				page_msg += "<br><strong>Outfit:</strong> [outfit ? outfit.name : "None"] "

				page_msg += "<a href='?src=\ref[src];choice=change_outfit;job=\ref[job]'>Change Outfit</a><br>"

				page_msg += "<br><strong>Alternative Titles:</strong><br>"
				for(var/F in job.alt_titles)
					page_msg += "[F] <a href='?src=\ref[src];choice=remove_alt_title;job=\ref[job];title=\ref[F]'>x</a>"

				page_msg += "<br><br><a href='?src=\ref[src];choice=add_alt_title;job=\ref[job]'>Add Alternate Title</a><br>"

				page_msg += "<br><a href='?src=\ref[src];choice=toggle_job_status;job=\ref[job]'>[job.enabled ? "Enabled" : "Disabled"]</a><br>"

				page_msg += "* HR Note: An exploitable job is a job that may provide access to weaponry, dangerous chemicals or has high abuse potential. \
				Toggling this will stricten the hiring standards."


				page_msg += "</fieldset><br>"


	else if(index == 5) // Access Page
		if(!current_business)
			current_business = get_business_by_owner_uid(unique_id)

		if(current_business)
			var/obj/item/weapon/card/id/id_card

			if(program && program.computer && program.computer.card_slot)
				id_card = program.computer.card_slot.stored_card

			page_msg = "<h2>[current_business]</h2><hr>"
			page_msg += "Welcome to your access portal. You can add accesses which you can use.<br><br>"

			page_msg += "[id_card ? "<b>Current ID:</b> [id_card.name] <a href='?src=\ref[src];choice=eject'>Eject</a>" : "<b>To modify access, please insert an ID</b>"]<br>"

			page_msg += "<br><a href='?src=\ref[src];add_access=1'>Add Access</a><hr>"

			for(var/datum/access/A in current_business.business_accesses)
				var/is_on_card = FALSE
				if(id_card && (A.id in id_card.access))
					is_on_card = TRUE

				page_msg += "<br>[A.desc]"
				page_msg += " <a href='?src=\ref[src];choice=edit_access;access=\ref[A]'>Edit Name</a>"
				if(id_card)
					page_msg += " <a href='?src=\ref[src];choice=modify_access_card;access=\ref[A];card=\ref[id_card]'>[is_on_card ? "Remove from ID" : "Add to ID"]</a>"
				page_msg += " <a href='?src=\ref[src];choice=remove_access;access=\ref[A]'>x</a><br>"

		else
			page_msg += "Something went wrong trying to display the job page, please try again!"

	else if(index == 6) // Business List Page
		page_msg = "<h2>Business Directory</h2><hr>"
		page_msg += "Here is a list of active businesses that exist, please select one to continue:<br>"

		for(var/datum/business/B in GLOB.all_businesses)
			page_msg += " <a href='?src=\ref[src];choice=select_business;biz=\ref[B]'>[B.name]</a><br>"


	else if(index == 7) // Business Viewer
		page_msg = "<h2>Business Directory</h2><hr>"
		if(selected_business)
			page_msg += "<h2>[selected_business.name]</h2><hr>"
			page_msg += "<b>Name:</b> [selected_business.name]<br>"
			if(selected_business.description)
				page_msg += "<b>Description:</b> [selected_business.description]<br>"
			page_msg += "<b>Unique ID:</b> [selected_business.business_uid]<br>"
			page_msg += "<b>Suspended:</b> [selected_business.suspended ? "Yes" : "No"]<br>"
			if(selected_business.suspended)
				page_msg += "<b>Suspended Reason: [selected_business.suspended_reason]<br>"
			page_msg += "<b>Created:</b> [selected_business.creation_date]<br>"
			page_msg += "<b>Owner:</b> [selected_business.get_owner_name()]<br>"

			var/datum/department/biz_dept = dept_by_id(selected_business.department)

			if(biz_dept && biz_dept.has_bank)
				page_msg += "<b>Net Worth:</b> [cash2text( biz_dept.get_balance(), FALSE, TRUE, TRUE )]<br>"
				page_msg += "<b>Bank ID:</b> [biz_dept.bank_account.account_number]<br>"
				page_msg += "<b>Taxed:</b> [biz_dept.business_taxed ? "Yes" : "No"]<br>"

			page_msg += " <a href='?src=\ref[src];business_transactions=1'>Print Transaction History</a><br>"
		else
			page_msg += "This business does not exist, please try again."
	data["index"] = index
	data["page_msg"] = page_msg
	data["full_name"] = full_name
	data["error_msg"] = error_msg
	data["current_business"] = (current_business || selected_business)

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "business_manager.tmpl", "Business Management Utility", 690, 680, state = state)
		if(program.update_layout())
			ui.auto_update_layout = 1
		ui.set_auto_update(1)
		ui.set_initial_data(data)
		ui.open()



///
/datum/computer_file/program/business_manager/proc/print_business_transaction(mob/user)
	var/datum/nano_module/program/business_manager/biz_mgr = NM
	if(!biz_mgr)
		return

	to_chat(usr, span("notice", "Printing transaction balance..."))

	var/datum/department/biz_dept = dept_by_id(biz_mgr.selected_business.department)
	if(!biz_dept || !biz_dept.bank_account)
		return

	var/R
	R += "<b>Transaction logs</b>: [biz_dept.name]<br>"
	R += "<i>Account holder:</i> [biz_dept.bank_account.owner_name]<br>"
	R += "<i>Account ID:</i> [biz_dept.bank_account.account_number]<br>"
	R += "<i>Date and time:</i> [stationtime2text()], [GLOB.current_date_string]<br><br>"
	R += "<table border=1 style='width:100%'>"
	R += "<tr>"
	R += "<td><b>Date</b></td>"
	R += "<td><b>Time</b></td>"
	R += "<td><b>Target</b></td>"
	R += "<td><b>Purpose</b></td>"
	R += "<td><b>Value</b></td>"
	R += "</tr>"
	for(var/datum/transaction/T in biz_dept.bank_account.transaction_log)
		R += "<tr>"
		R += "<td>[T.date]</td>"
		R += "<td>[T.time]</td>"
		R += "<td>[T.target_name]</td>"
		R += "<td>[T.purpose]</td>"
		R += "<td>[T.amount]</td>"
		R += "</tr>"
		CHECK_TICK
	R += "</table>"

	if(!computer.nano_printer.print_text(R, "Business Transation Data: [biz_dept.name]"))
		to_chat(user, "Hardware error: Printer was unable to print the file. It may be out of paper.")
		return


/datum/nano_module/program/business_manager/Topic(href, href_list)
	if(..()) return 1

	switch(href_list["action"])
		if("sw_menu")
			. = 1
			index = text2num(href_list["target"])

	if(href_list["main_menu"])
		. = 1
		index = 1
		reset_fields()

	if(href_list["back"])
		. = 1
		if(current_business)
			index = 2
		else if(selected_business)
			selected_business = null
			index = 6
		else
			index = 1
			reset_fields()

	if(href_list["register_biz"])
		index = 3

	if(href_list["manage_jobs"])
		index = 4

	if(href_list["manage_access"])
		index = 5

	if(href_list["manage_access"])
		if(!current_business)
			return

	if(href_list["edit_biz_color"])
		if(!current_business)
			return
		var/datum/department/biz_dept = dept_by_id(current_business.department)

		if(!biz_dept)
			return

		var/temp = input(usr, "Choose a business color.", "Business Color", biz_dept.dept_color) as color
		if(temp)
			biz_dept.dept_color = temp

	if(href_list["business_login"])
		var/list/all_bizzies = list()
		for(var/datum/business/B in GLOB.all_businesses)
			all_bizzies += B.name

		var/login_biz = input(usr, "Please select a business to log into.", "Business Login") as null|anything in all_bizzies
		var/datum/business/login_business = get_business_by_name(login_biz)

		if(!login_business)
			alert("No business found with that name, it may have been deleted - contact an administrator.")
			return

		var/access_password = sanitize(copytext(input(usr, "Please provide the password. (Max 40 letters)", "Business Management Utility")  as text,1,40))

		if(!login_business || (access_password != login_business.access_password))
			alert("Incorrect password, please try again.")
			return

		current_business = login_business
		index = 2


	if(href_list["add_access"])
		if(!current_business)
			return

		if(LAZYLEN(current_business.business_accesses) >= MAX_BUSINESS_ACCESSES)
			error_msg = "You can only have a maximum of [MAX_BUSINESS_ACCESSES] accesses."
			return

		var/new_access = sanitize(copytext(input(usr, "Enter a new access name (Max 50 letters)", "Business Management Utility")  as text,1,50))

		if(!new_access | !current_business)
			return

		if(LAZYLEN(current_business.business_accesses) >= MAX_BUSINESS_ACCESSES)	// nice try
			error_msg = "You can only have a maximum of [MAX_BUSINESS_ACCESSES] accesses."
			return

		if(length(new_access) > 50)
			error_msg = "Access name cannot exceed 50 characters."
			return

		current_business.create_new_access(new_access)


	if(href_list["add_new_job"])
		if(!current_business)
			return

		var/new_job = sanitize_name(copytext(input(usr, "Enter a new job title. (Max 40 letters)", "Business Management Utility", b_pass)  as text,1,40))

		if(!new_job)
			return

		if(!(LAZYLEN(current_business.business_jobs) >= MAX_BUSINESS_JOBS))
			current_business.create_new_job(new_job)
		else
			error_msg = "You can only have a maximum of [MAX_BUSINESS_JOBS] jobs."

	if(href_list["change_password"])
		var/biz_pass = sanitize(copytext(input(usr, "Enter your new password. (Max 40 letters)", "Business Management Utility", b_pass)  as text,1,40))
		if(!biz_pass || !current_business)
			return

		if(length(biz_pass) > 40)
			error_msg = "Business name cannot exceed 40 characters."
			return
		current_business.access_password = biz_pass


	if(href_list["modify_category"])
		if(!current_business)
			return

		var/service = input(usr, "Choose what you want to do.", "Modify Categories") as null|anything in list("Cancel", "Remove Category", "Add Category")

		switch(service)
			if("Cancel")
				return

			if("Remove Category")
				var/biz_category = input(usr, "Select a category to remove.", "Edit Category") as null|anything in current_business.categories
				if(!biz_category || !current_business)
					return
				if(LAZYLEN(current_business.categories) == 1)
					error_msg = "You only have one category! Because you need at least one, please add one before removing this one."
					return

				if(biz_category in current_business.categories)
					current_business.categories -= biz_category


			if("Add Category")
				var/biz_category = input(usr, "Select a category to add (Max 3).", "Edit Category") as null|anything in GLOB.business_categories
				if(!biz_category || !current_business)
					return

				if(LAZYLEN(current_business.categories) >= 3)
					error_msg = "Amount of categories cannot exceed three."
					return

				if(biz_category in current_business.categories)
					error_msg = "This category is already in your list!"
					return

				current_business.categories += biz_category


	if(href_list["edit_biz_desc"])
		if(!current_business)
			return
		var/biz_desc = sanitize(copytext(input(usr, "Enter a brief business description. (340 chars max)", "Business Management Utility", current_business.description)  as message,1,340))
		if(!biz_desc)
			return

		if(length(biz_desc) > 340)
			error_msg = "Business description cannot exceed 340 characters."
			return

		current_business.change_description(biz_desc)


	if(href_list["rename_business"])
		if(!current_business)
			return
		var/biz_name = sanitize_name(copytext(input(usr, "Enter your business name (40 chars max)", "Business Management Utility", b_name)  as text,1,40))
		if(!biz_name)
			return
		if(length(biz_name) > 40)
			error_msg = "Business name cannot exceed 40 characters."
			return
		current_business.rename_business(biz_name)

		alert("Business renamed to [biz_name].")

	if(href_list["toggle_ceo_pay"])

		if(!current_business)
			return

		current_business.pay_CEO = !current_business.pay_CEO



	if(href_list["transfer_money"])
		if(!current_business)
			return

		var/datum/money_account/department/business_account = dept_acc_by_id(current_business.department)

		if(!business_account)
			error_msg = "Issue accessing business account. Please contact support."
			return


		var/account_id = sanitize(copytext(input(usr, "Please enter the bank id of the account you are sending money to.", "Business Management Utility", null)  as text,1,70))

		if(!account_id)
			return

		var/datum/money_account/account_to_send = get_account(account_id)

		if(!account_to_send)
			error_msg = "This account does not appear to exist."
			return

		var/datum/money_account/D = get_account(current_business.owner.bank_id)
		var/attempt_pin = ""
		if(D && D.security_level)
			attempt_pin = input("Enter your personal bank account PIN (Verification Purposes Only)", "Transaction") as num


		if(!attempt_account_access(current_business.owner.bank_id, attempt_pin, 2) )
			error_msg = "There was an error with authenticating your bank account. Please contact your bank's administrator."
			return


		var/amount = input(usr, "How much would you like to transfer?.", "Transfer Amount")  as num

		if(!amount || (0 > amount))
			error_msg = "Please enter a valid amount."
			return

		if(amount > business_account.money)
			error_msg = "There are not enough funds in your business account to transfer to this account."
			return

		business_account.charge(amount, account_to_send, "Business Account Transfer [business_account.owner_name] Department")

		alert("[cash2text( amount, FALSE, TRUE, TRUE )] successfully sent to account id #[account_id] ([account_to_send.owner_name])")


	if(href_list["business_transactions"])
		if(!selected_business)
			return
		var/datum/computer_file/program/business_manager/printprog = program
		printprog.print_business_transaction(usr)

	if(href_list["add_funds"])
		if(!current_business)
			return

		if(!current_business.owner || !current_business.owner.bank_id)
			return

		var/datum/department/dept = dept_by_id(current_business.department)
		var/datum/money_account/department/business_account = dept_acc_by_id(current_business.department)

		if(!dept || !business_account)
			return

		var/paying = input(usr, "Please input funding amount to add to your account balance.", "Pay Balance") as num|null

		if(!paying || 0 > paying)
			return

		var/datum/money_account/D = get_account(current_business.owner.bank_id)
		var/attempt_pin = ""
		if(D && D.security_level)
			attempt_pin = input("Enter PIN", "Transaction") as num


		if(!attempt_account_access(current_business.owner.bank_id, attempt_pin, 2) )
			error_msg = "There was an error with authenticating your bank account. Please contact your bank's administrator."
			return

		if(paying > D.money)
			error_msg = "You have insufficient funds."
			return

		if(!charge_to_account(current_business.owner.bank_id, "Business Management System", "Funds Transfers [current_business.name]", "City Council DB #[rand(200,500)]", -paying))
			error_msg = "Unfortunately, your bank account cannot currently be charged at this time. Please check with an administrator."
			return

		dept.adjust_funds(paying, "Funds Transfer via Business Portal")

	if(href_list["withdraw_balance"])
		if(!current_business)
			return

		var/datum/money_account/department/business_account = dept_acc_by_id(current_business.department)

		if(!business_account)
			error_msg = "Issue accessing business account. Please contact support."
			return

		if(!get_account( current_business.get_owner_bank_id() ))
			error_msg = "Cannot find owner account, update your business details as soon as possible."
			return

		if(0 >= business_account.money)
			error_msg = "Your business account balance is either empty/in arrears and you are unable to withdraw funds."
			return

		if("No" == alert("Would you like to withdraw business funds into your bank account?", "Withdraw Business Funds", "No", "Yes"))
			return

		var/withdraw = input(usr, "Please enter how much you would like to withdraw.", "Withdraw Balance", business_account.money) as num|null

		if(!withdraw)
			return

		if(0 > withdraw)
			return

		if(withdraw > business_account.money)
			error_msg = "You only have [cash2text( business_account.money, FALSE, TRUE, TRUE )] in your business account. Please choose an amount no larger than this."
			return


		var/datum/department/dept = dept_by_id(current_business.department)
		dept.direct_charge_money(current_business.get_owner_bank_id(), dept.name, withdraw, "Business Account Withdrawal [business_account.owner_name] Department", "Business Management Portal")



	if(href_list["set_business_name"])
		. = 1
		var/biz_name = sanitize(copytext(input(usr, "Enter your business name (40 chars max)", "Business Management Utility", b_name)  as text,1,40))
		if(!biz_name)
			return
		if(length(biz_name) > 40)
			alert("Business name cannot exceed 40 characters.")
			return
		b_name = biz_name
		index = 3

	if(href_list["set_business_cats"])
		. = 1
		var/biz_category = input(usr, "Select a category to add (Max 3).", "Edit Category") as null|anything in GLOB.business_categories

		if(!biz_category)
			return

		if(biz_category in b_categories)
			reg_error = "This category is already in your list!"
			return

		if(LAZYLEN(b_categories) >= 3)
			reg_error = "Amount of categories cannot exceed three."
			return

		b_categories += biz_category
		index = 3


	if(href_list["set_business_desc"])
		. = 1
		var/biz_desc = sanitize(copytext(input(usr, "Enter a brief business description. (340 chars max)", "Business Management Utility", b_desc)  as message,1,340))
		if(!biz_desc)
			return

		if(length(biz_desc) > 340)
			alert("Business description cannot exceed 340 characters.")
			return
		b_desc = biz_desc
		index = 3

	if(href_list["set_biz_pass"])
		. = 1
		var/biz_pass = sanitize(copytext(input(usr, "Enter your password. (Max 40 words)", "Business Management Utility", b_pass)  as text,1,40))
		if(!biz_pass)
			return

		if(length(biz_pass) > 40)
			alert("Business name cannot exceed 40 characters.")
			return
		b_pass = biz_pass
		index = 3

	if(href_list["submit_new_business"])
		. = 1

		var/obj/item/weapon/card/id/I = usr.GetIdCard()

		if(get_business_by_owner_uid(unique_id))
			reg_error = "Sorry! Only one business per individual may be registered. Consider expanding or closing your existing business first!"
			return

		if(!b_name)
			reg_error = "You need to enter a business name!"
			return

		if(get_business_by_name(b_name))
			reg_error = "This business name already exists. Please choose another."
			return

		if(b_desc == initial(b_desc) || !b_desc )
			reg_error = "The business description cannot be left blank!"
			return

		if(b_pass == initial(b_pass) || !b_pass )
			reg_error = "A password is required!"
			return

		if(isemptylist(b_categories) || !b_categories )
			reg_error = "You must select at least one category!"
			return

		if("No" == alert("Register [b_name] for [SSpersistent_options.get_persistent_option_value("business_registration")] credits?", "Register Business", "No", "Yes"))
			return

		if(!I || !I.associated_account_number || !I.associated_pin_number)
			reg_error = "No identification payment card or valid valid bank details detected."
			return

		if(!email)
			reg_error = "There is no email address associated with your citizen ID, please contact an administrator to rectify this."
			return

		var/datum/money_account/D = get_account(I.associated_account_number)
		var/attempt_pin = ""
		if(D && D.security_level)
			attempt_pin = input("Enter PIN", "Transaction") as num


		if(!attempt_account_access(I.associated_account_number, attempt_pin, 2) )
			reg_error = "There was an error charging your bank account. Please contact your bank's administrator."
			return

		if(SSpersistent_options.get_persistent_option_value("business_registration") > D.money)
			reg_error = "You have insufficient funds to make this transaction."
			return

		if(!charge_to_account(I.associated_account_number, "[b_name] Registration", "Business Registration Fee", "Business Management", SSpersistent_options.get_persistent_option_value("business_registration") ))
			reg_error = "There was an error charging your bank account. Please contact your bank's administrator."
			return

		var/datum/business/new_biz = create_new_business(b_name, b_desc, b_pass, b_categories, unique_id, full_name, email, I.associated_account_number)

		if(!new_biz)
			reg_error = "There was an error creating your business. Please hold onto your transactional reciepts and contact an administrator."
			return

		var/datum/department/council = dept_by_id(DEPT_COUNCIL)
		council.adjust_funds(SSpersistent_options.get_persistent_option_value("business_registration"), "Business Registration for [new_biz.name]")
		show_custom_page("Success, your business - [new_biz.name] has been created. An email has been sent with the full details.")


	// Choices menus
	if(href_list["choice"])
		switch(href_list["choice"])

			if("select_business")
				var/B = locate(href_list["biz"])
				var/datum/business/biz = B

				if(!biz)
					return

				selected_business = biz
				index = 7


			if("remove_access")
				var/C = locate(href_list["access"])
				var/datum/access/access = C

				if(!current_business || !access)
					return

				current_business.business_accesses -= access

			if("edit_access")
				var/C = locate(href_list["access"])
				var/datum/access/access = C

				if(!current_business || !access)
					return

				var/access_name = sanitize(copytext(input(usr, "Enter a new access name (Max 50 letters)", "Business Management Utility", access.desc)  as text,1,50))

				if(length(access_name) > 50)
					error_msg = "Access name cannot exceed 50 characters."
					return

				if(!current_business || !access || !access_name)
					return

				access.desc = access_name



			if("remove_cat")
				var/E = locate(href_list["cat"])
				var/cat = E
				if(cat in b_categories)
					b_categories -= cat
				index = 3


	//Job Modification
			if("add_unique_employee")


				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				var/employee_list = list()

				for(var/datum/data/record/R in data_core.general)
					if(!R.fields["name"])
						continue
					employee_list += R.fields["name"]

				if(!employee_list)
					error_msg = "No civilian records exist on the system to select from!"

				var/employee = input(usr, "Please select a person to add to this job's listings.", "Edit Employees") as null|anything in employee_list

				if(!employee)
					return

				var/unique_id_empl = ""

				for(var/datum/data/record/C in data_core.general)
					if(C.fields["name"] == employee)
						unique_id_empl = C.fields["unique_id"]

				if(!current_business || !job)
					return

				job.exclusive_employees[unique_id_empl] = employee

			if("remove_exclusive_employee")
				var/E = locate(href_list["job"])
				var/datum/job/job = E
				var/EMP = locate(href_list["employee"])

				if(!job || !EMP)
					return

				job.exclusive_employees -= EMP

			if("modify_positions")


				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return
				var/new_pos = input("Enter amount of positions for job. Leave to 0 for infinite slots.", "Select Positions", job.total_positions) as num


				if(!new_pos || (0 > new_pos))
					job.total_positions = -1
				else
					if(new_pos > 20)
						job.total_positions = 20
					else
						job.total_positions = new_pos

			if("modify_wage")

				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return
				var/minimum_wage = SSpersistent_options.get_persistent_option_value("minimum_wage")
				var/new_wage = input("Enter the new wage for this role. Please note it is hourly. (Minimum [minimum_wage])", "Select Positions", job.wage) as num


				if((0 > new_wage) || !new_wage || (minimum_wage > new_wage))
					job.wage = minimum_wage
				else
					job.wage = new_wage


			if("modify_synth_wage")

				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				var/minimum_wage = SSpersistent_options.get_persistent_option_value("synth_minimum_wage")
				var/synth_option = alert("What would you like to do?", "Synth Wage", "Adjust Synth Wage", "Remove Synth Wage", "Cancel")

				if(synth_option== "Cancel")
					return

				if(synth_option== "Remove Synth Wage")
					job.synth_wage = null
					return

				if(!SSpersistent_options.get_persistent_option_value("discrim_synth"))
					alert("Synthetics are subjected to equal rights at this moment.")
					job.synth_wage = null
					return

				var/new_wage = input("Enter the new wage for this role. Please note it is hourly. (Minimum [minimum_wage])", "Select Positions", job.synth_wage) as num


				if((0 > new_wage) || !new_wage || (minimum_wage > new_wage))
					job.synth_wage = minimum_wage
				else
					job.synth_wage = new_wage

			if("modify_vatborn_wage")

				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				var/minimum_wage = SSpersistent_options.get_persistent_option_value("vatborn_minimum_wage")
				var/synth_option = alert("What would you like to do?", "Mass Produced Vatborn Wage", "Adjust Mass Produced Vatborn Wage", "Remove Mass Produced Vatborn Wage", "Cancel")

				if(synth_option== "Cancel")
					return

				if(synth_option== "Remove Mass Produced Vatborn Wage")
					job.mpv_wage = null
					return

				if(!SSpersistent_options.get_persistent_option_value("discrim_bvatborn"))
					alert("Mass Produced Vatborn are subjected to equal rights at this moment.")
					job.mpv_wage = null
					return

				var/new_wage = input("Enter the new wage for this role. Please note it is hourly. (Minimum [minimum_wage])", "Select Positions", job.mpv_wage) as num


				if((0 > new_wage) || !new_wage || (minimum_wage > new_wage))
					job.mpv_wage = minimum_wage
				else
					job.mpv_wage = new_wage


			if("modify_nonnational_wage")

				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				var/minimum_wage = SSpersistent_options.get_persistent_option_value("nonnational_minimum_wage")
				var/synth_option = alert("What would you like to do?", "Non-National Wage", "Adjust Non-National Wage", "Remove Non-National Wage", "Cancel")

				if(synth_option== "Cancel")
					return

				if(synth_option== "Remove Non-National Wage")
					job.nonnational_wage = null
					return

				if(!SSpersistent_options.get_persistent_option_value("discrim_nonnational"))
					alert("Non-national citizens are subjected to equal rights at this moment.")
					job.nonnational_wage = null
					return

				var/new_wage = input("Enter the new wage for this role. Please note it is hourly. (Minimum [minimum_wage])", "Select Positions", job.nonnational_wage) as num


				if((0 > new_wage) || !new_wage || (minimum_wage > new_wage))
					job.nonnational_wage = minimum_wage
				else
					job.nonnational_wage = new_wage

			if("toggle_record_req")

				var/E = locate(href_list["job"])
				var/datum/job/job = E

				if(!current_business || !job)
					return

				if(!SSpersistent_options.get_persistent_option_value("discrim_excon"))
					alert("Ex-Convict citizens are subjected to equal rights at this moment.")
					job.clean_record_required = FALSE
					return

				job.clean_record_required = !job.clean_record_required


			if("adjust_minimum_age")

				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return
				var/new_age = input("Enter the minimum age needed to work here (Minimum 18)", "Select Positions", job.minimum_character_age) as num


				if(!new_age || (18 > new_age))
					job.minimum_character_age = 18
				else
					job.minimum_character_age = new_age


			if("exploitable_job_toggle")	// to prevent grief, makes jobs a min of two weeks old

				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				if(job.minimal_player_age)
					job.minimal_player_age = 0
				else
					job.minimal_player_age = 14

			if("synth_toggle")	// to prevent grief, makes jobs a min of two weeks old

				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				if(!SSpersistent_options.get_persistent_option_value("discrim_synth"))
					alert("The government has not permitted the discrimination of synthetics in employment at this time.")
					job.allows_synths = TRUE
					return

				job.allows_synths = !job.allows_synths


			if("set_supervisors")

				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				var/new_supervisor = sanitize(copytext(input(usr, "Who or what role supervises for this job?", "Business Management Utility", job.supervisors)  as text,1,80))
				if(!new_supervisor)
					return
				if(length(new_supervisor) > 80)
					error_msg = "Supervisor description cannot exceed 80 characters."
					return

				job.supervisors = new_supervisor

			if("set_subordinates")

				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				var/new_sub = sanitize(copytext(input(usr, "Does this role have subordinates or a department they manage?", "Subordinates", job.subordinates)  as text,1,80))
				if(!new_sub)
					return
				if(length(new_sub) > 80)
					error_msg = "Subordinate description cannot exceed 80 characters."
					return

				job.subordinates = new_sub

			if("remove_access_from_job")
				var/E = locate(href_list["job"])
				var/datum/job/job = E

				var/V = locate(href_list["access"])
				var/job_access = V

				if(!current_business || !job || !job_access || !(job_access in job.access))
					return

				job.access -= job_access

				if(job_access in job.minimal_access)
					job.minimal_access -= job_access

			if("add_access_to_job")
				var/E = locate(href_list["job"])
				var/datum/job/job = E

				if(!current_business || !job)
					return

				if(isemptylist(current_business.business_accesses))
					error_msg = "No access data found - please make new accesses from the access panel."
					return

				var/list/access_add = list()
				for(var/datum/access/A in current_business.business_accesses)
					if(A.id in job.access)
						continue
					access_add += A.desc

				if(isemptylist(access_add))
					error_msg = "You currently don't have any more accesses to add to this job."
					return

				var/new_access = input(usr, "Select an access to add to this job.", "Edit Access") as null|anything in access_add

				if(!new_access || !current_business || !job)
					return

				for(var/datum/access/A in current_business.business_accesses)
					if(A.desc == new_access)
						job.access |= A.id
						job.minimal_access |= A.id
						break

			if("demote_job")
				var/E = locate(href_list["job"])
				var/datum/job/job = E
				var/G = locate(href_list["card"])
				var/obj/item/weapon/card/id/id = G

				if(!current_business || !job || !id)
					return

				id.rank = "Civilian"
				id.assignment = "Civilian"

				for(var/V in job.access)
					id.access -= V

				var/datum/data/record/R = gen_record_by_uid(unique_id)

				if(R)
					R.fields["rank"] = "Civilian"
					R.fields["real_rank"] = "Civilian"

				alert("You have removed [job.title] to the ID card.")


			if("promote_job")
				var/E = locate(href_list["job"])
				var/datum/job/job = E
				var/G = locate(href_list["card"])
				var/obj/item/weapon/card/id/id = G

				if(!current_business || !job || !id)
					return

				id.rank = job.title
				id.assignment = job.title

				var/datum/data/record/R = gen_record_by_uid(unique_id)

				var/new_title

				if(LAZYLEN(job.alt_titles))
					var/choices = list(job.title) + job.alt_titles
					new_title = input("Choose a new job title for this ID.", "Choose Title", job.title) as anything in choices|null

				if(R)
					R.fields["rank"] = (new_title ? new_title : job.title)
					R.fields["real_rank"] = job.title

				if(id.registered_name)
					id.name = "[id.registered_name]'s ID Card ([new_title ? new_title : job.title])"

				for(var/V in job.access)
					id.access += V

				alert("You have added [job.title] to the ID card.")



			if("add_alt_title")
				var/E = locate(href_list["job"])
				var/datum/job/job = E

				if(!job)
					return

				var/new_alt = sanitize(copytext(input(usr, "Please enter a new alt title.", "New alt title")  as text,1,40))
				if(!new_alt || !job)
					return

				if(LAZYLEN(job.alt_titles) > 4)
					error_msg = "You may add no more than five alternate job titles."
					return

				if(length(new_alt) > 40)
					error_msg = "Alternate title cannot exceed 40 characters."
					return

				if(!job.alt_titles)
					job.alt_titles = list()

				job.alt_titles += new_alt

			if("remove_alt_title")
				var/E = locate(href_list["job"])
				var/datum/job/job = E
				var/F = locate(href_list["title"])
				var/alt_title = F

				if(!(alt_title in job.alt_titles))
					return

				job.alt_titles -= alt_title

			if("change_outfit")
				var/E = locate(href_list["job"])
				var/datum/job/job = E

				if(!current_business || !job)
					return

				var/new_outfit = input(usr, "Select an outfit for this occupation.", "Edit Outfit") as null|anything in business_outfits

				if(!new_outfit || !current_business || !job)
					return

				var/list/L = business_outfits[new_outfit]

				job.outfit_type = L["path"]

			if("toggle_job_status")
				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				job.enabled = !job.enabled


			if("set_job_title")
				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				// making sure payroll doesn't get borkoborked
				for(var/datum/data/record/R in data_core.general)
					var/employee_title = R.fields["real_rank"]
					if(employee_title == job.title)
						error_msg = "Apologies, it appears that you have an employee actively working on payroll, \
						please edit this job title when they have finished their shift."

						return

				var/job_title = sanitize_name(copytext(input(usr, "Enter a new job title. (Max 40 letters)", "Business Management Utility", job.title)  as text,1,40))

				if(!job_title || !current_business || !job)
					return

				if(length(job_title) > 140)
					alert("Job title cannot exceed 140 characters.")
					return

				job.title = job_title


			if("set_job_desc")
				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				var/job_desc = sanitize(copytext(input(usr, "Enter a job description. (240 chars max)", "Business Management Utility", job.description)  as message,1,340))
				if(!job_desc || !current_business || !job)
					return

				if(length(job_desc) > 340)
					error_msg = "Job description cannot exceed 340 characters."
					return
				job.description = job_desc


			if("delete_job")
				var/E = locate(href_list["job"])
				var/datum/job/job = E
				if(!current_business || !job)
					return

				// making sure payroll doesn't get borkoborked
				for(var/datum/data/record/R in data_core.general)
					var/employee_title = R.fields["real_rank"]
					if(employee_title == job.title)

						error_msg = "Apologies, it appears that you have an employee actively working on payroll, \
						please delete this job when they have finished their shift."

						return

				current_business.business_jobs -= job
				SSjobs.occupations -= job
				qdel(job)

			if("modify_access_card")
				var/F = locate(href_list["access"])
				var/G = locate(href_list["card"])
				var/datum/access/access = F
				var/obj/item/weapon/card/id/id = G

				if(!current_business || !access || !id)
					return

				if(access.id in id.access)
					id.access -= access.id
				else
					id.access += access.id

			if("eject")
				if(program && program.computer && program.computer.card_slot)
					program.computer.proc_eject_id(usr)
