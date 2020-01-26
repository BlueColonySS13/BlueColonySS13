/obj/machinery/betting_machine
	name = "bet buddy 9000"
	desc = "Feeling lucky? Feel lucky with bet buddy 9000!"
	icon = 'icons/obj/machines/gambling.dmi'
	icon_state = "betting"
	anchored = 1

	light_range = 4
	light_power = 2
	light_color = "#ebf7fe"  //white blue

	var/multiplier = 1
	var/unique_id

/obj/machinery/betting_machine/attack_hand(mob/user as mob)
	add_fingerprint(usr)

	if(istype(user, /mob/living/silicon))
		to_chat (user, "<span class='warning'>A firewall prevents you from interfacing with this device!</span>")
		return

	interact(user)
	updateDialog()

/obj/machinery/betting_machine/interact(mob/user as mob)
	var/has_ID = 0
	var/meets_gambling_age = 0
	unique_id = null

	var/obj/item/weapon/card/id/I = user.GetIdCard()

	if(I && I.registered_name && I.unique_ID)
		has_ID = 1
		unique_id = I.unique_ID

	if(isnum(I.age))
		if(persistent_economy || !(persistent_economy.gambling_age > I.age) )
			meets_gambling_age = 1

	if(get_dist(src,user) <= 1)
		//js replicated from obj/machinery/computer/card
		var/dat = "<h1>[src]</h1>"
		dat += "<br><b>Place your bets, place your bets.</b> [src] will show you a range of betting options to get you rich! Select from the following!</br><br>"

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

					dat += "<b>[E.name]</b> (Minimum base bet: [E.base_bet] credits):"
					dat += "<br><b>Max Multiplier:</b> [E.max_multiplier]x"
					dat += "<br><i>[E.desc]</i>"

					if(!isemptylist(E.get_bet_count()))
						dat += "<br><b>Current bets:</b><br><ul>"
						for(var/BC in E.get_bet_count())
							dat += "<li>[BC]<br></li>"

						dat += "</ul>"

					dat += "<br><a href='?src=\ref[src];choice=betting;bet=\ref[E]'>Place Bet</a> "

					dat += "</fieldset>"

					dat += "<br><br>"

			else
				dat += "<i>No bets currently available, come back later!</i>"

		var/datum/browser/popup = new(user, "betting_machine", "[src]", 550, 650, src)
		popup.set_content(jointext(dat,null))
		popup.open()

		onclose(user, "betting_machine")

/obj/machinery/betting_machine/Topic(var/href, var/href_list)
	if(..())
		return 1



	if(href_list["choice"])
		switch(href_list["choice"])

			if("betting")
				var/bet = locate(href_list["bet"])
				if(!bet)
					alert("There is no bet.", "Make Bet")
					return


				var/datum/gambling_bet/B = bet
				var/actual_bet = input("Choose from the following to place a bet on:", "Place Bet") as null|anything in B.potential_betting_options()

				if(!(actual_bet in B.potential_betting_options()))
					return

				if(!B.potential_betting_options())
					return

				var/multiplier = round(input("The base bet is [B.base_bet], this will be multiplied by the multiplier that is current x1. Enter multiplier amount. Min: 1. Max: [B.max_multiplier]", "New amount", 1) as num)

				if(multiplier > B.max_multiplier || 1 > multiplier)
					alert("You must make a bet between the range. Min: 1. Max: [B.max_multiplier]", "Make Bet")
					return


				if("No" == alert("Bet on [B.name] for [B.base_bet * multiplier] credits?", "Make Bet", "No", "Yes"))
					return

				if(B.find_better(unique_id))
					alert("You have already placed a bet for [B.name].", "Make Bet")
					return

				var/obj/item/weapon/card/id/I = usr.GetIdCard()

				if(!I)
					return

				var/datum/money_account/customer_account = get_account(I.associated_account_number)

				if(!attempt_account_access(I.associated_account_number, I.associated_pin_number, 2))
					alert("There was an error charging your bank account. Please contact your bank's administrator!", "Make Bet")
					return

				if(customer_account.security_level != 0) //If card requires pin authentication (ie seclevel 1 or 2)
					var/attempt_pin = input("Enter pin code", "Vendor transaction") as num
					customer_account = attempt_account_access(I.associated_account_number, attempt_pin, 2)

					if(!customer_account)
						alert("Unable to access account: incorrect credentials.", "Make Bet")
						return

				var/bet_price = B.base_bet * multiplier

				if(bet_price > customer_account.money)
					alert("Insufficient funds in account.", "Make Bet")
					return

				if(!charge_to_account(I.associated_account_number, "[src]", "[B.name]: Bet", bet_price))
					alert("Unable to charge account.", "Make Bet")
					return

				B.add_better(I.registered_name, actual_bet, bet_amount = bet_price, I.associated_account_number, unique_id)


	updateDialog()