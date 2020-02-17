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
	var/email
	var/full_name
	var/acc_balance

	var/datum/lot/current_lot

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


	if(!I || !I.unique_ID || !get_account(I.associated_account_number) || !get_email(I.associated_email_login["login"]))
		index = 0

	if(index == 0)
		page_msg = "You are not authorized to use this system. Please ensure your ID is linked correctly to your citizen details."

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
				page_msg += "<font color=\"yellow\"><b>Price:</b></font> [L.get_lot_cost()]CR (incl [L.get_service_charge()]CR service charge per payroll)<br><br>"
				page_msg += "Lot has [L.tenancy_no_info()] tenants. Approx [L.get_approx_earnings()]CR per payroll.<br>"
				page_msg += "<font color=\"yellow\"><a href='?src=\ref[src];choice=buy_lot;lot=\ref[L]'>Buy [L.name] for [L.get_lot_cost()] credits.</a></font><br><hr>"
		else
			page_msg += "No properties are currently available for sale. Check back later, or alternatively view properties available for rent."

		page_msg += "</fieldset>"

	else if(index == 3) // Manage Property Page
		page_msg = "These are all the properties you own. You can choose to sell them to Nanotrasen, or put them back on the market for someone to buy them. \
		Please note that any lots you do sell can only be sold at their base price. Part of the rent you recieve from tenants will go towards housing tax. \
		The current housing tax rate is [HOUSING_TAX * 100]% as set by the government.<br>"

		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"

		if(!isemptylist(SSlots.get_lots_by_owner_uid(unique_id)))
			for(var/datum/lot/L in SSlots.get_lots_by_owner_uid(unique_id))
				var/datum/tenant/your_landlord = L.get_landlord()
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name]<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>Status:</b></font> [L.get_status()]<br>"
				page_msg += "<font color=\"yellow\"><b>ID:</b></font> \"[L.id]\"<br>"
				page_msg += "Lot has [L.tenancy_no_info()] tenants. Approx [L.get_approx_earnings()]CR per payroll.<br>"
				page_msg += "<font color=\"yellow\"><b>Price:</b></font> [L.get_lot_cost()]CR (incl [L.get_service_charge()]CR service charge per payroll)<br><br>"
				page_msg += "<font color=\"yellow\"><b>Service Charge Balance:</b></font> [L.get_landlord_balance()] ([L.get_service_charge()]CR per payroll)<br>"
				page_msg += "<a href='?src=\ref[src];choice=view_checkbook;lot=\ref[L]'>View Checkbook (Payment Records)</a>"

				var/labelpay = "Add Funds"
				if(!(your_landlord.account_balance > 0))
					labelpay = "Pay Charges ([your_landlord.account_balance]CR)"
				page_msg += "<a href='?src=\ref[src];choice=pay_serv_charges;lot=\ref[L];landlord=\ref[your_landlord]'>[labelpay]</a>"

				if(!(L.get_status() == LOT_HELD))
					page_msg += "<a href='?src=\ref[src];choice=sell_lot;lot=\ref[L]'>Sell to City Council ([L.get_default_price()]CR)</a> \
					<a href='?src=\ref[src];choice=market_lot;lot=\ref[L]'>Sell on Market</a> "

					if(L.get_status() == RENTED)
						for(var/datum/tenant/tenant in L.get_tenants())
							page_msg += "<font color=\"yellow\"><b>Tenant:</b></font> [tenant.name]<br>"
							page_msg += "<font color=\"yellow\"><b>Tenant's Rent Balance:</b></font> [tenant.get_balance()] ([L.get_rent()] per month)<br>"
							page_msg += "<font color=\"yellow\"><b>Last Payment:</b></font> [tenant.last_payment]<br>"
							page_msg += "<a href='?src=\ref[src];choice=evict_tenant;lot=\ref[L];tenant=\ref[tenant]'>Evict Tenant ([tenant.name])</a> </font><br>"
							page_msg += "<a href='?src=\ref[src];choice=send_warning_notice;lot=\ref[L];tenant=\ref[tenant]'>Send Warning Email ([tenant.name])</a> </font><br>"

						page_msg += "<a href='?src=\ref[src];choice=remove_rent_lot;lot=\ref[L]'>Remove Lot from Rent List</a> </font>"

					else
						if(L.get_status() == FOR_RENT)
							page_msg += "<a href='?src=\ref[src];choice=view_applicants;lot=\ref[L]'>See Applications[L.applied_tenants.len ? " ([L.applied_tenants.len] Applicants)" : ""]</a>"
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
				page_msg += "<font color=\"yellow\"><b>Rent:</b></font> [L.get_rent()]CR (per payroll)<br>"
				page_msg += "Lot has [L.tenancy_no_info()] tenants.<br>"
				page_msg += "<font color=\"yellow\"><b>Minimum Required Deposit:</b></font> [L.required_deposit]CR<br><br>"


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
		page_msg = "These are the lots that you currently rent.<br>"
		page_msg += "<fieldset style='border: 2px solid grey; display: inline; width: 80%'>"
		if(!isemptylist(SSlots.get_lots_by_tenant_uid(unique_id)))
			for(var/datum/lot/L in SSlots.get_lots_by_tenant_uid(unique_id))
				var/datum/tenant/your_tenant = L.get_tenant_by_uid(unique_id)
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name]<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>Status:</b></font> \"[L.get_status()]\"<br>"
				page_msg += "<font color=\"yellow\"><b>ID:</b></font> \"[L.id]\"<br>"
				page_msg += "<font color=\"yellow\"><b>Rent:</b></font> [L.get_rent()]CR<br>"
				page_msg += "<font color=\"yellow\"><b>Last Payment:</b></font> [your_tenant.last_payment]<br>"
				page_msg += "<font color=\"yellow\"><b>Account Balance:</b></font> [your_tenant.get_balance()]<br>"

				var/labelpay = "Add Funds"
				if(!(your_tenant.account_balance > 0))
					labelpay = "Pay Rent ([your_tenant.account_balance]CR)"
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

			for(var/datum/tenant/A in L.applied_tenants)
				page_msg += "<font color=\"yellow\"><b>Applicant Name:</b></font> [A.name]<br>"
				page_msg += "<font color=\"yellow\"><b>Email:</b></font> [A.email]<br>"

				page_msg += "<a href='?src=\ref[src];choice=accept_app;lot=\ref[L];applicant=\ref[A]'>Accept</a> "
				page_msg += "<a href='?src=\ref[src];choice=reject_app;lot=\ref[L];applicant=\ref[A]'>Reject</a>"

				page_msg += "<hr>"

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
					page_msg += "<li>[A]</li>"
			else
				page_msg += "<i>No entries found.</i>"

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
	current_lot = null

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

				var/datum/money_account/D = get_account(I.associated_account_number)
				var/attempt_pin = ""
				if(D && D.security_level)
					attempt_pin = input("Enter PIN", "Transaction") as num
					D = null

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
				index = 4


			if("sell_lot")	// This is for selling lots to City Council, the Council doesn't pay tax on lots.
				var/L = locate(href_list["lot"])
				var/datum/lot/LOT = L

				if(!LOT)
					return


				if("No" == alert("Sell [LOT.name] to NT for [LOT.price] credits?", "Sell Lot", "No", "Yes"))
					return

				if(!LOT.get_landlord_uid() == unique_id)
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

				if(!LOT)
					return

				if("No" == alert("Put [LOT.name] on the market for selling?", "Sell Lot", "No", "Yes"))
					return

				var/lot_new_price = input("Current lot price is [LOT.price]CR, input a new price for your lot. ([HOUSING_TAX]CR will be added to this by tax.)", "Set Price", LOT.price) as num|null

				if(!lot_new_price)
					return

				LOT.price = lot_new_price
				LOT.for_sale = TRUE
				clear_data()
				index = 6


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

				if("Yes" == alert("Monthly rent is [LOT.get_rent()] as a base amount, change this? Leave blank to cancel renting.", "Change Rent", "No", "Yes"))
					rent = input("Enter new rent.", "Set Rent", LOT.get_rent() ) as num|null
					if(!rent) return

				LOT.required_deposit = deposit
				LOT.rent = rent

				LOT.tenants_wanted = TRUE
				clear_data()
				index = 8


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


			if("remove_sale_lot") // you see a lot on the market and snab that mofo.
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

				clear_data()
				index = 3


			if("evict_tenant") // get out bitch get out!
				var/L = locate(href_list["lot"])
				var/T = locate(href_list["tenant"])

				var/datum/lot/LOT = L
				var/datum/tenant/tenant = T

				if(!LOT || !tenant)
					return

				if("No" == alert("Do you want to evict [tenant.name] from the property?", "Evict Tenant", "No", "Yes"))
					return

				if(unique_id == LOT.get_landlord_uid())
					error_msg = "You do not own this lot!"
					return

				if(!(LOT.get_status() == RENTED))
					error_msg = "This lot is not rented out to anyone."
					return

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

				if(unique_id == tenant.unique_id)
					error_msg = "You are not a tenant of this lot"
					return

				if(!(LOT.get_status() == RENTED))
					error_msg = "This lot is not rented out to anyone."
					return

				if(tenant.account_balance)
					error_msg = "You must clear all bills before ending your tenancy."
					return

				LOT.remove_tenant()
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

				if(tenant_count >= LOT.max_tenants)
					error_msg = "Apologies, this lot has reached the maximum number of tenants."
					return

				if(LOT.get_applicant_by_uid(unique_id))
					error_msg = "You already have applied for this lot."
					return

				var/offered_deposit = input(usr, "Enter your offered deposit. You can leave this as default, however a higher deposit might get you\
				better chances at being picked. The landlord will review all applications. \
				Please note: Your bank details will be stored, if successful, a deposit charge will be applied \
				 - continue? MINIMUM: [LOT.required_deposit]CR", "Pay Rent", LOT.required_deposit) as num|null

				if(!offered_deposit)
					return

				if(offered_deposit > LOT.required_deposit)
					error_msg = "You must enter a number higher than the minimum deposit!"
					return

				if("No" == alert("Apply for tenancy for [LOT.name] for [(LOT.get_rent() + offered_deposit)] credits?", "Apply for Tenancy", "No", "Yes"))
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


				LOT.add_applicant(unique_id, full_name, I.associated_account_number, email, offered_deposit)

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



			if("reject_tenant") // gtfo we see bad credit
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
				We wish you the best in your endeveours.\[br\] - [LOT.get_landlord_name()] \[br\] Do not reply: This is an automated email."

				message.stored_data = eml_cnt
				message.title = "Application Status: [LOT.name] - Rejection"
				message.source = "noreply@nanotrasen.gov.nt"

				council_email.send_mail(applicant.email, message)

				LOT.remove_applicant(applicant)


			if("accept_tenant") // yes you may be our slave good sir
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

				var/datum/computer_file/data/email_account/council_email = get_email(using_map.council_email)
				var/datum/computer_file/data/email_message/message = new/datum/computer_file/data/email_message()
				var/eml_cnt = "Dear [applicant.name], \[br\]"
				eml_cnt += "Congratulations, you been successful for your application for renting the property '[LOT.name]'. \
				You will now be able to start using the lot commencing onwards. You may contact your landlord on [LOT.landlord.email] \
				for any enquires. Best wishes,\[br\] [LOT.get_landlord_name()] \[br\] Do not reply: This is an automated email."

				message.stored_data = eml_cnt
				message.title = "Your New Property: [LOT.name] - Acceptance"
				message.source = "noreply@nanotrasen.gov.nt"

				council_email.send_mail(applicant.email, message)

				LOT.tenants += applicant
				LOT.applied_tenants -= applicant

				var/list/tenant_count = LOT.get_tenants()

				if(tenant_count >= LOT.max_tenants)
					LOT.tenants_wanted = FALSE

			if("pay_rent") // paying the rent
				var/L = locate(href_list["lot"])
				var/A = locate(href_list["tenant"])
				var/datum/lot/LOT = L
				var/datum/tenant/tenant = A

				if(!(A in LOT.tenants))
					return

				var/paying = 0

				if(0 > tenant.account_balance)
					paying = tenant.account_balance

				paying = input(usr, "Please input funding amount to add to your account balance.", "Pay Rent", paying) as num|null

				if(!paying)
					return

				var/datum/money_account/D = get_account(tenant.bank_id)
				var/attempt_pin = ""
				if(D && D.security_level)
					attempt_pin = input("Enter PIN", "Transaction") as num
					D = null

				if(!attempt_account_access(tenant.bank_id, attempt_pin, 2) )
					error_msg = "There was an error with authenticating your bank account. Please contact your bank's administrator."
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

				if(0 > landlord.account_balance)
					paying = landlord.account_balance

				paying = input(usr, "Please input funding amount to add to your account balance.", "Pay Balance", paying) as num|null

				if(!paying)
					return

				var/datum/money_account/D = get_account(landlord.bank_id)
				var/attempt_pin = ""
				if(D && D.security_level)
					attempt_pin = input("Enter PIN", "Transaction") as num
					D = null

				if(!attempt_account_access(landlord.bank_id, attempt_pin, 2) )
					error_msg = "There was an error with authenticating your bank account. Please contact your bank's administrator."
					return

				if(!charge_to_account(landlord.bank_id, "Landlord Management System", "Balance payment for [LOT.name]", "City Council DB #[rand(200,500)]", -paying))
					error_msg = "Unfortunately, your bank account cannot currently be charged at this time. Please check with an administrator."
					return

				LOT.pay_landlord_balance(paying)


			if("send_warning_notice") // you decided you didn't want that lot any more.
				var/L = locate(href_list["lot"])
				var/A = locate(href_list["resident"])
				var/datum/lot/LOT = L
				var/datum/tenant/resident = A

				if(!LOT || !resident)
					return


				if("No" == alert("Send warning email to [resident.name]?", "Warning Email", "No", "Yes"))
					return

				if(resident.account_balance > 0)
					error_msg = "This resident is not in debt."
					return

				LOT.send_arrears_letter(unique_id)

				alert("An email has been sent, informing the resident to pay their balance promptly.")

			if("withdraw_funds") // you decided you didn't want that lot any more.
				var/L = locate(href_list["lot"])
				var/datum/lot/LOT = L

				if(!LOT)
					return

				if("No" == alert("Would you like to withdraw lot funds into your bank account?", "Withdraw Lot Money", "No", "Yes"))
					return

				if(!(LOT.get_landlord_balance() > 0))
					error_msg = "Your account is in arrears and you are unable to withdraw funds."
					return

				var/withdraw = input(usr, "Please enter how much you would like to withdraw.", "Withdraw Balance", LOT.get_landlord_balance()) as num|null

				if(!withdraw)
					return

				if(withdraw > LOT.get_landlord_balance())
					error_msg = "You only have [LOT.get_landlord_balance()]CR in your landlord account. Please choose an amount no larger than this."
					return

				if(!charge_to_account(LOT.landlord.bank_id, "Landlord Management System", "Withdraw balance for [LOT.name]", "City Council DB #[rand(200,500)]", withdraw))
					error_msg = "Unfortunately, it is not possible to send money to your account. Please check with an administrator."
					return

				alert("[withdraw]CR has been sent to your bank account.")