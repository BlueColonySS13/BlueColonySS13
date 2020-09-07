
// Economy Taxes

/datum/portal_option/number_value/tax/economic_class/working
	name = "Working Class Tax"
	description = "An income tax affecting people who have between 0CR to 9,999CR in capital."
	id = "working_tax"

/datum/portal_option/number_value/tax/economic_class/middle
	name = "Middle Class Tax"
	id = "middle_tax"
	description = "An income tax affecting people who have between 10,000 to 79,999 in capital."

/datum/portal_option/number_value/tax/economic_class/upper
	name = "Upper Class Tax"
	id = "upper_tax"
	description = "An income tax affecting people who have between 80,000CR and over."


// Sales Taxes

/datum/portal_option/number_value/tax/sales/business
	name = "Business Sales Tax"
	description = "Taxes businesses for income they make through sales."
	id = "business_tax"

/datum/portal_option/number_value/tax/sales/medical
	name = "Medical Tax"
	description = "Taxes the sale of medical equipment, services and supplies."
	id = "medical_tax"

/datum/portal_option/number_value/tax/sales/weapons
	name = "Weapons Tax"
	description = "Taxes the sale of weaponry. Covers all ranged and melee weapons, also includes grenades and bombs."
	id = "weapons_tax"

/datum/portal_option/number_value/tax/sales/agriculture
	name = "Agriculture Tax"
	description = "Taxes the earnings of grown produce - including mutated strains. Covers fruit, vegetables, honey and beeswax."
	id = "agriculture_tax"

/datum/portal_option/number_value/tax/sales/alcohol
	name = "Alcohol Tax"
	description = "A tax type that taxes the sale of alcohol both wholesale or bought for recreational purposes."
	id = "alcohol_tax"

/datum/portal_option/number_value/tax/sales/tobacco
	name = "Tobacco Tax"
	description = "Taxes the sale of tobacco and cigarettes. This covers all forms of products that contain nicotene in general."
	id = "tobacco_tax"

/datum/portal_option/number_value/tax/sales/recreational_drugs
	name = "Recreational Drug Tax"
	description = "Taxes the sale of drugs that are used recreationally to achieve a high, this excludes cannabis or any drug that can be used for \
	medical purposes."
	id = "recreational_drug_tax"

/datum/portal_option/number_value/tax/sales/cannabis
	name = "Cannabis Tax"
	description = "Taxes the sale of marijuana or any derivatives. This is separate from recreational drugs due to the studied health properties of cannabis."
	id = "cannabis_tax"

/datum/portal_option/number_value/tax/sales/gambling
	name = "Gambling Tax"
	description = "Taxes the earnings of slot machines, scratch cards, poker games and anything relating to gambling."
	id = "gambling_tax"

/datum/portal_option/number_value/tax/sales/property
	name = "Property Tax"
	description = "Taxes the earnings of property, takes a sum of earnings that landlords recieve from rent."
	id = "property_tax"

/datum/portal_option/number_value/tax/sales/mining
	name = "Mining Tax"
	description = "Taxes the earnings of mining materials from NT owned mines and some mining equipment. Applies to both refined and non-refined materials."
	id = "mining_tax"

/datum/portal_option/number_value/tax/sales/banking
	name = "Banking Tax"
	description = "Taxes the earnings of government approved banks, including what they earn with loans or through debt management systems."
	id = "banking_tax"
