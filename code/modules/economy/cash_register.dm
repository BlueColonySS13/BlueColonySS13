#define LAW "law"
#define MED "medical"
#define COR "court"

/obj/machinery/cash_register
	name = "cash register"
	desc = "Swipe your ID card to make purchases electronically."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "register_idle"
	flags = NOBLUDGEON
	anchored = 0
	table_drag = TRUE
	table_shift = 0

	var/locked = 1
	var/cash_locked = 1
	var/cash_open = 0
	var/machine_id = ""
	var/transaction_amount = 0 // cumulatd amount of money to pay in a single purchase
	var/transaction_purpose = null // text that gets used in ATM transaction logs
	var/list/transaction_logs = list() // list of strings using html code to visualise data
	var/list/item_list = list()  // entities and according
	var/list/price_list = list() // prices for each purchase
	var/list/tax_list = list() // prices for each purchase
	var/manipulating = 0

	var/cash_stored = 0
	var/obj/item/confirm_item
	var/datum/money_account/linked_account
	var/account_to_connect = null

	var/menu_items
	var/adds_tax = TRUE

	var/owner_uid = null
	var/owner_name = null

	var/dept_id = "" // Now connects to department instead of a specific account.

	unique_save_vars = list("locked", "cash_stored", "dept_id", "owner_uid", "owner_name")

// Claim machine ID
/obj/machinery/cash_register/initialize(mapload)
	machine_id = "[station_name()] RETAIL #[GLOB.num_financial_terminals++]"
	GLOB.transaction_devices += src // Global reference list to be properly set up by /proc/setup_economy()

	connect_to_dept()

/obj/machinery/cash_register/on_persistence_load()
	connect_to_dept()

/obj/machinery/cash_register/proc/connect_to_dept()
	if(!SSeconomy)
		return

	if(account_to_connect)
		//public account linking
		var/datum/money_account/M = dept_acc_by_id(account_to_connect)
		if(!M)
			return FALSE
		linked_account = M
	else
		//business account linking
		var/datum/money_account/M = dept_acc_by_id(dept_id)

		linked_account = M

	return linked_account



/obj/machinery/cash_register/examine(mob/user as mob)
	..(user)
	if(cash_open)
		if(cash_stored)
			to_chat(user, "It holds [cash_stored] credit\s of money.")
		else
			to_chat(user, "It's completely empty.")

	if(owner_name)
		to_chat(user, "This cash register is locked to [owner_name].")


/obj/machinery/cash_register/attack_hand(mob/user as mob)
	// Don't be accessible from the wrong side of the machine
	if(get_dir(src, user) & reverse_dir[src.dir]) return

	if(cash_open)
		if(cash_stored)
			if(trigger_lot_security_system(user, /datum/lot_security_option/theft, "Removing [cash_stored]CR from \the [src]."))
				return
			spawn_money(cash_stored, loc, user)
			cash_stored = 0
			overlays -= "register_cash"
		else
			open_cash_box()
	else
		user.set_machine(src)
		interact(user)


/obj/machinery/cash_register/AltClick(mob/user)
	if(Adjacent(user))
		open_cash_box()


/obj/machinery/cash_register/interact(mob/user as mob)
	var/dat = get_data_ui()

	var/datum/browser/popup = new(user, "cash_register", "[src]", 350, 500, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "cash_register")

/obj/machinery/cash_register/proc/get_data_ui()
	var/dat = "<h2>Cash Register<hr></h2>"

	if(!account_to_connect && (!dept_id || !owner_uid|| !owner_name))
		dat += "This register requires you to own a business to your name. Please swipe your ID card to claim this till.<br>"
		return dat

	var/acc_name = null

	if(linked_account)
		acc_name = get_account_name(linked_account.account_number)

	if (locked)
		dat += "<a href='?src=\ref[src];choice=toggle_lock'>Unlock</a><br>"

		dat += "Linked account: <b>[acc_name ? acc_name : "None"]</b><br>"
		dat += "<b>[cash_locked? "Unlock" : "Lock"] Cash Box</b> | "
	else
		dat += "<a href='?src=\ref[src];choice=toggle_lock'>Lock</a><br>"
		dat += "Linked account: <a href='?src=\ref[src];choice=link_account'>[acc_name ? acc_name : "None"]</a><br>"
		dat += "<a href='?src=\ref[src];choice=toggle_cash_lock'>[cash_locked? "Unlock" : "Lock"] Cash Box</a> | "
		if(owner_uid)
			dat += "<a href='?src=\ref[src];choice=reset_owner'>Reset Owner</a><br>"

	dat += "<a href='?src=\ref[src];choice=custom_order'>Custom Order</a> | "
	dat += "<a href='?src=\ref[src];choice=show_shopping_list'>Show List</a> <hr>"


	if(item_list.len)
		dat += get_current_transaction()
		dat += "<br>"

	if(menu_items)
		dat += get_custom_menu()

	for(var/i=transaction_logs.len, i>=1, i--)
		dat += "[transaction_logs[i]]<br>"

	if(transaction_logs.len)
		dat += locked ? "<br>" : "<a href='?src=\ref[src];choice=reset_log'>Reset Log</a><br>"
		dat += "<br>"

	dat += "<i>Device ID:</i> [machine_id]"

	return dat


/obj/machinery/cash_register/proc/get_custom_menu()
	var/dat
	if(menu_items == LAW)
		dat += "Government protocol now allows former convicts to have misdemeanor and criminal offenses paid off from their record by doubling original fine amount \
		 - major crimes are exempt. To be eligible they must have written permission from a Judge or Chief of Police showing they \
		have had good behaviour and no criminal offenses in the last 30 days. A note is left by a judge or prosecutor detailing which crimes are removed.<br><br>"
		for(var/datum/law/L in presidential_laws)
			if(L.fine)
				dat += "<a href='?src=\ref[src];choice=add_menu;menuitem=\ref[L]'>([L.id]) [L.name]</a><br>"

	if(menu_items == MED)
		for(var/datum/medical_bill/M in medical_bills)
			if(M.cost)
				dat += "<a href='?src=\ref[src];choice=add_menu;menuitem=\ref[M]'>[M.name]</a><br>"

	if(menu_items == COR)
		for(var/datum/court_fee/J in court_fees)
			if(J.cost)
				dat += "<a href='?src=\ref[src];choice=add_menu;menuitem=\ref[J]'>[J.name]</a><br>"
	return dat


/obj/machinery/cash_register/Topic(var/href, var/href_list)
	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	if(href_list["choice"])
		switch(href_list["choice"])
			if("toggle_lock")
				if(owner_uid)
					var/obj/item/weapon/card/id/I = usr.GetIdCard()
					if(I && (I.unique_ID != owner_uid))
						to_chat(usr, "\icon[src]<span class='warning'>Error: Lack of identification or card's unique ID does not match the owner's.</span>")
						return
					else
						locked = !locked
						updateDialog()
						return

				if(allowed(usr))
					locked = !locked
				else
					to_chat(usr, "\icon[src]<span class='warning'>Insufficient access.</span>")
			if("toggle_cash_lock")
				if(!locked)
					cash_locked = !cash_locked
			if("link_account")
				if(!account_to_connect)
					var/list/all_bizzies = list()
					for(var/datum/business/B in GLOB.all_businesses)
						all_bizzies += B.name

					var/login_biz = input(usr, "Please select a business to log into.", "Business Login") as null|anything in all_bizzies
					var/datum/business/login_business = get_business_by_name(login_biz)

					if(!login_business)
						alert("No business found with that name, it may have been deleted - contact an administrator.")
						return
					var/access_password = sanitize(copytext(input(usr, "Please provide the password. (Max 40 letters)", "Business Management Utility")  as text,1,40))

					if(!login_business || (access_password != login_business.access_password))
						alert("Incorrect password, please try again.")
						return

					dept_id = login_business.get_department_id()
					connect_to_dept()
					return TRUE
				else
					var/list/all_depts = list()
					for(var/datum/department/D in GLOB.public_departments)
						all_depts += D.name
					var/new_dept = input(usr, "Please select a department.", "Department Login") as null|anything in all_depts
					var/datum/department/login_dept = dept_by_name(new_dept)

					if(!login_dept)
						return

					linked_account = login_dept.bank_account
					account_to_connect = login_dept.id
					return TRUE



			if("custom_order")
				var/t_purpose = sanitize(input("Enter purpose", "New purpose") as text)
				if (!t_purpose || !Adjacent(usr)) return
				transaction_purpose = t_purpose
//				item_list += t_purpose
				var/t_amount = round(input("Enter price (Max 10000)", "New price") as num)
				if (!t_amount || !Adjacent(usr)) return
				if(t_amount < 0) return
				t_amount = Clamp(t_amount, 0, 10000)
				transaction_amount += t_amount
//				price_list += t_amount

				item_list[t_purpose] += 1
				price_list[t_purpose] += t_amount

				playsound(src, 'sound/effects/checkout.ogg', 25)
				src.visible_message("\icon[src][transaction_purpose]: [cash2text( t_amount, FALSE, TRUE, TRUE )].")

			if("add_menu")
				if(!Adjacent(usr)) return

				var/menuitem = locate(href_list["menuitem"])
				var/t_amount
				var/t_purpose
				var/tax_percent
				var/item_desc
				var/tax_cost

				if (istype(menuitem, /datum/law))
					var/datum/law/law_charge = menuitem
					t_amount = law_charge.get_item_cost()
					t_purpose = law_charge.name
					tax_percent = law_charge.get_tax()
					transaction_purpose = law_charge.name
					tax_cost = law_charge.post_tax_cost()
					item_desc = "Fine"

				if (istype(menuitem, /datum/medical_bill))
					var/datum/medical_bill/med_charge = menuitem
					t_amount = med_charge.get_item_cost()
					t_purpose = med_charge.name
					tax_percent = med_charge.get_tax()
					transaction_purpose = med_charge.name
					tax_cost = med_charge.post_tax_cost()
					item_desc = "Medical Bill"

				if (istype(menuitem, /datum/court_fee))
					var/datum/court_fee/court_charge = menuitem
					t_amount = court_charge.get_item_cost()
					t_purpose = court_charge.name
					tax_percent = court_charge.get_tax()
					transaction_purpose = court_charge.name
					tax_cost = court_charge.post_tax_cost()
					item_desc = "Court Fee"

				if(adds_tax)
					t_amount += tax_cost

				item_list[t_purpose] += 1
				price_list[t_purpose] = t_amount

				tax_list[t_purpose] = tax_percent

				transaction_amount += t_amount

				playsound(src, 'sound/effects/checkout.ogg', 25)
				src.visible_message("\icon[src] <b>[item_desc]:</b> [transaction_purpose]: [cash2text( t_amount, FALSE, TRUE, TRUE )].")

			if("set_amount")
				var/item_name = locate(href_list["item"])
				var/n_amount = round(input("Enter amount", "New amount") as num)
				n_amount = Clamp(n_amount, 0, 20)
				if (!item_list[item_name] || !Adjacent(usr)) return
				transaction_amount += (n_amount - item_list[item_name]) * price_list[item_name]
				if(!n_amount)
					item_list -= item_name
					price_list -= item_name
				else
					item_list[item_name] = n_amount
			if("subtract")
				var/item_name = locate(href_list["item"])
				if(item_name)
					transaction_amount -= price_list[item_name]
					item_list[item_name]--
					if(item_list[item_name] <= 0)
						item_list -= item_name
						price_list -= item_name
						tax_list -= item_name
			if("add")
				var/item_name = locate(href_list["item"])
				if(item_list[item_name] >= 20) return
				transaction_amount += price_list[item_name]
				item_list[item_name]++
			if("clear")
				var/item_name = locate(href_list["item"])
				if(item_name)
					transaction_amount -= price_list[item_name] * item_list[item_name]
					item_list -= item_name
					price_list -= item_name
					tax_list -= item_name
				else
					transaction_amount = 0
					item_list.Cut()
					price_list.Cut()
					tax_list.Cut()

			if("set_price")
				var/item_name = locate(href_list["item"])
				var/n_amount = round(input("Enter new price. (Max 10000)", "New price") as num)
				n_amount = Clamp(n_amount, 0, 10000)
				if (!item_list[item_name]  || !price_list[item_name] || !Adjacent(usr)) return

				transaction_amount -= (item_list[item_name] * price_list[item_name])
				price_list[item_name] = n_amount
				transaction_amount += (item_list[item_name] * price_list[item_name])

			if("reset_log")
				transaction_logs.Cut()
				to_chat(usr, "\icon[src]<span class='notice'>Transaction log reset.</span>")
			if("reset_owner")
				var/choice = alert(usr,"Reset the owner of this machine and set back to factory settings?","Reset [src]?","Yes","No")
				if(choice == "Yes")
					owner_uid = null
					owner_name = null
					dept_id = null
					linked_account = null


			if("show_shopping_list")
				if(LAZYLEN(item_list))
					playsound(src, 'sound/effects/checkout.ogg', 25)
					show_shopping_list()
	updateDialog()



/obj/machinery/cash_register/attackby(obj/O as obj, user as mob)
	// Check for a method of paying (ID, PDA, e-wallet, cash, ect.)
	var/obj/item/weapon/card/id/I = O.GetID()
	if(I && !account_to_connect && (!owner_uid || !dept_id))
		if(!I.unique_ID || !I.registered_name)
			to_chat(usr, "\icon[src]<span class='notice'>Invalid card: Identification card lacks registered name and/or unique ID.</span>")
			return

		var/datum/business/B = get_business_by_owner_uid(I.unique_ID)
		var/datum/department/D

		if(B)
			D = dept_by_id(B.business_uid)

		if(!D || !D.bank_account)
			to_chat(usr, "\icon[src]<span class='notice'>No Business: Please register a business before continuing.</span>")
			return
		to_chat(usr, "\icon[src]<span class='notice'>New owner set to [I.registered_name].</span>")
		owner_uid = I.unique_ID
		owner_name = I.registered_name
		dept_id = D.id
		connect_to_dept()
	if(I)
		scan_card(I, O)
	else if (istype(O, /obj/item/weapon/spacecash/ewallet))
		var/obj/item/weapon/spacecash/ewallet/E = O
		scan_wallet(E)
	else if (istype(O, /obj/item/weapon/spacecash))
		var/obj/item/weapon/spacecash/SC = O
		if(cash_open)
			to_chat(user, "You neatly sort the cash into the box.")
			cash_stored += SC.worth
			overlays |= "register_cash"
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				H.drop_from_inventory(SC)
			qdel(SC)
		else
			scan_cash(SC)
	else if(istype(O, /obj/item/weapon/card/emag))
		return ..()
	else if(istype(O, /obj/item/weapon/wrench))
		var/obj/item/weapon/wrench/W = O
		toggle_anchors(W, user)
	// Not paying: Look up price and add it to transaction_amount
	else
		scan_item_price(O)


/obj/machinery/cash_register/MouseDrop_T(atom/dropping, mob/user)
	if(Adjacent(dropping) && Adjacent(user) && !user.stat)
		attackby(dropping, user)


/obj/machinery/cash_register/proc/confirm(obj/item/I)
	if(confirm_item == I)
		return 1
	else
		confirm_item = I
		src.visible_message("\icon[src]<b>Total price:</b> [cash2text( transaction_amount, FALSE, TRUE, TRUE )] credit\s. Swipe again to confirm.")
		playsound(src, 'sound/machines/twobeep.ogg', 25)
		return 0


/obj/machinery/cash_register/proc/scan_card(obj/item/weapon/card/id/I, obj/item/ID_container)
	if (!transaction_amount)
		return

	if (cash_open)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 25)
		usr << "\icon[src]<span class='warning'>The cash box is open.</span>"
		return

	if((item_list.len > 1 || item_list[item_list[1]] > 1) && !confirm(I))
		return

	if (!linked_account)
		usr.visible_message("\icon[src]<span class='warning'>Unable to connect to linked account.</span>")
		return

	// Access account for transaction
	if(check_account())
		var/datum/money_account/D = get_account(I.associated_account_number)

		var/attempt_pin = ""
		if(D && D.security_level)
			attempt_pin = input("Enter PIN", "Transaction") as num
			D = null
		D = attempt_account_access(I.associated_account_number, attempt_pin, 2)

		if(!D)
			src.visible_message("\icon[src]<span class='warning'>Unable to access account. Check security settings and try again.</span>")
		else
			if(D.suspended)
				src.visible_message("\icon[src]<span class='warning'>Your account has been suspended.</span>")
			else
				if(transaction_amount > D.money)
					src.visible_message("\icon[src]<span class='warning'>Not enough funds.</span>")
				else
					// Transfer the money
					D.money -= transaction_amount
					charge_to_account(linked_account.account_number, "[D.owner_name]", "[transaction_purpose]: #[transaction_logs.len+1]", machine_id, transaction_amount)

					// Create log entry in client's account
					D.add_transaction_log(get_account_name(linked_account.account_number), transaction_purpose, -transaction_amount, machine_id)

					// Save log
					add_transaction_log(I.registered_name ? I.registered_name : "n/A", "ID Card", -transaction_amount)

					// Print reciept
					var/receipt_data = get_receipt(I.registered_name ? I.registered_name : "n/A", "ID Card", -transaction_amount)

					var/obj/item/weapon/paper/P = new /obj/item/weapon/paper(loc)
					P.name = "receipt - card payment #[transaction_logs.len+1]"
					P.info = receipt_data

					// Confirm and reset
					transaction_complete()


/obj/machinery/cash_register/proc/scan_wallet(obj/item/weapon/spacecash/ewallet/E)
	if (!transaction_amount)
		return

	if (cash_open)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 25)
		usr << "\icon[src]<span class='warning'>The cash box is open.</span>"
		return

	if((item_list.len > 1 || item_list[item_list[1]] > 1) && !confirm(E))
		return

	// Access account for transaction
	if(check_account())
		if(transaction_amount > E.worth)
			src.visible_message("\icon[src]<span class='warning'>Not enough funds.</span>")
		else
			// Transfer the money
			E.worth -= transaction_amount
			charge_to_account(linked_account.account_number, "E-Wallet Purchase", "[transaction_purpose]: #[transaction_logs.len+1]", machine_id, transaction_amount)

			// Confirm and reset
			transaction_complete()


/obj/machinery/cash_register/proc/scan_cash(obj/item/weapon/spacecash/SC)
	if (!transaction_amount)
		return

	if (cash_open)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 25)
		usr << "\icon[src]<span class='warning'>The cash box is open.</span>"
		return

	if((item_list.len > 1 || item_list[item_list[1]] > 1) && !confirm(SC))
		return

	if(transaction_amount > SC.worth)
		src.visible_message("\icon[src]<span class='warning'>Not enough money.</span>")
	else
		// Insert cash into magical slot
		SC.worth -= transaction_amount
		SC.update_icon()
		if(!SC.worth)
			if(ishuman(SC.loc))
				var/mob/living/carbon/human/H = SC.loc
				H.drop_from_inventory(SC)
			qdel(SC)
		cash_stored += transaction_amount

		// Save log
		add_transaction_log("N/A", "Cash", -transaction_amount, usr.client.ckey)

		// Print reciept
		var/receipt_data = get_receipt("N/A", "Cash", transaction_amount, usr.client.ckey)

		var/obj/item/weapon/paper/P = new /obj/item/weapon/paper(loc)
		P.name = "receipt - cash payment #[transaction_logs.len+1]"
		P.info = receipt_data

		// Confirm and reset
		transaction_complete()

/obj/machinery/cash_register/proc/show_shopping_list()
	for(var/O in item_list)
		src.visible_message("\icon[src] <b>[O]:</b> [price_list[O] ? "[price_list[O]] credit\s" : "free of charge"][tax_list[O] ? "([tax_list[O] * 100]% tax)" : ""].")

/obj/machinery/cash_register/proc/scan_item_price(obj/O)
	if(!istype(O))	return
	if(item_list.len > 10)
		src.visible_message("\icon[src]<span class='warning'>Only up to ten different items allowed per purchase.</span>")
		return
	if (cash_open)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 25)
		usr << "\icon[src]<span class='warning'>The cash box is open.</span>"
		return

	// First check if item has a valid price
	var/price = O.get_item_cost()

	if(0 > price) // no money exploits here
		price = 0

	var/tax

	if(adds_tax)
		tax = O.get_tax()
		price += O.post_tax_cost()
	if(isnull(price))
		src.visible_message("\icon[src]<span class='warning'>Unable to find item in database.</span>")
		return
	// Call out item cost
	src.visible_message("\icon[src]\A [O]: [price ? "[price] credit\s" : "free of charge"][tax ? "([tax * 100]% tax)" : ""].")
	// Note the transaction purpose for later use
	if(transaction_purpose)
		transaction_purpose += "<br>"
	transaction_purpose += "[O]: [price] credit\s"
	transaction_amount += price
	for(var/previously_scanned in item_list)
		if(price == price_list[previously_scanned] && O.name == previously_scanned)
			. = item_list[previously_scanned]++
	if(!.)
		item_list[O.name] = 1
		price_list[O.name] = price
		tax_list[O.name] = tax
		. = 1
	// Animation and sound
	playsound(src, 'sound/effects/checkout.ogg', 25)
	// Reset confirmation
	confirm_item = null
	updateDialog()


/obj/machinery/cash_register/proc/get_current_transaction()
	var/dat = {"
	<head><style>
		.tx-title-r {text-align: center; background-color:BF6275; font-weight: bold}
		.tx-name-r {background-color: #9F4053}
		.tx-data-r {text-align: right; background-color: #BF6275;}
	</head></style>
	<table width=300>
	<tr><td colspan="2" class="tx-title-r">New Entry</td></tr>
	<tr></tr>"}
	var/item_name
	var/tax

	if(adds_tax)
		tax = tax_list[item_name]
	for(var/i=1, i<=item_list.len, i++)
		item_name = item_list[i]
		dat += "<tr><td class=\"tx-name-r\">[item_list[item_name] ? "<a href='?src=\ref[src];choice=subtract;item=\ref[item_name]'>-</a> <a href='?src=\ref[src];choice=set_amount;item=\ref[item_name]'>Set</a> <a href='?src=\ref[src];choice=add;item=\ref[item_name]'>+</a> [item_list[item_name]] x " : ""][item_name][tax ? " ([tax * 100]% tax)" : ""] <a href='?src=\ref[src];choice=clear;item=\ref[item_name]'>Remove</a> <a href='?src=\ref[src];choice=set_price;item=\ref[item_name]'>Set Price</a></td><td class=\"tx-data-r\" width=50>[price_list[item_name] * item_list[item_name]] &thorn</td></tr>"
	dat += "</table><table width=300>"
	dat += "<tr><td class=\"tx-name-r\"><a href='?src=\ref[src];choice=clear'>Clear Entry</a></td><td class=\"tx-name-r\" style='text-align: right'><b>Total Amount: [cash2text( transaction_amount, FALSE, TRUE, TRUE )] &thorn</b></td></tr>"
	dat += "</table></html>"
	return dat


/obj/machinery/cash_register/proc/add_transaction_log(var/c_name, var/p_method, var/t_amount)
	var/dat = {"
	<head><style>
		.tx-title {text-align: center; background-color:#55a358; font-weight: bold}
		.tx-name {background-color: #62629F}
		.tx-data {text-align: right; background-color: #2f7832;}
	</head></style>
	<table width=300>
	<tr><td colspan="2" class="tx-title">Transaction #[transaction_logs.len+1]</td></tr>
	<tr></tr>
	<tr><td class="tx-name">Customer</td><td class="tx-data">[c_name]</td></tr>
	<tr><td class="tx-name">Pay Method</td><td class="tx-data">[p_method]</td></tr>
	<tr><td class="tx-name">Payment Time</td><td class="tx-data">[stationtime2text()]</td></tr>
	</table>
	<table width=300>
	"}
	var/item_name
	var/tax
	if(adds_tax)
		tax = tax_list[item_name]
	for(var/i=1, i<=item_list.len, i++)
		item_name = item_list[i]
		dat += "<tr><td class=\"tx-name\">[item_list[item_name] ? "[item_list[item_name]] x " : ""][item_name][tax ? " ([tax * 100]% tax)" : ""]</td><td class=\"tx-data\" width=50>[price_list[item_name] * item_list[item_name]] &thorn</td></tr>"
	dat += "<tr></tr><tr><td colspan=\"2\" class=\"tx-name\" style='text-align: right'><b>Total Amount: [cash2text( transaction_amount, FALSE, TRUE, TRUE )] &thorn</b></td></tr>"
	dat += "</table></html>"

	transaction_logs += dat

/obj/machinery/cash_register/proc/get_receipt(var/c_name, var/p_method, var/t_amount)
	var/dat = {"
	<head><style>
		.tx-title {text-align: center; background-color:#55a358; font-weight: bold}
		.tx-name {background-color: #bbbbee}
		.tx-data {text-align: right; background-color: #2f7832;}
	</head></style>
	<table width=300>
	<tr><td colspan="2" class="tx-title">Receipt</td></tr>
	<tr></tr>
	<tr><td class="tx-name">Customer</td><td class="tx-data">[c_name]</td></tr>
	<tr><td class="tx-name">Pay Method</td><td class="tx-data">[p_method]</td></tr>
	<tr><td class="tx-name">Payment Time</td><td class="tx-data">[stationtime2text()]</td></tr>
	</table>
	<table width=300>
	"}
	var/item_name
	var/tax
	if(adds_tax)
		tax = tax_list[item_name]
	for(var/i=1, i<=item_list.len, i++)
		item_name = item_list[i]
		dat += "<tr><td class=\"tx-name\">[item_list[item_name] ? "[item_list[item_name]] x " : ""][item_name][tax ? " ([tax * 100]% tax)" : ""]</td><td class=\"tx-data\" width=50>[price_list[item_name] * item_list[item_name]] &thorn</td></tr>"
	dat += "<tr></tr><tr><td colspan=\"2\" class=\"tx-name\" style='text-align: right'><b>Total Amount: [cash2text( transaction_amount, FALSE, TRUE, TRUE )] &thorn</b></td></tr>"
	dat += "</table></html>"

	return dat

/obj/machinery/cash_register/proc/check_account()
	if(!linked_account)
		return

	if (!get_account(linked_account.account_number))
		usr.visible_message("\icon[src]<span class='warning'>Unable to connect to linked account.</span>")
		return 0

	if(check_account_suspension(linked_account.account_number))
		src.visible_message("\icon[src]<span class='warning'>Connected account has been suspended.</span>")
		return 0
	return 1

/obj/machinery/cash_register/proc/transaction_complete()
	if(adds_tax)
		var/total_tax
		for(var/item in tax_list)
			total_tax += tax_list[item] * (item_list[item] * price_list[item])

		SSeconomy.charge_main_department(total_tax, transaction_purpose)

	/// Visible confirmation
	playsound(src, 'sound/machines/chime.ogg', 25)
	src.visible_message("\icon[src]<span class='notice'>Transaction complete.</span>")
	flick("register_approve", src)
	reset_memory()
	updateDialog()


/obj/machinery/cash_register/proc/reset_memory()
	transaction_amount = null
	transaction_purpose = ""
	item_list.Cut()
	price_list.Cut()
	tax_list.Cut()
	confirm_item = null


/obj/machinery/cash_register/verb/open_cash_box()
	set category = "Object"
	set name = "Open Cash Box"
	set desc = "Open/closes the register's cash box."
	set src in view(1)

	if(usr.stat) return

	if(cash_open)
		cash_open = 0
		overlays -= "register_approve"
		overlays -= "register_open"
		overlays -= "register_cash"
	else if(!cash_locked)
		cash_open = 1
		overlays += "register_approve"
		overlays += "register_open"
		if(cash_stored)
			overlays += "register_cash"
	else
		usr << "<span class='warning'>The cash box is locked.</span>"


/obj/machinery/cash_register/proc/toggle_anchors(obj/item/weapon/wrench/W, mob/user)
	if(manipulating) return
	manipulating = 1
	if(!anchored)
		user.visible_message("\The [user] begins securing \the [src] to the floor.",
	                         "You begin securing \the [src] to the floor.")
	else
		user.visible_message("<span class='warning'>\The [user] begins unsecuring \the [src] from the floor.</span>",
	                         "You begin unsecuring \the [src] from the floor.")
	playsound(src, W.usesound, 50, 1)
	if(!do_after(user, 20 * W.toolspeed))
		manipulating = 0
		return
	if(!anchored)
		user.visible_message("<span class='notice'>\The [user] has secured \the [src] to the floor.</span>",
	                         "<span class='notice'>You have secured \the [src] to the floor.</span>")
	else
		user.visible_message("<span class='warning'>\The [user] has unsecured \the [src] from the floor.</span>",
	                         "<span class='notice'>You have unsecured \the [src] from the floor.</span>")
	anchored = !anchored
	manipulating = 0
	return



/obj/machinery/cash_register/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		src.visible_message("<span class='danger'>The [src]'s cash box springs open as [user] swipes the card through the scanner!</span>")
		playsound(src, "sparks", 50, 1)
		req_access = list()
		emagged = 1
		locked = 0
		cash_locked = 0
		open_cash_box()


//--Premades--//

/obj/machinery/cash_register/city
	account_to_connect = DEPT_COLONY
	dont_save = TRUE
	req_access = list(access_president)

/obj/machinery/cash_register/command
	account_to_connect = DEPT_COUNCIL
	dont_save = TRUE
	req_access = list(access_captain)

/obj/machinery/cash_register/medical
	account_to_connect = DEPT_HEALTHCARE
	menu_items = MED
	dont_save = TRUE
	req_access = list(access_cmo)

/obj/machinery/cash_register/engineering
	account_to_connect = DEPT_MAINTENANCE
	dont_save = TRUE
	req_access = list(access_ce)

/obj/machinery/cash_register/science
	account_to_connect = DEPT_RESEARCH
	dont_save = TRUE
	req_access = list(access_rd)

/obj/machinery/cash_register/security
	account_to_connect = DEPT_POLICE
	menu_items = LAW
	dont_save = TRUE
	req_access = list(access_hos)

/obj/machinery/cash_register/cargo
	account_to_connect = DEPT_FACTORY
	dont_save = TRUE
	req_access = list(access_qm)

/obj/machinery/cash_register/civilian
	account_to_connect = DEPT_PUBLIC
	dont_save = TRUE

/obj/machinery/cash_register/bar
	account_to_connect = DEPT_BAR
	dont_save = TRUE

/obj/machinery/cash_register/botany
	account_to_connect = DEPT_BOTANY
	dont_save = TRUE

/obj/machinery/cash_register/court
	account_to_connect = DEPT_LEGAL
	menu_items = COR
	dont_save = TRUE
#undef LAW
#undef MED
#undef COR
