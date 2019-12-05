/datum/computer_file/program/pdsi_report
	filename = "pdsi_rpt"
	filedesc = "PDSI Reporting Utility"
	extended_desc = "This program allows you to make reports that will be passed onto the PDSI NT agents."
	requires_ntnet = 1
	size = 3
	nanomodule_path = /datum/nano_module/program/pdsi_report/

/datum/nano_module/program/pdsi_report/
	name = "PDSI Reporting Utility"
	var/index = 0
	var/page_msg

	var/datum/pdsi_report/current_rpt

/datum/nano_module/program/pdsi_report/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = list()
	if(program)
		data = program.get_header_data()

	//page related
	data["index"] = index
	data["page_msg"] = page_msg

	if(current_rpt)
		//current open pdsi report
		data["report_id"] = current_rpt.id
		data["report_title"] = current_rpt.title
		
	if(index == 0) // main screen
		page_msg = "Welcome to the PDSI Report application. The PDSI is a investigatory branch that aids in \
		mediating and monitor internal affairs. Please choose from the options below."
		
	if(index == 1) 
		page_msg = "Please select a PDSI case to view."
		for(var/datum/pdsi_report/P in pdsi_reports)
			page_msg += "[P.name]"
			page_msg += "<hr>"
		
	if(index = 2)
		page_msg = "Please enter a reference number."
		
	if(index = 3)
		if(current_rpt && current_rpt.title)
			page_msg = "<h4>[current_rpt.title]</h4><br>"
			page_msg += "Case ID: <i>[current_rpt.id]</i>"
			
	if(index = 4)
		page_msg = "Submit case?"

	if(index == 5) 
		page_msg = "Please fill in your details and elaborate on a concise summary of your case."		

/datum/nano_module/program/pdsi_report/Topic(href, href_list)
	if(..()) return 1

	if(href_list["back"])
		. = 1
		index = 0


	if(href_list["create_new"])
		. = 1
		index = 1
		
	if(href_list["find"])
		. = 1
		index = 2

	if(href_list["view_case"])
		. = 1
		index = 3
		
	if(href_list["submit_case"])
		. = 1
		index = 4
