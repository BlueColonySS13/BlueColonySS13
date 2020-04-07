/var/global/account_hack_attempted = 0

/datum/event/money_hacker
	var/datum/money_account/affected_account
	endWhen = 100
	var/end_time

/datum/event/money_hacker/setup()
	end_time = world.time + 6000
	if(GLOB.all_money_accounts.len)
		affected_account = pick(GLOB.all_money_accounts)

		account_hack_attempted = 1
	else
		kill()

/datum/event/money_hacker/announce()
	var/message = "A brute force hack has been detected (in progress since [stationtime2text()]). The target of the attack is: Financial account #[affected_account.account_number], \
	without intervention this attack will succeed in approximately 10 minutes. Required intervention: temporary suspension of affected accounts until the attack has ceased. \
	Notifications will be sent as updates occur.<br>"
	var/my_department = "[station_name()] firewall subroutines"

	for(var/obj/machinery/message_server/MS in world)
		if(!MS.active) continue
		MS.send_rc_message("Head of Personnel's Desk", my_department, message, "", "", 2)


/datum/event/money_hacker/tick()
	if(world.time >= end_time)
		endWhen = activeFor
	else
		endWhen = activeFor + 10

/datum/event/money_hacker/end()
	var/message
	if(affected_account && !affected_account)
		//hacker wins
		message = "The hack attempt has succeeded."

		//subtract the money
		var/lost = affected_account.money * 0.8 + (rand(2,4) - 2) / 10
		affected_account.money -= lost

		//create a taunting log entry

		var/target_name = pick("","yo brotha from anotha motha","el Presidente","chieF smackDowN")
		var/purpose = pick("Ne$ ---ount fu%ds init*&lisat@*n","PAY BACK YOUR MUM","Funds withdrawal","pWnAgE","l33t hax","liberationez", "alla money","9001$","HOLLA HOLLA GET DOLLA")
		var/source_terminal = pick("","[pick("Biesel","New Gibson")] GalaxyNet Terminal #[rand(111,999)]","your mums place","nantrasen high CommanD")

		affected_account.add_transaction_log(target_name, purpose, -lost, source_terminal)


	else
		//crew wins
		message = "The attack has ceased, the affected accounts can now be brought online."

	var/my_department = "[station_name()] firewall subroutines"

	for(var/obj/machinery/message_server/MS in world)
		if(!MS.active) continue
		MS.send_rc_message("Head of Personnel's Desk", my_department, message, "", "", 2)
