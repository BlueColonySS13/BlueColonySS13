// Helper proc to optimize the use of effects by making sure they do not run if nobody is around to perceive it.
/proc/check_for_player_proximity(var/atom/proximity_to, var/radius = 12, var/ignore_ghosts = FALSE, var/ignore_afk = TRUE)
	if(!proximity_to)
		return FALSE

	for(var/thing in player_list)
		var/mob/M = thing // Avoiding typechecks for more speed, player_list will only contain mobs anyways.
		if(ignore_ghosts && isobserver(M))
			continue
		if(ignore_afk && M.client && M.client.is_afk(5 MINUTES))
			continue
		if(M.z == proximity_to.z && get_dist(M, proximity_to) <= radius)
			return TRUE
	return FALSE