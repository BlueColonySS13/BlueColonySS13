
/datum/computer_file/program/business_manager
	filename = "bizmgmt"
	filedesc = "Business Management Utility"
	extended_desc = "This program allows you to register a new business or manage an existing one."
	requires_ntnet = 1
	available_on_ntnet = 0

	size = 8
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
	var/b_name = " "
	var/b_slogan = " "
	var/b_desc = " "
	var/list/b_categories = list()

/datum/nano_module/program/business_manager/proc/reset_fields()
	b_name = initial(b_name)
	b_desc = initial(b_desc)
	b_slogan = initial(b_slogan)
	b_categories = initial(b_categories)

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

		if(current_business)
			page_msg = "Your business, [current_business] is now manageable from your fingertips. \
			There are a range of settings you can utilize below:<br>"

			if(current_business.department && current_business.department.has_bank)
				page_msg += "<b>Business Account Balance:</b> [current_business.department.get_balance()]<br>"

			// Business Tools

			// : Employment
			page_msg += "<b>Employment: </b><br>"

			page_msg += "<a href='?src=\ref[src];choice=edit_description'>Manage Current Employees</a>"
			page_msg += "<a href='?src=\ref[src];choice=edit_description'>Manage Jobs</a>"

		else
			page_msg = "We're very sorry, there seems to be an issue with finding your business on our database. \
			Please try again or try creating your business on our portal."

			page_msg += "<a href='?src=\ref[src];choice=edit_description'>Register a New Business</a>"

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

		<p><em>Please complete the form below.</em></p><hr>"}

		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"

		// Actual form //

		// Name
		page_msg += "<br><strong>Business Name*: [b_name]</strong>"
		page_msg += "<a href='?src=\ref[src];set_business_name=1'>Change Business Name</a>"
		page_msg += "<br>"

		// Pick Categories
		page_msg += "<br><strong>Categories*: </strong>"
		page_msg += "<a href='?src=\ref[src];choice=edit_description'>Pick Categories</a>"
		page_msg += "<br>"

		// Business Description
		page_msg += "<br><strong>Business Description*: </strong>"
		page_msg += "<a href='?src=\ref[src];choice=edit_description'>Add Business Description</a>"
		page_msg += "<br>"

		// Password
		page_msg += "<br><strong>Access Password*: </strong>"
		page_msg += "<a href='?src=\ref[src];choice=edit_description'>Set Password</a>"
		page_msg += "<br>"

		page_msg += "</fieldset>"

		page_msg += {"<p>By pressing "Submit" you agree to the business terms and conditions and a payment of 3,500 credits charged to your bank account.</p>"}

		page_msg += "<br><a href='?src=\ref[src];choice=edit_description'>Submit</a>"


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

	if(href_list["back"])
		. = 1
		index = 0
		reset_fields()

	if(href_list["set_business_name"])
		. = 1
		var/biz_name = sanitize(copytext(input(usr, "Enter your business name (40 chars max)", "Business Management Utility", null)  as text,1,40))
		if(!biz_name)
			return
		b_name = biz_name