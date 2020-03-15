/datum/controller/subsystem/elections/proc/save_candidates()
	if(!path)				return 0
	var/savefile/S = new /savefile(path)
	if(!fexists(path))		return 0
	if(!S)					return 0
	S.cd = "/"

	if(!SSelections)
		return

	S["total_votes"] << total_votes
	S["last_election_votes"] << last_election_votes
	S["snap_election"] << snap_election
	S["current_president"] << current_president
	S["political_candidates"] << political_candidates
	S["vice_president"] << vice_president
	S["former_presidents"] << former_presidents
	S["former_candidates"] << former_candidates
	S["government_applications"] << government_applications

//	message_admins("Saved election data.", 1)
	return 1


/datum/controller/subsystem/elections/proc/load_candidates()
	if(!path)				return 0
	if(!fexists(path))
		save_candidates()
		return 0
	var/savefile/S = new /savefile(path)
	if(!S)					return 0
	S.cd = "/"


	S["total_votes"] >> total_votes
	S["last_election_votes"] >> last_election_votes
	S["snap_election"] >> snap_election
	S["current_president"] >> current_president
	S["political_candidates"] >> political_candidates
	S["vice_president"] >> vice_president
	S["former_presidents"] >> former_presidents
	S["former_candidates"] >> former_candidates
	S["government_applications"] >> government_applications

//	message_admins("Loaded election data.", 1)
	return 1
