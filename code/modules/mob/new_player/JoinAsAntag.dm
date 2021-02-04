
/mob/new_player/proc/JoinAsAntag()
	if(!SSjobs)
		return

	var/dat = JoinAntagData()


	var/datum/browser/popup = new(usr, "joinasantag", "Join As Antag", 470, 730, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(usr, "joinasantag")


/mob/new_player/proc/JoinAntagData()

	var/dat = ""

	if(!config.allow_lobby_antagonists)
		dat += "<center><font color='red'>Joining as an antagonist is currently disabled.</font></center><br>"
		return dat

	var/datum/job/job = SSjobs.GetJob(selected_job)

	if(!job)
		job = SSjobs.GetJob("Civilian")

	dat += "<b>Current Character:</b> [client.prefs.real_name]<br>"
	dat += "<b>Current Job:</b> [job.title]<br>"
	dat += "<b>Active Police Officers:</b> [SSjobs.get_active_police()]<hr>"
	dat += "<b>Antag Cap:</b> [get_lobbyjoin_antag_count()]/[ticker.mode.max_antags]<br>"

	if(config.canonicity)
		dat += "<b>NOTICE:</b> This is a <i>canon</i> round, everything your character does this round is canon. Your character's criminal record and \
		reputation is persistent and will be remembered if you are found out - it cannot be retconned. If this is a character you would prefer <i>not</i> \
		to be remembered for traitorous infamy, use another character.<br>"
	else
		dat += "The current round is not persistent, actions you do will not be remembered or saved next round.<br>"

	var/list/lobby_antagonists = GLOB.lobbyjoin_antagonists


	if(!LAZYLEN(lobby_antagonists))
		dat += "There are no antagonist types available for joining at the moment, please visit later."
	else
		dat += "<br>"

		for(var/datum/antagonist/antag in lobby_antagonists)

			dat += "<fieldset style='width: 80%; border: 2px solid red; display: inline'>"
			dat += "<legend align='left' style='color: #fff'>[antag.role_text]</legend>"

			dat += "<br>[antag.antag_text]"
			if(config.use_age_restriction_for_antags)
				dat += "<br><b>Minimum Player Age:</b> [antag.minimum_player_age] (Current: [client.player_age])"

			dat += "<br><b>Max [antag.role_text_plural]:</b> "
			if(antag.hard_cap)
				dat += "[antag.get_antag_count()]/[antag.hard_cap]"
			else
				dat += "Unlimited"
			if(antag.police_per_antag)
				dat += "<br><b>Police Per [antag.role_text]:</b> [antag.police_per_antag]"

			if(client.lobby_joined)
				dat += "<br><font color='red'><b>You already played as antag this round. Please wait for the next round.</b></font>"

			if(job.title in antag.restricted_jobs)
				dat += "<br><font color='red'><b>This antagonist type cannot be played by your current job: [job.title].</b></font>"

			else if(!antag.can_become_antag(mind))
				dat += "<br><font color='red'><b>You are not eligible for this role.</b></font>"

			else if(get_lobbyjoin_antag_count() >= ticker.mode.max_antags)
				dat += "<b>Max antag count for this gamemode reached.</b></font>"

			else if(antag.get_antag_count() >= antag.hard_cap)
				dat += "<br><font color='red'><b>This antag type has reached the maximum amount.</b></font>"

			else if(isnum(client.player_age) && !(client.player_age >= antag.minimum_player_age))
				dat += "<br><font color='red'><b>You don't meet the minimum player age to play this role.</b></font>"

			else if(antag.get_needed_police() > SSjobs.get_active_police())
				dat += "<br><font color='red'><b>To join, the round needs at least [antag.get_needed_police()] police officer(s).</b></font>"
			else
				dat += "<br><a href='byond://?src=\ref[src];JoinAsAntag=[antag.id]'>Join As [antag.role_text]</a>"

			dat += "</fieldset>"

			dat += "<br>"


	return dat


/mob/new_player/proc/JoinAntag(var/datum/antagonist/antag)

	if(!antag || !istype(antag, /datum/antagonist) )
		return FALSE

	if(client.lobby_joined)
		to_chat(src, "<b>You already played as antag this round. Please wait for the next round.</b>")
		return FALSE

	if(get_lobbyjoin_antag_count() >= ticker.mode.max_antags)
		to_chat(src, "<b>Max antag count for this gamemode reached.</b>")
		return FALSE

	if(selected_job in antag.restricted_jobs)
		to_chat(src, "<b>This antagonist type cannot be played by your current job: [selected_job].</b>")
		return FALSE

	if(antag.get_antag_count() >= antag.hard_cap)
		to_chat(src, "This antag type has reached the max count.")
		return FALSE

	if(!antag.can_become_antag(mind))
		to_chat(src, "You are not eligible for this antagonist type.")
		return FALSE

	if(antag.get_antag_count() >= antag.hard_cap)
		to_chat(src, "Limit for this antagonist group reached.")
		return FALSE

	if(antag.get_needed_police() > SSjobs.get_active_police())
		to_chat(src, "This antagonist type cannot be joined until more police officers join.")
		return FALSE

	if(config.use_age_restriction_for_antags && isnum(client.player_age) && !(client.player_age >= antag.minimum_player_age))
		to_chat(src, "You don't meet the minimum player age to play this role.")
		return FALSE
	JoinLate(selected_job, antag.id)
	client.lobby_joined = TRUE
