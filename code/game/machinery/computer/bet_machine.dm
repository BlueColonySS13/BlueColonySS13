/obj/machinery/computer/betting_machine
	name = "bet buddy 9000"
	desc = "Feeling lucky? Feel lucky with bet buddy 9000!"
	icon = 'icons/obj/machines/gambling.dmi'
	icon_state = "betting"
	anchored = 1

	light_range = 4
	light_power = 2
	light_color = "#ebf7fe"  //white blue

/obj/machinery/computer/betting_machine/attack_hand(mob/user as mob)
	add_fingerprint(usr)

	if(istype(user, /mob/living/silicon))
		to_chat (user, "<span class='warning'>A firewall prevents you from interfacing with this device!</span>")
		return

	interact(user)
	updateDialog()

/obj/machinery/computer/betting_machine/interact(mob/user as mob)
	var/has_ID = 0
	var/meets_gambling_age = 0

	var/obj/item/weapon/card/id/I = user.GetIdCard()

	if(I && I.registered_name && I.unique_ID)
		has_ID = 1

	if(isnum(I.age))
		if(persistent_economy || !(persistent_economy.gambling_age > I.age) )
			meets_gambling_age = 1

	if(get_dist(src,user) <= 1)
		//js replicated from obj/machinery/computer/card
		var/dat = "<h1>[src]</h1>"
		dat += "<br><b>Place your bets, place your bets.</b> [src] will show you a range of betting options to get you rich! Select from the following!</br>"

		if(!(has_ID && meets_gambling_age))
			if(!has_ID)
				dat += "<b>We apologize, your identification card must have your full unique ID, age and name. Contact an admin for details.</b><br>"

			if(!meets_gambling_age)
				dat += "<b>You must meet the legal gambling age to continue.</b><br>"
				if(persistent_economy.gambling_age)
					dat += "<b>The current gambling age is [persistent_economy.gambling_age]</b><br>"

		else

			if(!isemptylist(SSbetting.gambling_bets))
				for(var/datum/gambling_bet/E in SSbetting.gambling_bets)

					dat += "<fieldset style='border: 2px solid white; display: inline'>"

					dat += "([E.name])</b> (Minimum base bet: [E.base_bet] credits)."
					dat += "<br>Max Multiplier: [E.max_multiplier]x"
					dat += "<br><i>[E.desc]</i>"

					dat += "<a href=''>Place Bet</a> "

					dat += "</fieldset>"

					dat += "<br>"

			else
				dat += "No bets currently available, come back later!"

		var/datum/browser/popup = new(user, "betting_machine", "[src]", 550, 650, src)
		popup.set_content(jointext(dat,null))
		popup.open()

		onclose(user, "betting_machine")