SUBSYSTEM_DEF(betting)
	name = "Betting"
	init_order = INIT_ORDER_BETTING
	flags = SS_NO_FIRE

	var/list/gambling_bets = list()

/datum/controller/subsystem/betting/proc/create_bets()
	for(var/datum/gambling_bet/instance in subtypesof(/datum/gambling_bet))
		var/datum/gambling_bet/G = new instance
		SSbetting.gambling_bets += G

var/global/list/horse_names = list("Treasure", "Fleetlight", "Lord Kaine", "Joestar", "Pietro the Cuban", "Charm", "Annabel", "Jazzy", "Snowball", "Romeo", "Duke", "Elizabeth",
		"Butt Stallion", "Karana", "Joye", "Mac", "Jeff", "Abacchio", "Morning Sparks", "Miles", "Fiddler", "Sugar", "Willow", "Sapphire", "Midnightfeet", "Lincoln",
		"Flightsilver", "Archie", "Morningheart", "Barkley", "Thunder Step", "Landslide", "DIO", "Andrejana", "Sugarpuff", "Twilight Sparkle", "Vixen", "Red Baron", "Flash Forward",
		"Red Racer", "Accelerator", "Polnareff", "Altair", "Oblivion", "Uniquess", "Paladine", "Carver", "Gatsby", "Chauncey", "Storm Blossom", "G.T. Melons", "Mr. Pibbs",
		"Moonheart", "Scarlette", "Triggerfeet", "Nelson", "Rusty", "Baloo", "Highlight", "Xiao", "Pescao", "Falcor", "Gallow", "Gallena", "Faux", "Bama", "La Roux", "Humblebottom",
		"Noble Stallion", "Bayjour", "Nanook", "Mustang", "Shirley", "Snipper", "Heap", "Sky", "Level", "Hawk", "Eternal","Creole", "Rain Ranger", "Starduster", "Bear", "Sisco",
		"Sizzler", "Brocco", "Ledger", "Charmcaster", "Tennyson", "Bezel")



/datum/gambling_bet/proc/add_better(name, betted, bet_amount = 0, bank_account_id, uid)
	var/list/bet = list("name" = name, "betted" = betted, "bet_money" = bet_amount, "account" = bank_account_id, "unique_id" = uid)
	bets += bet

/datum/gambling_bet/proc/get_bet_status()
	return active

/datum/gambling_bet/proc/find_better(uid)
	for(var/list/V in bets)
		if(V["unique_id"] == uid)
			return V

/datum/gambling_bet/proc/award_better(uid)
	var/list/better = find_better(uid)
	charge_to_account(better["account"], "Betting Terminal", "[name]: Betting Win for [better["betted"]]", 777, better["bet_money"])


/proc/pay_betters(bet_id, winning_bet)
	var/datum/gambling_bet/bet = get_bet_by_id(bet_id)

	if(!bet.get_bet_status())
		return

	for(var/list/V in bet.bets)
		if(V["betted"] == winning_bet)
			bet.award_better(V["unique_id"])
	return

/proc/finalise_bet(bet_id, winning_bet)
	pay_betters(bet_id, winning_bet)
	reset_bets(bet_id)

/proc/reset_bets(bet_id)
	var/datum/gambling_bet/bet = get_bet_by_id(bet_id)
	bet.bets = list()


/proc/disable_bet(bet_id)
	var/datum/gambling_bet/bet = get_bet_by_id(bet_id)
	bet.active = FALSE

/proc/enable_bet(bet_id)
	var/datum/gambling_bet/bet = get_bet_by_id(bet_id)
	bet.active = TRUE


/proc/get_bet_status(bet_id)
	var/datum/gambling_bet/bet = get_bet_by_id(bet_id)
	return bet.get_bet_status()

/proc/get_bet_by_id(bet_id)
	for(var/datum/gambling_bet/B in SSbetting.gambling_bets)
		if(B.id == bet_id)
			return B

