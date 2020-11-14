// Holds information on what the trade machine is willing to buy.
/datum/trade_offer
	var/atom/movable/type_wanted = null // Type of object the machine is wanting to buy. Used to get the name of the object and to check that it's the correct item.
	var/quantity_wanted = 1 // How many of that type is wanted.
	var/payment_offered = 0 // How much to pay when someone tries to sell the object.
	var/wanted = TRUE // If false, the machine won't buy it even if it's in the offers list.

// Looks at an item to set up future trades for similar items.
// Returns FALSE if the item isn't suitable (e.g. empty reagent container)
/datum/trade_offer/proc/scan_prototype(atom/movable/prototype)
	type_wanted = prototype.type
	payment_offered = prototype.get_item_cost() ? prototype.get_item_cost() : 1
	return TRUE

// Checks if an item matches what the datum wants.
/datum/trade_offer/proc/check_item(obj/item/I)
	return I.type == type_wanted

// Returns the 'quantity' of an item. For regular items it's always one, since each instance represents one object.
/datum/trade_offer/proc/check_item_quantity(obj/item/I)
	return 1

/datum/trade_offer/proc/display_name()
	return initial(type_wanted.name)

/datum/trade_offer/proc/display_quantity_offer()
	return "[quantity_wanted]"

// Subtypes can display how much the machine will pay with added context (e.g. how much per stack).
/datum/trade_offer/proc/display_payment_offer()
	return "[payment_offered]CR"

// Subtypes.
// The machine will use these if it scans a specific type of item, in order to be able to compare them properly.

// Material stacks have a quantity var so the machine needs to operate of that instead of object instances.
/datum/trade_offer/stack

/datum/trade_offer/stack/check_item_quantity(obj/item/stack/I)
	ASSERT(istype(I))
	return I.amount

/datum/trade_offer/stack/display_quantity_offer()
	return "[quantity_wanted] sheets"

/datum/trade_offer/stack/display_payment_offer()
	var/obj/item/stack/S = type_wanted
	return "[payment_offered]CR/sheet ([payment_offered * initial(S.max_amount)]CR/stack)"




// Reagents are inside of reagent containers so the machine needs to be aware of that.
/datum/trade_offer/reagent
	var/reagent_id_wanted = null // ID of the reagent that the machine wants.

/datum/trade_offer/reagent/scan_prototype(obj/item/weapon/reagent_containers/prototype)
	ASSERT(istype(prototype))
	..()
	var/datum/reagent/R = prototype?.reagents?.reagent_list[1]
	if(R)
		reagent_id_wanted = R.id
		payment_offered = R.get_item_cost() ? R.get_item_cost() : 1
		return TRUE
	return FALSE


// This overrides the check so the machine doesn't try to buy matching bottles but instead the contents of the bottle.
/datum/trade_offer/reagent/check_item(obj/item/weapon/reagent_containers/I)
	if(!istype(I))
		return FALSE
	if(isnull(I.reagents) || !LAZYLEN(I.reagents.reagent_list))
		return FALSE // Can't hold reagents or is an empty container.
	if(LAZYLEN(I.reagents.reagent_list) > 1)
		return FALSE // Pure bottles only.
	var/datum/reagent/R = I.reagents.reagent_list[1]
	return R.id == reagent_id_wanted

/datum/trade_offer/reagent/check_item_quantity(obj/item/weapon/reagent_containers/I)
	ASSERT(istype(I))
	for(var/thing in I?.reagents?.reagent_list)
		var/datum/reagent/R = thing
		if(R.id != reagent_id_wanted)
			continue
		return R.volume
	return 0

/datum/trade_offer/reagent/display_name()
	var/datum/reagent/R = chemistryProcess.chemical_reagents[reagent_id_wanted] // I wish this was SSchemistry.
	if(R)
		return R.name

/datum/trade_offer/reagent/display_quantity_offer()
	return "[quantity_wanted]u"

/datum/trade_offer/reagent/display_payment_offer()
	return "[payment_offered]CR/u"
