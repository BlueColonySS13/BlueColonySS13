// Persistent lots are saved to /maps/persistent/lots by default, the id is the filename	~ Cassie

/datum/lot
	var/name = "Empty Lot"
	var/id = "emptylot"
	var/desc = "A generic lot you can buy."
	var/price = 20000
	var/rent = 300

	//owner related
	var/datum/tenant/landlord
	var/list/tenants = list()

	var/list/applied_tenants = list()	//people who have applied to become a tenant, for rejection or for approval

//	var/company_name						// if owned by a company. (not implemented)

	var/service_light_warning = 5000
	var/service_charge_warning = 15000			// how much debt landlord is in before letters start arriving.
	var/service_charge_possession = 20000  		//how much debt landlord is in with service charges before council come be a bitch.

	var/required_deposit = 200

	var/list/landlord_checkbook = list()		//changes every payroll

	var/list/licenses = list(LICENSE_LANDLORD_COMMERCIAL, LICENSE_LANDLORD_OFFICE)

	var/held = FALSE
	var/tenants_wanted = FALSE
	var/for_sale = FALSE

	var/tmp/turf/top_left			//turf of top left
	var/tmp/turf/bottom_right		//turf of bottom right
	var/tmp/area/lot_area

	var/path = "data/persistent/lots/"

	var/reason_held = ""

	var/max_tenants = 3

	var/allow_saving = TRUE

	var/list/notes = list()


/datum/lot/New()
	SSlots.all_lots += src
	get_coordinates()

	..()



// Lot signs, if a lot is vacant, it'll spawn a for rent sign on round start. Else, it'll delete itself. It'll copy the pixel_x and pixel_y of itself to the for rent sign, too.

/obj/effect/landmark/lotsign
	name = "rent sign spawner"
	icon = 'icons/obj/signs.dmi'
	desc = "Spawns a rent sign."
	icon_state = "rent"

	var/lot_id		//associated lot ID
	dont_save = FALSE

/obj/effect/landmark/lotsign/initialize()
	SSlots.lotsigns += src

/obj/effect/landmark/lotsign/proc/get_lot_data()
	if(!lot_id)
		var/area/_area = loc.loc
		lot_id = _area.lot_id

	var/datum/lot/lot = SSlots.get_lot_by_id(lot_id)

	if(lot)
		if(lot.get_status() == FOR_RENT)
			var/obj/structure/sign/rent/R = new /obj/structure/sign/rent (src.loc)
			R.icon_state = "rent"

			R.name = "[lot.name] - For Rent ([lot.get_rent()]cr per payroll)"
			R.desc = "This rent sign says <b>[lot.name] - For Rent ([lot.get_rent()]cr per payroll)</b><br>\
			Underneath, the sign notes the housing is owned by <b>[lot.get_landlord_name()]</b>. Contact them for more details or buy from the Landlord Management Program on the computers in the library."

			//copy over mapping values.
			R.pixel_z = pixel_z
			R.pixel_x = pixel_x
			R.pixel_y = pixel_y
		if(lot.get_status() == FOR_SALE)
			var/obj/structure/sign/rent/R = new /obj/structure/sign/rent (src.loc)
			R.icon_state = "sale"

			R.name = "[lot.name] - For Sale ([lot.get_price()]cr)"
			R.desc = "This rent sign says <b>[lot.name] - For Sale ([lot.get_price()]cr)</b><br>\
			Underneath, the sign notes the housing is owned by <b>[lot.get_landlord_name()]</b>. Contact them for more details or buy from the Landlord Management Program on the computers in the library."

			//copy over mapping values.
			R.pixel_z = pixel_z
			R.pixel_x = pixel_x
			R.pixel_y = pixel_y
		if(lot.get_status() == LOT_HELD)
			var/obj/structure/sign/rent/R = new /obj/structure/sign/rent (src.loc)
			R.icon_state = "held"

			R.name = "[lot.name] - Held"
			R.desc = "This lot has been seized by City Council."
			if(lot.reason_held)
				R.desc += " Reason: [lot.reason_held]"

			//copy over mapping values.
			R.pixel_z = pixel_z
			R.pixel_x = pixel_x
			R.pixel_y = pixel_y

	delete_me = 1
	qdel(src)
