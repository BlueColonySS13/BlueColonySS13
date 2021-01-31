/obj/item/weapon/card/department
	name = "budget card"
	desc = "This card allows you to spend from a certain department. There is a limit on what you can buy, however."

	icon_state = "budgetcard"
	dont_save = TRUE

	var/department = DEPT_COLONY
	var/spending_limit = 300

	var/owner_name = ""

	var/card_uid = ""

/obj/item/weapon/card/department/examine(mob/user)
	..()
	var/datum/department/D = get_department()
	if(D)
		to_chat(user, "This is a [name] for spending. It has [cash2text( spending_limit, FALSE, TRUE, TRUE )] left.")

		if(owner_name && D.dept_type != HIDDEN_DEPARTMENT)
			to_chat(user, "It belongs to <b>[owner_name]</b>.")


/obj/item/weapon/card/department/New()
	..()

	var/datum/department/D = get_department()
	update_icon()
	update_name()

	var/dept_spending_limit = D.card_spending_limit
	var/portal_value = SSpersistent_options.get_persistent_option_value(D.portal_card_id)

	if(!isnull(portal_value))
		spending_limit = portal_value
	else
		spending_limit = dept_spending_limit

	GLOB.department_cards += src

	if(!card_uid)
		card_uid = "[game_id]_[D.id]_[rand(2,1000)]"

/obj/item/weapon/card/department/on_persistence_load()
	update_icon()

/obj/item/weapon/card/department/update_icon()
	overlays.Cut()

	if(department)
		var/datum/department/D = get_department()
		var/image/I =  image(icon, "[initial(icon_state)]_overlay")
		I.color = D.dept_color
		overlays |= I

/obj/item/weapon/card/department/proc/update_name()
	var/datum/department/D = get_department()

	if(owner_name)
		name = "[owner_name]'s [D.name] [initial(name)]"

	if(D.dept_type == HIDDEN_DEPARTMENT)
		name = "[D.name] [initial(name)]"



/obj/item/weapon/card/department/proc/can_spend(num, type)
	// returns null if there's no department or department bank account. returns -1 if dept suspended. returns -2 if wrong type.
	// returns FALSE if not enough money.
	// returns TRUE if there's enough money.
	var/datum/department/D = get_department()

	if(!D || !D.get_account())
		return null

	if(D.bank_account.suspended)
		return -1

	if(type)
		if(!isemptylist(D.allowed_buy_types) && !(type in D.allowed_buy_types))
			return -2

	var/department_money = D.get_balance()

	if(num > department_money)
		return FALSE

	return TRUE

/obj/item/weapon/card/department/proc/spend_account(num, purpose)
	var/datum/department/D = get_department()
	if(!D)
		return null

	var/datum/money_account/department/M = D.get_account()

	if(!M)
		return null

	adjust_dept_funds(D.id, num, purpose)
	return TRUE

/obj/item/weapon/card/department/proc/get_department()
	return dept_by_id(department)


/obj/item/weapon/card/department/proc/get_bank_id()
	var/datum/department/D = get_department()
	return D.get_bank_id()

/proc/get_deptcard_by_id(id)
	for(var/obj/item/weapon/card/department/DC in GLOB.department_cards)
		if(DC.card_uid == id)
			return DC

// Departments
/obj/item/weapon/card/department/colony
	department = DEPT_COLONY

/obj/item/weapon/card/department/council
	department = DEPT_COUNCIL

/obj/item/weapon/card/department/law
	department = DEPT_LEGAL

/obj/item/weapon/card/department/maintenance
	department = DEPT_MAINTENANCE

/obj/item/weapon/card/department/research
	department = DEPT_RESEARCH

/obj/item/weapon/card/department/police
	department = DEPT_POLICE

/obj/item/weapon/card/department/healthcare
	department = DEPT_HEALTHCARE

/obj/item/weapon/card/department/public
	department = DEPT_PUBLIC

/obj/item/weapon/card/department/factory
	department = DEPT_FACTORY

/obj/item/weapon/card/department/solgov
	department = DEPT_SOLGOV

/obj/item/weapon/card/department/nanotrasen
	department = DEPT_NANOTRASEN

// Factions

/obj/item/weapon/card/department/workersunion
	department = DEPT_WORKERSUNION

/obj/item/weapon/card/department/bluemooncartel
	department = DEPT_BLUEMOONCARTEL

/obj/item/weapon/card/department/trustfund
	department = DEPT_TRUSTFUND

/obj/item/weapon/card/department/quercuscoalition
	department = DEPT_QUERCUSCOALITION

/obj/item/weapon/card/department/houseofjoshua
	department = DEPT_HOUSEOFJOSHUA