// A machine that protects the lot it's in from various forms of vandalism and theft.
// This protection is not free, however.

/obj/machinery/lot_security_system
	name = "\improper Z.E.U.S. System"
	desc = "The Zone Electrified Unmanned Security System. \
	A sophisticated security system that's capable of both detecting and preventing various crimes against the property owner. \
	It does this by logging unlawful acts performed within it's assigned location, with the option to remotely shock \
	the perpetrator. ZEUS sees all, and will punish the guilty, for a price."
	icon = 'icons/obj/secmachine.dmi'
	icon_state = "security_machine"
	anchored = TRUE
	density = TRUE

	unique_save_vars = list("prevent_flags", "report_flags", "owner_uid", "zap_power", "reports", "custom_access_exemptions", "active", "anchored")

	// Working vars.
	var/prevent_flags = 0		// What the system will try to stop as well as log. Bitflag.
	var/report_flags = 0		// What the system will only log. Bitflag.
	var/owner_uid = null		// The owner is exempt from all interference by the machine.
	var/zap_power = 0			// How much 'zapping power' the machine can use to stop criminal scum. More can be added, at a cost.
	var/list/reports = list()	// Logs of what the machine did, viewable to players and can be printed out.
	var/list/innate_access_exemptions = list(access_security) // People that have one of the accesses in this list, or the list below, won't get zapped.
	var/list/custom_access_exemptions = list() // This list can be customized in the UI.
	var/active = TRUE			// If FALSE, does nothing.
	var/emped = FALSE			// Similar to above but temporary, used when EMP'd.
//	var/disable_timer_id = 0	// Timer ID for the EMP timer. Used if it gets EMP'd again while it's emped. Commented out due to no timer subsystem :(
	var/temporary_inactive = FALSE	// When TRUE, the system is turned off similar to `active` being false, however this var intentionally doesn't persist.

	// Balance/config vars.
	var/damage_to_criminals = 20 		// How much damage to inflict on someone who the machine thinks is guilty.
	var/stun_to_criminals = 3		// How severe of a stun will that someone get alongside the damage.
	var/desired_area_type = /area/lots	// The system only works inside this type of area. By default it only works in lots.
	var/max_zap_storage = 30			// Max amount of zapping power that can be stored.
	var/max_report_length = 50		// How many log entries the machine can store before it starts deleting the oldest entries.
	var/emp_disable_time = 2 MINUTES	// How long the machine turns off when EMP'd.
	var/hardened = FALSE			// If true, EMP does nothing.

// A subtype that could be useful for mapping in admin-only areas to stop end-of-round griffins from hacking in or something.
// Also useful for testing.
/obj/machinery/lot_security_system/centcom
	name = "Z.E.U.S. System Deluxe"
	prevent_flags = LOT_SECURITY_STOP_EVERYTHING
	innate_access_exemptions = list() // Even the CoP can't grief.
	zap_power = INFINITY
	hardened = TRUE
	desired_area_type = /area
	owner_uid = "Nanotrasen"

/obj/machinery/lot_security_system/centcom/president	// for the commander in chief
	name = "Presidential Z.E.U.S. System Deluxe"
	innate_access_exemptions = list(access_president)

/obj/machinery/lot_security_system/centcom/police
	name = "Police Z.E.U.S. System Deluxe"
	innate_access_exemptions = list(access_security)
	damage_to_criminals = 0 // avoid police lawsuits lol
	hardened = FALSE // should be empable

// The kind you get straight from the factory, only difference is that it doesn't start anchored.
/obj/machinery/lot_security_system/factory_ordered
	anchored = FALSE

/obj/machinery/lot_security_system/initialize()
	add_to_area()
	return ..()

/obj/machinery/lot_security_system/Destroy()
	remove_from_area()
	return ..()

/obj/machinery/lot_security_system/on_persistence_load()
	add_to_area()

/obj/machinery/lot_security_system/get_persistent_metadata()
	return reports

/obj/machinery/lot_security_system/load_persistent_metadata(datums)
	if(!datums)
		reports = list()
	reports = datums

/obj/machinery/lot_security_system/emp_act(severity)
	if(hardened)
		return
	if(emped) // Sadly due to lacking the Timer subsystem, we can't do this cleanly.
		return
//	if(disable_timer_id)
//		deltimer(disable_timer_id)
	emped = TRUE
	update_icon()
//	addtimer(CALLBACK(src, .proc/enable), emp_disable_time, TIMER_STOPPABLE)
	spawn(emp_disable_time)
		enable()

/obj/machinery/lot_security_system/update_icon()
	if(emped)
		icon_state = "[initial(icon_state)]_emp"
	else if(!is_active())
		icon_state = "[initial(icon_state)]_off"
	else
		icon_state = initial(icon_state)

/obj/machinery/lot_security_system/attackby(obj/item/I, mob/living/user)
	if(!istype(I))
		return

	// Claiming.
	if(istype(I, /obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/ID = I
		if(!owner_uid)
			owner_uid = ID.unique_ID
			to_chat(user, SPAN_NOTICE("You claim \the [src] as your own."))
			interact(user)
			return

	// Refilling.
	if(istype(I, /obj/item/weapon/lot_security_charge))
		var/obj/item/weapon/lot_security_charge/charge = I
		if(zap_power + charge.charge_amount > max_zap_storage)
			to_chat(user, SPAN_WARNING("\The [charge] buzzes in your hand, signaling that \
			it detects it would overcharge \the [src] if it was used, and so it aborts the \
			recharge."))
			return
		zap_power += charge.charge_amount
		user.drop_from_inventory(charge)
		to_chat(user, SPAN_NOTICE("You plug in \the [charge] into \the [src]'s proprietary charging \
		port, and \the [charge] is quickly drained. You discard the now useless object."))
		qdel(charge)
		interact(user)
		return

	return ..()


/obj/machinery/lot_security_system/attack_hand(mob/living/user)
	if(owner_uid)
		var/obj/item/weapon/card/id/ID = user.GetIdCard()
		if(!istype(ID) || ID.unique_ID != owner_uid)
			to_chat(user, SPAN_WARNING("Only the owner of \the [src] adjust the settings."))
			return
	interact(user)

/obj/machinery/lot_security_system/interact(mob/user)
	var/list/html = build_main_window(user)

	var/datum/browser/popup = new(user, "security_system", "[src]", 680, 640, src)
	popup.set_content(html.Join())
	popup.open()

	onclose(user, "security_system")

/obj/machinery/lot_security_system/proc/build_main_window(mob/user)
	. = list()
	. += "Thank you for choosing [strip_improper(src.name)], the ultimate solution to unmanned security.<br>"
	if(!owner_uid)
		. += "To claim this security system as your own, please swipe your ID."
		return
	. += "The security system is currently [is_active() ? "ACTIVATED" : "<span class='bad'>DEACTIVATED</span>"].<br>"
	. += "You currently have <b>[zap_power]</b>/<b>[max_zap_storage]</b> potential to protect your property.<br>"
	. += "Z.E.U.S. charges can be used to refill this machine for continued operation."
	. += "<hr>"
	. += "<h2>Configuration</h2><br>"
	for(var/thing in GLOB.all_lot_security_options)
		var/datum/lot_security_option/option = GLOB.all_lot_security_options[thing]
		. += "[option.name] (Cost to stop: [option.cost])<br>"
		. += "<i>[option.desc]</i><br>"

		if(!((report_flags|prevent_flags) & option.id))
			. += "<b>Ignore</b> "
		else
			. += href(src, list("set_ignore" = option.id), "Ignore")

		if(report_flags & option.id)
			. += " <b>Report Only</b> "
		else
			. += href(src, list("set_report" = option.id), "Report Only")

		if(prevent_flags & option.id)
			. += " <b>Report & Prevent</b>"
		else
			. += href(src, list("set_prevent" = option.id), "Report & Prevent")
		. += "<br><br>"
	. += "<hr>"
	. += href(src, list("reports_window" = 1), "View Reports")
	. += href(src, list("accesses_window" = 1), "Configure Access Exemptions")
	. += href(src, list("toggle_bolts" = 1), "Toggle Bolts")
	. += "<br>"
	. += href(src, list("toggle_temp_security" = 1), "Toggle Security (Temporary)")
	. += href(src, list("toggle_security" = 1), "Toggle Security (Permanent)")
	. += "<br>"
	. += href(src, list("factory_reset" = 1), "Factory Reset")

/obj/machinery/lot_security_system/proc/show_access_window(mob/living/user)
	var/list/html = build_access_window(user)

	var/datum/browser/popup = new(user, "security_system_access", "[src]", 340, 640, src)
	popup.set_content(html.Join())
	popup.open()

	onclose(user, "security_system_access")

/obj/machinery/lot_security_system/proc/build_access_window(mob/user)
	. = list()
	. += "This machine will scan the worn ID of someone that triggers it.<br>"
	. += "If they have at least one of the accesses in any of the lists below, they will not be stopped by this system, however \
	they will still be logged if the system is not set to ignore it entirely for everyone.<br>"
	. += "The lists are divided into innate, and custom access lists."
	. += "<hr>"

	. += "<h2>Innate Accesses</h2>"
	. += "<i>Innate means that it cannot be changed.</i><br>"
	if(!innate_access_exemptions.len)
		. += "Nothing"
	else
		for(var/thing in innate_access_exemptions)
			. += " - "
			. += get_access_desc(thing)
			. += "<br>"
	. += "<hr>"

	. += "<h2>Custom Accesses</h2>"
	. += "<i>Custom means that it can be configured, using the buttons below.</i><br>"
	if(!custom_access_exemptions.len)
		. += "Nothing"
	else
		for(var/thing in custom_access_exemptions)
			. += " - "
			if(istext(thing)) // Dumb but it works, since business accesses are strings and normal ones are (hopefully) numbers.
				. += get_biz_access_name_id(thing)
			else
				. += get_access_desc(thing)
			. += href(src, list("toggle_access" = thing), "Remove")
			. += "<br>"
	. += "<hr>"

	. += "<h2>Add Access</h2>"
	. += "<h3>City Accesses</h3>"
	for(var/thing in get_all_station_access())
		. += " - "
		. += get_access_desc(thing)
		if(thing in custom_access_exemptions)
			. += " <b>Added</b>"
		else
			. += href(src, list("toggle_access" = thing), "Add")
		. += "<br>"
	. += "<h3>Business Accesses</h3>"
	for(var/thing in SSbusiness.business_access_list)
		var/datum/access/A = thing
		. += " - "
		. += get_biz_access_name_id(A.id)
		if(A.id in custom_access_exemptions)
			. += " <b>Added</b>"
		else
			. += href(src, list("toggle_access" = A.id), "Add")
		. += "<br>"

/obj/machinery/lot_security_system/proc/show_report_window(mob/living/user)
	var/list/html = build_report_window(user)

	var/datum/browser/popup = new(user, "security_system_report", "[src]", 880, 640, src)
	popup.set_content(html.Join())
	popup.open()

	onclose(user, "security_system_report")

/obj/machinery/lot_security_system/proc/build_report_window(mob/living/user)
	. = list()
	. += "Below is a list of reports that the system has logged as a result of possible action taken against your property.<br>"
	. += "This list can be printed out for long term physical storage, or if you wish to give this to the police as evidence.<br>"
	. += "It should be noted that if the data storage becomes full, the oldest log will automatically be deleted.<br><br>"
	. += "Data storage: [LAZYLEN(reports)]/[max_report_length]<br>"
	. += href(src, list("print_report" = REF(reports)), "Print All Reports")
	. += "<br>"
	. += href(src, list("wipe_all_reports" = 1), "Wipe Reports")

	. += "<hr>"
	. += "<h2>Reports In Memory</h2>"
	. += "<i>Reports are listed from oldest to newest.</i>"
	. += build_report_table(reports, TRUE)

/obj/machinery/lot_security_system/proc/build_report_table(list/input, add_buttons = FALSE)
	. = list()
	. += "<table border='0' style='width:90%'>"
	. += "<tr>"
	. += "<th>Timestamp</th>"
	. += "<th>Perpetrator</th>"
	. += "<th>Offense</th>"
	. += "<th>Details</th>"
	. += "<th>Action Taken</th>"
	if(add_buttons)
		. += "<th>Actions</th>"
	. += "</tr>"
	var/i = 1
	for(var/thing in input)
		var/datum/lot_security_report/report = thing

		. += "<tr>"
		. += "<td>[report.timestamp]</td>"
		. += "<td>[report.perp]</td>"
		. += "<td>[report.offense]</td>"
		. += "<td>[report.details]</td>"
		. += "<td>[report.action_taken]</td>"
		if(add_buttons)
			. += "<td>"
			. += href(src, list("print_report" = REF(report)), "Print This Report")
			. += href(src, list("delete_report" = i), "Delete Report")
			. += "</td>"
		. += "</tr>"
		i++

	. += "</table>"

/obj/machinery/lot_security_system/Topic(href, href_list)
	if(..())
		return

	// Just some extra checks to ward off schannigans.
	var/mob/living/L = usr
	if(!istype(L))
		return
	if(!owner_uid)
		return
	var/obj/item/weapon/card/id/ID = L.GetIdCard()
	if(!istype(ID) || ID.unique_ID != owner_uid)
		to_chat(L, SPAN_WARNING("Access denied."))
		return

	if(href_list["set_ignore"])
		set_ignore(text2num(href_list["set_ignore"]))

	if(href_list["set_report"])
		set_report(text2num(href_list["set_report"]))

	if(href_list["toggle_bolts"])
		toggle_anchored()
		to_chat(L, SPAN_NOTICE("\The [src] is now [anchored ? "secured to the ground" : "able to be moved"]."))

	if(href_list["set_prevent"])
		set_prevent(text2num(href_list["set_prevent"]))

	if(href_list["toggle_security"])
		temporary_inactive = FALSE
		if(active)
			active = FALSE
			to_chat(L, SPAN_NOTICE("\The [src] has been disabled, until it is reactivated at a later time from the control panel."))
		else
			active = TRUE
			to_chat(L, SPAN_NOTICE("\The [src] is now active."))
		update_icon()

	if(href_list["toggle_temp_security"])
		active = TRUE
		if(!temporary_inactive)
			temporary_inactive = TRUE
			to_chat(L, SPAN_NOTICE("\The [src] is now disabled for the rest of the day. \
			It will re-enable itself afterwards, or the system can be re-engaged earlier from the settings panel."))
		else
			to_chat(L, SPAN_NOTICE("\The [src] is now active."))
			temporary_inactive = FALSE
		update_icon()

	if(href_list["accesses_window"])
		show_access_window(L)
		return

	if(href_list["toggle_access"])
		var/input_access = href_list["toggle_access"]
		var/converted_access = text2num(input_access)
		if(isnum(converted_access))
			input_access = converted_access
		if(isnull(input_access))
			return

		if(input_access in custom_access_exemptions)
			custom_access_exemptions -= input_access
		else
			custom_access_exemptions += input_access
		show_access_window(L)
		return // To stop the main window from layering over the access one.

	if(href_list["reports_window"])
		show_report_window(L)
		return

	if(href_list["wipe_all_reports"])
		if(alert(L, "Really delete all reports in storage? This cannot be undone.", "Report Wipe Confirmation", "No", "Yes") == "No")
			return
		reports.Cut()
		show_report_window(L)
		return

	if(href_list["delete_report"])
		var/index = text2num(href_list["delete_report"])
		if(!index)
			return
		if(alert(L, "Really delete this report? This cannot be undone.", "Report Delete Confirmation", "No", "Yes") == "No")
			return
		reports.Cut(index, index+1)
		show_report_window(L)
		return

	if(href_list["print_report"])
		var/list/input = locate(href_list["print_report"])
		if(istype(input, /datum/lot_security_report))
			input = list(input)
//		var/list/input = json_decode(href_list["print_record"])
//		var/list/input = params2list(href_list["print_record"])
		if(!LAZYLEN(input))
			return
//		var/i = 1
//		for(var/thing in input)
//			input[i] = locate(input[i])
//			i++
		var/obj/item/weapon/paper/P = new(get_turf(src))
		var/title = "[strip_improper(src.name)] Security Report"
		P.name = title

		var/list/html = list("<h1>[title]</h1><hr>")
		html += build_report_table(input)


		P.info = html.Join()
		playsound(src, "sound/effects/printer.ogg", 50, TRUE)

	if(href_list["factory_reset"])
		if(alert(L, "Really reset all settings and wipe this machine's memory? This cannot be undone.", "Factory Reset Confirmation", "No", "Yes") == "No")
			return
		factory_reset()

	// To refresh the UI.
	interact(usr)

/obj/machinery/lot_security_system/proc/enable()
	emped = FALSE
	update_icon()

/obj/machinery/lot_security_system/proc/is_active()
	if(emped)
		return FALSE
	if(!active)
		return FALSE
	var/area/A = get_area(src)
	if(A.security_system != src)
		return FALSE
	if(temporary_inactive)
		return FALSE
	return TRUE

/obj/machinery/lot_security_system/proc/add_to_area()
	if(!anchored)
		return
	var/area/A = get_area(src)
	if(istype(A, desired_area_type))
		A.security_system = src

/obj/machinery/lot_security_system/proc/remove_from_area()
	var/area/A = get_area(src)
	if(A.security_system == src)
		A.security_system = null

/obj/machinery/lot_security_system/proc/toggle_anchored()
	anchored = !anchored
	playsound(src, 'sound/items/drill_use.ogg', 25)
	if(anchored)
		add_to_area()
	else
		remove_from_area()


// Sets the bitflags to make the machine zap someone who does a specific bad thing.
/obj/machinery/lot_security_system/proc/set_prevent(security_flag)
	prevent_flags |= security_flag
	report_flags &= ~security_flag

// Ditto, but only reports/logs it.
/obj/machinery/lot_security_system/proc/set_report(security_flag)
	prevent_flags &= ~security_flag
	report_flags |= security_flag

// Makes the machine ignore something entirely.
/obj/machinery/lot_security_system/proc/set_ignore(security_flag)
	prevent_flags &= ~security_flag
	report_flags &= ~security_flag

// Adds a report to be saved and possibly shared with the police later.
/obj/machinery/lot_security_system/proc/add_report(datum/lot_security_report/report)
	LAZYADD(reports, report)
	// Delete the oldest log.
	truncate_oldest(reports, max_report_length)



// Returns TRUE if the machine should ignore what happened, e.g. it's the owner remodeling.
/obj/machinery/lot_security_system/proc/check_exemption(mob/living/baddie, security_flag)
	// Check to see if it's the owner. If so, just ignore.
	var/obj/item/weapon/card/id/ID = baddie.GetIdCard()
	if(ID?.unique_ID == owner_uid)
		return TRUE

	// Check if the 'baddie' has one of the accesses on their ID card.
	if(!istype(ID))
		return FALSE

	var/list/combined_access = innate_access_exemptions.Copy() + custom_access_exemptions.Copy()
	if(has_access(null, combined_access, ID.GetAccess()))
		return TRUE

	return FALSE

// Called when an object says that it's being used against a lot.
// Return TRUE if whatever caused this to get called should be interrupted (if the caller cares about that), FALSE otherwise.
/obj/machinery/lot_security_system/proc/respond_to_crime(mob/living/baddie, security_option_type, details)
	. = FALSE

	if(!is_active())
		return FALSE

	var/datum/lot_security_option/option = GLOB.all_lot_security_options[security_option_type]

	if(!option)
		return FALSE

	var/security_flag = option.id

	var/action_taken = "Logged."

	// Prevention.
	if(prevent_flags & security_flag)
		if(!istype(baddie)) // If we don't know who did it, we can't punish them, but we can log it anyways.
			action_taken = "Failed to retaliate: Unknown perpetrator."
		else if(check_exemption(baddie, security_flag))
			action_taken = "Logged (Exemption)"
		else if(option.cost > zap_power)
			action_taken = "Failed to retaliate: Insufficent charge."
		else
			zap_power -= option.cost
			zap_criminal(baddie)
			action_taken = "Retaliated."
			. = TRUE

	// Logging.
	if((prevent_flags|report_flags) & security_flag)
		// In the grim dark future, we will use ISO 8601.
		var/timestamp = "[get_game_year()]-[get_game_month()]-[get_game_day()]T[get_game_hour()]:[get_game_minute()]:[get_game_second()]"
		var/perp = null
		if(!baddie)
			perp = "N/A"
		else
			perp = baddie.name // This will show the baddie's false identity if one is being used, as it's not using `realname`.
/*
		var/list/new_report = list()
		new_report["timestamp"] = timestamp
		new_report["perp"] = perp
		new_report["offense"] = option.name
		new_report["details"] = details
		new_report["action_taken"] = action_taken
*/
		var/datum/lot_security_report/new_report = new(timestamp, perp, option.name, details, action_taken)
		add_report(new_report)


/obj/machinery/lot_security_system/proc/zap_criminal(mob/living/baddie)
	var/zap_damage = damage_to_criminals
	// Do double damage to non-humanoids. Fluff it as the system not holding back or something.
	// Otherwise it will cost a thousand or so credits to kill a spider.
	if(isanimal(baddie))
		zap_damage *= 2
	baddie.electrocute_act(damage_to_criminals, src, 1, BP_TORSO)
	baddie.Weaken(stun_to_criminals) // The electrocute_act should also stun, but just to be safe.

	playsound(baddie, 'sound/effects/lightningbolt.ogg', 75, TRUE)
	playsound(src, 'sound/machines/alarm4.ogg', 60, TRUE)
	Beam(baddie, "lightning[rand(1, 12)]", 'icons/effects/beam.dmi', 0.5 SECONDS, INFINITY)
	flick("[icon_state]_fire", src)

	baddie.visible_message(
		span("danger", "\The [baddie] was shocked by \the [get_area(src)]'s security system!"),
		span("danger", "You've been shocked by the security system!"),
		span("danger", "You hear an electric zap.")
	)
	log_and_message_admins("was zapped by \the [src] at \the [get_area(src)].", baddie)

/obj/machinery/lot_security_system/proc/factory_reset()
	owner_uid = null
	prevent_flags = 0
	report_flags = 0
	custom_access_exemptions = list()
	reports = list()


// Used to refill the security system. Orderable in the factory, and possibly can be manufactured later down the road.
// The 'proprietary electrical interface' is a fluff reason why you can't use these as batteries, or why you can't just use batteries in the ZEUS.
// Intellectual property is fun!
/obj/item/weapon/lot_security_charge
	name = "\improper Z.E.U.S. charge"
	desc = "A specialized power cell with a proprietary electrical interface, \
	intended exclusively for the Zone Electrified Unmanned Security system."
	icon = 'icons/obj/items.dmi'
	icon_state = "lot_security_charge"
	w_class = ITEMSIZE_NORMAL
	var/charge_amount = 1	// How many charges this restores to the security system.

/obj/item/weapon/lot_security_charge/five
	name = "\improper Z.E.U.S. charge (x5)"
	charge_amount = 5

/obj/item/weapon/lot_security_charge/ten
	name = "\improper Z.E.U.S. charge (x10)"
	charge_amount = 10

// Basic /atom proc that should be called when someone does something naughty.
// It relays the call to the security machine, if one exists, based on the area.
// Make sure this gets called by the 'victim' object, e.g. a window being hit,
// and not the object that's causing the issue.

// First parameter is who's doing the bad thing. This CAN be null if you don't want someone getting zapped but still want it to get logged.
// Second one is the type of `/datum/lot_security_option` that is relevant, e.g. `/datum/lot_security_option/vandalism` if someone is smashing a window.
// Third is a short description of what happened e.g. `\The [src] was hit by \the [W].`
/atom/proc/trigger_lot_security_system(mob/living/baddie, security_option_type, details)
	var/area/A = get_area(src)
	if(A)
		return A.trigger_lot_security_system(baddie, security_option_type, details)
	return FALSE // Wew nullspace.

/area
	var/obj/machinery/lot_security_system/security_system = null

// Tells the security machine that someone is being bad.
// Defined on the base area type instead of `/area/lots` in-case there is ever a need for these to be used outside those areas in the future.
/area/trigger_lot_security_system(mob/living/baddie, security_option_type, details)
	if(!security_system)
		return FALSE
	return security_system.respond_to_crime(baddie, security_option_type, details)

// Datums of options for the owner to configure the security system.
// The various datums are singletons, as only the bitflag on the machine is needed to store what the machine should stop.

GLOBAL_LIST_INIT(all_lot_security_options, init_subtypes_assoc(/datum/lot_security_option) )

/datum/lot_security_option
	var/id = null // Used as a bitflag for the setting being saved on the machine itself.
	var/name = null // Shown in the UI.
	var/desc = null // Ditto.
	var/cost = 0 // How much of the resource this machine uses will it take to prevent someone from doing this, as opposed to just logging it.

/datum/lot_security_option/graffiti
	id = LOT_SECURITY_STOP_GRAFFITI
	name = "Graffiti"
	desc = "Spraying or carving onto walls, as well as painting the walls, windows, and other objects a different color."
	cost = 1

/datum/lot_security_option/vandalism
	id = LOT_SECURITY_STOP_VANDALISM
	name = "Vandalism"
	desc = "Damaging walls, windows, doors, and other ways for someone to cause property damage, or enter unauthorized."
	cost = 1

/datum/lot_security_option/intrusion
	id = LOT_SECURITY_STOP_INTRUSION
	name = "Intrusion"
	desc = "More sophisticated methods of illicit access, such as hacking doors or brute-forcing a PIN."
	cost = 2

/datum/lot_security_option/theft
	id = LOT_SECURITY_STOP_THEFT
	name = "Theft"
	desc = "Accessing assets held inside of a machine or other secure container, such as stealing from cash registers."
	cost = 2

// Lightweight datum to hold onto reports generated by the lot security system.
/datum/lot_security_report
	var/timestamp = "NULL"
	var/perp = "NULL"
	var/offense = "NULL"
	var/details = "NULL"
	var/action_taken = "NULL"

/datum/lot_security_report/New(new_timestamp, new_perp, new_offense, new_details, new_action_taken)
	timestamp = new_timestamp
	perp = new_perp
	offense = new_offense
	details = new_details
	action_taken = new_action_taken