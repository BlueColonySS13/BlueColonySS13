

var/global/list/pdsi_reports = list()

/datum/pdsi_report
	var/id
	var/title
	var/message
	var/reporter_name
	var/game_id
	var/status

	var/list/handlers = list()
	var/list/involved = list()

/datum/pdsi_report/New()
	id = generate_gameid()
	pdsi_reports += src

/proc/new_pdsi_report(var/title, var/message, var/reporter_name)
	var/datum/pdsi_report/report = new /datum/pdsi_report(src)

	report.title = title
	report.message = message
	report.reporter_name = reporter_name
	report.game_id = game_id
	report.status = ACTIVE

	return report


