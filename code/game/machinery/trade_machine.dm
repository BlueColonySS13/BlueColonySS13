// This essentially acts as the reverse of the display case, where the owner is someone looking to buy specific items.

/obj/machinery/trade_machine
	name = "auto-commerce machine"
	desc = "A machine that facilitates commerce between two parties, without the need for \
    both parties to be present at the same time. \
	In other words, it's a reverse vending machine, where you put items the owner wants inside, and it pays the business you work for."

	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "auto_commerce"
	unacidable = TRUE
	density = TRUE
	anchored = TRUE

	circuit = /obj/item/weapon/circuitboard/trade_machine

	unique_save_vars = list("anchored", "maint_mode", "owner_uid", "staff_pin", "business_bank_id")

	var/list/trade_offers = list() // List of datums for what the machine is offering to buy.
	var/max_offers = 5 // How many trade offers can exist at one time per machine.
	var/list/purchased_goods = list() // List of objects this machine bought, waiting to be collected by the owner.
	var/maint_mode = FALSE // If true, settings can be changed and stuff can be taken out.
	var/owner_uid = null // UID of the actual owner.
	var/business_bank_id = null // Account ID that the machine will use to pay for items people sell it.
	var/staff_pin = 0 // Pin used to access maint_mode by other people besides the original owner.
	var/datum/ingame_authentication/auth = null // Datum that handles authenticating to access maint mode.

/obj/machinery/trade_machine/initialize(mapload)
	if(!staff_pin)
		staff_pin = rand(1111, 9999)
	return ..()

/obj/machinery/trade_machine/Destroy()
	QDEL_NULL(auth)
	trade_offers.Cut()
	for(var/thing in purchased_goods)
		var/atom/movable/AM = thing
		AM.forceMove(get_turf(src))
	return ..()

/obj/machinery/trade_machine/get_saveable_contents()
	return purchased_goods

/obj/machinery/trade_machine/on_persistence_load()
	purchased_goods = contents

/obj/machinery/trade_machine/get_persistent_metadata()
	return trade_offers

/obj/machinery/trade_machine/load_persistent_metadata(datums)
	trade_offers = datums

/obj/machinery/trade_machine/attack_hand(mob/living/user)
	..()
	if(stat & (BROKEN|NOPOWER))
		return

	interact(user)

/obj/machinery/trade_machine/attackby(obj/item/I, mob/living/user)
	if(!istype(I))
		return

	if(istype(I, /obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/ID = I
		if(!owner_uid)
			var/datum/business/B = get_business_by_owner_uid(ID.unique_ID)
			var/datum/department/D = dept_by_id(B?.business_uid)
			if(!D || !D.bank_account)
				to_chat(user, span("warning", "No business associated with you was found. Please register one and try again."))
				return

			owner_uid = ID.unique_ID
			business_bank_id = D.bank_account.account_number
			to_chat(user, span("notice", "You claim \the [src] as your own."))
			interact(user)
		// Return here to avoid people setting up deals for ID cards or something.
		return


	// Adding a new offer.
	if(maint_mode)
		if(add_offer(I, user))
			playsound(src, 'sound/machines/chime.ogg', 25, TRUE)
		else
			playsound(src, 'sound/machines/buzz-sigh.ogg', 25, TRUE)
		return

	// Trying to sell an item to the owner.
	var/sold = FALSE
	for(var/thing in trade_offers)
		var/datum/trade_offer/offer = thing
		if(!trade_offer_eligable(offer))
			continue
		if(!offer.check_item(I))
			continue
		if(sell_to_machine(I, offer, user))
			sold = TRUE
			break

	if(!sold)
		to_chat(user, span("warning", "\The [src] doesn't have any valid offers for \the [I]."))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 25, TRUE)
	else
		playsound(src, 'sound/machines/chime.ogg', 25, TRUE)

// Called when hitting the machine with something while in maint mode.
/obj/machinery/trade_machine/proc/add_offer(obj/item/I, mob/user)
	if(LAZYLEN(trade_offers) >= max_offers)
		to_chat(user, span("warning", "\The [src] has reached it's maximum capacity for trading offers, which is [max_offers]. Remove one and try again."))
		return FALSE

	for(var/thing in trade_offers)
		var/datum/trade_offer/offer = thing
		if(offer.check_item(I))
			to_chat(user, span("warning", "\The [src] already has a deal for [offer.display_name()]."))
			return FALSE

	var/type_to_use = /datum/trade_offer
	if(istype(I, /obj/item/stack))
		type_to_use = /datum/trade_offer/stack
	else if(istype(I, /obj/item/weapon/reagent_containers))
		var/list/exclude_reagent_containers = list(/obj/item/weapon/reagent_containers/food)
		if(!is_type_in_list(exclude_reagent_containers))
			type_to_use = /datum/trade_offer/reagent

	var/datum/trade_offer/offer = new type_to_use()
	if(!offer.scan_prototype(I))
		to_chat(user, span("warning", "\The [src] failed to scan \the [I]."))
		qdel(offer)
		return FALSE

	trade_offers += offer
	to_chat(user, span("notice", "\The [src] scans \the [I], and can now buy more of those on your behalf. \
		You should adjust the quantity and price before leaving."))
	interact(user)
	return TRUE

// Return TRUE if the item got sold and nothing went wrong, FALSE otherwise.
/obj/machinery/trade_machine/proc/sell_to_machine(obj/item/I, datum/trade_offer/offer, mob/living/user)
	// Check that the user isn't trying to sell nonpersistant stuff.
	if(I.dont_save)
		to_chat(user, span("warning", "\The [src] detects that \the [I] belongs to someone, and thus refuses to buy it from you."))
		return FALSE

	// Check that the owner can afford to buy, to maintain the laws of econo-dynamics and not make money from thin air.
	var/quantity_to_sell = offer.check_item_quantity(I)
	quantity_to_sell = min(quantity_to_sell, offer.quantity_wanted) // Don't sell more than they want.

	// In the future, maybe there can be code in the trade offer datum to automatically split stacks or reagents somehow.
	// For now let's be lazy and make the player do it.
	if(quantity_to_sell != offer.check_item_quantity(I))
		to_chat(user, span("warning", "\The [src] doesn't want [offer.check_item_quantity(I)] of \the [I], but only [quantity_to_sell]. \
		Please try again with a smaller amount."))
	var/value_to_transfer = offer.payment_offered * quantity_to_sell

	if(quantity_to_sell <= 0)
		to_chat(user, span("warning", "\The [src] doesn't want any more of \the [I]."))
		return FALSE

	if(!check_account_exists(business_bank_id))
		to_chat(user, span("warning", "No bank account appears to be associated with \the [src], and thus it cannot pay you."))
		return FALSE

	if(check_account_suspension(business_bank_id))
		to_chat(user, span("warning", "The bank account associated with \the [src] appears to be suspended, and thus it cannot pay you."))
		return FALSE

	var/datum/money_account/owner_account = get_account(business_bank_id)
	if(owner_account.money < value_to_transfer)
		to_chat(user, span("warning", "The bank account associated with \the [src] does not have sufficient funds to cover this transaction, \
		and thus it cannot pay you."))
		return FALSE


	// Check that the user can receive the money.
	var/obj/item/weapon/card/id/ID = user.GetIdCard()

	if(!ID)
		to_chat(user, span("warning", "Please wear a valid citizen ID card that is linked to your bank details."))
		return FALSE

	// Determine if the money should go to the player's personal account or their department/business's account, if one exists.
	var/department_transaction = FALSE
	var/target_account_number = null
	if(ID.rank)
		var/datum/job/J = SSjobs.GetJob(ID.rank)
		var/datum/department/D = dept_by_id(J?.department)
		if(D && D.dept_type != PUBLIC_DEPARTMENT) // Ignore public departments. Only private business employees will have sales go to the business account.
			var/datum/money_account/department/department_account = D.bank_account
			target_account_number = department_account.account_number
			department_transaction = TRUE

	if(!target_account_number) // If we didn't find a business/dept acc number let's try for personal accounts instead.
		if(!ID.associated_account_number)
			to_chat(user, span("warning", "Your ID does not appear to have any bank details."))
			return FALSE
		target_account_number = ID.associated_account_number

	if(!check_account_exists(target_account_number))
		to_chat(user, span("warning", "Account '[target_account_number]' does not appear to exist."))
		return FALSE

	if(check_account_suspension(target_account_number))
		to_chat(user, span("warning", "Account '[target_account_number]' appears to be suspended."))
		return FALSE

	// Move item to the machine.
	user.drop_from_inventory(I)
	I.forceMove(src)
	purchased_goods += I
	offer.quantity_wanted -= quantity_to_sell
	visible_message(span("notice", "\The [user] places \the [I] into \the [src]."))
	playsound(src, 'sound/machines/chime.ogg', 25)

	// Take money out of the owner's account.
	charge_to_account(
		attempt_account_number = business_bank_id,
		source_name = name,
		purpose = "Bought [quantity_to_sell] [I.name] from \the [user].",
		terminal_id = "[src]",
		amount = -value_to_transfer
	)

	// Pay the user.
	var/tax_owed = I.post_tax_cost()
	var/value_to_user = value_to_transfer - tax_owed
	if(value_to_user)
		charge_to_account(
			attempt_account_number = target_account_number,
			source_name = name,
			purpose = "Sold [quantity_to_sell] [I.name] (taxed [tax_owed] credit\s)",
			terminal_id = "[src]",
			amount = value_to_user
		)

	// Pay the government.
	if(tax_owed)
		SSeconomy.charge_main_department(
			amount = tax_owed,
			purpose = "[src] Tax Transfer: [I.name] ([tax_owed])"
		)

	// Tell the user everything went well.
	to_chat(user, span("notice", "You have sold \the [I] to \the [src]."))
	to_chat(user, span("notice", "Payment offered was <b>[value_to_transfer]</b>CR."))
	if(tax_owed)
		to_chat(user, span("notice", "This transaction was subject to a tax of <b>[tax_owed]</b>CR by the government."))
	to_chat(user, span("notice", "<b>[value_to_user]</b>CR has been deposited into \
	[department_transaction ? "the departmental" : "your personal"] bank account electronically."))
	return TRUE

/obj/machinery/trade_machine/proc/trade_offer_eligable(datum/trade_offer/offer)
	return offer.wanted && offer.quantity_wanted > 0

// Resets everything.
/obj/machinery/trade_machine/proc/factory_reset()
	trade_offers.Cut() // The datums should get GC'd.
	for(var/thing in purchased_goods)
		var/atom/movable/AM = thing
		AM.forceMove(get_turf(src))
		purchased_goods -= AM
	owner_uid = null
	staff_pin = null
	business_bank_id = null
	maint_mode = FALSE

/obj/machinery/trade_machine/interact(mob/living/user)
	var/list/html = build_window(user)

	var/datum/browser/popup = new(user, "trade_machine", "[src]", 680, 480, src)
	popup.set_content(html.Join())
	popup.open()

	onclose(user, "trade_machine")

/obj/machinery/trade_machine/proc/build_window(mob/living/user)
	. = list()
	. += "Welcome. This machine allows you to sell specific goods to the owner of this machine.<br>"
	if(!owner_uid)
		. += "<b>To claim this machine, please swipe your ID.</b>"
		return
	. += "<br>"

	. += build_trade_offer_table()

	if(maint_mode)
		. += "<hr>"
		. += "<b>Purchased items<b><br>"
		var/i = 1
		for(var/thing in purchased_goods)
			var/atom/movable/AM =  thing
			. += href(src, list("withdraw_item" = 1, "index" = i), AM.name)
			. += "<br>"
			i++

	. += "<hr>"
	if(maint_mode)
		. += "<b>MAINTENANCE MODE ACTIVE</b><br>"
	. += href(src, list("toggle_maint_mode" = 1), "Toggle Maintenance Mode")
	if(maint_mode)
		. += "<br>"
		. += href(src, list("toggle_anchored" = 1), "Toggle Floor Bolts")
		. += href(src, list("set_staff_pin" = 1), "Change Staff PIN")
		. += href(src, list("factory_reset" = 1), "Factory Reset")

/obj/machinery/trade_machine/proc/build_trade_offer_table()
	if(!LAZYLEN(trade_offers))
		if(maint_mode)
			. += "<i>To get started, scan some items you want this machine to buy.</i>"
		else
			. += "<i>Unfortunately, nothing is currently in demand by the owner. Check back again later.</i>"
		return

	. += "Below is a list of goods that the owner is willing to buy from you.<br>"
	. += "<i>Payments offered may be subject to tax, and are not included in the displayed amount.</i><br>"
	. += "<i>Liquid containers must contain only one liquid to be accepted.</i>"

	. += "<center>"
	. += "<table border='0' style='width:90%'>"
	. += "<tr>"
	. += "<th>Wanted Item</th>"
	. += "<th>Quantity Demanded</th>"
	. += "<th>Payment Offered</th>"
	if(maint_mode)
		. += "<th>Actions</th>"
	. += "</tr>"

	var/i = 1
	for(var/thing in trade_offers)
		var/datum/trade_offer/offer = thing
		. += "<tr>"
		. += trade_offer_eligable(offer) ? "<td>[offer.display_name()]</td>" : "<td><s>[offer.display_name()]</s></td>"
		if(maint_mode)
			. += "<td>[href(src, list("set_quantity" = 1, "index" = i), offer.display_quantity_offer())]</td>"
			. += "<td>[href(src, list("set_payment" = 1, "index" = i), offer.display_payment_offer())]</td>"
		else
			. += "<td>[offer.display_quantity_offer()]</td>"
			. += "<td>[offer.display_payment_offer()]</td>"

		if(maint_mode)
			. += "<td>"
			. += href(src, list("toggle_purchase" = 1, "index" = i), "Toggle Purchasing")
			. += href(src, list("remove_offer" = 1, "index" = i), "Remove Offer")
			. += "</td>"
		. += "</tr>"
		i++

	. += "</table>"
	. += "</center>"


/obj/machinery/trade_machine/Topic(var/href, var/href_list)
	if(..())
		return 1

	if(href_list["toggle_maint_mode"])
		if(maint_mode)
			maint_mode = FALSE
			interact(usr)
			return

		if(!auth) // Only make the datum if needed, to save on (a very tiny amount of) memory.
			auth = new /datum/ingame_authentication(owner_uid, staff_pin)
		if(auth.attempt_authentication(usr, src))
			maint_mode = TRUE
		interact(usr)
		return

	// Maint mode restricted actions.
	// href hackers go away.
	if(!maint_mode)
		to_chat(usr, span("warning", "Maintenance mode has to be active to do that."))
		interact(usr)
		return

	var/index = text2num(href_list["index"])
	if(href_list["toggle_anchored"])
		anchored = !anchored
		playsound(src, 'sound/items/drill_use.ogg', 25)

		if(anchored)
			to_chat(usr, span("notice", "The anchors tether themselves back into the floor. It is now secured."))
		else
			to_chat(usr, span("notice", "You toggle the anchors of \the [src]. It can now be moved."))

	if(href_list["set_staff_pin"])
		if(!auth)
			auth = new /datum/ingame_authentication(owner_uid, staff_pin)
		var/new_pin = input(usr, "Write the new PIN here (1111-9999).", "New PIN", staff_pin) as null|num
		var/validated_pin = auth.validate_pin_change(usr, new_pin)
		if(!isnull(validated_pin))
			staff_pin = auth.staff_pin // So it gets saved.

	if(href_list["remove_offer"])
		var/datum/trade_offer/offer = trade_offers[index]
		trade_offers -= offer
		to_chat(usr, span("notice", "Removed trade offer for [offer.display_name()]."))
		qdel(offer)

	if(href_list["set_quantity"])
		var/datum/trade_offer/offer = trade_offers[index]

		var/new_value = input(usr, "Input new quantity here. The current setting is [offer.quantity_wanted].", "New Quantity", offer.quantity_wanted) as null|num
		if(!isnull(new_value))
			if(new_value <= 0)
				to_chat(usr, span("warning", "Please use positive numbers only."))
				return

			offer.quantity_wanted = new_value

	if(href_list["set_payment"])
		var/datum/trade_offer/offer = trade_offers[index]

		var/new_value = input(usr, "Input new payment offer here. The current setting is [offer.payment_offered].", "New Payment Offer", offer.payment_offered) as null|num
		if(!isnull(new_value))
			if(new_value <= 0)
				to_chat(usr, span("warning", "Please use positive numbers only."))
				return

			offer.payment_offered = new_value

	if(href_list["toggle_purchase"])
		var/datum/trade_offer/offer = trade_offers[index]

		offer.wanted = !offer.wanted
		to_chat(usr, span("notice", "\The [src] will [offer.wanted ? "now" : "no longer"] buy [offer.display_name()]."))

	if(href_list["withdraw_item"])
		var/atom/movable/AM = LAZYACCESS(purchased_goods, index)
		if(AM)
			AM.forceMove(get_turf(src))
			to_chat(usr, span("notice", "You withdraw \the [AM] from \the [src]'s storage."))

	if(href_list["factory_reset"])
		if(alert(usr, "Really reset everything?", "Factory Reset Confirmation", "No", "Yes") == "No")
			return
		factory_reset()
		to_chat(usr, span("notice", "All settings on \the [src] have been reset."))

	interact(usr) // To refresh the UI.
