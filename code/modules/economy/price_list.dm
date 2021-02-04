// For convenience and easier comparing and maintaining of item prices,
// all these will be defined here and sorted in different sections.

// The item price in credits. atom/movable so we can also assign a price to animals and other things.
/atom/movable/var/price_tag = null
/atom/movable/var/tagged_price = null
/atom/movable/var/tax_type = null // put the portal id of the tax we're charging here.

// The proc that is called when the price is being asked for. Use this to refer to another object if necessary.
/atom/movable/proc/get_item_cost(skip_tag = FALSE)
	if(skip_tag)
		return round(price_tag)

	if(!isnull(tagged_price))
		return round(tagged_price)

	return round(price_tag)


/atom/movable/proc/get_full_cost()	// with tax
	return (get_item_cost() + post_tax_cost())

// TAXES

/atom/movable/proc/get_tax()
	return SSpersistent_options.get_persistent_option_value(tax_type)

/datum/reagent/proc/get_tax()
	return SSpersistent_options.get_persistent_option_value(tax_type)

/datum/reagent/proc/get_item_cost()
	return round(price_tag)

//post tax post gets the "extra" money added that is added from tax

/datum/reagent/proc/post_tax_cost()
	if(!get_tax())
		return 0

	return round(get_tax() * get_item_cost())

/atom/movable/proc/post_tax_cost()
	if(!get_tax())
		return 0

	return round(get_tax() * get_item_cost())

/datum/medical_bill/proc/post_tax_cost()
	if(!get_tax())
		return 0

	return round(get_tax() * get_item_cost())

/datum/law/proc/post_tax_cost()
	if(!get_tax())
		return 0

	return round(get_tax() * get_item_cost())

/datum/court_fee/proc/post_tax_cost()
	if(!get_tax())
		return 0

//***************//
//---Beverages---//
//***************//

/datum/reagent/var/price_tag = null		// This is now price per unit. It gets rounded up to the nearest 10 when get_item_cost() is called.
/datum/reagent/var/tax_type = null


///////////////////
//---Law---------//
//***************//

/datum/law/var/price_tag = null

/datum/law/proc/get_item_cost()
	return fine

/datum/law/proc/get_tax()
	return

///////////////////
//---Med---------//
//***************//

/datum/medical_bill/var/price_tag = null

/datum/medical_bill/proc/get_item_cost()
	var/pres_portal_cost = SSpersistent_options.get_persistent_option_value(portal_id)
	if(!isnull(pres_portal_cost))
		return pres_portal_cost

	return cost

/datum/medical_bill/proc/get_tax()
	return SSpersistent_options.get_persistent_option_value(MEDICAL_TAX)

///////////////////
//---Court---------//
//***************//

/datum/court_fee/var/price_tag = null

/datum/court_fee/proc/get_item_cost()
	return cost

/datum/court_fee/proc/get_tax()
	return

///////////////////
//---Lots--------//
//***************//

/datum/lot/var/price_tag = null

/datum/lot/proc/get_item_cost()
	return price

/datum/lot/proc/get_tax()
	return SSpersistent_options.get_persistent_option_value(PROPERTY_TAX)

// Juices, soda and similar //

/datum/reagent/water
	price_tag = 0.05

/datum/reagent/drink/juice
	price_tag = 0.1

/datum/reagent/toxin/poisonberryjuice
	price_tag = 0.2

/datum/reagent/drink/milk
	price_tag = 0.1

/datum/reagent/drink/soda
	price_tag = 0.2

/datum/reagent/drink/doctor_delight
	price_tag = 0.12

/datum/reagent/drink/nothing
	price_tag = 0.08

/datum/reagent/drink/milkshake
	price_tag = 0.12

/datum/reagent/drink/roy_rogers
	price_tag = 0.14

/datum/reagent/drink/shirley_temple
	price_tag = 0.15

/datum/reagent/drink/arnold_palmer
	price_tag = 0.16

/datum/reagent/drink/collins_mix
	price_tag = 0.16



// Hot Drinks //

/datum/reagent/drink/rewriter
	price_tag = 0.14

/datum/reagent/drink/tea
	price_tag = 0.09

/datum/reagent/drink/coffee
	price_tag = 0.09

/datum/reagent/drink/hot_coco
	price_tag = 0.11

// Dynamic Food/Drink Calculation //


/obj/item/weapon/reagent_containers/get_item_cost()
	if(!isnull(tagged_price))
		return round(tagged_price)

	var/total_price

	if(reagents)
		for(var/datum/reagent/R in reagents.reagent_list)
			total_price += R.price_tag * R.volume

	return round(total_price)

/obj/item/weapon/reagent_containers/get_tax()
	if(reagents)
		for(var/datum/reagent/R in reagents.reagent_list)
			if(R.get_tax())
				return R.get_tax()



/obj/item/pizzabox/get_item_cost()
	if(pizza)
		return get_item_cost(pizza)
	else
		return price_tag


//***************//
//----Smokes-----//
//***************//

/obj/item/weapon/storage/box/matches
	price_tag = 1

/obj/item/weapon/flame/lighter
	price_tag = 2

/obj/item/weapon/flame/lighter/zippo
	price_tag = 5

////////////////////
// -- Minerals -- //
////////////////////

/obj/item/stack/get_item_cost(skip_tag = FALSE)
	var/total_price

	if(skip_tag)
		if(istype(src, /obj/item/stack/material))
			var/obj/item/stack/material/mat = src
			total_price = mat.amount * mat.material.get_worth()
			return round(total_price)

		if(!isemptylist(associated_reagents))
			var/divider = amount / associated_reagents.len
			for(var/R in associated_reagents)
				var/datum/reagent/rgnt = chemical_reagents_list[R]
				total_price += (rgnt.price_tag * divider) * reagent_multiplier
				return round(total_price)



	if(!isnull(tagged_price))
		return round(tagged_price)

	return round(total_price)


/obj/item/stack/get_tax()
	if(reagents)
		for(var/datum/reagent/R in reagents.reagent_list)
			if(R.get_tax())
				return R.get_tax()


// other taxes

/obj/machinery/computer/betting_terminal/get_tax()
	return SSpersistent_options.get_persistent_option_value(GAMBLING_TAX)