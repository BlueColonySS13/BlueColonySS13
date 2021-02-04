
// TODO: Make gun classification types and link them to the permit tiers.

/datum/persistent_option/number_value/permit
	min_value = 0
	max_value = 50000
	portal_category = "Permit Pricing"
	portal_grouping = "Economy Settings"
	value_is_money = TRUE

// Gun Permits
/datum/persistent_option/number_value/permit/gun/tier_0
	name = "Tier 0 Gun Permit Cost"
	description = "This is the cost of a permit, a tier 0 permit will cost this much when purchased."
	id = "gun_permit_tier_0"
	value = 200

/datum/persistent_option/number_value/permit/gun/tier_1
	name = "Tier 1 Gun Permit Cost"
	description = "This is the cost of a permit, a tier 1 permit will cost this much when purchased."
	id = "gun_permit_tier_1"
	value = 400

/datum/persistent_option/number_value/permit/gun/tier_2
	name = "Tier 2 Gun Permit Cost"
	description = "This is the cost of a permit, a tier 2 permit will cost this much when purchased."
	id = "gun_permit_tier_2"
	value = 700

/datum/persistent_option/number_value/permit/gun/tier_3
	name = "Tier 3 Gun Permit Cost"
	description = "This is the cost of a permit, a tier 3 permit will cost this much when purchased."
	id = "gun_permit_tier_3"
	value = 1000

/datum/persistent_option/number_value/permit/gun/tier_4
	name = "Tier 4 Gun Permit Cost"
	description = "This is the cost of a permit, a tier 4 permit will cost this much when purchased."
	id = "gun_permit_tier_4"
	value = 1500

/datum/persistent_option/number_value/permit/gun/tier_5
	name = "Tier 5 Gun Permit Cost"
	description = "This is the cost of a permit, a tier 5 permit will cost this much when purchased."
	id = "gun_permit_tier_5"
	value = 7000

// Retail Licenses

/datum/persistent_option/number_value/permit/retail/cannabis
	name = "Cannabis Retail License"
	description = "Allows you to set the price of cannabis retail licenses."
	id = "retail_permit_cannabis"
	value = 800

/datum/persistent_option/number_value/permit/retail/tobacco
	name = "Tobacco Retail License"
	description = "Allows you to set the price of tobacco retail licenses."
	id = "retail_permit_tobacco"
	value = 400

/datum/persistent_option/number_value/permit/retail/alcohol
	name = "Alcohol Retail License"
	description = "Allows you to set the price of alcohol retail licenses."
	id = "retail_permit_alcohol"
	value = 400

/datum/persistent_option/number_value/permit/retail/blades
	name = "Blades Retail License"
	description = "Allows you to set the price of blade retail licenses."
	id = "retail_permit_blades"
	value = 400

/datum/persistent_option/number_value/permit/retail/firearms
	name = "Firearms Retail License"
	description = "Allows you to set the price of firearm retail licenses."
	id = "retail_permit_firearms"
	value = 400

// Production Licenses

/datum/persistent_option/number_value/permit/production/cannabis
	name = "Cannabis Retail License"
	description = "Allows you to set the price of cannabis production licenses."
	id = "retail_production_cannabis"
	value = 800

/datum/persistent_option/number_value/permit/production/tobacco
	name = "Tobacco Retail License"
	description = "Allows you to set the price of tobacco production licenses."
	id = "retail_production_cannabis"
	value = 400

/datum/persistent_option/number_value/permit/production/alcohol
	name = "Alcohol Retail License"
	description = "Allows you to set the price of alcohol production licenses."
	id = "retail_production_alcohol"
	value = 400

/datum/persistent_option/number_value/permit/production/blades
	name = "Blades Retail License"
	description = "Allows you to set the price of vkade production licenses."
	id = "retail_production_blades"
	value = 400

/datum/persistent_option/number_value/permit/production/firearms
	name = "Firearms Retail License"
	description = "Allows you to set the price of firearm production licenses."
	id = "retail_production_firearms"
	value = 400