/datum/persistent_option/value_list/public_wages
	name = "Public Wages"
	description = "This allows you to set the different wages of each public job type."
	id = "public_wages"
	var/wage_var = "wage"
	override_changes = TRUE

	portal_category = "Wages"
	portal_grouping = "Economy Settings"

	compact_listing = FALSE

	value = 10

	creation_text = "A new ballot for \"%NAME\" has been raised! \
	Please go to your local ballot box to cast your votes. Your voice matters!"

	on_ballot_pass = "The ballot for %NAME has passed! The changes will take place immediately."
	compact_listing = 0

/datum/persistent_option/value_list/public_wages/get_formatted_value()
	var/text_list = ""
	for(var/V in value_list)
		var/datum/job/J = SSjobs.GetJob(V)
		text_list += "<b>[J.title]:</b> [cash2text( value_list[V], FALSE, TRUE, TRUE )] (Original: [cash2text( J.vars[wage_var], FALSE, TRUE, TRUE )]) <br>"

	return text_list

/datum/persistent_option/value_list/public_wages/custom_checks(mob/user)
	var/list/L = value_list.Copy()

	var/removeadd = alert(user, "Would you like to remove or modify the job listings?", "[name]", "Add", "Remove", "Cancel")

	if(!removeadd || removeadd == "Cancel")
		return FALSE

	if(removeadd == "Add")
		var/job_list = list()
		for(var/datum/job/J in SSjobs.occupations)
			if(J.business)
				continue
			if(J.title in gov_positions)
				continue

			job_list += J.title

		if(!LAZYLEN(job_list))
			alert("No jobs exist to select from!")
			return

		var/the_job = input(usr, "Please select a job to modify.", "Modify Job") as null|anything in job_list

		var/datum/job/JOB = SSjobs.GetJob(the_job)

		if(!JOB)
			return

		var/new_wage = input(usr, "Please enter a new wage for this job.", "[name]", value) as num|null

		if(isnull(new_wage) || 0 > new_wage)
			return

		L[JOB.title] = new_wage
	else
		if(!LAZYLEN(L))
			alert("Nothing to remove!")
			return
		var/to_remove = input(user, "Which option would you like to remove?", "[name]") as null|anything in L

		if(!(to_remove in L))
			return FALSE

		L = (L - to_remove)

	return L

/datum/persistent_option/value_list/public_wages/synth_wages
	name = "Public Synth Wages"
	description = "This allows you to set the different wages of each public job type. This applies specifically to synths."
	id = "public_synth_wages"
	wage_var = "synth_wage"

/datum/persistent_option/value_list/public_wages/mpv_wages
	name = "Public Mass Produced Vatborn Wages"
	description = "This allows you to set the different wages of each public job type. This applies specifically to vatborn that are mass produced."
	id = "public_mpv_wages"
	wage_var = "mpv_wage"

/datum/persistent_option/value_list/public_wages/nonnational_wages
	name = "Non-National Citizen Wages"
	description = "This allows you to set the different wages of each public job type. This applies specifically to people from other systems."
	id = "public_nonnational_wages"
	wage_var = "nonnational_wage"