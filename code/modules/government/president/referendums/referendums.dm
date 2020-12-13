/datum/voting_ballot
	var/name = "Vote Ballot"
	var/list/options = list()
	var/list/ckeys_voted = list()
	var/list/vote_log = list()

/datum/voting_ballot/referendum
	name = "Referendum"

/datum/voting_ballot/referendum/proc/add_vote(option, client/voter)
	var/client/voter_client = voter

	if(ismob(voter))
		voter_client = M.client

	if(!voter_client)
		return

	if(!(option in options))
		return

	ckeys_voted[voter_client.ckey] = option

/datum/voting_ballot/referendum/proc/add_vote_log(ckey, option) // This is an OOC vote log for admins to keep note of.
	if(!ckey || !option)
		return

	vote_log += "[ckey] has voted for [option] at [time_stamp()]"

/datum/voting_ballot/referendum/proc/get_option_amount(option)
	var/count = 0
	for(var/O in options)
		if(options[O] == option)
			count++
	return count


/datum/voting_ballot/referendum/proc/check_winner()
	var/current_winner
	var/current_winner_votes

	for(var/O in options)
		if(get_option_amount(option) > current_winner

