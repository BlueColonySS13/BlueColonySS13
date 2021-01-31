/datum/persistent_option/proc/save_option()
	var/full_path = "[path][id].sav"

	if(!full_path)			return 0

	if(!saveable)			return 0

	var/savefile/S = new /savefile(full_path)
	if(!fexists(full_path)) return 0


	if(!S)					return 0
	S.cd = "/"

	sanitize_options()

	S << get_value()

	return 1

/datum/persistent_option/proc/load_option()
	var/full_path = "[path][id].sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	if(!saveable)			return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	S >> vars[var_to_edit]

	sanitize_options()

	return 1

/datum/controller/subsystem/persistent_options/proc/save_ballots()
	var/full_path = "data/persistent/ballots.sav"

	if(!full_path)			return 0

	var/savefile/S = new /savefile(full_path)
	if(!fexists(full_path)) return 0


	if(!S)					return 0
	S.cd = "/"

	S << get_ballots()

	return 1

/datum/controller/subsystem/persistent_options/proc/load_ballots()
	var/full_path = "data/persistent/ballots.sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0


	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0
	S.cd = "/"

	var/list/ballots = list()

	S >> ballots

	for(var/datum/voting_ballot/VB in ballots)
		all_voting_ballots[VB.id] = VB
		VB.sanitize_ballot()

	return 1
