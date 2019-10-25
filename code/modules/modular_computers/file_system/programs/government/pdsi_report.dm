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