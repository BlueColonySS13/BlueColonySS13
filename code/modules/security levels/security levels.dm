//var/security_level = 0
//0 = code green
//1 = code blue
//2 = code red
//3 = code delta

//config.alert_desc_blue_downto
/var/datum/announcement/priority/security/security_announcement_up = new(do_log = 0, do_newscast = 1, new_sound = sound('sound/misc/notice1.ogg'))
/var/datum/announcement/priority/security/security_announcement_down = new(do_log = 0, do_newscast = 1)

/proc/set_security_level(var/level)

	var/datum/code_level/level_datum = security_levels[level]

	if(!level_datum)
		return

	var/current_sec_level = SSpersistent_options.get_persistent_option_value("security_level") // check what level we're on atm, if it's the same, disregard

	if(current_sec_level == level_datum.level)
		return

	var/escalation = TRUE

	if(current_sec_level > level_datum.level)
		escalation = FALSE

	// checks done, let's announce

	var/new_sound = sound('sound/misc/notice1.ogg')

	if(level_datum.level == SEC_LEVEL_DELTA)
		new_sound = sound('sound/effects/siren.ogg')

	if(escalation)
		security_announcement_up.Announce( SSpersistent_options.get_persistent_option_value(level_datum.upto), "Attention! City Security Elevated to [level_datum.name]", new_sound)
	else
		security_announcement_down.Announce( SSpersistent_options.get_persistent_option_value(level_datum.downto), "Attention! City Security Lowered to [level_datum.name]")

	SSpersistent_options.update_pesistent_option_value("security_level", level_datum.level)

	var/newlevel = level_datum.level
	for(var/obj/machinery/firealarm/FA in machines)
		if(FA.z in using_map.contact_levels)
			FA.set_security_level(newlevel)

	for(var/obj/machinery/status_display/FA in machines)
		if(FA.z in using_map.contact_levels)
			FA.on_alert_changed(newlevel)

	if(newlevel >= SEC_LEVEL_RED)
		atc.reroute_traffic(yes = 1) // Tell them fuck off we're busy.
	else
		atc.reroute_traffic(yes = 0)


/proc/get_security_level()
	var/current_sec_level = SSpersistent_options.get_persistent_option_value("security_level")

	for(var/S in security_levels)
		var/datum/code_level/CL = security_levels[S]
		if(CL.level == current_sec_level)
			return CL.code


/proc/num2seclevel(var/num)
	var/datum/code_level/CL = security_levels[num]

	if(CL)
		return CL.code

/proc/seclevel2num(var/seclevel)

	for(var/S in security_levels)
		var/datum/code_level/CL = security_levels[S]
		if(CL.code == lowertext(seclevel))
			return CL.level


/*DEBUG
/mob/verb/set_thing0()
	set_security_level(0)
/mob/verb/set_thing1()
	set_security_level(1)
/mob/verb/set_thing2()
	set_security_level(2)
/mob/verb/set_thing3()
	set_security_level(3)
*/

var/global/list/security_levels = list()

/hook/startup/proc/populate_security_levels()
	instantiate_security_levels()
	return 1

/proc/instantiate_security_levels()
	for(var/instance in subtypesof(/datum/code_level))
		var/datum/code_level/J = new instance
		security_levels[J.code] = J


/datum/code_level
	var/name = "Green"
	var/code = CODE_LEVEL_GREEN
	var/level = SEC_LEVEL_GREEN

	var/upto = "code_green"
	var/downto = "code_blue_down"

/datum/code_level/blue
	name = "Blue"
	code = CODE_LEVEL_BLUE
	level = SEC_LEVEL_BLUE

	upto = "code_blue"
	downto = "code_blue_down"

/datum/code_level/red
	name = "Red"
	code = CODE_LEVEL_RED
	level = SEC_LEVEL_RED

	upto = "code_red"
	downto = "code_red_down"


/datum/code_level/delta
	name = "Delta"
	code = CODE_LEVEL_DELTA
	level = SEC_LEVEL_DELTA

	upto = "code_delta"
	downto = "code_delta"