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
			return persistent_economy.tax_rate_upper * 100
		if(CLASS_MIDDLE)
			return persistent_economy.tax_rate_middle * 100
		if(CLASS_WORKING)
			return persistent_economy.tax_rate_lower * 100

/proc/get_economic_class(money)
	switch(money)
		if(0 to 9999)				return CLASS_WORKING
		if(10000 to 79999)			return CLASS_MIDDLE
		if(80000 to INFINITY)		return CLASS_UPPER

		else 					return CLASS_WORKING	// this accounts for balances that are negative
