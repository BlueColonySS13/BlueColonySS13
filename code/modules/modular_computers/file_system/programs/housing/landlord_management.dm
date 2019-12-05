/datum/computer_file/program/landlord_management
	filename = "landlordm"
	filedesc = "Landlord Management Utility"
	extended_desc = "This program can be used by landlords to buy and sell properties, you can also manage existing properties you own."
	program_icon_state = "generic"
	size = 5
	requires_ntnet = 1
	available_on_ntnet = 1

	nanomodule_path = /datum/nano_module/landlord_management

/datum/nano_module/landlord_management/
	name = "Landlord Management"

	var/index = 1
	var/page_msg
	var/error_msg = " "
	var/unique_id
	var/full_name

/datum/nano_module/landlord_management/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = list()
	if(program)
		data = program.get_header_data()

	var/obj/item/weapon/card/id/I = user.GetIdCard()

	full_name = I.registered_name
	unique_id = I.unique_ID


	if(!I || !I.unique_ID)
		index = 0

	if(index == 0)
		page_msg = "You are not authorized to use this system."

	else if(index == 1) // Main Portal Page
		page_msg = "This is the Landlord Management Portal, [full_name].<br>\
		You can buy new properties, or sell existing ones. Please select from the menu."

	else if(index == 2) // Buy Property Page
		page_msg = "Here is a list of available properties that you may buy. Please select from the list.<br>"

		page_msg += "<fieldset style='border: 2px solid grey; display: inline'>"

		if(!isemptylist(SSlots.all_lots))
			for(var/datum/lot/L in SSlots.get_lots_for_sale())
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name] (Owned by [L.landlord_name ? L.landlord_name : "Nanotrasen"])<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>ID:</b></font> \"[L.id]\"<br>"
				page_msg += "<font color=\"yellow\"><b>Price:</b></font> [L.price]CR<br>"
				page_msg += "<a href='?src=\ref[src];choice=buy_lot;lot=\ref[L]'>Buy [L.name] for [L.price] credits.</a><hr>"
		else
			page_msg += "No properties currently available for sale."

		page_msg += "</fieldset>"

	else if(index == 3) // Sell Property Page
		page_msg = "These are all the properties you own. You can choose to sell them to Nanotrasen, or put them back on the market for someone to buy them."

		if(!isemptylist(SSlots.all_lots))
			for(var/datum/lot/L in SSlots.get_lots_by_owner_uid(unique_id))
				page_msg += "<font color=\"yellow\"><b>Lot Name:</b></font> [L.name]<br>"
				page_msg += "<font color=\"yellow\">[L.desc]</font><br>"
				page_msg += "<font color=\"yellow\"><b>ID:</b></font> \"[L.id]\"<br>"
				page_msg += "<font color=\"yellow\"><b>Price:</b></font> [L.price]CR<br>"
				page_msg += "<a href='?src=\ref[src];choice=sell_lot;lot=\ref[L]'>Sell [L.name] to NT.</a>  <a href='?src=\ref[src];choice=market_lot;lot=\ref[L]'>Sell [L.name] on market.</a><hr>"

		else
			page_msg += "There are no properties that you own."

	else if(index == 4) // Lot Purchase Success
		page_msg = "Lot purchase successful."


	else if(index == 5) // Lot Sold
		page_msg = "Lot successfully sold."


	else if(index == 6) // Lot put on market
		page_msg = "Lot has been placed on the market. This can be withdrawn at any time."

	if(index == -1)
		page_msg = "This isn't a thing yet, sorry."


	data["index"] = index
	data["page_msg"] = page_msg
	data["full_name"] = full_name
	data["error_msg"] = error_msg




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

	if(href_list["sell_lots"])
		. = 1
		index = 3

	if(href_list["choice"])
		switch(href_list["choice"])

			if("buy_lot")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if("No" == alert("Buy [LOT.name] for [LOT.price] credits?", "Buy Lot", "No", "Yes"))
					return

				var/obj/item/weapon/card/id/I = usr.GetIdCard()

				if(!I || !I.associated_account_number || !I.associated_pin_number)
					error_msg = "No identification payment card or valid valid bank details detected."
					return

				if(!attempt_account_access(I.associated_account_number, I.associated_pin_number, 2) || !charge_to_account(I.associated_account_number, "Housing Purchase", "[LOT.name] Lot Purchase", "Landlord Management", -LOT.price))
					error_msg = "There was an error charging your bank account. Please contact your bank's administrator."
					return
				else
					LOT.set_new_ownership(unique_id, full_name, I.associated_account_number)
					index = 4


			if("sell_lot")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if("No" == alert("Sell [LOT.name] to NT for [LOT.price] credits?", "Sell Lot", "No", "Yes"))
					return

				var/obj/item/weapon/card/id/I = usr.GetIdCard()

				if(!I || !I.associated_account_number || !I.associated_pin_number)
					error_msg = "No identification payment card or valid valid bank details detected."
					return

				if(!charge_to_account(I.associated_account_number, "Housing Sell", "[LOT.name] Lot Sell", "Landlord Management", LOT.price))
					error_msg = "There was an error charging your bank account. Please contact your bank's administrator."
					return
				else
					LOT.sell_to_nanotrasen()
					index = 5



			if("market_lot")
				var/L = locate(href_list["lot"])

				var/datum/lot/LOT = L

				if("No" == alert("Put [LOT.name] on the market for selling?", "Sell Lot", "No", "Yes"))
					return

				index = 6
