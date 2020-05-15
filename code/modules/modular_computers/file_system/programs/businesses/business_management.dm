
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
	b_categories = list()

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

		current_business = get_business_by_owner_uid(unique_id)

		if(current_business)
			var/datum/department/biz_dept = dept_by_id(current_business.department)

			page_msg = "<h2>[current_business]</h2><hr>"

			if(biz_dept && biz_dept.has_bank)
				page_msg += "<b>Business Account Balance:</b> [cash2text( biz_dept.get_balance(), FALSE, TRUE, TRUE )]<br>"
				page_msg += "<b>Bank ID:</b> [biz_dept.bank_account.account_number]<br>"
				page_msg += "<a href='?src=\ref[src];withdraw_balance=1'>Withdraw Balance</a>"
				page_msg += "<a href='?src=\ref[src];transfer_money=1'>Transfer Money</a>"

			page_msg += "<br><br><b>Business:</b> [current_business.name]<br>"
			page_msg += "<b>Creation Date:</b> [current_business.creation_date]<br>"
			page_msg += "<b>Unique Identifier:</b> [current_business.business_uid]<br>"
			page_msg += "<b>Taxed:</b> [current_business.gets_business_tax ? "Yes" : "No"]<br>"
			page_msg += "<b>Owner:</b> [current_business.get_owner_name()]<br>"
			page_msg += "<b>Status:</b> [current_business.get_status()]<br>"
			if(current_business.suspended)
				page_msg += "[current_business.suspended_reason]<br>"

			// Business Tools

			page_msg += "<br>There are a range of settings you can utilize below:<br>"

			// : General
			page_msg += "<br><br><b>General Settings: </b><br>"
			page_msg += "<a href='?src=\ref[src];rename_business=1'>Rename Business</a>"
			page_msg += "<a href='?src=\ref[src];edit_biz_desc=1'>Edit Description</a>"
			page_msg += "<a href='?src=\ref[src];modify_category=1'>Modify Categories</a>"
			page_msg += "<a href='?src=\ref[src];change_password=1'>Change Access Password</a>"

			// : Employment
			page_msg += "<br><br><b>Employment: </b><br>"

			page_msg += "<a href='?src=\ref[src];manage_employees=1'>Manage Current Employees</a>"
			page_msg += "<a href='?src=\ref[src];manage_jobs=1'>Manage Jobs</a>"

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

			for(var/datum/job/job in current_business.get_jobs())

				page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"
				page_msg += "<legend align='center' style='color: #fff'>[job.title]</legend>"
				page_msg += "<strong>Description:</strong> <br>[job.description]<br><br>"

				page_msg += "<a href='?src=\ref[src];choice=change_job_title'>Change Job Title</a>"
				page_msg += "<a href='?src=\ref[src];choice=change_job_title'>Change Description</a>"

				page_msg += "<br><br>"
				var/job_positions = job.total_positions
				if(0 > job.total_positions)
					job_positions = "Unlimited"
				page_msg += "<strong>Max Positions:</strong> [job_positions] <a href='?src=\ref[src];'>Change</a><br>"
				page_msg += "<strong>Wage:</strong> [job.wage] <a href='?src=\ref[src];'>Change</a><br>"
				page_msg += "<strong>Clean Criminal Record Required:</strong> [job.clean_record_required ? "Yes" : "No"] <a href='?src=\ref[src];'>Change</a><br>"
				page_msg += "<strong>Minimum Employee Age:</strong> [job.minimum_character_age] <a href='?src=\ref[src];'>Change</a><br>"
				page_msg += "<strong>Days Required in City:</strong> [job.minimal_player_age] <a href='?src=\ref[src];'>Change</a><br>"
				page_msg += "<strong>Supervisors:</strong> [job.supervisors] <a href='?src=\ref[src];'>Change</a><br>"
				page_msg += "<strong>Subordinates:</strong> [job.subordinates] <a href='?src=\ref[src];'>Change</a><br>"

				page_msg += "<strong>Accesses:</strong> PLACEHOLDER <a href='?src=\ref[src];'>Adjust Accesses</a><br>"

				page_msg += "<strong>Outfit:</strong> PLACEHOLDER <a href='?src=\ref[src];'>Change Outfit</a><br>"


				page_msg += "</fieldset><br>"
		else
			page_msg += "Something went wrong trying to display the job page, please try again!"


	data["index"] = index
	data["page_msg"] = page_msg
	data["full_name"] = full_name
	data["error_msg"] = error_msg
	data["current_business"] = current_business

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "business_manager.tmpl", "Business Management Utility", 690, 680, state = state)
		if(program.update_layout())
			ui.auto_update_layout = 1
		ui.set_auto_update(1)
		ui.set_initial_data(data)
		ui.open()




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
		index = 1
		reset_fields()

	if(href_list["register_biz"])
		index = 3

	if(href_list["manage_jobs"])
		index = 4

	if(href_list["change_password"])
		var/biz_pass = sanitize(copytext(input(usr, "Enter your new password. (Max 40 words)", "Business Management Utility", b_pass)  as text,1,40))
		if(!biz_pass || !current_business)
			return

		if(length(biz_pass) > 40)
			alert("Business name cannot exceed 40 characters.")
			return
		current_business.access_password = biz_pass


	if(href_list["modify_category"])
		if(!current_business)
			return

		switch(alert(usr, "Remove Category","Add Category","Cancel"))
			if("Cancel")
				return

			if("Remove Category")
				var/biz_category = input(usr, "Select a category to remove.", "Edit Category") as null|anything in current_business.categories
				if(!biz_category || !current_business)
					return
				if(biz_category in current_business.categories)
					current_business.categories -= biz_category


			if("Add Category")
				var/biz_category = input(usr, "Select a category to add (Max 3).", "Edit Category") as null|anything in GLOB.business_categories
				if(!biz_category || !current_business)
					return

				current_business.categories += biz_category


	if(href_list["edit_biz_desc"])
		if(!current_business)
			return
		var/biz_desc = sanitize(copytext(input(usr, "Enter a brief business description. (140 chars max)", "Business Management Utility", current_business.description)  as message,1,140))
		if(!biz_desc)
			return

		if(length(biz_desc) > 140)
			alert("Business description cannot exceed 140 characters.")
			return
		b_desc = biz_desc
		index = 3


	if(href_list["rename_business"])
		if(!current_business)
			return
		var/biz_name = sanitize(copytext(input(usr, "Enter your business name (40 chars max)", "Business Management Utility", b_name)  as text,1,40))
		if(!biz_name)
			return
		if(length(biz_name) > 40)
			alert("Business name cannot exceed 40 characters.")
			return
		current_business.rename_business(biz_name)

		alert("Business renamed to [biz_name].")


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


		var/amount = input(usr, "How much would you like to transfer?.", "Transfer Amount")  as num

		if(!amount || (0 > amount))
			error_msg = "Please enter a valid amount."
			return

		if(amount > business_account.money)
			error_msg = "There are not enough funds in your business account to transfer to this account."
			return

		business_account.charge(amount, account_to_send, "Business Account Transfer [business_account.owner_name] Department")

		alert("[cash2text( amount, FALSE, TRUE, TRUE )] successfully sent to account id #[account_id] ([account_to_send.owner_name])")



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

			if(!charge_to_account(current_business.get_owner_bank_id(), "Business Management Utility", "Withdraw balance for [current_business.name]", "City Council DB #[rand(200,500)]", withdraw))
				error_msg = "Unfortunately, it is not possible to send money to your account. Please check with an administrator."
				return


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
		var/biz_desc = sanitize(copytext(input(usr, "Enter a brief business description. (140 chars max)", "Business Management Utility", b_desc)  as message,1,140))
		if(!biz_desc)
			return

		if(length(biz_desc) > 140)
			alert("Business description cannot exceed 140 characters.")
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

		if("No" == alert("Register [b_name] for [persistent_economy.business_registration] credits?", "Register Business", "No", "Yes"))
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

		if(persistent_economy.business_registration > D.money)
			reg_error = "You have insufficient funds to make this transaction."
			return

		if(!charge_to_account(I.associated_account_number, "[b_name] Registration", "Business Registration Fee", "Business Management", -persistent_economy.business_registration ))
			reg_error = "There was an error charging your bank account. Please contact your bank's administrator."
			return

		var/datum/business/new_biz = create_new_business(b_name, b_desc, b_pass, b_categories, unique_id, full_name, email, I.associated_account_number)

		if(!new_biz)
			reg_error = "There was an error creating your business. Please hold onto your transactional reciepts and contact an administrator."
			return


		show_custom_page("Success, your business - [new_biz.name] has been created. An email has been sent with the full details.")


	// Choices menus
	if(href_list["choice"])
		switch(href_list["choice"])

			if("remove_cat")
				var/E = locate(href_list["cat"])
				var/cat = E
				if(cat in b_categories)
					b_categories -= cat
				index = 3