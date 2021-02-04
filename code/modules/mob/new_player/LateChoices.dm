
/mob/new_player/proc/LateChoices()

	if(!SSjobs || !SSeconomy)
		return

	var/dat = "<center>"
	if(emergency_shuttle) //In case NanoTrasen decides reposess CentCom's shuttles.
		if(emergency_shuttle.going_to_centcom()) //Shuttle is going to CentCom, not recalled
			dat += "<font color='red'><b>The city has been evacuated.</b></font><br>"
		if(emergency_shuttle.online())
			if (emergency_shuttle.evac)	// Emergency shuttle is past the point of no recall
				dat += "<font color='red'>The city is currently undergoing evacuation procedures.</font><br>"
			else						// Crew transfer initiated
				dat += "<font color='red'>The city is currently undergoing civilian transfer procedures.</font><br>"
	dat += "</center><br>"

	//Selected job (quick sanitization, just in case)
	if(!selected_job || !job_select_mode || !(job_select_mode in list("PUBLIC", "PRIVATE", "ALL")) )
		selected_job = initial(selected_job)
		job_select_mode = "ALL"

	var/datum/job/job = SSjobs.GetJob(selected_job)

	if(!job)
		job = SSjobs.GetJob("Civilian")

	var/datum/department/job_department = job.get_department()

	// ####### JOB PREVIEW CHARACTER CODE ########## //
	var/mob/living/carbon/human/dummy/mannequin/mannequin = job.get_job_mannequin()
	var/icon/job_icon = getFlatIcon(mannequin, SOUTH)
	job_icon.Scale(job_icon.Width() * 2.5, job_icon.Height() * 2.5)
	send_rsc(usr, job_icon, "job_icon_[job.title].png")

	// ####### JOB DESCRIPTION + PREVIEW ########## //

	if(job)
		var/job_no_label

		if(job.total_positions && job.total_positions > 0)
			job_no_label = "<p><span style=\"font-size: 30px;\">[job.current_positions]/[job.total_positions]</span></p>"

		dat += {"



	<table style="width: 100%;">
		<tbody>
			<tr>
				<td style="width: 10%;"><img src="job_icon_[job.title].png" width="220" height="220" class="fr-fil fr-dii"></td>
				<td style="width: 74.7797%; background-color: rgb(0, 0, 0); padding: 15px; border: 1px solid #515151;">
					<div style="text-align: center; border: 1px solid [job_department.dept_color ? job_department.dept_color : ""]; padding: 5px;"><strong><span>[job.title]</span></strong></div>

					<center>[job_no_label ? "<br>[job_no_label]" : ""]</center>

					<br>[job.get_full_description()]"}



	dat += "<br><br><div style=\"text-align: center;\">"

	var/alt_title = client.prefs.GetPlayerAltTitle(job)

	if(IsJobAvailable(job.title))
		dat += "<a href='byond://?src=\ref[src];SelectedJob=[job.title]'>Join As [alt_title ? alt_title : job.title]</a>"
	else
		dat += "<a style=\"background: #515151;\" href='#'>Join As [alt_title ? alt_title : job.title]</a>"
		dat += "<br>"

		if(!is_hard_whitelisted(src, job))
			dat += "This job requires whitelisting, or is obtained IC'ly through in-game events."
		else if(!job.enabled)
			dat += "This job is currently on hold by the employer."
		else if(jobban_isbanned(src,job.title))
			dat += "You are banned from playing this role."
		else if(!job.player_old_enough(client))
			dat += "You need to be playing for at least [job.minimal_player_age] days."
		else if(job.minimum_character_age && client && (client.prefs.age < job.minimum_character_age))
			dat += "Your character needs to be at least [job.minimum_character_age]."
		else if(!isemptylist(client.prefs.crime_record) && job.clean_record_required)
			dat += "Your criminal record prevents you from working in this role."
		else if(job.title == "Prisoner" && client.prefs.criminal_status != "Incarcerated")
			dat += "Only incarcerated individuals can play this role."
		else if(job.title != "Prisoner" && client.prefs.criminal_status == "Incarcerated")
			dat += "You are currently in prison and are unable to work. Play as a prisoner."
		else if(!job.is_position_available())
			dat += "This role is fully filled. Try again later."
		else if(!isemptylist(job.exclusive_employees) && !(client.prefs.unique_id in job.exclusive_employees))
			dat += "This job requires you to apply in-person and be accepted by the employer."
		else if(job.business)
			var/datum/business/biz = get_business_by_biz_uid(job.business)
			if(biz && biz.suspended)
				dat += "The business of this job is currently suspended."
		else if(client.prefs.is_synth())
			dat += "This job does not hire synthetics."

		else
			dat += "This job is unavailable."

		dat += "<br>"

	dat += " <a href='byond://?src=\ref[src];set_alt_title=1;job=\ref[job]'>Set Alt Title</a>"
	dat+= "<br></div></td></tr></tbody></table>"




	dat += "<center>"
	// ####### JOB SELECTION MENU ########## //

	var/list/job_departments = list()
	var/label = "Active Jobs"
	var/switch_type = "ALL"

	switch(job_select_mode)
		if("ALL")
			job_departments += (SSeconomy.get_all_nonbusiness_departments()+shuffle(SSeconomy.get_all_business_departments()))
			label = "Active Jobs"
			dat += "<BR>Active Jobs | <a href='byond://?src=\ref[src];SelectDeptType=PUBLIC'>Public Sector Jobs</a>"
			dat += " | <a href='byond://?src=\ref[src];SelectDeptType=PRIVATE'>Private Sector Jobs</a>"
			dat += "<BR>This is a list of all available jobs that you can join, feel free to play as one. See the public and private tabs to filter."
		if("PUBLIC")
			job_departments += shuffle(SSeconomy.get_all_nonbusiness_departments())
			label = "Public Sector"
			switch_type = "PRIVATE"
			dat += "<BR><a href='byond://?src=\ref[src];SelectDeptType=ALL'>Active Jobs</a> | Public Sector Jobs | <a href='byond://?src=\ref[src];SelectDeptType=[switch_type]'>Private Sector Jobs</a>"
			dat += "<BR>Public jobs are jobs funded by the government or aren't associated with any private business."
		if("PRIVATE")
			job_departments += shuffle(SSeconomy.get_all_business_departments())
			label = "Private Sector"
			switch_type = "PUBLIC"
			dat += "<BR><a href='byond://?src=\ref[src];SelectDeptType=ALL'>Active Jobs</a> | <a href='byond://?src=\ref[src];SelectDeptType=[switch_type]'>Public Sector Jobs</a> | Private Sector Jobs"
			dat += "<BR>These are private sector jobs, business owners of the city occasionally open jobs for you to join."


	dat += "<br>"

	//public departments

	dat += "<br><b>[label]</b><br>"



	if(!isemptylist(GLOB.public_departments))

		for(var/datum/department/PUB_D in job_departments)
			var/list/available_jobs = PUB_D.get_available_jobs(src)
			var/list/net_jobs = PUB_D.get_all_jobs()

			if(switch_type == "ALL" && isemptylist(available_jobs))
				continue

			if(isemptylist(net_jobs))
				continue

			dat += "<fieldset style='width: 80%; border: 2px solid #515151; display: inline'>"
			dat += "<legend align='center' style='color: #fff'>[PUB_D.name]</legend>"

			var/list/all_jobs = list()

			if(switch_type == "ALL")
				all_jobs = available_jobs
			else
				all_jobs = net_jobs


			for(var/datum/job/pub_job in all_jobs )

				var/job_color = PUB_D.dept_color
				var/job_text = "#fff"

				if(!IsJobAvailable(pub_job.title))
					job_color = "#515151"

				if(pub_job in SSjobs.prioritized_jobs)
					job_text = "yellow"

				dat += "<a style=\"color: [job_text]; background: [job_color];\" href='byond://?src=\ref[src];SelectJob=[pub_job.title]'>[pub_job.title]</a> "
			dat += "</fieldset><br><br>"

	else
		dat += "<strong>No jobs exist for this sector.</strong>"
	dat += "</center>"


	var/datum/browser/popup = new(usr, "latechoices", "Job Selection Menu", 750, 930, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(usr, "latechoices")
