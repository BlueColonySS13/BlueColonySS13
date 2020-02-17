/datum/gambling_bet
	var/name = "Misc Bet"
	var/desc = "This is a bet in the machine, it's always here but shouldn't be loaded in the game. Technically you shouldn't be seeing this."
	var/active = TRUE	// if this isn't active, it won't show up
	var/base_bet = 20 // The base bet for this bet. This can be multiplied by the player.
	var/ends_on	// this'll be the date.
	var/id		// so this can be remotely changed or toggled on or off.

	var/max_multiplier	// how many times the person can multiple the base bet amount/raise the stakes

	var/list/bets = list()

/datum/gambling_bet/New()
	..()

	SSbetting.gambling_bets += src

/datum/gambling_bet/election
	name = "Election Results"
	desc = "Vote for the candidate who will win on election day! Who's going to win? Will YOU win? This bet will pay out on the 28th upon announcement of results."
	base_bet = 100
	id = "election"

	max_multiplier = 5

/datum/gambling_bet/election/get_bet_status()		// when should this bet be available to bet on?
	var/day = get_game_day()
	if(SSelections.is_campaign_days(day) || SSelections.is_voting_days(day))
		return TRUE

/datum/gambling_bet/election/potential_betting_options()		// always needs to be something in order to work
	return SSelections.getcandidatenames()

/datum/gambling_bet/no_confidence
	name = "No Confidence"
	desc = "Will the elected president be no-confidenced? Take the dare of a bet. This bet will be paid out if the president reaches 30 no confidence votes."
	base_bet = 10
	id = "noconfidence"

	max_multiplier = 10

/datum/gambling_bet/no_confidence/get_bet_status()		// when should this bet be available to bet on?
	if(!SSelections.snap_election)
		return TRUE

/datum/gambling_bet/no_confidence/potential_betting_options()		// always needs to be something in order to work
	return list("No Confidence", "Will Stay In Office")

// to be implemented
/*
/datum/gambling_bet/horse_race
	name = "Daily Cascington Horse Races"
	desc = "Now you can gamble like a bored Cascingonite too!"
	base_bet = 1000
	id = "horserace"

	max_multiplier = 20

*/

/datum/gamble_better	// universally used to store info on betters.
	var/full_name
	var/unique_id
	var/betted_for
	var/bet_amount
	var/bank_id
