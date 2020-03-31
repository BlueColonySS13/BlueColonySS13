/datum/business_job
	var/title = "Unnamed Job"
	var/slots = 3
	var/wage = 20
	var/open = TRUE 	// if open, it will allow anyone to join from the jobs menu. if closed, only people in the allowed UIDs can join.
	var/enabled = TRUE
	var/list/blacklist = list() // uses unique_id
	var/list/applicants = list() // uses /datum/business_person
	var/list/employees = list() // uses /datum/business_person