/datum/computer_file/program/landlord_management
	filename = "landlordm"
	filedesc = "Landlord Management Utility"
	extended_desc = "This program can be used by landlords to buy and sell properties, you can also manage existing properties you own."
	program_icon_state = "generic"
	size = 5
	requires_ntnet = 1
	available_on_ntnet = 0

	nanomodule_path = /datum/nano_module/landlord_management

/datum/computer_file/program/landlord_management/proc/print_lot_data(mob/user, datum/lot/LOT)
	if(!LOT)
		to_chat(user, "ERROR: Missing lot data.")
		return

	if(!computer.nano_printer)
		to_chat(user, "Missing Hardware: Your computer does not have the required hardware to complete this operation.")
		return

	var/output


	output += "<h1>Lot Details: [LOT.name]</h1><br> \
	<hr> \
	<b>Lot Name:</b> [LOT.name]<br> \
	<b>Owner:</b> [LOT.get_landlord_name()]<br> \
	<b>Description:</b> [LOT.desc]<br> \
	<b>Price:</b> [cash2text( LOT.get_price(), FALSE, TRUE, TRUE )] (Original Price: [cash2text( LOT.get_default_price(), FALSE, TRUE, TRUE )])<br> \
	<b>Current Default Rent:</b> [cash2text( LOT.get_rent(), FALSE, TRUE, TRUE )] (Original Rent: [cash2text( LOT.get_default_rent(), FALSE, TRUE, TRUE )])<br><hr>"

	if(LOT.landlord)
		output += "<b>Landlord Balance:</b> [cash2text( LOT.get_landlord_balance(), FALSE, TRUE, TRUE )] ([cash2text( LOT.get_service_charge(), FALSE, TRUE, TRUE )] per payroll)<br>"

	if(!isemptylist(LOT.get_tenants()))
		output += "<b>Tenants [LOT.tenancy_no_info()]:</b><br>"
		for(var/datum/tenant/T in LOT.get_tenants())
			output += "<li>[T.name] | Account Balance: [cash2text( T.get_balance(), FALSE, TRUE, TRUE )] (Rent: [cash2text( LOT.get_rent(T), FALSE, TRUE, TRUE )]) (Last Payment: [T.last_payment])</li>"


	else
		output += "<i>Lot has no tenants.</i>"

	output += "<br><br>"

	output += "<b>Lot Notes:</b> <br>"
	if(LAZYLEN(LOT.notes))
		for(var/V in LOT.notes)
			output += "<li>[V]</li>"
	else
		output += "<i>No lot notes found.</i>"

	output += "<br><br>"

	output += "<b>Checkbook:</b><br>"
	if(LAZYLEN(LOT.landlord_checkbook))
		for(var/V in LOT.landlord_checkbook)
			output += "<li>[V]</li>"
	else
		output += "<i>No checkbook/payment notes found.</i>"

	if(!computer.nano_printer.print_text(output, "Lot Data: [LOT.name]"))
		to_chat(user, "Hardware error: Printer was unable to print the file. It may be out of paper.")
		return 1

/datum/nano_module/landlord_management/
	name = "Landlord Management"

	var/index = 1
	var/page_msg
	var/error_msg = " "
	var/unique_id
	var/email
	var/full_name
	var/acc_balance

	var/judge_access = FALSE
	var/clerk_access = FALSE

	var/datum/lot/current_lot

/datum/nano_module/landlord_management/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = list()
	if(program)
		data = program.get_header_data()

	var/obj/item/weapon/card/id/I = user.GetIdCard()

	if(I)
		full_name = I.registered_name
		unique_id = I.unique_ID

		if(access_hop in I.access)
			clerk_access = TRUE
		else
			clerk_access = FALSE

		if(access_judge in I.access)
			judge_access = TRUE
		else
			judge_access = FALSE

		var/datum/money_account/bank = get_account(I.associated_account_number)
		if(bank)
			acc_balance = bank.money

		email = I.associated_email_login["login"]


	if(!I || !I.unique_ID || !get_account(I.associated_account_number) || !get_email(email) || !config.lot_saving)
		index = 0

	if(index == 0)
		if(!config.lot_saving)
			page_msg = "The landlord management program is currently unavailable. Sorry for the inconvienience."
		else
			page_msg = "You are not authorized to use this system. Please ensure your ID is linked correctly to your citizen details, bank, and email."

	else if(index == 1) // Main Portal Page
		page_msg = "This is the Landlord Management Portal, [full_name].<br>\
		You can buy new properties, or sell existing ones. Please select from the menu."


	else if(index == 2) // Buy Property Page
		page_msg = "Here is a list of available properties that you may buy. Please select from the list.<br>"

		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"

		if(!isemptylist(SSlots.get_lots_for_sale()))
			for(var/datum/lot/L in SSlots.get_lots_for_sale())
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name] (Owned by [L.get_landlord_name()])<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>ID:</b></font> \"[L.id]\"<br>"
				page_msg += "<font color=\"yellow\"><b>Price:</b></font> [cash2text( L.get_price(), FALSE, TRUE, TRUE )] (incl [cash2text( L.get_service_charge(), FALSE, TRUE, TRUE )] service charge per payroll)<br><br>"
				page_msg += "Lot has [L.tenancy_no_info()] tenants. Profit: [cash2text( L.get_approx_earnings(), FALSE, TRUE, TRUE )] per payroll.<br>"
				page_msg += "<b>Licensed for:</b>"
				for(var/V in L.licenses)
					page_msg += "<br><li>[V]</li>"

				page_msg += "<br>"
				page_msg += "<font color=\"yellow\"><a href='?src=\ref[src];choice=buy_lot;lot=\ref[L]'>Buy [L.name] for [cash2text( L.get_price(), FALSE, TRUE, TRUE )].</a></font><br><hr>"
		else
			page_msg += "No properties are currently available for sale. Check back later, or alternatively view properties available for rent."

		page_msg += "</fieldset>"

	else if(index == 3) // Manage Property Page
		page_msg = "These are all the properties you own. You can choose to sell them to City Council, or put them back on the market for someone to buy them. \
		<br><br>Please note that any lots you do sell to City Council can only be sold at their base price. <br><br>Part of the rent you recieve from tenants will go towards property tax. \
		<br>The current property tax rate is [SSpersistent_options.get_persistent_formatted_value(PROPERTY_TAX)] as set by the government.<br>"

		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"

		if(!isemptylist(SSlots.get_lots_by_owner_uid(unique_id)))
			for(var/datum/lot/L in SSlots.get_lots_by_owner_uid(unique_id))
				var/datum/tenant/your_landlord = L.get_landlord()
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name]<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>Minimum Deposit:</b></font> [cash2text( L.required_deposit, FALSE, TRUE, TRUE )]<br>"
				if(L.autorent_deposit)
					page_msg += "<font color=\"yellow\"><b>Auto-Rent :</b></font> [cash2text( L.autorent_deposit, FALSE, TRUE, TRUE )]<br>"
				page_msg += "<font color=\"yellow\"><b>Status:</b></font> [L.get_status()]<br>"
				page_msg += "<font color=\"yellow\"><b>ID:</b></font> \"[L.id]\"<br>"
				page_msg += "Lot has [L.tenancy_no_info()] tenants. Profit: [cash2text( L.get_approx_earnings(), FALSE, TRUE, TRUE )] per payroll.<br>"
				page_msg += "<b>Licensed for:</b>"
				for(var/V in L.licenses)
					page_msg += "<br><li>[V]</li>"

				page_msg += "<br>"
				page_msg += "<font color=\"yellow\"><b>Price:</b></font> [cash2text( L.get_price(), FALSE, TRUE, TRUE )] (incl [cash2text( L.get_service_charge(), FALSE, TRUE, TRUE )] service charge per payroll)<br><br>"
				page_msg += "<font color=\"yellow\"><b>Service Charge Balance:</b></font> [cash2text( L.get_landlord_balance(), FALSE, TRUE, TRUE )] ([cash2text( L.get_service_charge(), FALSE, TRUE, TRUE )] per payroll)<br>"
				page_msg += "<a href='?src=\ref[src];choice=view_checkbook;lot=\ref[L]'>View Checkbook (Payment Records)</a>"
				page_msg += "<a href='?src=\ref[src];choice=print_lot_details;lot=\ref[L]'>Print Full Details</a>"

				var/labelpay = "Add Funds"
				if(0 > your_landlord.account_balance)
					labelpay = "Pay Charges ([cash2text( your_landlord.account_balance, FALSE, TRUE, TRUE )])"
				page_msg += "<a href='?src=\ref[src];choice=pay_serv_charges;lot=\ref[L];landlord=\ref[your_landlord]'>[labelpay]</a>"


				if(!(L.get_status() == LOT_HELD))
					page_msg += "<a href='?src=\ref[src];choice=withdraw_funds;lot=\ref[L];landlord=\ref[your_landlord]'>Withdraw Funds</a>"

					if(L.get_status() == FOR_SALE)
						page_msg += "<a href='?src=\ref[src];choice=remove_sale_lot;lot=\ref[L]'>Remove Lot from Market</a>"
					else
						page_msg += "<a href='?src=\ref[src];choice=sell_lot;lot=\ref[L]'>Sell to City Council ([cash2text( L.get_default_price(), FALSE, TRUE, TRUE )])</a> \
					<a href='?src=\ref[src];choice=market_lot;lot=\ref[L]'>Sell on Market</a> "

					if(L.get_status() == FOR_RENT)
						page_msg += "<a href='?src=\ref[src];choice=view_applicants;lot=\ref[L]'>See Applications[L.applied_tenants.len ? " ([L.applied_tenants.len] Applicants)" : ""]</a>"
						page_msg += "<a href='?src=\ref[src];choice=remove_rent_lot;lot=\ref[L]'>Remove Lot from Rent List</a>"

					else
						page_msg += "<a href='?src=\ref[src];choice=rent_lot;lot=\ref[L]'>Put up for Renting</a> </font>"

					page_msg += "<a href='?src=\ref[src];choice=set_rent;lot=\ref[L]'>Set Rent</a> </font>"
					page_msg += "<a href='?src=\ref[src];choice=set_autorent;lot=\ref[L]'>Set Auto-rent Minimum</a> </font>"

					page_msg += "<a href='?src=\ref[src];choice=set_price;lot=\ref[L]'>Set Price</a> </font>"

					page_msg += "<a href='?src=\ref[src];choice=rename_lot;lot=\ref[L]'>Rename Lot</a> </font>"
					page_msg += "<a href='?src=\ref[src];choice=edit_description;lot=\ref[L]'>Change Description</a> </font>"


					if(!isemptylist(L.get_tenants()))
						page_msg += "<br><br><div style='background-color:black; font-size: 11px; color: white'>"
						page_msg += "<h3>Tenants:</h4><br>"
						for(var/datum/tenant/tenant in L.get_tenants())
							page_msg += "<font color=\"yellow\"><b>Tenant:</b></font> [tenant.name]<br>"
							page_msg += "<font color=\"yellow\"><b>Tenant Current Rent:</b></font> [cash2text( L.get_rent(tenant), FALSE, TRUE, TRUE )]<br>"
							page_msg += "<font color=\"yellow\"><b>Tenant's Rent Balance:</b></font> [cash2text( tenant.get_balance(), FALSE, TRUE, TRUE )] ([cash2text( L.get_rent(tenant), FALSE, TRUE, TRUE )] per payroll)<br>"
							page_msg += "<font color=\"yellow\"><b>Last Payment:</b></font> [tenant.last_payment]<br>"
							page_msg += "<a href='?src=\ref[src];choice=evict_tenant;lot=\ref[L];tenant=\ref[tenant]'>Evict Tenant ([tenant.name])</a> </font><br>"
							page_msg += "<a href='?src=\ref[src];choice=unique_rent_tenant;lot=\ref[L];tenant=\ref[tenant]'>Set Unique Rent ([tenant.name])</a> </font><br>"
							page_msg += "<a href='?src=\ref[src];choice=send_warning_notice;lot=\ref[L];tenant=\ref[tenant]'>Send Warning Email ([tenant.name])</a> </font><br>"
							page_msg += "<hr>"

						page_msg += "</div><br>"

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
				page_msg += "<font color=\"yellow\"><b>Rent:</b></font> [cash2text( L.get_rent(), FALSE, TRUE, TRUE )] (default per payroll)<br>"
				page_msg += "Lot has [L.tenancy_no_info()] tenants.<br>"
				page_msg += "<font color=\"yellow\"><b>Minimum Required Deposit:</b></font> [cash2text( L.required_deposit, FALSE, TRUE, TRUE )]<br>"
				if(L.autorent_deposit)
					page_msg += "<font color=\"yellow\"><b>This property is eligible for instant renting if deposit is [cash2text( L.autorent_deposit, FALSE, TRUE, TRUE )] and over.</b></font> <br>"

				page_msg += "<br>"



				if(!(unique_id == L.get_landlord_uid() ))
					if(!L.get_applicant_by_uid(unique_id))
						page_msg += "<a href='?src=\ref[src];choice=apply_for_rental;lot=\ref[L]'>Apply to Rent [L.name]</a>"
					else
						var/datum/tenant/A = L.get_applicant_by_uid(unique_id)
						page_msg += "<a href='?src=\ref[src];choice=withdraw_application;lot=\ref[L];applicant=\ref[A]'>Remove Rent Application for [L.name]</a>"
				else
					page_msg += "<a href='?src=\ref[src];choice=remove_rent_lot;lot=\ref[L]'>Remove Lot from Rent List</a>"
					page_msg += "<a href='?src=\ref[src];choice=view_applicants;lot=\ref[L]'>See Applications[L.applied_tenants.len ? " ([L.applied_tenants.len] Applicants)" : ""]</a>"

				page_msg += "<hr>"

		else
			page_msg += "There are no properties available for renting at this time. Check back later."

		page_msg += "</fieldset>"

	else if(index == 10) // Lot that you rent
		page_msg = "These are the lots that you currently rent.<br><br>"
		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"
		if(!isemptylist(SSlots.get_lots_by_tenant_uid(unique_id)))
			for(var/datum/lot/L in SSlots.get_lots_by_tenant_uid(unique_id))
				var/datum/tenant/your_tenant = L.get_tenant_by_uid(unique_id)
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name]<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>Landlord:</b></font> [L.get_landlord_name()]<br>"
				page_msg += "<font color=\"yellow\"><b>Contact Email:</b></font> [L.landlord.email]<br><br>"
				page_msg += "<b>Licensed for:</b>"
				for(var/V in L.licenses)
					page_msg += "<br><li>[V]</li>"

				page_msg += "<br>"

				page_msg += "<font color=\"yellow\"><b>Rent:</b></font> [cash2text( L.get_rent(), FALSE, TRUE, TRUE )]<br>"
				page_msg += "<font color=\"yellow\"><b>Last Payment:</b></font> [your_tenant.last_payment]<br>"
				page_msg += "<font color=\"yellow\"><b>Account Balance:</b></font> [cash2text( your_tenant.get_balance(), FALSE, TRUE, TRUE )]<br>"

				var/labelpay = "Add Funds"
				if(!(your_tenant.account_balance > 0))
					labelpay = "Pay Rent ([cash2text( your_tenant.account_balance, FALSE, TRUE, TRUE )])"
				page_msg += "<a href='?src=\ref[src];choice=pay_rent;lot=\ref[L];tenant=\ref[your_tenant]'>[labelpay]</a>"
				page_msg += "<a href='?src=\ref[src];choice=end_tenancy;lot=\ref[L];tenant=\ref[your_tenant]'>Cancel Tenancy</a>"

				page_msg += "<hr>"

		else
			page_msg += "There are no properties that you rent."
		page_msg += "</fieldset>"

	else if(index == 11) // Applications from tenants
		if(!current_lot)
			page_msg = "There appears to be no lot selected.<br>"
		else
			var/datum/lot/L = current_lot
			page_msg = "These are the current applications for tenancy for this lot.<br>"
			page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"

			if(!isemptylist(L.applied_tenants))
				for(var/datum/tenant/A in L.applied_tenants)
					page_msg += "<font color=\"yellow\"><b>Applicant Name:</b></font> [A.name]<br>"
					page_msg += "<font color=\"yellow\"><b>Email:</b></font> [A.email]<br>"
					page_msg += "<font color=\"yellow\"><b>Offered Deposit:</b></font> [cash2text( A.agreed_deposit, FALSE, TRUE, TRUE )]<br>"
					if(A.application_note)
						page_msg += "<font color=\"yellow\"><b>Application Note:</b></font> [A.application_note]<br>"


					page_msg += "<a href='?src=\ref[src];choice=accept_app;lot=\ref[L];applicant=\ref[A]'>Accept</a> "
					page_msg += "<a href='?src=\ref[src];choice=reject_app;lot=\ref[L];applicant=\ref[A]'>Reject</a>"

					page_msg += "<hr>"
			else
				page_msg += "There are no applications for tenancy. Check back later."

			page_msg += "</fieldset>"

	else if(index == 12) // Financial Log Book / Landlord Checkbook
		if(!current_lot)
			page_msg = "There appears to be no lot selected.<br>"
		else
			var/datum/lot/L = current_lot
			page_msg = "This is a list of financial transactions from the last payroll you may review.<br>"
			page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"

			if(!isemptylist(L.landlord_checkbook))
				for(var/A in L.landlord_checkbook)
					page_msg += "[A]<br>"
			else
				page_msg += "<i>No entries found.</i>"

			page_msg += "</fieldset>"

	else if(index == 13) // View all lots
		page_msg = "This is a list of all lots available in [using_map.station_name].<br>"

		for(var/datum/lot/L in SSlots.all_lots)
			page_msg += "<a href='?src=\ref[src];choice=select_lot;lot=\ref[L]'>Select</a> "

			page_msg += "<b>[L.name]</b> | <b>STATUS:</b> [L.get_status()] | <b>Market Price:</b> [cash2text( L.get_price(), FALSE, TRUE, TRUE )] | <b>No of Tenants:</b> [L.tenancy_no_info()]<br>"

	else if(index == 14) // View a certain lot
		if(!current_lot)
			page_msg = "There appears to be no lot selected.<br>"
		else
			var/datum/lot/L = current_lot
			var/status = L.get_status()

			page_msg = "<h3>[L.name]</h3>"
			page_msg += "<b>ID</b>:<br> [L.id]<br>"
			page_msg += "<b>Name</b>:<br> [L.name]<br>"
			page_msg += "<b>Description</b>:<br> [L.desc]<br>"
			page_msg += "<b>Status</b>:<br> [status]<br>"
			page_msg += "<b>Owner</b>:<br> [L.get_landlord_name()]<br>"

			if(status == FOR_RENT)
				page_msg += "<font color=\"yellow\"><b>Minimum Required Deposit:</b></font> [cash2text( L.required_deposit, FALSE, TRUE, TRUE )]<br>"
				if(L.autorent_deposit)
					page_msg += "<font color=\"yellow\"><b>This property is eligible for instant renting if deposit is [cash2text( L.autorent_deposit, FALSE, TRUE, TRUE )] and over.</b></font> <br>"

			if(L.landlord)
				page_msg += "<b>Contact Email:</b> [L.landlord.email]<br>"

			if(clerk_access || judge_access)
				if(!isemptylist(L.get_tenants()))
					page_msg += "<b>Tenants [L.tenancy_no_info()]:</b><br>"
					for(var/datum/tenant/T in L.get_tenants())
						page_msg += "<li>[T.name] | Account Balance: [cash2text( T.get_balance(), FALSE, TRUE, TRUE )] (Last Payment: [T.last_payment]) | Rent: [cash2text( L.get_rent(T), FALSE, TRUE, TRUE )]</li>"

				page_msg += "<br>"


				page_msg += "<b>Landlord Balance</b>: [cash2text( L.get_landlord_balance(), FALSE, TRUE, TRUE )]<br>"


				if(judge_access && L.landlord)
					page_msg += "<a href='?src=\ref[src];choice=repossess_lot;lot=\ref[L]'>Repossess Lot</a>"


				if(!L.held)
					page_msg += "<a href='?src=\ref[src];choice=hold_lot;lot=\ref[L]'>Freeze Lot</a>"
				else
					page_msg += "<a href='?src=\ref[src];choice=unhold_lot;lot=\ref[L]'>Unfreeze Lot</a>"

				if(L.landlord && (0 > L.get_landlord_balance()))
					page_msg += "<a href='?src=\ref[src];choice=send_warning_notice_landlord;lot=\ref[L]'>Send Arrears Email</a>"

				page_msg += "<a href='?src=\ref[src];choice=print_lot_details;lot=\ref[L]'>Print Full Details</a>"

				page_msg += "<div class='statusDisplay' style='overflow: auto;'>"
				if(LAZYLEN(L.notes))
					for(var/V in L.notes)
						page_msg += "[V]<br>"
				else
					page_msg += "No notes found."

				page_msg += "</div>"

			page_msg += "<br><br>"
			if(L.held)
				page_msg += "<b>Held Purpose</b>:<br> [L.reason_held]<br><br>"

	if(index == -1)
		page_msg = "This isn't a thing yet, sorry."


	data["index"] = index
	data["page_msg"] = page_msg
	data["full_name"] = full_name
	data["error_msg"] = error_msg
	data["acc_balance"] = acc_balance
	data["current_lot"] = current_lot
	data["judge_access"] = judge_access

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "landlord_management.tmpl", "Landlord Management Utility", 960, 450, state = state)
		if(program.update_layout())
			ui.auto_update_layout = 1
		ui.set_auto_update(1)
		ui.set_initial_data(data)
		ui.open()



/datum/nano_module/landlord_management/proc/clear_data()
	error_msg = " "
	current_lot = null

/datum/nano_module/landlord_management/Topic(href, href_list)
	if(..()) return 1

	if(href_list["main"])
		. = 1
		clear_data()
		index = 1

	if(href_list["back"])
		. = 1
		error_msg = initial(error_msg)
		if(index in list(12, 11))
			index = 3
		else if(index in list(14))
			index = 13
		else
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

	if(href_list["view_all_lots"])
		. = 1
		index = 13

	if(href_list["choice"])
		switch(href_list["choice"])


			if("view_applicants")
				var/L = locate(href_list["lot"])
				var/datum/lot/LOT = L

				if(!(LOT.get_landlord_uid() == unique_id))
					return

				current_lot = LOT
				index = 11

			if("view_checkbook")
				var/L = locate(href_list["lot"])
				var/datum/lot/LOT = L

				if(!(LOT.get_landlord_uid() == unique_id))
					return

				current_lot = LOT
				index = 12

			if("select_lot")
				. = 1
				var/L = locate(href_list["lot"])
				current_lot = L

				if(!current_lot)
					index = 1
					return
				index = 14


			if("set_price")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					return

				var/lot_new_price = input("Current lot price is [LOT.get_price()]CR, input a new price for your lot.", "Set Price", LOT.price) as num|null

				if(!lot_new_price || (0 > lot_new_price))
					return

				if("No" == alert("Set the price of [LOT.name] to [lot_new_price]CR?", "Price Lot", "No", "Yes"))
					return

				LOT.add_note(full_name, "Changed [LOT.name]'s price from [LOT.get_price()]CR to [lot_new_price]CR.",usr)

				LOT.price = lot_new_price


			if("set_autorent")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					return


				var/autorent_option = alert("What would you like to do?", "Autorent Lot", "Adjust Autorent", "Remove Autorent", "Cancel")

				if(autorent_option== "Cancel")
					return

				if(autorent_option == "Remove Autorent")
					LOT.autorent_deposit = 0
					LOT.add_note(full_name, "Removed [LOT.name]'s auto-rent.",usr)

					return

				var/lot_new_autorent = input("Auto-renting occurs when you set an minimum deposit amount needed to automatically rent. This must be higher than your minimum deposit.", "Set Autorent", LOT.autorent_deposit) as num|null

				if(0 > lot_new_autorent)
					return

				if("No" == alert("Set the autorent of [LOT.name] to [lot_new_autorent]CR?", "Autorent Lot", "No", "Yes"))
					return

				if(LOT.required_deposit > lot_new_autorent)
					lot_new_autorent = LOT.required_deposit

				LOT.add_note(full_name, "Changed [LOT.name]'s auto-rent amount from [LOT.autorent_deposit]CR to [lot_new_autorent]CR.",usr)

				LOT.autorent_deposit = lot_new_autorent


			if("set_rent")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					return

				var/max_rent = SSpersistent_options.get_persistent_option_value("maximum_rent")
				var/lot_new_rent = input("Current lot price is [LOT.get_rent()]CR, input the new default rent for your lot. Warning: You should probably let your tenants know before doing this. Max Rent: [max_rent]CR", "Set Price", LOT.get_rent()) as num|null

				if(!lot_new_rent || (0 > lot_new_rent))
					return


				if(lot_new_rent > max_rent)
					alert("The maximum you may set the rent to is [max_rent]CR.")
					return


				if("No" == alert("Set the rent of [LOT.name] to [lot_new_rent]CR?", "Rent Lot", "No", "Yes"))
					return

				LOT.add_note(full_name, "Changed [LOT.name]'s rent from [LOT.get_rent()]CR to [lot_new_rent]CR.",usr)

				LOT.rent = lot_new_rent


			if("rename_lot")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					error_msg = "This lot does not exist."
					return


				var/new_name = sanitize(input("Current lot name is [LOT.name], enter a new name.", "Set Name", LOT.name) as text, MAX_NAME_LEN)

				if("No" == alert("Rename [LOT.name] to [new_name]?", "Confirm Name", "No", "Yes"))
					return

				LOT.add_note(full_name, "Renamed [LOT.name] to [new_name].",usr)
				LOT.name = capitalize(new_name)
				LOT.lot_area.name = capitalize(new_name)



			if("edit_description")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					error_msg = "This lot does not exist."
					return


				var/new_desc = sanitize(input("Enter a new description for your lot. Clearing this will set the description back to default.", "Set Name", LOT.desc) as message, MAX_PAPER_MESSAGE_LEN)

				if(!new_desc)
					LOT.desc = initial(LOT.desc)
					LOT.add_note(full_name, "Reset [LOT.name]'s description to default.",usr)
					return

				LOT.desc = new_desc
				LOT.add_note(full_name, "Changed [LOT.name]'s description.",usr)


			if("buy_lot")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L
				var/obj/item/weapon/card/id/I = usr.GetIdCard()
				var/landlord_email = I.associated_email_login["login"]


				if(!LOT)
					error_msg = "This lot does not exist."
					return

				if(!(LOT.get_status() == FOR_SALE))
					error_msg = "This lot is not for sale."
					return

				if("No" == alert("Buy [LOT.name] for [LOT.get_price()] credits?", "Buy Lot", "No", "Yes"))
					return



				if(!I || !I.associated_account_number || !I.associated_pin_number)
					error_msg = "No identification payment card or valid valid bank details detected."
					return

				if(!landlord_email)
					error_msg = "There is no email address associated with your citizen ID, please contact an administrator to rectify this."
					return

				var/max_lots = SSpersistent_options.get_persistent_option_value("maximum_lots")
				if(LAZYLEN(SSlots.get_lots_by_owner_uid(unique_id)) >= max_lots)
					error_msg = "You may have no more than [max_lots] properties."
					return


				var/datum/money_account/D = get_account(I.associated_account_number)
				var/attempt_pin = ""
				if(D && D.security_level)
					attempt_pin = input("Enter PIN", "Transaction") as num


				if(!attempt_account_access(I.associated_account_number, attempt_pin, 2) )
					error_msg = "There was an error charging your bank account. Please contact your bank's administrator."
					return

				if(LOT.get_price() > D.money)
					error_msg = "You have insufficient funds to buy this lot."
					return

				if(!charge_to_account(I.associated_account_number, "Housing Purchase", "[LOT.name] Lot Purchase", "Landlord Management", -LOT.get_price() ))
					error_msg = "There was an error charging your bank account. Please contact your bank's administrator."
					return

				LOT.set_new_ownership(unique_id, full_name, I.associated_account_number, landlord_email)
				clear_data()
				LOT.for_sale = FALSE
				index = 4


			if("sell_lot")	// This is for selling lots to City Council, the Council doesn't pay tax on lots.
				var/L = locate(href_list["lot"])
				var/datum/lot/LOT = L

				if(!LOT)
					return


				if("No" == alert("Sell [LOT.name] to City Council for [LOT.get_default_price()] credits?", "Sell Lot", "No", "Yes"))
					return

				if(!LOT.get_landlord_uid() == unique_id)
					return

				var/obj/item/weapon/card/id/I = usr.GetIdCard()

				if(!I || !I.associated_account_number || !I.associated_pin_number)
					error_msg = "No identification payment card or valid valid bank details detected."
					return

				if(!charge_to_account(I.associated_account_number, "Housing Sell", "[LOT.name] Lot Sell", "Landlord Management", LOT.get_default_price()))
					error_msg = "There was an error charging your bank account. Please contact your bank's administrator."
					return

				LOT.sell_to_council()
				LOT.tenants_wanted = FALSE
				clear_data()
				index = 5



			if("market_lot")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					return

				if("No" == alert("Put [LOT.name] on the market for selling?", "Sell Lot", "No", "Yes"))
					return

				var/lot_new_price = input("Current lot price is [LOT.price]CR, input a new price for your lot.", "Set Price", LOT.price) as num|null

				if(!lot_new_price)
					return

				LOT.price = lot_new_price
				LOT.for_sale = TRUE
				clear_data()
				index = 6
				LOT.add_note(full_name, "Added [LOT.name] to sale market.",usr)



			if("rent_lot") // you put a lot on the market for people to rent.
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					return

				if(!(LOT.get_status() == OWNED) && !(unique_id == LOT.get_landlord_uid()) && LOT.get_status() == RENTED)
					error_msg = "You are unable to put this lot for rent as it is either up for sale, already rented, or a lot you do not own."
					return

				if("No" == alert("Put [LOT.name] on the market for rent?", "Rent Lot", "No", "Yes"))
					return

				var/deposit = LOT.required_deposit
				var/rent = LOT.get_rent()

				if("Yes" == alert("Current minimum deposit required is [LOT.required_deposit], change deposit?", "Change Minimum Deposit Amount", "No", "Yes"))
					deposit = input("Enter your required deposit. Leave empty or 0 to rent to disable deposit requirement.", "Set Deposit", LOT.required_deposit) as num|null

				if("Yes" == alert("Rent is [LOT.get_rent()] per payroll, change this? Leave blank to cancel renting.", "Change Rent", "No", "Yes"))
					rent = input("Enter new rent.", "Set Rent", LOT.get_rent() ) as num|null
					if(!rent) return

				LOT.required_deposit = deposit
				LOT.rent = rent

				LOT.tenants_wanted = TRUE
				clear_data()
				index = 8
				LOT.add_note(full_name, "Added [LOT.name] to rent list.",usr)



			if("remove_rent_lot") // you don't want to rent it out any more
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					return

				if(!(unique_id == LOT.get_landlord_uid()))
					error_msg = "You cannot change rent status of a property that does not belong to you."
					return

				if("No" == alert("Do you want to remove [LOT.name] from the renting market?", "Cancel Rent Lot", "No", "Yes"))
					return

				LOT.tenants_wanted = FALSE
				LOT.remove_all_applicants()
				LOT.add_note(full_name, "Removed [LOT.name] from rent list.",usr)

			if("remove_sale_lot") // remove the lot from sale
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					return

				if(!(unique_id == LOT.get_landlord_uid() ))
					error_msg = "You cannot change sale status of a property that does not belong to you."
					return

				if("No" == alert("Do you want to remove [LOT.name] from the sale market?", "Cancel Rent Lot", "No", "Yes"))
					return

				LOT.for_sale = FALSE
				LOT.add_note(full_name, "Removed [LOT.name] from sale list.",usr)

				clear_data()
				index = 3

			if("print_lot_details") // remove the lot from sale
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					return

				if(!(unique_id == LOT.get_landlord_uid() ) && !clerk_access && !judge_access)
					error_msg = "You cannot print details of a property that you have no rights to."
					return
				var/datum/computer_file/program/landlord_management/printprog = program
				printprog.print_lot_data(usr, LOT)


			if("hold_lot") // get out bitch get out!
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if(!LOT)
					return

				if(!clerk_access && !judge_access)
					return

				if(LOT.held)
					error_msg = "This lot is already held."
					return

				// no you can't join as a city council member and hold the lot of your own landlord. nice try tho
				if(LOT.get_tenant_by_uid(unique_id) || (unique_id == LOT.get_landlord_uid() ) )
					error_msg = "Due to conflict of interest, as a council member you cannot handle lots that you are a tenant or landlord of."
					alert("Due to conflict of interest, as a council member you cannot handle lots that you are a tenant or landlord of.")
					return


				if("No" == alert("Are you sure you want to put [LOT.name] on hold?", "Freeze Lot", "No", "Yes"))
					return

				var/held_rsn = sanitize(input("Enter a hold reason, you must enter a detailed hold reason explaining why this lot is held or this will not go through. Max chars ([MAX_PAPER_MESSAGE_LEN])", "Set Name") as message, MAX_PAPER_MESSAGE_LEN)

				if(!held_rsn)
					return

				LOT.held = TRUE
				LOT.reason_held = held_rsn

				if(LOT.landlord)
					var/datum/computer_file/data/email_account/council_email = get_email(using_map.council_email)
					var/datum/computer_file/data/email_message/message = new/datum/computer_file/data/email_message()
					var/eml_cnt = "Dear [LOT.get_landlord_name()], \[br\]"
					eml_cnt += "[LOT.name] has been frozen for the following reason:\[BR\]\[BR\]\
					[LOT.reason_held]\[BR\]\[BR\] \
					This can be contested in a court of law, please contact city council at [using_map.council_email] for more details."

					message.stored_data = eml_cnt
					message.title = "Property Held: [LOT.name] - City Council"
					message.source = "noreply@nanotrasen.gov.nt"

					council_email.send_mail(LOT.landlord.email, message)

				LOT.add_note(full_name, "Held/Froze [LOT.name].",usr)

			if("unhold_lot") // get out bitch get out!
				var/L = locate(href_list["lot"])
				var/datum/lot/LOT = L

				if(!LOT)
					return

				if(!clerk_access && !judge_access)
					return

				if(!LOT.held)
					error_msg = "This lot is not held."
					return

				// no you can't join as a city council member and hold the lot of your own landlord. nice try tho
				if(LOT.get_tenant_by_uid(unique_id) || (unique_id == LOT.get_landlord_uid() ) )
					error_msg = "Due to conflict of interest, as a council member you cannot handle lots that you are a tenant or landlord of."
					alert("Due to conflict of interest, as a council member you cannot handle lots that you are a tenant or landlord of.")
					return


				if("No" == alert("Are you sure you want to take [LOT.name] off hold?", "Unfreeze Lot", "No", "Yes"))
					return

				LOT.held = FALSE

				LOT.add_note(full_name, "Took [LOT.name] off hold.",usr)


			if("repossess_lot") // this ours now!
				var/L = locate(href_list["lot"])
				var/datum/lot/LOT = L

				if(!LOT)
					return

				if(!judge_access)
					return

				if(!LOT.landlord)
					alert("You cannot repossess lots that do not have a landlord!")

				if("No" == alert("Do you want to repossess [LOT.name]? [LOT.get_landlord_name()] will lose access to the property. Do not do this lightly!", "Repossess", "No", "Yes"))
					return

				// no you can't join as a city council member and hold the lot of your own landlord. nice try though.
				if(LOT.get_tenant_by_uid(unique_id) || (unique_id == LOT.get_landlord_uid() ) )
					error_msg = "Due to conflict of interest, as a council member you cannot handle lots that you are a tenant or landlord of."
					alert("Due to conflict of interest, as a council member you cannot handle lots that you are a tenant or landlord of.")
					return

				if(LOT.service_charge_possession > LOT.get_landlord_balance())
					error_msg = "This lot has not accured enough debt to be eligible for reposession. It must be -[LOT.service_charge_possession]CR and under."
					alert("This lot has not accured enough debt to be eligible for reposession. It must be -[LOT.service_charge_possession]CR and under.")
					return

				LOT.add_note(full_name, "Repossessed [LOT.name] as a tenant from [LOT.name] - [cash2text( LOT.get_landlord_balance(), FALSE, TRUE, TRUE )] processed to landlord's account",usr)
				LOT.repossess_lot()



			if("unique_rent_tenant") // get out bitch get out!
				var/L = locate(href_list["lot"])
				var/T = locate(href_list["tenant"])

				var/datum/lot/LOT = L
				var/datum/tenant/tenant = T

				if(!LOT || !tenant)
					return
				var/max_rent = SSpersistent_options.get_persistent_option_value("maximum_rent")
				var/new_rent = input("Please set a new unique rent amount for this tenant. Leave blank to set to lot default. Max: [max_rent]CR.", "Set Unique Rent", tenant.get_rent()) as num|null

				if(0 > new_rent)
					return


				if(new_rent > max_rent)
					alert("The maximum you may set the rent to is [max_rent]CR.")
					return

				if("No" == alert("Set the unique rent of [tenant.name] to [new_rent]CR?", "Unique Rent", "No", "Yes"))
					return

				LOT.add_note(full_name, "Changed [tenant.name]'s individual rent from [cash2text( LOT.get_rent(tenant), FALSE, TRUE, TRUE )] to [cash2text( new_rent, FALSE, TRUE, TRUE )].",usr)

				tenant.unique_rent = new_rent


			if("evict_tenant") // get out bitch get out!
				var/L = locate(href_list["lot"])
				var/T = locate(href_list["tenant"])

				var/datum/lot/LOT = L
				var/datum/tenant/tenant = T

				if(!LOT || !tenant)
					return

				if("No" == alert("Do you want to evict [tenant.name] from the property?", "Evict Tenant", "No", "Yes"))
					return

				if(!(unique_id == LOT.get_landlord_uid()))
					error_msg = "You do not own this lot!"
					return

				if(!LOT.has_tenants())
					error_msg = "This lot is not rented out to anyone."
					return

				var/min_arrears = SSpersistent_options.get_persistent_option_value("minimum_arrears_tenant")
				if(tenant.get_balance() > min_arrears)
					error_msg = "This tenant has not reached the minimum threshold for eviction which is currently [min_arrears]CR and under."
					return

				LOT.add_note(full_name, "Evicted [tenant.name] as a tenant from [LOT.name]",usr)
				LOT.remove_tenant(tenant.unique_id)
				clear_data()
				index = 3

			if("end_tenancy") // when you leave a tenancy
				var/L = locate(href_list["lot"])
				var/T = locate(href_list["tenant"])

				var/datum/lot/LOT = L
				var/datum/tenant/tenant = T

				if(!LOT || !tenant)
					return



				if("No" == alert("Do you want end your tenancy with [tenant.name]? You will not get a refund of your deposit.", "End Tenancy", "No", "Yes"))
					return

				if(!(unique_id == tenant.unique_id))
					error_msg = "You are not a tenant of this lot"
					return

				if(!LOT.has_tenants())
					error_msg = "This lot is not rented out to anyone."
					return

				if(0 > tenant.account_balance)
					error_msg = "You must clear all bills before ending your tenancy."
					return

				LOT.add_note(full_name, "Terminated own tenancy for [LOT.name]",usr)
				LOT.remove_tenant(tenant.unique_id)	//fixes issue where one cannot cancel own tenancy.
				clear_data()
				index = 10


			if("apply_for_rental") // you see a lot for rent on the market and snab that mofo.
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L
				var/obj/item/weapon/card/id/I = usr.GetIdCard()


				if(!(LOT.get_status() == FOR_RENT))
					error_msg = "This lot is no longer available for rent."
					return

				var/list/tenant_count = LOT.get_tenants()

				if(tenant_count.len >= LOT.max_tenants)
					error_msg = "Apologies, this lot has reached the maximum number of tenants."
					return

				if(LOT.get_applicant_by_uid(unique_id))
					error_msg = "You already have applied for this lot."
					return

				if(LOT.get_tenant_by_uid(unique_id))
					error_msg = "You are already a tenant."
					return

				var/reason = sanitize(input(usr, "Please enter your reasons for renting this property.", "Pay Rent") as message, MAX_NAME_LEN)
				if(!reason)
					return

				var/offered_deposit = input(usr, "Enter your offered deposit. You can leave this as default, however a higher deposit might get you \
				better chances at being picked. The landlord will review all applications. \
				Please note: Your bank details will be stored, if successful, a deposit charge will be applied \
				 - continue? MINIMUM: [LOT.required_deposit]CR", "Offer Deposit", LOT.required_deposit) as num|null

				if(!offered_deposit)
					return

				if(LOT.required_deposit > offered_deposit)
					error_msg = "You must enter a number equal to or higher than the minimum deposit!"
					return

				if("No" == alert("Apply for tenancy for [LOT.name] for [offered_deposit] credits?", "Apply for Tenancy", "No", "Yes"))
					return

				if(LOT.get_applicant_by_uid(unique_id))
					error_msg = "You already have applied for this lot."
					return

				if(unique_id == LOT.get_landlord_uid())
					error_msg = "You cannot rent out your own property!"
					return

				if(!I || !I.associated_account_number || !I.associated_pin_number)
					error_msg = "No identification payment card or valid valid bank details detected."
					return

				var/tenant_email = I.associated_email_login["login"]

				if(!tenant_email)
					error_msg = "There is no email address associated with your citizen ID, please contact an administrator to rectify this."
					return

				var/datum/money_account/D = get_account(I.associated_account_number)
				var/attempt_pin = ""
				if(D && D.security_level)
					attempt_pin = input("Enter PIN", "Transaction") as num
					D = null

				if(!attempt_account_access(I.associated_account_number, attempt_pin, 2) )
					error_msg = "There appears to be an issue with your bank details. Please contact your bank's administrator."
					return


				var/datum/tenant/app = LOT.add_applicant(unique_id, full_name, I.associated_account_number, email, offered_deposit, reason)

				if(LOT.autorent_deposit)
					if(app && (offered_deposit >= LOT.autorent_deposit))
						LOT.accept_rentee(app) // woohoo instant accept!

				clear_data()
				index = 1


			if("withdraw_application") // you decided you didn't want that lot any more.
				var/L = locate(href_list["lot"])
				var/A = locate(href_list["applicant"])
				var/datum/lot/LOT = L
				var/datum/tenant/applicant = A

				if(!LOT || !applicant)
					return

				if("No" == alert("Withdraw application for renting?", "Apply for Tenancy", "No", "Yes"))
					return

				LOT.remove_applicant(applicant)



			if("reject_app") // gtfo we see bad credit
				var/L = locate(href_list["lot"])
				var/A = locate(href_list["applicant"])
				var/datum/lot/LOT = L
				var/datum/tenant/applicant = A

				if(!LOT || !applicant)
					return

				if("No" == alert("Reject [applicant]? An email will be sent showing a standard rejection message.", "Apply for Tenancy", "No", "Yes"))
					return


				var/datum/computer_file/data/email_account/council_email = get_email(using_map.council_email)
				var/datum/computer_file/data/email_message/message = new/datum/computer_file/data/email_message()
				var/eml_cnt = "Dear [applicant.name], \[br\]"
				eml_cnt += "Unfortunately you have not been successful for your application for renting the property '[LOT.name]' on this occasion. \
				We wish you the best in your endeavours.\[br\] - City Council \[br\] Do not reply: This is an automated email."

				message.stored_data = eml_cnt
				message.title = "Application Status: [LOT.name] - Rejection"
				message.source = "noreply@nanotrasen.gov.nt"

				council_email.send_mail(applicant.email, message)

				LOT.remove_applicant(applicant)

				LOT.add_note(full_name, "Rejected [LOT.name]'s tenancy application for [applicant.name]",usr)


			if("accept_app") // yes you may be our slave good sir
				var/L = locate(href_list["lot"])
				var/A = locate(href_list["applicant"])
				var/datum/lot/LOT = L
				var/datum/tenant/applicant = A

				if(!LOT || !applicant)
					return

				if("No" == alert("Accept [applicant]? Their agreed deposit is [applicant.agreed_deposit] and this will be charged from their account.", "Apply for Tenancy", "No", "Yes"))
					return

				if(!charge_to_account(applicant.bank_id, "Landlord Management System", "Deposit for [LOT.name]", "City Council DB #[rand(200,500)]", -applicant.agreed_deposit))
					error_msg = "Unfortunately, the applicant's bank account cannot currently be charged at this time. This may be due to issues with the applicant's bank account."
					return

				if(applicant)
					LOT.accept_rentee(applicant)

			if("pay_rent") // paying the rent
				var/L = locate(href_list["lot"])
				var/A = locate(href_list["tenant"])
				var/datum/lot/LOT = L
				var/datum/tenant/tenant = A

				if(!(A in LOT.tenants))
					return

				var/paying = 0

				if(tenant.account_balance > 0)
					paying = tenant.account_balance

				paying = input(usr, "Please input funding amount to add to your account balance.", "Pay Rent", paying) as num|null

				if(!paying)
					return

				if(0 > paying)
					return

				var/datum/money_account/D = get_account(tenant.bank_id)
				var/attempt_pin = ""
				if(D && D.security_level)
					attempt_pin = input("Enter PIN", "Transaction") as num


				if(!attempt_account_access(tenant.bank_id, attempt_pin, 2) )
					error_msg = "There was an error with authenticating your bank account. Please contact your bank's administrator."
					return

				if(paying > D.money)
					error_msg = "You have insufficient funds."
					return

				if(!charge_to_account(tenant.bank_id, "Landlord Management System", "Rent payment for [LOT.name]", "City Council DB #[rand(200,500)]", -paying))
					error_msg = "Unfortunately, your bank account cannot currently be charged at this time. Please check with an administrator."
					return

				LOT.pay_tenant_balance(tenant.unique_id, paying)


			if("pay_serv_charges") // paying the rent
				var/L = locate(href_list["lot"])
				var/A = locate(href_list["landlord"])
				var/datum/lot/LOT = L
				var/datum/tenant/landlord = A

				if(!(A == LOT.landlord))
					return

				var/paying = 0

				if(landlord.account_balance > 0)
					paying = landlord.account_balance

				paying = input(usr, "Please input funding amount to add to your account balance.", "Pay Balance", paying) as num|null

				if(!paying)
					return

				if(0 > paying)
					return

				var/datum/money_account/D = get_account(landlord.bank_id)
				var/attempt_pin = ""
				if(D && D.security_level)
					attempt_pin = input("Enter PIN", "Transaction") as num


				if(!attempt_account_access(landlord.bank_id, attempt_pin, 2) )
					error_msg = "There was an error with authenticating your bank account. Please contact your bank's administrator."
					return

				if(paying > D.money)
					error_msg = "You have insufficient funds."
					return

				if(!charge_to_account(landlord.bank_id, "Landlord Management System", "Balance payment for [LOT.name]", "City Council DB #[rand(200,500)]", -paying))
					error_msg = "Unfortunately, your bank account cannot currently be charged at this time. Please check with an administrator."
					return

				if(0 > landlord.account_balance)
					var/datum/department/council = dept_by_id(DEPT_COUNCIL)
					if(paying > landlord.account_balance)
						var/add_amt = (landlord.account_balance * -1)
						council.adjust_funds(add_amt, "Arrears cleared on [LOT.name]")
					else
						council.adjust_funds(paying, "Partial Balance Payment for [LOT.name]")

				LOT.pay_landlord_balance(paying)


			if("send_warning_notice") // when the landlords say "don't try me" to the occupants
				var/L = locate(href_list["lot"])
				var/A = locate(href_list["tenant"])
				var/datum/lot/LOT = L
				var/datum/tenant/resident = A

				if(!LOT || !resident)
					return


				if("No" == alert("Send warning email to [resident.name]?", "Warning Email", "No", "Yes"))
					return

				if(resident.account_balance > 0)
					error_msg = "This resident is not in debt."
					return

				LOT.send_arrears_letter(resident.unique_id) // sent email to resident

				alert("An email has been sent, informing the resident to pay their balance promptly.")
				LOT.add_note(full_name, "Sent warning notice to [resident.name] for [LOT.name] regarding their [cash2text( resident.account_balance, FALSE, TRUE, TRUE )] arrears.",usr)

			if("send_warning_notice_landlord") // when the city council say "don't try me" to the landlord
				var/L = locate(href_list["lot"])
				var/datum/lot/LOT = L

				if(!LOT || !LOT.get_landlord())
					return


				if("No" == alert("Send warning email to [LOT.get_landlord_name()]?", "Warning Email", "No", "Yes"))
					return

				if(LOT.get_landlord_balance() > 0)
					error_msg = "This landlord is not in debt."
					return

				if(LOT.get_landlord_balance() > -LOT.service_light_warning)
					error_msg = "This landlord needs to be at least [-LOT.service_light_warning] in debt before a warning can be sent."
					return

				LOT.send_arrears_letter(LOT.get_landlord_uid())

				alert("An email has been sent, informing the landlord to pay their service charge balance promptly.")
				LOT.add_note(full_name, "Sent warning notice to [LOT.get_landlord_name()] for [LOT.name] regarding their [cash2text( LOT.get_landlord_balance(), FALSE, TRUE, TRUE )] service charge arrears.",usr)


			if("withdraw_funds") // collect that delicious rent money
				var/L = locate(href_list["lot"])
				var/datum/lot/LOT = L

				if(!LOT)
					return

				if(!(LOT.get_landlord_balance() > 0) || !LOT.get_landlord_balance())
					alert("Your landlord account balance is either empty/in arrears and you are unable to withdraw funds.")
					return

				if("No" == alert("Would you like to withdraw lot funds into your bank account?", "Withdraw Lot Money", "No", "Yes"))
					return

				var/withdraw = input(usr, "Please enter how much you would like to withdraw.", "Withdraw Balance", LOT.get_landlord_balance()) as num|null

				if(0 >= withdraw)
					return

				if(withdraw > LOT.get_landlord_balance())
					error_msg = "You only have [cash2text( LOT.get_landlord_balance(), FALSE, TRUE, TRUE )] in your landlord account. Please choose an amount no larger than this."
					return

				if(!charge_to_account(LOT.landlord.bank_id, "Landlord Management System", "Withdraw balance for [LOT.name]", "City Council DB #[rand(200,500)]", withdraw))
					error_msg = "Unfortunately, it is not possible to send money to your account. Please check with an administrator."
					return

				LOT.landlord.account_balance -= withdraw

				alert("[withdraw]CR has been sent to your bank account.")
				LOT.add_note(full_name, "Withdrew [withdraw]CR to their bank account.",usr)

