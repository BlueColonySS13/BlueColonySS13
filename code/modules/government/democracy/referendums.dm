//Referendums
GLOBAL_LIST_EMPTY(all_voting_ballots)

/datum/voting_ballot
	var/name = "Vote Ballot"
	var/desc = "This is a voting ballot."
	var/id = ""
	var/list/options = list("Yes", "No")
	var/list/ckeys_voted = list()
	var/list/vote_log = list()

	var/persistent_option_id = null
	var/new_change = null

	var/author = "Nanotrasen"

	var/creation_date = ""
	var/days_until_expiry = 7

	var/active = TRUE

/datum/voting_ballot/proc/sanitize_ballot()
	if(id && !GLOB.all_voting_ballots[id])
		GLOB.all_voting_ballots[id] = src

	if(!creation_date)
		creation_date = full_game_time()


	var/days_expiry = expiry_days()

	if(0 >= days_expiry)
		expire_ballot()

/datum/voting_ballot/proc/expire_ballot()
	active = FALSE

/datum/voting_ballot/proc/get_status() // indicator of status
	return active

/datum/voting_ballot/proc/get_status_text() // indicator of status
	return (active ? "Active" : "Expired")


/datum/voting_ballot/referendum
	name = "Referendum"

/datum/voting_ballot/proc/expiry_days()
	var/days_open = Days_Difference(creation_date, full_game_time())
	return days_until_expiry - days_open


/datum/voting_ballot/proc/add_vote(option, mob/M)
	var/client/voter_client = M.client

	if(!voter_client)
		return

	if(!(option in options))
		return

	ckeys_voted[voter_client.ckey] = option

/datum/voting_ballot/proc/add_vote_log(ckey, option) // This is an OOC vote log for admins to keep note of.
	if(!ckey || !option)
		return

	vote_log += "[ckey] has voted for [option] at [time_stamp()]"

/datum/voting_ballot/proc/get_option_amount(option)
	var/count = 0
	for(var/O in options)
		if(options[O] == option)
			count++
	return count


/datum/voting_ballot/proc/check_winner()
	var/current_winner
	var/current_winner_votes

	for(var/O in options)
		if(get_option_amount(O) > current_winner_votes)
			current_winner = O
			current_winner_votes = get_option_amount(O)

	return current_winner


/datum/voting_ballot/proc/get_persistent_option()
	return get_persistent_option(persistent_option_id)


/datum/voting_ballot/proc/apply_ballot_outcome() // if the ballot passes, it'll apply this outcome.
	var/datum/persistent_option/PO = get_persistent_option()

	if(!PO)
		return

	return SSpersistent_options.update_pesistent_option_value(PO.id, new_change, author)
