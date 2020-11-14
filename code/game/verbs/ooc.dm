
/client/verb/ooc(msg as text)
	set name = "OOC"
	set category = "OOC"

	if(!can_speak_ooc(src, msg, "OOC", MUTE_OOC, /datum/client_preference/show_ooc, config.ooc_allowed))
		return

	log_ooc(msg, src)
	last_ooc_message = msg

	if(msg)
		handle_spam_prevention(MUTE_OOC, sent_message = msg)

	var/ooc_style = "everyone"
	if(holder && !holder.fakekey)
		ooc_style = "elevated"
		if(holder.rights & R_CBIA)
			ooc_style = "SSevents"
		if(holder.rights & R_MOD)
			ooc_style = "moderator"
		if(holder.rights & R_DEBUG)
			ooc_style = "developer"
		if(holder.rights & R_ADMIN)
			ooc_style = "admin"


	//The linkify span classes and linkify=TRUE below make ooc text get clickable chat href links if you pass in something resembling a url
	//YOG START - Yog OOC
	var/regex/ping = regex("@(\\w+)","g")//Now lets check if they pinged anyone
	if(ping.Find(msg))
		if((world.time - last_ping_time) < 30)
			to_chat(src,"<span class='danger'>You are pinging too much! Please wait before pinging again.</span>")
			return
		last_ping_time = world.time
	var/list/pinged = ping.group
	for(var/x in pinged)
		x = ckey(x)
	//YOGS END

	for(var/client/target in GLOB.clients)
		if(target.is_preference_enabled(/datum/client_preference/show_ooc))
			if(target.is_key_ignored(key)) // If we're ignored by this person, then do nothing.
				continue
			var/display_name = src.key
			if(holder)
				if(holder.fakekey)
					if(target.holder)
						display_name = "[holder.fakekey]/([src.key])"
					else
						display_name = holder.fakekey
			if(holder && !holder.fakekey && (holder.rights & R_ADMIN) && config.allow_admin_ooccolor && (src.prefs.ooccolor != initial(src.prefs.ooccolor))) // keeping this for the badmins
				to_chat(target, "<font color='[src.prefs.ooccolor]'><span class='ooc'>" + create_text_tag("ooc", "OOC:", target) + " <EM>[display_name]:</EM> <span class='message'>[msg]</span></span></font>")
			else
				to_chat(target, "<span class='ooc'><span class='[ooc_style]'>" + create_text_tag("ooc", "OOC:", target) + " <EM>[display_name]:</EM> <span class='message'>[msg]</span></span></span>")

			if(ckey(target.key) in pinged)
				var/sound/pingsound = sound('sound/items/bikehorn.ogg')
				pingsound.volume = 50
				pingsound.pan = 80
				SEND_SOUND(target,pingsound)


/client/verb/looc(msg as text)
	set name = "LOOC"
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	if(say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	if(!mob)
		return

	if(IsGuestKey(key))
		to_chat(src, "Guests may not use LOOC.")
		return

	msg = sanitize(msg)
	msg = emoji_parse(msg)
	if(!msg)
		return

	if(!can_speak_ooc(src, msg, "LOOC", MUTE_OOC, /datum/client_preference/show_looc, config.looc_allowed))
		return


	log_looc(msg,src)
	last_ooc_message = msg

	if(msg)
		handle_spam_prevention(MUTE_OOC)

	var/mob/source = mob.get_looc_source()
	var/turf/T = get_turf(source)
	if(!T) return
	var/list/in_range = get_mobs_and_objs_in_view_fast(T,world.view,0)
	var/list/m_viewers = in_range["mobs"]

	var/list/receivers = list() // Clients, not mobs.
	var/list/r_receivers = list()

	var/display_name = key
	if(holder && holder.fakekey)
		display_name = holder.fakekey
	if(mob.stat != DEAD)
		display_name = mob.name

	// Everyone in normal viewing range of the LOOC
	for(var/mob/viewer in m_viewers)
		if(viewer.client && viewer.client.is_preference_enabled(/datum/client_preference/show_looc))
			receivers |= viewer.client
		else if(istype(viewer,/mob/observer/eye)) // For AI eyes and the like
			var/mob/observer/eye/E = viewer
			if(E.owner && E.owner.client)
				receivers |= E.owner.client

	// Admins with RLOOC displayed who weren't already in
	for(var/client/admin in admins)
		if(!(admin in receivers) && admin.is_preference_enabled(/datum/client_preference/holder/show_rlooc))
			r_receivers |= admin

	// Send a message
	for(var/client/target in receivers)
		var/admin_stuff = ""

		if(target in admins)
			admin_stuff += "/([key])"

		to_chat(target, "<span class='ooc'><span class='looc'>" + create_text_tag("looc", "LOOC:", target) + " <EM>[display_name][admin_stuff]:</EM> <span class='message'>[msg]</span></span></span>")

	for(var/client/target in r_receivers)
		var/admin_stuff = "/([key])([admin_jump_link(mob, target.holder)])"

		to_chat(target, "<span class='ooc'><span class='looc'>" + create_text_tag("looc", "LOOC:", target) + " <span class='prefix'>(R)</span><EM>[display_name][admin_stuff]:</EM> <span class='message'>[msg]</span></span></span>")

/mob/proc/get_looc_source()
	return src

/mob/living/silicon/ai/get_looc_source()
	if(eyeobj)
		return eyeobj
	return src

/client/proc/can_speak_ooc(client, msg, ooc_type = "OOC", mute_verb = MUTE_OOC, show_preference = /datum/client_preference/show_ooc, toggle_option = config.ooc_allowed)

	if(say_disabled)	//This is here to try to identify lag problems
		to_chat(src, "<span class='warning'>Speech is currently admin-disabled.</span>")
		return


	if(!mob)	return
	if(IsGuestKey(key))
		to_chat(src, "Guests may not use [ooc_type].")
		return

	msg = sanitize(msg)
	msg = emoji_parse(msg)
	if(!msg)	return

	var/raw_msg = msg


	if((copytext(msg, 1, 2) in list(".",";","#","say")) || (findtext(lowertext(copytext(msg, 1, 5)), "say")))
		if(alert("Your message \"[raw_msg]\" looks like it was meant for in game communication, say it in OOC?", "Meant for OOC?", "No", "Yes") != "Yes")
			return

	if(!is_preference_enabled(show_preference))
		to_chat(src, "<span class='warning'>You have [ooc_type] muted.</span>")
		return

	if(!holder)
		if(!config.ooc_allowed)
			to_chat(src, "<span class='danger'>[ooc_type] is globally muted.</span>")
			return

		if(!config.allow_repeat_ooc_messages && (last_ooc_message == msg))
			to_chat(src, "<span class='danger'>Repeat [ooc_type] messages are disallowed, please edit your message. Last Message: \"[msg]\"</span>")
			return

		if(!config.dooc_allowed && (mob.stat == DEAD))
			to_chat(src, "<span class='danger'>[ooc_type] for dead mobs has been turned off.</span>")
			return

		if(prefs.muted & mute_verb)
			to_chat(src, "<span class='danger'>You cannot use [ooc_type] (muted).</span>")
			return
		if(findtext(msg, "byond://") && !config.allow_byond_links)
			to_chat(src, "<B>Advertising other servers is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to advertise in [ooc_type]: [msg]")
			message_admins("[key_name_admin(src)] has attempted to advertise in [ooc_type]: [msg]")
			return

		if((findtext(msg, "discord.gg") || findtext(msg, "discord.com/invite")) && !config.allow_discord_links)
			to_chat(src, "<B>Advertising discords is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to advertise a discord server in [ooc_type]: [msg]")
			message_admins("[key_name_admin(src)] has attempted to advertise a discord server in [ooc_type]: [msg]")
			return

		if((findtext(msg, "http://") || findtext(msg, "https://")) && !config.allow_url_links)
			to_chat(src, "<B>Posting external links is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to post a link in [ooc_type]: [msg]")
			message_admins("[key_name_admin(src)] has attempted to post a link in [ooc_type]: [msg]")
			return

	return 1

