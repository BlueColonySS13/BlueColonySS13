/datum/antagonist/proc/can_become_antag(var/datum/mind/player, var/ignore_role)
	if(player.current)
		if(jobban_isbanned(player.current, bantype))
			return FALSE
		if(!isnewplayer(player.current) && !isobserver(player.current))
			if(!player.current.can_be_antagged) // Stop autotraitoring pAIs!
				return FALSE
	if(!ignore_role)
		if(player.assigned_role in restricted_jobs)
			return FALSE
		if(config.protect_roles_from_antagonist && (player.assigned_role in protected_jobs))
			return FALSE
	return TRUE

/datum/antagonist/proc/antags_are_dead()
	for(var/datum/mind/antag in current_antagonists)
		if(mob_path && !istype(antag.current,mob_path))
			continue
		if(antag.current.stat==2)
			continue
		return 0
	return 1

/datum/antagonist/proc/get_antag_count()
	return current_antagonists ? current_antagonists.len : 0

/datum/antagonist/proc/is_antagonist(var/datum/mind/player)
	if(player in current_antagonists)
		return 1

/datum/antagonist/proc/is_type(var/antag_type)
	if(antag_type == id || antag_type == role_text)
		return 1
	return 0

/datum/antagonist/proc/is_votable()
	return (flags & ANTAG_VOTABLE)

/datum/antagonist/proc/can_late_spawn()
	if(!(allow_latejoin))
		return 0
	update_current_antag_max()
	if(get_antag_count() >= cur_max)
		return 0
	return 1

/datum/antagonist/proc/is_latejoin_template()
	return (flags & (ANTAG_OVERRIDE_MOB|ANTAG_OVERRIDE_JOB))

/datum/antagonist/proc/get_needed_police() // how many police are needed for this antag type?
	var/playing_antags = get_antag_count()
	if(!playing_antags)
		return police_per_antag

	return (police_per_antag * get_antag_count())

/datum/antagonist/proc/meets_police_lobby_join() // can we get one (or more) for lobby join?
	if(!get_needed_police())
		return TRUE

	var/police_needed = get_needed_police() + police_per_antag

	if(SSjobs.get_active_police() >= police_needed)
		return TRUE

/proc/get_lobbyjoin_antag_count()
	var/count = 0
	for(var/datum/antagonist/antag in GLOB.lobbyjoin_antagonists)
		count += antag.get_antag_count()

	return count



GLOBAL_LIST_EMPTY(lobbyjoin_antagonists)


