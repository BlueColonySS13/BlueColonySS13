
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
	var/index = 0
	var/page_msg = ""
	var/reg_error = "*Fields marked with an asterisk are required."
	var/error_msg = " "

	var/unique_id
	var/email
	var/full_name

	var/datum/business/current_business

/datum/nano_module/program/business_manager/proc/reset_fields()
	b_name = initial(b_name)
	b_desc = initial(b_desc)
	b_slogan = initial(b_slogan)
	b_category = initial(b_category)
	business_pass = initial(business_pass)

/datum/nano_module/program/business_manager/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = list()
	if(program)
		data = program.get_header_data()

	var/obj/item/weapon/card/id/I = user.GetIdCard()

	if(I)
		full_name = I.registered_name
		unique_id = I.unique_ID
		email = I.associated_email_login["login"]


	if(!I || !I.unique_ID || !get_account(I.associated_account_number) || !get_email(email) || !config.lot_saving)
		index = 0

	if(index == 0)
		if(!config.lot_saving)
			page_msg = "The landlord management program is currently unavailable. Sorry for the inconvienience."
		else
			page_msg = "You are not authorized to use this system. Please ensure your ID is linked correctly to your citizen details, bank, and email."
