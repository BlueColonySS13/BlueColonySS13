/datum/game_mode/canon
	name = "Canon"
	config_tag = "canon"
	required_players = 0
	canon = TRUE
	round_description = "Any roleplaying goes, however this round is canon so your character and money saves! Read rules and roleplay guidelines before pursuing conflict."
	extended_round_description = "This round is canon, your money, appearance, and department account money will be saved. \
	Conflict is allowed if it is well roleplayed and flows well into the story and doesn't become too chaotic."
	votable = TRUE

	allow_late_antag = TRUE
	show_antag_print = TRUE // antags can be late added


/datum/game_mode/canon/noncanon
	name = "Non-Canon"
	config_tag = "noncanon"
	canon = FALSE
	round_description = "We're all in a TV show, nothing is real. Nothing saves."
	extended_round_description = "This round is NOT canon, your character and money won't save and nothing in this round applies. \
	Conflict is allowed if it is well roleplayed and flows well into the story, a bit more chaos is allowed than usual. Lot vandalism rules do not apply."
