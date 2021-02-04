/obj/item/device/calories_scanner
	name = "calories scanner"
	desc = "Calculates the sugars, fats and lipids and their calorific value so dieters can be even pickier."
	icon_state = "calorie_scanner"
	origin_tech = list(TECH_MATERIAL = 6)
	var/scan_sound = 'sound/effects/checkout.ogg'
	var/on = TRUE

	tax_type = ELECTRONICS_TAX

/obj/item/device/calories_scanner/attack_self(mob/user)
	if(user.incapacitated())
		return

	on = !on

	to_chat(user, "<span class='notice'>You turn \the [on ? "on" : "off"].</span>")


/obj/item/device/calories_scanner/afterattack(obj/item/weapon/reagent_containers/target, mob/user)
	if(!on)
		return

	var/calories = 0
	calories += target.get_calories()
	user.show_message("\The [target]: [calories] calories.")
	playsound(src, scan_sound, 25)

/obj/item/device/breathalyzer
	name = "breathalyzer"
	desc = "Scans for the prescence of alcohol and certain drugs in the bloodstream."
	icon_state = "breathalyzer"
	matter = list(DEFAULT_WALL_MATERIAL = 200)
	origin_tech = list(TECH_MATERIAL = 3, TECH_BIO = 2)

	var/list/reagent_types_to_detect = list(/datum/reagent/ethanol, /datum/reagent/drug)
	var/list/reagent_exceptions = list("nicotine")
	var/list/obscuring_reagents = list("nicotine")
	var/obscure_chance = 80

	var/results
	var/last_scanned = ""

	var/autoprint = FALSE
	var/is_printing = FALSE

	price_tag = 20

/obj/item/device/breathalyzer/attack(mob/living/M, mob/living/user)
	scan_mob(M, user)


/obj/item/device/breathalyzer/proc/scan_mob(mob/living/M, mob/living/user)
	if(!M || !user)
		return

	if(!do_after(M,40))
		return 0

	var/list/found_reagents = list()
	var/obscure = FALSE

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(C.ingested && C.ingested.total_volume)
			for(var/datum/reagent/R in C.ingested.reagent_list)
				if((R.id in obscuring_reagents) && prob(obscure_chance))
					obscure = TRUE
					break

				if(R.id in reagent_exceptions)
					continue

				for(var/V in reagent_types_to_detect)
					if(istype(R, V))
						found_reagents += R
						continue

	if(isemptylist(found_reagents) || obscure)
		results = "<b>[M]:</b> No drugs found in bloodstream."
	else
		results = "<b>[M]:</b>"
		for(var/datum/reagent/R in found_reagents)
			results += "<br>[R]: [round(R.volume)] unit(s)"

	user.visible_message("<span class='notice'>[user] scans [M] with [src].</span>")
	user.visible_message("<span class='notice'>[results]</span>")
	last_scanned = M.name

	if(results && autoprint)
		result_print(user)

/obj/item/device/breathalyzer/verb/print_results(mob/user)
	set name = "Print Results"
	set desc = "Allows you to print results of the breathalyzer."
	set category = "Object"
	set src in usr

	result_print(user)

/obj/item/device/breathalyzer/verb/toggle_autoprint(mob/user)
	set name = "Toggle Autoprint"
	set desc = "Toggles if the breathalyzer prints automatically or not."
	set category = "Object"
	set src in usr

	autoprint = !autoprint
	to_chat(user, "You toggle [src] to [autoprint ? "print automatically" : "only print on request"].")

/obj/item/device/breathalyzer/proc/result_print(mob/user)
	if(!results)
		to_chat(user, "<span class='warning'>No results stored on this device!</span>")
		return

	if(is_printing)
		to_chat(user, "[src] is still printing, be patient!")
		return

	to_chat(user, "Printing results...")
	is_printing = TRUE

	sleep(15)
	playsound(loc, pick('sound/items/polaroid1.ogg', 'sound/items/polaroid2.ogg'), 75, 1, -3)
	var/obj/item/weapon/paper/P = new /obj/item/weapon/paper(get_turf(src))
	P.name = "Breathalyzer Results[last_scanned ? ": [last_scanned]" : ""]"
	P.info = "<h1>Breathalyzer Results</h1><center>[GLOB.current_date_string] at [stationtime2text()]</center><hr>"

	P.info += results

	is_printing = FALSE






