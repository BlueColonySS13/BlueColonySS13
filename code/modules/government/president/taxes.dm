
/datum/persistent_option/number_value/tax
	min_value = 0		// 0%
	max_value = 3		// 300%
	portal_category = "Sales Taxes"
	round_value = 0.01

	portal_grouping = "Taxes"

/datum/persistent_option/number_value/tax/income
	min_value = 0		// 0%
	max_value = 0.90	// 90%
	portal_category = "Economic Bracket Taxes"


/datum/persistent_option/number_value/tax/get_formatted_value() // for use in UIs
	var/the_value = "[(get_value() * 100)]%"
	return the_value

// Economy Taxes

/datum/persistent_option/number_value/tax/income/working
	name = "Working Class Tax"
	description = "An income tax affecting people who have between 0CR to 9,999CR in capital."
	id = WORKING_TAX

/datum/persistent_option/number_value/tax/income/middle
	name = "Middle Class Tax"
	id = MIDDLE_TAX
	description = "An income tax affecting people who have between 10,000CR to 79,999CR in capital."

/datum/persistent_option/number_value/tax/income/upper
	name = "Upper Class Tax"
	id = UPPER_TAX
	description = "An income tax affecting people who have between 80,000CR and over."


// Sales Taxes

/datum/persistent_option/number_value/tax/sales/business
	name = "Business Sales Tax"
	description = "Taxes businesses for income they make through sales."
	id = BUSINESS_TAX

/datum/persistent_option/number_value/tax/sales/medical
	name = "Medical Tax"
	description = "Taxes the sale of medical equipment, services and supplies."
	id = MEDICAL_TAX

/datum/persistent_option/number_value/tax/sales/weapons
	name = "Weapons Tax"
	description = "Taxes the sale of weaponry. Covers all ranged and melee weapons, also includes grenades and bombs."
	id = WEAPONS_TAX

/datum/persistent_option/number_value/tax/sales/food
	name = "Food Tax"
	description = "Taxes the earnings of edible prepared food in the colony."
	id = FOOD_TAX

/datum/persistent_option/number_value/tax/sales/drinks
	name = "Drinks Tax"
	description = "Taxes the earnings of non-alcoholic beverages in the colony."
	id = DRINKS_TAX

/datum/persistent_option/number_value/tax/sales/agriculture
	name = "Agriculture Tax"
	description = "Taxes the earnings of grown produce - including mutated strains. Covers fruit, vegetables, honey and beeswax."
	id = AGRICULTURE_TAX

/datum/persistent_option/number_value/tax/sales/alcohol
	name = "Alcohol Tax"
	description = "A tax type that taxes the sale of alcohol both wholesale or bought for recreational purposes."
	id = ALCOHOL_TAX

/datum/persistent_option/number_value/tax/sales/tobacco
	name = "Tobacco Tax"
	description = "Taxes the sale of tobacco, cigars, cigarettes and e-cigarettes. This covers all forms of products that contain nicotene in general."
	id = TOBACCO_TAX

/datum/persistent_option/number_value/tax/sales/recreational_drugs
	name = "Recreational Drug Tax"
	description = "Taxes the sale of drugs that are used recreationally to achieve a high, this excludes cannabis or any drug that can be used for \
	medicinal purposes."
	id = DRUG_TAX

/datum/persistent_option/number_value/tax/sales/cannabis
	name = "Cannabis Tax"
	description = "Taxes the sale of marijuana or any derivatives. This is separate from recreational drugs due to the studied health properties of cannabis."
	id = CANNABIS_TAX

/datum/persistent_option/number_value/tax/sales/pharma
	name = "Pharmaceutical Tax"
	description = "Taxes the sale of pharmaceutical medicines that are for medical use."
	id = PHARMA_TAX

/datum/persistent_option/number_value/tax/sales/hazardous_chem
	name = "Hazardous Chemicals Tax"
	description = "Taxes the sale of hazardous or poisonous chemicals."
	id = HAZARD_CHEM_TAX

/datum/persistent_option/number_value/tax/sales/gambling
	name = "Gambling Tax"
	description = "Taxes the earnings of slot machines, scratch cards, poker games and anything relating to gambling."
	id = GAMBLING_TAX

/datum/persistent_option/number_value/tax/sales/property
	name = "Property Tax"
	description = "Taxes the earnings of property, takes a sum of earnings that landlords recieve from rent."
	id = PROPERTY_TAX

/datum/persistent_option/number_value/tax/sales/mining
	name = "Mining Tax"
	description = "Taxes the earnings of mining materials from NT owned mines and some mining equipment. Applies to both refined and non-refined materials."
	id = MINING_TAX

/datum/persistent_option/number_value/tax/sales/banking
	name = "Banking Tax"
	description = "Taxes the earnings of government approved banks, including what they earn with loans or through debt management systems."
	id = BANKING_TAX

/datum/persistent_option/number_value/tax/sales/xenofauna
	name = "Xenofauna Tax"
	description = "Taxes the earnings made from xenofauna that is sold on the colony."
	id = XENO_TAX

/datum/persistent_option/number_value/tax/sales/electronics
	name = "Electronics Tax"
	description = "Taxes electronic based machinery, circuits, and devices."
	id = ELECTRONICS_TAX

/datum/persistent_option/number_value/tax/sales/clothing
	name = "Clothing Tax"
	description = "Taxes fabrics and clothing made from fabrics."
	id = CLOTHING_TAX

// Export taxes lol
/datum/persistent_option/number_value/tax/exports/sol
	name = "Sol Export Tax"
	description = "Taxes the earnings of things being shipped to and from Sol."
	id = SOL_IMPORT_TAX

/datum/persistent_option/number_value/tax/exports/andromeda
	name = "Andromeda Export Tax"
	description = "Taxes the earnings of things being shipped to and from Andromeda."
	id = ANDRO_IMPORT_TAX

