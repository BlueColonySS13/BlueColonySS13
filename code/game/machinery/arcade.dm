/obj/machinery/food_machine
	name = "food machine"
	icon = 'icons/obj/arcade.dmi'
	icon_state = "popcorn"

	var/price_per_vend = 5
	var/accepted_produce = "corn"

	var/needs_dry = TRUE

	var/max_product = 10
	var/product_left = 0

	var/product_item = /obj/item/weapon/reagent_containers/food/snacks/popcorn
	var/product_desc = "popcorn"
	var/process_sound = 'sound/machines/vending_drop.ogg'

	var/owner_name
	var/owner_uid
	var/bank_id

	density = TRUE
	anchored = TRUE

	unique_save_vars = list("anchored", "owner_name", "owner_uid", "bank_id", "price_per_vend", "product_left")

/obj/machinery/food_machine/New()
	..()
	update_icon()

/obj/machinery/food_machine/on_persistence_load()
	update_icon()

/obj/machinery/food_machine/popcorn
	name = "popcorn machine"
	desc = "A popcorn machine that dispenses popcorn to the masses. Uses dried corn to refill."
	icon_state = "popcorn"

	accepted_produce = "corn"
	needs_dry = TRUE

	product_desc = "fresh hot popcorn"
	product_item = /obj/item/weapon/reagent_containers/food/snacks/popcorn
	circuit = /obj/item/weapon/circuitboard/popcorn_machine

/obj/machinery/food_machine/examine(mob/user)
	..()
	if(owner_name)
		to_chat(user, "[name] belongs to <b>[owner_name]</b>, report any issues with the machine to the owner.")
	if(product_left)
		to_chat(user, "There's <i>[product_desc]</i> inside. There are [product_left] servings left.")
	else
		to_chat(user, "[name] is empty...")


/obj/machinery/food_machine/update_icon()
	icon_state = "[initial(icon_state)]_empty"

	switch(product_left)
		if(6 to INFINITY)
			icon_state = "[initial(icon_state)]_3"
		if(4 to 6)
			icon_state = "[initial(icon_state)]_2"
		if(1 to 3)
			icon_state = "[initial(icon_state)]_1"
		if(0)
			icon_state = "[initial(icon_state)]_empty"

/obj/machinery/food_machine/attack_hand(mob/user as mob)
	add_fingerprint(usr)


	if(istype(user, /mob/living/silicon))
		to_chat (user, "<span class='warning'>A firewall prevents you from interfacing with this device!</span>")
		return

	interact(user)
	updateDialog()



/obj/machinery/food_machine/interact(mob/user as mob)
	var/dat

	dat = get_vend_data(user)

	var/datum/browser/popup = new(user, "food_machine", "[src]", 550, 650, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "food_machine")


/obj/machinery/food_machine/proc/get_vend_data(mob/user as mob)
	var/dat

	//title
	dat += "<b>[name]</b><br>"

	if(!owner_uid)
		dat += "Please swipe your ID to claim ownership of this machine.<br>"
		return dat

	if(!check_account_exists(bank_id))
		dat += "<i>There appears to be an issue with the payment account of this vendor. Please contact the owner. If you are the owner, please scan your ID to \
		update bank details or check the status of your bank account</i>"
		return dat

	dat += "Please swipe a card or cash to dispense [product_desc]. <br><br><b>Cost:</b> [cash2text( price_per_vend, FALSE, TRUE, TRUE )].<BR>"

	if(!product_left)
		dat += "<B>SOLD OUT</B>"
	else
		dat += "Please insert [cash2text( price_per_vend, FALSE, TRUE, TRUE )] to dispense [product_desc].<BR>"

	return dat

/obj/machinery/food_machine/proc/set_new_owner(obj/item/weapon/card/id/I)
	owner_name = I.registered_name
	owner_uid = I.unique_ID
	bank_id = I.associated_account_number
	visible_message("<span class='info'>New owner set to '[I.registered_name]'.</span>")
	playsound(src, 'sound/machines/chime.ogg', 25)

/obj/machinery/food_machine/attackby(obj/item/weapon/W as obj, mob/user as mob)
	var/obj/item/weapon/card/id/I = W.GetID()

	if(!istype(W, /obj/item/weapon/reagent_containers/food/snacks/grown) || !istype(W,/obj/item/weapon/card/id) || !istype(W,/obj/item/weapon/spacecash/ewallet) || !istype(W,/obj/item/weapon/spacecash)) //i hate looking at this line
		return

	if(!owner_uid && I)
		if(!I.unique_ID || !I.registered_name || !I.associated_account_number || !check_account_exists(I.associated_account_number))
			visible_message("<span class='notice'>There is an issue with setting your ownership on this message, it could be due to a lack of details on the card like \
			a unique id, name, or valid bank details. Please contact a technician for more details.</span>")
			return
		else
			set_new_owner(I)
			update_icon()
			updateDialog()
		return


	if(!owner_uid)
		to_chat(user, "<span class='notice'>Please swipe your ID to claim ownership of this machine!</span>")
		return

	if(!check_account_exists(bank_id) && (owner_uid == I.unique_ID))
		visible_message("<span class='info'>Attempting to update details...</span>")
		set_new_owner(I)
		update_icon()
		updateDialog()
		return

	if(istype(W,/obj/item/weapon/reagent_containers/food/snacks/grown))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/food = W
		if(food.plantname && (food.plantname == accepted_produce))
			if(product_left >= max_product)
				to_chat(user, "<span class='notice'>This is already full!</span>")
				return
			if(!food.dry && needs_dry)
				to_chat(user, "<span class='notice'>This needs to be dried first!</span>")
				return
			to_chat(user, "<span class='notice'>You add [food] to [src]!</span>")
			user.drop_item(food)
			qdel(food)
			product_left++
			update_icon()
			updateDialog()
			return

	if(check_account_exists(bank_id))

		if(0 >= product_left)
			to_chat(user, "<span class='notice'>There's no [product_desc] left!</span>")
			return

		if(istype(W,/obj/item/weapon/spacecash))
			var/obj/item/weapon/spacecash/S = W

			if(price_per_vend > S.worth)
				to_chat(user, "<span class='notice'>You don't have enough!</span>")
				return

			visible_message("<span class='info'>\The [usr] inserts cash into \the [src].</span>")
			S.worth -= price_per_vend

			if(S.worth <= 0)
				user.drop_item(S)
				qdel(S)
			else
				S.update_icon()

			charge_to_account(bank_id, "[src]", "[product_desc] cash purchase", "[src]", price_per_vend)


		if(istype(W,/obj/item/weapon/spacecash/ewallet))
			var/obj/item/weapon/spacecash/ewallet/S = W

			if(price_per_vend > S.worth)
				to_chat(user, "<span class='notice'>This charge card does not have enough!</span>")
				return

			visible_message("<span class='info'>\The [usr] inserts [S] into \the [src].</span>")
			S.worth -= price_per_vend

			charge_to_account(bank_id, "[src]", "[product_desc] e-wallet purchase", "[src]", price_per_vend)


		if(istype(W,/obj/item/weapon/card/id))
			var/obj/item/weapon/card/id/ID = W

			var/datum/money_account/customer_account = get_account(ID.associated_account_number)
			if(!customer_account)
				visible_message("<span class='notice'>Error: Unable to access account. Please contact technical support if problem persists.</span>")
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

			if(price_per_vend > customer_account.money)
				visible_message("<span class='notice'>Insufficient funds in account.")
				return

			// debit money from the purchaser's account
			customer_account.money -= price_per_vend
			customer_account.add_transaction_log("[owner_name] (via [name])", "Purchase of [product_desc]", -price_per_vend, name)
			charge_to_account(bank_id, "[src]", "[product_desc] card purchase by [customer_account.owner_name]", "[src]", price_per_vend)

		make_product()


/obj/machinery/food_machine/proc/make_product()
	if(process_sound)
		playsound(src, process_sound, 25)
	var/obj/O = new product_item(loc)
	visible_message("<span class='notice'>[src] dispenses some [O]!</span>")
	product_left--
	update_icon()
	updateDialog()


/obj/machinery/food_machine/verb/set_pricing()
	set name = "Set Pricing"
	set desc = "Set the price of the product produced by the machine."
	set category = "Object"
	set src in oview(1)

	var/obj/item/weapon/card/id/I = usr.GetIdCard()

	if(!I || !I.unique_ID)
		to_chat(usr, "<span class='notice'>You require an ID card with a unique id set on it to do this!</span>")
		return

	if(I.unique_ID != owner_uid)
		to_chat(usr, "<span class='notice'>Your ID's unique id does not match this unit!</span>")
		return

	var/set_price = input("Input a new price (Inputting 0 will make the item free).") as num
	to_chat(usr, "You set [src]'s price setting to <b>[cash2text( set_price, FALSE, TRUE, TRUE )]</b>.")
	price_per_vend = set_price
	updateDialog()
	return

/obj/machinery/food_machine/verb/set_anchors()
	set name = "Set Anchors"
	set desc = "Set the anchors of the machine."
	set category = "Object"
	set src in oview(1)

	var/obj/item/weapon/card/id/I = usr.GetIdCard()

	if(!I || !I.unique_ID)
		to_chat(usr, "<span class='notice'>You require an ID card with a unique id set on it to do this!</span>")
		return

	if(I.unique_ID != owner_uid)
		to_chat(usr, "<span class='notice'>Your ID's unique id does not match this unit!</span>")
		return

	anchored = !anchored
	playsound(src, 'sound/items/drill_use.ogg', 25)

	if(anchored)
		to_chat(usr, "<b>The anchors tether themselves back into the floor. It is now secured.</b>")
	else
		to_chat(usr, "<b>You toggle the anchors of the food machine. It can now be moved.</b>")

/*********************
	Token Machine
*********************/
/obj/machinery/token_machine
	name = "Token Dispenser"
	desc = "A machine that dispenses arcade tokens."
	icon = 'icons/obj/terminals.dmi'
	icon_state = "tokens"

	var/owner_uid
	var/bank_id
	var/owner_name = ""
	var/price_per_vend = 5
	var/product_item = /obj/item/token

	unique_save_vars = list("owner_uid", "bank_id", "owner_name", "price_per_vend", "anchored")

/obj/machinery/token_machine/verb/set_anchors()
	set name = "Set Anchors"
	set desc = "Set the anchors of the machine."
	set category = "Object"
	set src in oview(1)

	var/obj/item/weapon/card/id/I = usr.GetIdCard()

	if(!I || !I.unique_ID)
		to_chat(usr, "<span class='notice'>You require an ID card with a unique id set on it to do this!</span>")
		return

	if(I.unique_ID != owner_uid)
		to_chat(usr, "<span class='notice'>Your ID's unique id does not match this unit!</span>")
		return

	anchored = !anchored
	playsound(src, 'sound/items/drill_use.ogg', 25)

	if(anchored)
		to_chat(usr, "<b>The anchors tether themselves back into the floor. It is now secured.</b>")
	else
		to_chat(usr, "<b>You toggle the anchors of the token machine. It can now be moved.</b>")

/obj/machinery/token_machine/examine(mob/user)
	..()
	if(owner_name)
		to_chat(user, "[name] belongs to <b>[owner_name]</b>, report any issues with the machine to the owner.")

/obj/machinery/token_machine/attackby(obj/item/weapon/W as obj, mob/user as mob)
	var/obj/item/weapon/card/id/I = W.GetID()

	if(!owner_uid && I)
		if(!I.unique_ID || !I.registered_name || !I.associated_account_number || !check_account_exists(I.associated_account_number))
			visible_message("<span class='notice'>There is an issue with setting your ownership on this message, it could be due to a lack of details on the card like \
			a unique id, name, or valid bank details. Please contact a technician for more details.</span>")
			return
		else
			set_new_owner(I)
		return


	if(!owner_uid)
		to_chat(user, "<span class='notice'>Please swipe your ID to claim ownership of this machine!</span>")
		return

	if(!check_account_exists(bank_id) && (owner_uid == I.unique_ID))
		visible_message("<span class='info'>Attempting to update details...</span>")
		set_new_owner(I)
		return

	if(check_account_exists(bank_id))

		if(istype(W,/obj/item/weapon/spacecash))
			var/obj/item/weapon/spacecash/S = W

			if(price_per_vend > S.worth)
				to_chat(user, "<span class='notice'>You don't have enough!</span>")
				return

			visible_message("<span class='info'>\The [usr] inserts cash into \the [src].</span>")
			S.worth -= price_per_vend

			if(S.worth <= 0)
				user.drop_item(S)
				qdel(S)
			else
				S.update_icon()

			charge_to_account(bank_id, "[src]", "arcade token cash purchase", "[src]", price_per_vend)


		if(istype(W,/obj/item/weapon/spacecash/ewallet))
			var/obj/item/weapon/spacecash/ewallet/S = W

			if(price_per_vend > S.worth)
				to_chat(user, "<span class='notice'>This charge card does not have enough!</span>")
				return

			visible_message("<span class='info'>\The [usr] inserts [S] into \the [src].</span>")
			S.worth -= price_per_vend

			charge_to_account(bank_id, "[src]", "arcade token e-wallet purchase", "[src]", price_per_vend)


		if(istype(W,/obj/item/weapon/card/id))
			var/obj/item/weapon/card/id/ID = W

			var/datum/money_account/customer_account = get_account(ID.associated_account_number)
			if(!customer_account)
				visible_message("<span class='notice'>Error: Unable to access account. Please contact technical support if problem persists.</span>")
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

			if(price_per_vend > customer_account.money)
				visible_message("<span class='notice'>Insufficient funds in account.")
				return

			// debit money from the purchaser's account
			customer_account.money -= price_per_vend
			customer_account.add_transaction_log("[owner_name] (via [name])", "Purchase of arcade token", -price_per_vend, name)
			charge_to_account(bank_id, "[src]", "arcade token card purchase by [customer_account.owner_name]", "[src]", price_per_vend)

		make_product()


/obj/machinery/token_machine/proc/make_product()
	var/obj/O = new product_item(loc)
	visible_message("<span class='notice'>[src] dispenses an [O]!</span>")

/obj/machinery/token_machine/verb/set_pricing()
	set name = "Set Pricing"
	set desc = "Set the price of the product produced by the machine."
	set category = "Object"
	set src in oview(1)

	var/obj/item/weapon/card/id/I = usr.GetIdCard()

	if(!I || !I.unique_ID)
		to_chat(usr, "<span class='notice'>You require an ID card with a unique id set on it to do this!</span>")
		return

	if(I.unique_ID != owner_uid)
		to_chat(usr, "<span class='notice'>Your ID's unique id does not match this unit!</span>")
		return

	var/set_price = input("Input a new price (Inputting 0 will make the item free).") as num
	to_chat(usr, "You set [src]'s price setting to <b>[cash2text( set_price, FALSE, TRUE, TRUE )]</b>.")
	price_per_vend = set_price
	return

/obj/machinery/token_machine/proc/set_new_owner(obj/item/weapon/card/id/I)
	owner_name = I.registered_name
	owner_uid = I.unique_ID
	bank_id = I.associated_account_number
	visible_message("<span class='info'>New owner set to '[I.registered_name]'.</span>")
	playsound(src, 'sound/machines/chime.ogg', 25)
