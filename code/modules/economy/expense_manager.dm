/obj/machinery/expense_manager
	name = "expense manager"
	desc = "Swipe your ID card to set up a pay-in-chunks direct debt for a bank account. Useful if customers cannot pay in full. Put in the client's ID, not your own."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "expense"
	flags = NOBLUDGEON
	req_access = list(access_heads)

	anchored = 1

	var/expense_type = /datum/expense

	var/obj/item/weapon/card/id/stored_id

	var/datum/money_account/current_account

	var/icon_state_active = "expense_1"
	var/icon_state_inactive = "expense"
	var/expense_limit = 500000			// highest expense you can set.
	var/payroll_limit = 15000 // max that can be charged per payroll

	var/business_id = ""
	var/business = FALSE

	var/owner_name = ""
	var/owner_uid = ""
	unique_save_vars = list("business_id", "owner_name", "owner_uid")

	var/current_operator = ""

	dont_save = TRUE
	table_drag = TRUE



/obj/machinery/expense_manager/business
	name = "business expense manager"
	business = TRUE
	req_access = list()
	expense_limit = 800000
	payroll_limit = 8000
	dont_save = FALSE
	circuit = /obj/item/weapon/circuitboard/expense_manager

/obj/machinery/expense_manager/business/examine(mob/user)
	..()
	if(expense_limit)
		to_chat(user, "The expense limit is <b>[expense_limit]CR.</b>")
	var/datum/business/B = get_business_by_biz_uid(business_id)
	if(B)
		to_chat(user, "<b>It is registered to [B.name].</b>")

/obj/machinery/expense_manager/update_icon()
	if(stored_id)
		icon_state = icon_state_active
	else
		icon_state = icon_state_inactive

/obj/machinery/expense_manager/police
	name = "police fine manager"
	expense_type = /datum/expense/police
	expense_limit = 100000
	req_access = list(access_sec_doors)

/obj/machinery/expense_manager/hospital
	name = "hospital bill manager"
	expense_type = /datum/expense/hospital
	expense_limit = 100000
	req_access = list(access_medical)

/obj/machinery/expense_manager/court
	name = "court injunction manager"
	expense_type = /datum/expense/law
	expense_limit = 500000
	req_access = list(access_judge)

/obj/machinery/expense_manager/attackby(obj/item/I, mob/user)

	if(!I)
		return

	if (!istype(I, /obj/item/weapon/card/id) && !stored_id)
		to_chat(user, "\icon[src] <span class='warning'>Error: [src] can only accept identification cards.</span>")
		return

	if(business && !business_id)
		set_new_owner(I, user)
		return

	if(stored_id)
		to_chat(user, "\icon[src] <span class='warning'>Error: [src] already has an ID stored, please sell or eject this ID before continuing.</span>")
		return

	if(insert_id(I, user))
		var/obj/item/weapon/card/id/iden = user.GetIdCard()

		if(!iden || !check_access(iden))
			return

		current_operator = iden.registered_name

		to_chat(user, "You place [I] into [src].")
		playsound(src, 'sound/machines/chime.ogg', 25)
		src.visible_message("\icon[src] \icon[I] <b>[src]</b> chimes, \"<span class='notice'>ID accepted.</span>\"")

		interact(user)
	else
		to_chat(user, "\icon[src] <span class='warning'>Error: Unable to accept ID card, this may be due to incorrect details. Contact an administrator for more information.</span>")

/obj/machinery/expense_manager/proc/set_new_owner(obj/item/O, mob/user)
	if(!istype(O, /obj/item/weapon/card/id))
		return
	var/obj/item/weapon/card/id/I = O
	var/datum/business/B = get_business_by_owner_uid(I.unique_ID)
	if(!B)
		to_chat(usr, "\icon[src]<span class='warning'>No business detected, please register one first.</span>")
		return
	if(!dept_acc_by_id(B.business_uid))
		to_chat(usr, "\icon[src]<span class='warning'>No business bank account detected, please contact an administrator.</span>")
		return
	to_chat(usr, "\icon[src]<span class='notice'>Business set to [B.name].</span>")
	business_id = B.business_uid
	owner_uid = I.unique_ID
	owner_name = I.registered_name

/obj/machinery/expense_manager/proc/insert_id(obj/item/weapon/card/id/I, mob/user)
	current_account = get_account(I.associated_account_number)

	if(!current_account)
		return 0

	stored_id = I
	user.drop_from_inventory(I, src)

	I.forceMove(src)

	update_icon()

	return 1


/obj/machinery/expense_manager/verb/eject_id()
	set name = "Eject ID"
	set category = "Object"
	set desc = "Ejects an item from the machine."
	set src in view(1)

	if(usr.stat)
		to_chat (usr, "<span class='warning'>You can't operate [src] while in this state!</span>")
		return

	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr

		if(stored_id)
			if(!H.get_active_hand())
				H.put_in_hands(stored_id)
			else
				stored_id.forceMove(loc)


			stored_id = null
			current_account = null

			update_icon()
			add_fingerprint(H)
			return 1
		else
			to_chat(usr, "<span class='warning'>There's no cards stored within [src]!</span>")
			return 0


	else
		to_chat(usr, "<span class='warning'>You have trouble operating [src].</span>")
		return 0



/obj/machinery/expense_manager/attack_hand(mob/user)
	add_fingerprint(usr)


	if(istype(user, /mob/living/silicon))
		to_chat(user, "\icon[src] <span class='warning'>A firewall prevents you from interfacing with this device!</span>")
		return

	if(!stored_id)
		to_chat(user, "\icon[src] <span class='warning'>Error: There is no identification card in this device, please insert an ID.</span>")
		return

	var/obj/item/weapon/card/id/iden = user.GetIdCard()

	if(!check_access(iden))
		to_chat(user, "\icon[src] <span class='warning'>Error: You do not have access to this terminal.</span>")
		return

	if(!iden || !iden.registered_name || !iden.unique_ID)
		to_chat(user, "\icon[src] <span class='warning'>Error: You need a valid ID card to use this terminal.</span>")
		return

	interact(user)
	updateDialog()

/obj/machinery/expense_manager/interact(mob/user)

	var/dat = "<h1>[src]</h1><hr>"

	dat += "This machine allows you to edit expenses on any active ID card. Please note that it is considered fraud to remove \
	expenses from one's own account, or to illegitimately add or remove expenses outside of official protocol. Prosecution \
	may result from abuse of this machine.<hr>"

	if(get_dist(src,user) <= 1)
		if(!current_account) // Shouldn't happen, but you know.
			dat += "<b>No account found.</b>"

		else

			dat += "<b>Name:</b> [current_account.owner_name]<br>"
			dat += "<b>Account No:</b> [current_account.account_number]<br>"
			dat += "<b>Current Funds:</b> [current_account.money] credits.<br><br>"

			dat += "<a href='?src=\ref[src];choice=add_new_expense'>Add New Expense</a> "
			dat += "<a href='?src=\ref[src];choice=remove_all_expenses'>Remove All Expenses</a>"
			dat += "<a href='?src=\ref[src];choice=refresh'>Refresh</a>"
			dat += "<a href='?src=\ref[src];choice=eject_id'>Eject ID</a> <br>"

			//get expenses
			var/list/datum/expense/expense_list = list()

			for(var/datum/expense/E in current_account.expenses)
				if(business && (E.department != business_id))
					continue
				if (istype(E, expense_type))
					expense_list += E

			//show expenses
			dat += "<br><h2>Debts:</h2><hr>"

			if(LAZYLEN(expense_list))
				for(var/datum/expense/E in expense_list)

					dat += "<fieldset style='border: 2px solid [E.color]; display: inline'>"

					dat += "Debt: <b>[E.purpose] - ([E.name])</b> ([E.initial_cost] credits)."
					dat += "<br>Charge Per Payroll: [E.cost_per_payroll] credits."
					dat += "<br>Current Debt Left: [E.amount_left] credits."
					dat += "<br>Added By: [E.added_by]"
					dat += "<br>Creation Date: [E.creation_date]"
					var/dept_name = dept_name_by_id(E.department)
					if(dept_name)
						dat += "<br>Department: [dept_name]"

					dat += "<br>Status: [E.active ? "Active" : "Inactive"]<br><br>"



					dat += "<br>Comments: <i>[E.comments]</i><br>"

					dat += "<a href='?src=\ref[src];choice=edit_expense;expense=\ref[E]''>Edit Expense</a> "
					dat += "<a href='?src=\ref[src];choice=remove_expense;expense=\ref[E]''>Remove Expense</a> "
					dat += "<a href='?src=\ref[src];choice=toggle_expense;expense=\ref[E]'>Toggle Expense</a> "
					dat += "<a href='?src=\ref[src];choice=adjust_payroll;expense=\ref[E]'>Adjust Per-Payroll</a> "
					dat += "</fieldset>"

					dat += "<br>"

			else
				dat += "No expenses found on this account for this department."

		var/datum/browser/popup = new(user, "expense_machine", "[src]", 550, 650, src)
		popup.set_content(jointext(dat,null))
		popup.open()

		onclose(user, "expense_machine")

/obj/machinery/expense_manager/proc/add_new_expense(mob/user)

	var/expense_purpose = sanitize(input("Enter the purpose of this expense.", "Expense Purpose") as text)
	if(!expense_purpose) return

	var/expense_amount = round(input("Enter amount", "New amount") as num)
	expense_amount = Clamp(expense_amount, 0, expense_limit)

	if(!expense_amount) return

	var/expense_commments = sanitize_text(input(usr, "Enter any comments regarding this expense.", "Expense Comments")  as message,1,100)
	if(!expense_commments) return


	var/datum/expense/new_expense = create_expense(expense_type, expense_purpose, expense_commments, expense_amount, user.name, user.ckey)
	if(!new_expense) return

	if(business && business_id)
		var/datum/business/B = get_business_by_biz_uid(business_id)
		if(B)
			new_expense.department = B.business_uid

	current_account.expenses += new_expense

	var/datum/money_account/M = dept_acc_by_id(new_expense.department)
	if(M)
		M.add_transaction_log("[new_expense.name]: New Expense", "Expense registered to [current_account.owner_name]'s account authorised by [current_operator] (Charged Account ID: [current_account.account_number]). | Amount: [expense_amount]CR | Purpose: [expense_purpose]", 0)
		current_account.add_transaction_log("[new_expense.name]: New Expense", "Received new expense from [M.owner_name] authorised by [current_operator] (Charging Account ID: [M.account_number]). | Amount: [expense_amount]CR | Purpose: [expense_purpose]", 0)
		log_money(user, "added expense to [current_account.owner_name]: [new_expense.name]. (Charging Account ID: [M.account_number]). | Amount: [expense_amount]CR | Purpose: [expense_purpose]", current_account.account_number, current_account.owner_name, expense_amount)


/obj/machinery/expense_manager/proc/remove_expense(mob/user, var/datum/expense/E)
	if(!E)
		return

	var/choice = alert(user,"Would you like to remove this expense?","Remove Expense","No","Yes")
	if(choice == "Yes")
		current_account.expenses -= E

		var/datum/money_account/M = dept_acc_by_id(E.department)
		if(M)
			M.add_transaction_log("[E.name]: Removed Expense", "Expense removed from [current_account.owner_name]'s account authorised by [current_operator]", 0)
			current_account.add_transaction_log("[E.name]: Removed Expense", "Expense removed: [M.owner_name] authorised by [current_operator] (Charging Account ID: [M.account_number])", 0)
			log_money(user, "[E.name]: Removed expense from [current_account.owner_name]: [E.name]. (Charging Account ID: [M.account_number]), current_account.account_number, current_account.owner_name", 0)
		qdel(E)


		return TRUE

	return FALSE

/obj/machinery/expense_manager/proc/suspend_expense(mob/user, var/datum/expense/E)
	if(!E)
		return

	var/choice = alert(user,"[E.active ? "Suspend" : "Un-suspend"] this expense?","Suspend Expense","Yes","No")
	if(choice == "Yes")
		E.active = !E.active

		var/datum/money_account/M = dept_acc_by_id(E.department)
		if(M)
			M.add_transaction_log("[E.name]: [E.active ? "un" : ""]suspended Expense", "Expense [E.active ? "un" : ""]suspended from [current_account.owner_name]'s account authorised by [current_operator] (Charged Account ID: [current_account.account_number]).", 0)
			current_account.add_transaction_log("[E.name]: [E.active ? "un" : ""]suspended Expense", "Expense [E.active ? "un" : ""]suspended: Expense from [M.owner_name], authorised by [current_operator] (Charging Account ID: [M.account_number]).", 0)
			log_money(user, "suspended expense to [current_account.owner_name]: [E.name]. ", current_account.account_number, current_account.owner_name, 0)

		return


	return FALSE

/obj/machinery/expense_manager/proc/edit_expense(mob/user, var/datum/expense/E)
	if(!E)
		return

	var/expense_purpose = sanitize_text(input(usr, "Enter the purpose of this expense.", "Expense Purpose", E.name)  as text,1,25)
	if(!expense_purpose) return

	var/expense_amount = sanitize_integer(input(usr, "Enter expense amount (in credits).", "Expense Amount", E.amount_left)  as num|null, 1, 10000)
	if(!expense_amount) return

	var/expense_commments = sanitize_text(input(usr, "Enter any comments regarding this expense.", "Expense Comments", E.comments)  as message,1,100)
	if(!expense_commments) return

	E.purpose = expense_purpose
	E.comments = expense_commments
	E.amount_left = expense_amount

	if(!(user.ckey in E.ckey_edit_list))
		E.ckey_edit_list += user.ckey

	E.cost_per_payroll = Clamp(E.cost_per_payroll, 0, E.amount_left)

	var/datum/money_account/M = dept_acc_by_id(E.department)
	if(M)
		M.add_transaction_log("[E.name]: Edited Expense", "Edited Expense on [current_account.owner_name]'s account authorised by [current_operator] (Charged Account ID: [current_account.account_number]). | Amount: [expense_amount]CR | Purpose: [expense_purpose]", 0)
		current_account.add_transaction_log("[E.name]: Suspended Expense", "Expense edited: Expense from [M.owner_name] edited, authorised by [current_operator] (Charging Account ID: [M.account_number]) | Amount: [expense_amount]CR | Purpose: [expense_purpose]", 0)
		log_money(user, "edited expense to [current_account.owner_name]: [E.name]. | Amount: [expense_amount]CR | Purpose: [expense_purpose] | Comments: [expense_commments]", current_account.account_number, current_account.owner_name, 0)


/obj/machinery/expense_manager/proc/remove_all_expenses(mob/user)

	if(!current_account)
		return
	else
		var/choice = alert(user,"Delete all expenses from account? This cannot be undone!","Delete Expense","No","Yes")
		if(choice == "Yes")
			for(var/datum/expense/E in current_account.expenses)
				if(business && (E.department != business_id))
					continue
				if (istype(E, expense_type))
					current_account.expenses -= E

			var/datum/money_account/M = dept_acc_by_id(business_id)
			if(M)
				M.add_transaction_log("Expense Removal", "All expenses removed for [current_account.owner_name]'s account authorised by [current_operator] (Charged Account ID: [current_account.account_number]).", 0)
				current_account.add_transaction_log("Expense Removal", "All expense removed: All expenses from [M.owner_name] removed, authorised by [current_operator] (Charging Account ID: [M.account_number]).", 0)
				log_money(user, "all expenses removed from [current_account.owner_name]. ", current_account.account_number, current_account.owner_name, 0)

		else if(choice == "No")
			return

/obj/machinery/expense_manager/Topic(var/href, var/href_list)
	if(..())
		return 1

	var/obj/item/weapon/card/id/iden = usr.GetIdCard()

	if(!check_access(iden))
		return

	current_operator = iden.registered_name

	if(href_list["choice"])
		switch(href_list["choice"])

			if("add_new_expense")
				add_new_expense(usr)

			if("remove_expense")
				var/E = locate(href_list["expense"])
				remove_expense(usr, E)

			if("toggle_expense")
				var/E = locate(href_list["expense"])
				suspend_expense(usr, E)

			if("adjust_payroll")
				var/E = locate(href_list["expense"])
				if(!E) return
				var/datum/expense/exp = E
				var/payroll_amt = sanitize_integer(input(usr, "Enter expense amount per hour (in credits). Max: [payroll_limit]", "Expense Amount", exp.cost_per_payroll)  as num|null, 1, 1000)
				if(!payroll_amt || (payroll_amt > payroll_limit))
					to_chat(usr, "Please enter a valid amount!")
					return

				if(payroll_amt > exp.amount_left)
					payroll_amt = exp.amount_left

				var/datum/money_account/M = dept_acc_by_id(exp.department)
				if(M)
					M.add_transaction_log("[exp.name]: Expense Adjustment", "Expense payroll rate adjustment to [payroll_amt]CR [current_account.owner_name]'s account authorised by [current_operator]", 0)
					current_account.add_transaction_log("[exp.name]: Adjusted Expense", "Expense payroll adjusted to [payroll_amt]CR: [M.owner_name] authorised by [current_operator] (Charging Account ID: [M.account_number])", 0)
					log_money(usr, "[exp.name]: Changed payroll rate of [current_account.owner_name] to [payroll_amt]CR: [exp.name]. (Charging Account ID: [M.account_number]), current_account.account_number, current_account.owner_name", 0)


				exp.cost_per_payroll = payroll_amt

			if("edit_expense")
				var/E = locate(href_list["expense"])
				edit_expense(usr, E)

			if("remove_all_expenses")
				remove_all_expenses(usr)

			if("refresh")
				updateDialog()

			if("eject_id")
				eject_id(usr)

	updateDialog()
