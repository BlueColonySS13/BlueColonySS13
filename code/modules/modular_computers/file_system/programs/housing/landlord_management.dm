/datum/computer_file/program/landlord_management
	filename = "landlordm"
	filedesc = "Landlord Management Utility"
	extended_desc = "This program can be used by landlords to buy and sell properties, you can also manage existing properties you own."
	program_icon_state = "generic"
	size = 5
	requires_ntnet = 1
	available_on_ntnet = 0

	nanomodule_path = /datum/nano_module/landlord_management

/datum/nano_module/landlord_management/
	name = "Landlord Management"

	var/index = 1
	var/page_msg
	var/error_msg = " "
	var/unique_id
	var/full_name
	var/acc_balance

/datum/nano_module/landlord_management/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = list()
	if(program)
		data = program.get_header_data()

	var/obj/item/weapon/card/id/I = user.GetIdCard()

	if(I)
		full_name = I.registered_name
		unique_id = I.unique_ID

		var/datum/money_account/bank = get_account(I.associated_account_number)
		if(bank)
			acc_balance = bank.money


	if(!I || !I.unique_ID || !get_account(I.associated_account_number))
		index = 0

	if(index == 0)
		page_msg = "You are not authorized to use this system."

	else if(index == 1) // Main Portal Page
		page_msg = "This is the Landlord Management Portal, [full_name].<br>\
		You can buy new properties, or sell existing ones. Please select from the menu."

	else if(index == 2) // Buy Property Page
		page_msg = "Here is a list of available properties that you may buy. The current housing tax rate is [HOUSING_TAX * 100]% as set by the government. Please select from the list.<br>"

		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"

		if(!isemptylist(SSlots.get_lots_for_sale()))
			for(var/datum/lot/L in SSlots.get_lots_for_sale())
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name] (Owned by [L.landlord_name ? L.landlord_name : "City Council"])<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>ID:</b></font> \"[L.id]\"<br>"
				page_msg += "<font color=\"yellow\"><b>Price:</b></font> [L.get_lot_price()]CR ([L.get_lot_tax_diff()]CR tax added)<br><br>"
				page_msg += "<font color=\"yellow\"><a href='?src=\ref[src];choice=buy_lot;lot=\ref[L]'>Buy [L.name] for [L.get_lot_price()] credits.</a></font><br><hr>"
		else
			page_msg += "No properties are currently available for sale. Check back later, or alternatively view properties available for rent."

		page_msg += "</fieldset>"

	else if(index == 3) // Manage Property Page
		page_msg = "These are all the properties you own. You can choose to sell them to Nanotrasen, or put them back on the market for someone to buy them.<br>"

		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"

		if(!isemptylist(SSlots.get_lots_by_owner_uid(unique_id)))
			for(var/datum/lot/L in SSlots.get_lots_by_owner_uid(unique_id))
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name]<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>Status:</b></font> [L.status]<br>"
				page_msg += "<font color=\"yellow\"><b>ID:</b></font> \"[L.id]\"<br>"
				page_msg += "<font color=\"yellow\"><b>Price:</b></font> [L.get_lot_price()]CR (incl [L.get_lot_tax_diff()]CR tax)<br><br>"
				page_msg += "<font color=\"yellow\"><b>Service Charges:</b></font> [L.landlord_balance] ([L.get_service_charge()]CR per month)<br>"

				if(!(L.status == LOT_HELD))
					page_msg += "<font color=\"yellow\"><a href='?src=\ref[src];choice=sell_lot;lot=\ref[L]'>Sell to City Council ([L.price]CR)</a> \
					<a href='?src=\ref[src];choice=market_lot;lot=\ref[L]'>Sell on Market</a> "

					if(L.status == RENTED)
						page_msg += "<font color=\"yellow\"><b>Tenant:</b></font> [L.tenant_name]<br>"
						page_msg += "<font color=\"yellow\"><b>Tenant's Rent Balance:</b></font> [L.tenant_balance] ([L.get_rent()] per month)<br>"
						page_msg += "<font color=\"yellow\"><b>Last Payment:</b></font> [L.last_payment]<br>"
						page_msg += "<a href='?src=\ref[src];choice=evict_tenant;lot=\ref[L]'>Evict Tenant ([L.tenant_name])</a> </font>"
						page_msg += "<a href='?src=\ref[src];choice=remove_rent_lot;lot=\ref[L]'>Remove Lot from Rent List</a> </font>"

					else
						if(L.status == FOR_RENT)
							page_msg += "<a href='?src=\ref[src];choice=remove_rent_lot;lot=\ref[L]'>Remove Lot from Rent List</a>"
						else
							page_msg += "<a href='?src=\ref[src];choice=rent_lot;lot=\ref[L]'>Put up for Renting</a> </font>"

				page_msg += "<hr>"

		else
			page_msg += "There are no properties that you own."

		page_msg += "</fieldset>"

	else if(index == 4) // Lot Purchase Success
		page_msg = "Lot purchase successful."


	else if(index == 5) // Lot Sold
		page_msg = "Lot successfully sold."


	else if(index == 6) // Lot put on market
		page_msg = "Lot has been placed on the market. This can be withdrawn at any time."


	else if(index == 7) // Lot proposals
		page_msg = "This is a list of your tenancy and lot proposals. You may reject or accept them here."

	else if(index == 8) // Lot put up for rent
		page_msg = "Your lot has been put up for rent. You will now begin to recieve rent proposals."

	else if(index == 9) // Lot for that are available for rent
		page_msg = "Here's a list of lots available for renting.<br>"
		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"
		if(!isemptylist(SSlots.get_lots_for_rent()))
			for(var/datum/lot/L in SSlots.get_lots_for_rent())
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name]<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>ID:</b></font> \"[L.id]\"<br>"
				page_msg += "<font color=\"yellow\"><b>Rent:</b></font> [L.get_rent()]CR (with [L.get_rent()]CR tenant charges per month.)<br>"
				page_msg += "<font color=\"yellow\"><b>Required Deposit:</b></font> [L.required_deposit]CR<br>"

				if(!(unique_id == L.landlord_uid))
					page_msg += "<a href='?src=\ref[src];choice=rent_out_lot;lot=\ref[L]'>Rent [L.name]</a>"
				else
					page_msg += "<a href='?src=\ref[src];choice=remove_rent_lot;lot=\ref[L]'>Remove Lot from Rent List</a>"

				page_msg += "<hr>"

		else
			page_msg += "There are no properties available for renting at this time. Check back later."

		page_msg += "</fieldset>"

	else if(index == 10) // Lot that you rent
		page_msg = "These are the lots that you currently rent.<br>"
		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"
		if(!isemptylist(SSlots.get_lots_by_tenant_uid(unique_id)))
			for(var/datum/lot/L in SSlots.get_lots_by_tenant_uid(unique_id))
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name]<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>Status:</b></font> \"[L.status]\"<br>"
				page_msg += "<font color=\"yellow\"><b>ID:</b></font> \"[L.id]\"<br>"
				page_msg += "<font color=\"yellow\"><b>Rent:</b></font> [L.get_rent()]CR (includes [L.get_rent()]CR service charges)<br>"
				page_msg += "<font color=\"yellow\"><b>Last Payment:</b></font> [L.last_payment_tnt]<br>"

				page_msg += "<a href='?src=\ref[src];choice=end_tenancy;lot=\ref[L]'>Cancel Tenancy</a>"

				page_msg += "<hr>"

		else
			page_msg += "There are no properties that you rent."
		page_msg += "</fieldset>"
	if(index == -1)
		page_msg = "This isn't a thing yet, sorry."


	data["index"] = index
	data["page_msg"] = page_msg
	data["full_name"] = full_name
	data["error_msg"] = error_msg
	data["acc_balance"] = acc_balance

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "landlord_management.tmpl", "Landlord Management Utility", 600, 450, state = state)
		if(program.update_layout())
			ui.auto_update_layout = 1
		ui.set_auto_update(1)
		ui.set_initial_data(data)
		ui.open()



/datum/nano_module/landlord_management/proc/clear_data()
	error_msg = " "

/datum/nano_module/landlord_management/Topic(href, href_list)
	if(..()) return 1

	if(href_list["back"])
		. = 1
		clear_data()
		index = 1

	if(href_list["buy_lots"])
		. = 1
		index = 2

	if(href_list["manage_lots"])
		. = 1
		index = 3


	if(href_list["rent_lots"])
		. = 1
		index = 9

	if(href_list["view_rent_lots"])
		. = 1
		index = 10

	if(href_list["choice"])
		switch(href_list["choice"])

			if("buy_lot")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L
				var/obj/item/weapon/card/id/I = usr.GetIdCard()
				var/landlord_email = I.associated_email_login["login"]


				if(!LOT)
					error_msg = "This lot does not exist."
					return

				if(!(LOT.status == FOR_SALE))
					error_msg = "This lot is not for sale."
					return

				if("No" == alert("Buy [LOT.name] for [LOT.get_lot_price()] credits?", "Buy Lot", "No", "Yes"))
					return



				if(!I || !I.associated_account_number || !I.associated_pin_number)
					error_msg = "No identification payment card or valid valid bank details detected."
					return

				if(!landlord_email)
					error_msg = "There is no email address associated with your citizen ID, please contact an administrator to rectify this."
					return

				if(!attempt_account_access(I.associated_account_number, I.associated_pin_number, 2) )
					error_msg = "There was an error charging your bank account. Please contact your bank's administrator."
					return

				var/datum/money_account/M = get_account(I.associated_account_number)
				if(LOT.get_lot_price() > M.money)
					error_msg = "You have insufficient funds to buy this lot."
					return


				if(!charge_to_account(I.associated_account_number, "Housing Purchase", "[LOT.name] Lot Purchase", "Landlord Management", -LOT.get_lot_price() ))
					error_msg = "There was an error charging your bank account. Please contact your bank's administrator."
					return


				LOT.set_new_ownership(unique_id, full_name, I.associated_account_number, landlord_email)
				clear_data()
				index = 4


			if("sell_lot")	// This is for selling lots to City Council, the Council doesn't pay tax on lots.
				var/L = locate(href_list["lot"])
				var/datum/lot/LOT = L


				if("No" == alert("Sell [LOT.name] to NT for [LOT.price] credits?", "Sell Lot", "No", "Yes"))
					return

				if(!LOT.landlord_uid == unique_id)
					return

				var/obj/item/weapon/card/id/I = usr.GetIdCard()

				if(!I || !I.associated_account_number || !I.associated_pin_number)
					error_msg = "No identification payment card or valid valid bank details detected."
					return

				if(!charge_to_account(I.associated_account_number, "Housing Sell", "[LOT.name] Lot Sell", "Landlord Management", LOT.price))
					error_msg = "There was an error charging your bank account. Please contact your bank's administrator."
					return
				else
					var/datum/money_account/M = get_account(I.associated_account_number)
					if(M)
						M.money += LOT.price
					LOT.sell_to_council()
					clear_data()
					index = 5



			if("market_lot")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if("No" == alert("Put [LOT.name] on the market for selling?", "Sell Lot", "No", "Yes"))
					return

				var/lot_new_price = input("Current lot price is [LOT.price]CR, input a new price for your lot. ([HOUSING_TAX]CR will be added to this by tax.)", "Set Price", LOT.price) as num|null

				if(!lot_new_price)
					return

				LOT.price = lot_new_price
				LOT.status = FOR_SALE
				clear_data()
				index = 6


			if("rent_lot") // you put a lot on the market for people to rent.
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!(LOT.status == OWNED) && !(unique_id == LOT.landlord_uid) && LOT.status == RENTED)
					error_msg = "You are unable to put this lot for rent as it is either up for sale, already rented, or a lot you do not own."
					return

				if("No" == alert("Put [LOT.name] on the market for rent?", "Rent Lot", "No", "Yes"))
					return

				var/deposit = LOT.required_deposit
				var/rent = LOT.rent

				if("Yes" == alert("Current deposit required is [LOT.required_deposit], change deposit?", "Change Deposit Amount", "No", "Yes"))
					deposit = input("Enter your required deposit. Leave empty or 0 to rent to disable deposit requirement.", "Set Deposit", LOT.required_deposit) as num|null

				if("Yes" == alert("Monthly rent is [LOT.rent] as a base amount, change this? Note: Any service charges you add will be added onto this at the end of this process.", "Change Rent", "No", "Yes"))
					rent = input("Enter new rent.", "Set Rent", LOT.rent ) as num|null
					if(!rent) return

				LOT.required_deposit = deposit
				LOT.rent = rent

				LOT.status = FOR_RENT
				clear_data()
				index = 8

			if("rent_out_lot") // you see a lot on the market and snab that mofo.
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L
				var/obj/item/weapon/card/id/I = usr.GetIdCard()


				if(!(LOT.status == FOR_RENT))
					error_msg = "This lot is no longer available for rent."
					return

				if("No" == alert("Rent [LOT.name] for [(LOT.rent + LOT.required_deposit)] credits? ([LOT.rent]CR rent with [LOT.required_deposit]CR deposit)", "Rent Out Lot", "No", "Yes"))
					return

				if(unique_id == LOT.landlord_uid)
					error_msg = "You cannot rent out your own property!"
					return

				if(!I || !I.associated_account_number || !I.associated_pin_number)
					error_msg = "No identification payment card or valid valid bank details detected."
					return

				var/tenant_email = I.associated_email_login["login"]

				if(!tenant_email)
					error_msg = "There is no email address associated with your citizen ID, please contact an administrator to rectify this."
					return

				if(!attempt_account_access(I.associated_account_number, I.associated_pin_number, 2) )
					error_msg = "There was an error charging your bank account. Please contact your bank's administrator."
					return

				var/datum/money_account/M = get_account(I.associated_account_number)
				if((LOT.rent + LOT.required_deposit) > M.money)
					error_msg = "You have insufficient funds to buy this lot."
					return

				if(!charge_to_account(I.associated_account_number, "Housing Purchase", "[LOT.name] Lot Purchase", "Landlord Management", -(LOT.rent + LOT.required_deposit) ))
					error_msg = "There was an error charging your bank account. Please contact your bank's administrator."
					return

				LOT.make_tenant(unique_id, full_name, I.associated_account_number, tenant_email)
				clear_data()
				index = 1

			if("remove_rent_lot") // you don't want to rent it out any more
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!(unique_id == LOT.landlord_uid))
					error_msg = "You cannot change rent status of a property that does not belong to you."
					return

				if("No" == alert("Do you want to remove [LOT.name] from the renting market?", "Cancel Rent Lot", "No", "Yes"))
					return

				if(LOT.landlord_uid)
					LOT.status = OWNED
				else
					LOT.status = FOR_RENT


			if("remove_sale_lot") // you see a lot on the market and snab that mofo.
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!(unique_id == LOT.landlord_uid))
					error_msg = "You cannot change sale status of a property that does not belong to you."
					return

				if("No" == alert("Do you want to remove [LOT.name] from the sale market?", "Cancel Rent Lot", "No", "Yes"))
					return

				if(LOT.landlord_uid)
					LOT.status = OWNED
				else
					LOT.status = FOR_SALE

				clear_data()
				index = 3


			if("evict_tenant") // get out bitch get out!
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if("No" == alert("Do you want to evict [LOT.tenant_name] from the property?", "Evict Tenant", "No", "Yes"))
					return

				if(unique_id == LOT.landlord_uid)
					error_msg = "You do not own this lot!"
					return

				if(!(LOT.status == RENTED))
					error_msg = "This lot is not rented out to anyone."
					return

				LOT.remove_tenant()
				clear_data()
				index = 3

			if("end_tenancy") // when you leave a tenancy
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if("No" == alert("Do you want end your tenancy with [LOT.tenant_name]? You will not get a refund of your deposit.", "End Tenancy", "No", "Yes"))
					return

				if(unique_id == LOT.tenant_uid)
					error_msg = "You are not a tenant of this lot"
					return

				if(!(LOT.status == RENTED))
					error_msg = "This lot is not rented out to anyone."
					return

				if(LOT.tenant_balance)
					error_msg = "You must clear all bills before ending your tenancy."
					return

				LOT.remove_tenant()
				clear_data()
				index = 10