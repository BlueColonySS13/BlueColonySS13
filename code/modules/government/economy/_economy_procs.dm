/proc/get_tax_price(tax, price)
	var/tax_amt
	tax_amt = tax * price
	return price + tax_amt

/proc/get_tax_amount(tax, price)
	var/amt
	amt = tax * price
	return amt


/proc/get_tax_rate(class)

	switch(class)
		if(CLASS_UPPER)
			return SSpersistent_options.get_persistent_formatted_value(UPPER_TAX)
		if(CLASS_MIDDLE)
			return SSpersistent_options.get_persistent_formatted_value(MIDDLE_TAX)
		if(CLASS_WORKING)
			return SSpersistent_options.get_persistent_formatted_value(WORKING_TAX)

/proc/get_economic_class(money, unique_id)
	var/total_money = money

	var/datum/business/B = get_business_by_owner_uid(unique_id) // no escape from tax amounts in business funds LOL
	if(B)
		total_money += B.get_funds()

	switch(money)
		if(0 to 9999)				return CLASS_WORKING
		if(10000 to 79999)			return CLASS_MIDDLE
		if(80000 to INFINITY)		return CLASS_UPPER

		else 					return CLASS_WORKING	// this accounts for balances that are negative
