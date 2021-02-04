
/datum/persistent_option/number_value/landlord
	portal_category = "Leasehold and Tenancy"
	portal_grouping = "Social Services"
	compact_listing = 0

/datum/persistent_option/number_value/landlord/service_charge	// charges this much per tile in the lot.
	name = "Hourly Service Charge Per Tile"
	description = "Calculates service charges per square tile of the property and makes this the hourly charge. \
	IE: 0.02 * 100 = 20CR service charge per hour. This goes to the city council account."
	id = "hourly_service_charge"
	value = 0.05
	min_value = 0
	max_value = 1
	round_value = 0.01

	make_referendum = TRUE

/datum/persistent_option/number_value/landlord/maximum_rent
	name = "Maximum Rent Per Tenant"
	description = "How much can landlords charge their tenants per hour?"
	id = "maximum_rent"
	value = 100
	min_value = 1
	max_value = 500
	value_is_money = TRUE

/datum/persistent_option/number_value/landlord/max_lots
	name = "Maximum Properties Per Landlord"
	description = "How many properties can one landlord own? (This will prevent landlords from buying more, but won't affect current landlords.)"
	id = "maximum_lots"
	value = 2
	min_value = 1
	max_value = 3
	make_referendum = TRUE

/datum/persistent_option/number_value/landlord/minimum_arrears_tenant
	name = "Minimum Arrears For Tenant Eviction"
	description = "In negative numbers, how low must the tenant fall into arrears before their landlord can evict them?"
	id = "min_arrears_tenant"
	value = -5000
	max_value = -1000
	min_value = -10000
	value_is_money = TRUE