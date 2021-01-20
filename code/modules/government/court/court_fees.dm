var/global/list/court_fees = list()

/hook/startup/proc/populate_court_datums()
	instantiate_court_fees()
	return 1

/proc/instantiate_court_fees()

	for(var/instance in subtypesof(/datum/court_fee))
		var/datum/court_fee/J = new instance
		court_fees += J

		if(J.portal_id)
			J.cost = SSpersistent_options.get_persistent_option_value(J.portal_id) // takes the id from the portal and uses the price there.


/datum/court_fee
	var/name = "Sample Court Fee"
	var/description = "n/a"

	var/portal_id = null						// 	will borrow cost from this, if enabled
	var/cost = 0								//	In credits

	var/can_edit = 1							//	Can the minister of health/president edit this?

/datum/court_fee/minor_appeal
	name = "Minor Appeal Fee"
	description = "A fee to cover the cost incurred by the Court to hear an appeal on Misdemeanour or Criminal Offenses."
	portal_id = "minor_appeal"

/datum/court_fee/mayoral_appeal
	name = "Mayoral Appeal Fee"
	description = "A fee to cover the cost of a member of the Mayoral Corps hearing an appeal for a Misdemeanour or Criminal Offense."
	portal_id = "mayoral_appeal"

/datum/court_fee/small_claims
	name = "Small Claims Suit Fee"
	description = "A fee to cover the cost of filing a lawsuit seeking damages 4999Cr or less."
	portal_id = "small_claims"

/datum/court_fee/large_claims
	name = "Large Claims Suit Fee"
	description = "A fee to cover the cost of filing a lawsuit seeking damages 5000Cr or more."
	portal_id = "large_claims"

/datum/court_fee/court_fine
	name = "Court Fine"
	description = "A administrative fine issued by the Judge or Magistrate to counsel or a litigant for misconduct."
	cost = 100
	portal_id = "court_fine"

/datum/court_fee/high_court_appeal
	name = "High Court of Pollux Appeal Fee"
	description = "A fee to cover the cost inccured by the High Court of the Republic of Pollux to hear an appeal."
	cost = 1000

	portal_id = "high_court_appeal"