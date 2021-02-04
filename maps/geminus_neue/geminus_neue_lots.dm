// business lots

/datum/lot/business
	price = 100000
	rent = 5
	licenses = list(LICENSE_LANDLORD_COMMERCIAL)
	max_tenants = 6

/datum/lot/business/one
	name = "Business Lot 1"
	id = "bizlot1"
	desc = "A decently sized commercial lot located on the high street - located near the arrival bus station."
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

/datum/lot/business/two
	name = "Business Lot 2"
	id = "bizlot2"
	desc = "A decently sized commercial lot located on the high street - located near the arrival bus station."
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

/datum/lot/business/three
	name = "Business Lot 3"
	id = "bizlot3"
	price = 350000
	desc = "A massive store property designed to accomodate a large quatity of wares."
	max_tenants = 9

/datum/lot/business/four
	name = "Business Lot 4"
	id = "bizlot4"
	price = 233000
	rent = 15
	desc = "A large commercial lot licensed for catering, pubs or a restaurant. Has two offices and VIP rooms and a toilet."
	max_tenants = 4
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

/datum/lot/business/five
	name = "Business Lot 5"
	id = "bizlot5"
	desc = "A medium sized lot located near the science labs, it is opposite the police station."
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

/datum/lot/business/six
	name = "Business Lot 6"
	id = "bizlot6"
	price = 129000
	desc = "A medium sized lot located near the science labs, it is opposite the police station and has several rooms."
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

/datum/lot/business/seven
	name = "Business Lot 7"
	id = "bizlot7"
	price = 289000
	desc = "A large sized lot located across the road (east) of the police station."
	max_tenants = 5
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

/datum/lot/business/eight
	name = "Business Lot 8"
	id = "bizlot8"
	price = 190000
	desc = "A large sized lot located across the road (east) of the police station, it is closer to the factory."
	max_tenants = 5
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

/datum/lot/business/nine
	name = "Business Lot 9"
	id = "bizlot9"
	price = 210000
	desc = "A business lot right outside the airbus evacuation area and opposite the inn, it is very large and spaceous."
	max_tenants = 6
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

/datum/lot/business/ten
	name = "Business Lot 10"
	id = "bizlot10"
	price = 120000
	desc = "A very old lot that requires refurbishment - is it two floors and worth investment."
	max_tenants = 6
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

/datum/lot/business/eleven
	name = "Business Lot 11"
	id = "bizlot11"
	desc = "An old lot in need of refurbishment, is it currently in disrepair after the previous landowner's tenants used it for illegal purposes."
	price = 90000
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)
	max_tenants = 6

/datum/lot/business/twelve
	name = "Business Lot 12"
	id = "bizlot12"
	price = 130000
	desc = "A business lot located on the east side of the hospital, modern, unfurnished and medium sized and suitable for many uses.."
	max_tenants = 6
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

//stalls
/datum/lot/stall
	price = 9000
	desc = "A tiny set of tiny stalls intended for a small business."
	max_tenants = 1

/datum/lot/stall/one
	name = "Stall 1"
	id = "stall1"
	desc = "A tiny stall next to the factory. It is located on the upper top right."

/datum/lot/stall/two
	name = "Stall 2"
	id = "stall2"
	desc = "A tiny stall next to the factory. It is located on the upper top left."

/datum/lot/stall/three
	name = "Stall 3"
	id = "stall3"
	desc = "A tiny stall next to the factory. It is located on the middle left."

/datum/lot/stall/four
	name = "Stall 4"
	id = "stall4"
	desc = "A tiny stall next to the factory. It is located on the middle right."

/datum/lot/stall/five
	name = "Stall 5"
	id = "stall5"
	desc = "A tiny stall next to the factory. It is located on the bottom left."

/datum/lot/stall/six
	name = "Stall 6"
	id = "stall6"
	desc = "A tiny stall next to the factory. It is located on the bottom right."

/datum/lot/stall/seven
	name = "Stall 7"
	id = "stall7"
	desc = "A tiny stall right next to the arrival bus."


// shopping lots

/datum/lot/shopping
	price = 50000
	rent = 5
	desc = "A lot that is located in the shopping mall."
	licenses = list(LICENSE_LANDLORD_COMMERCIAL)

/datum/lot/shopping/one
	name = "Shopping Lot 1"
	id = "shoplot1"
	price = 40000
	desc = "A small lot located on the ground floor of the shopping mall - left hand side."


/datum/lot/shopping/two
	name = "Shopping Lot 2"
	id = "shoplot2"
	price = 40000
	desc = "A small lot located on the ground floor of the shopping mall - right hand side."

/datum/lot/shopping/three
	name = "Shopping Lot 3"
	id = "shoplot3"
	desc = "A medium-small lot located on the top floor and top left of the shopping mall."


/datum/lot/shopping/four
	name = "Shopping Lot 4"
	id = "shoplot4"
	price = 61000
	desc = "A medium lot located on the top floor and top right of the shopping mall."

/datum/lot/shopping/five
	name = "Shopping Lot 5"
	id = "shoplot5"
	price = 61200
	desc = "A medium lot located on the top floor and bottom left of the shopping mall."

/datum/lot/shopping/six
	name = "Shopping Lot 6"
	id = "shoplot6"
	price = 61200
	desc = "A medium lot located on the top floor and bottom right of the shopping mall."

// office lots

/datum/lot/office
	price = 40000
	licenses = list(LICENSE_LANDLORD_OFFICE)

/datum/lot/office/multi/office_complex_one
	name = "Office Complex 1"
	id = "office_complex_1"
	price = 75000
	desc = "A complex of three office lots and a reception area, intended for renting."

/datum/lot/office/one
	name = "Office Lot 1"
	id = "office1"
	price = 35000
	desc = "A small office lot next to the courtroom."

/datum/lot/office/two
	name = "Office Lot 2"
	id = "office2"
	price = 45000
	desc = "A secluded office off the high street, located top left of the city."


// office lots

/datum/lot/farm
	price = 30000
	licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_AGRICULTURE)

/datum/lot/farm/one
	name = "Farmlot 1"
	id = "farmlot1"
	desc = "A farmlot that is located next to the park, it has facilities provided for agricultural supply."