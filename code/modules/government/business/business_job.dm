/datum/job/business_job
	title = "Unnamed Business Job"
	var/open = TRUE 	// if open, it will allow anyone to join from the jobs menu. if closed, only people in the allowed UIDs can join.
	var/enabled = TRUE
	var/list/blacklist = list() // uses unique_id
	var/list/applicants = list() // uses /datum/business_person
	var/list/employees = list() // uses /datum/business_person
