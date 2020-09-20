/obj/item/weapon/redemption_box
	name = "redemption box"
	desc = "A secure electronic box that can hold a large number of items that are released upon swiping your card to paying for the contents, \
	it is powered by bluespace technology and virtually unbreakable."
	w_class = ITEMSIZE_LARGE

	var/recieving_department = DEPT_NANOTRASEN
	var/manufacture_comment = "Purchased from Nanotrasen"

	var/list/starting_contents = list()	// we can put starting contents in this, for customisation.


/obj/item/weapon/redemption_box/get_item_cost()
	var/price = 0
	for(var/obj/I in get_saveable_contents())
		price += I.get_item_cost()
	return price

/obj/item/weapon/redemption_box/proc/unlock_box()
	visible_message("<span class='notice'><b>[src]</b> beeps, \"Unlocking...Now extracting contents.\"</span>")
	playsound(src, 'sound/machines/chime.ogg', 25)
	for(var/obj/O in get_saveable_contents())
		O.forceMove(get_turf(src))

	qdel(src)

/obj/item/weapon/redemption_box/attackby(obj/item/weapon/W as obj, mob/user as mob)

	var/price = get_item_cost()

	if(!price)
		unlock_box()
		return

	var/obj/item/weapon/card/id/I = W.GetID()

	if (!istype(W, /obj/item/weapon/card/id))
		to_chat(user, "<span class='warning'>You need to scan your ID in order to pay for this item.</span>")
		return

	var/datum/money_account/customer_account = get_account(I.associated_account_number)
	if(!customer_account)
		visible_message("<span class='notice'>Error: Unable to access bank account details from this card, please try again.</span>")
		return

	if(customer_account.suspended)
		visible_message("<span class='notice'>Unable to access account: account suspended.</span>")
		return

	// Have the customer punch in the PIN before checking if there's enough money. Prevents people from figuring out acct is
	// empty at high security levels
	if(customer_account.security_level != 0) //If card requires pin authentication (ie seclevel 1 or 2)
		var/attempt_pin = input("Enter pin code", "Vendor transaction") as num
		customer_account = attempt_account_access(I.associated_account_number, attempt_pin, 2)

		if(!customer_account)
			visible_message("Unable to access account: incorrect credentials.")
			return

	if(price > customer_account.money)
		visible_message("Insufficient funds in account.")
		return

	// debit money from the purchaser's account
	charge_to_account(customer_account.account_number, "Redemption Box", "Purchase ([manufacture_comment])", "[src]", -price)

	var/datum/department/department = dept_by_id(recieving_department)

	if(department)
		department.adjust_funds(price, "Redemption Box: Purchase ([manufacture_comment])")

