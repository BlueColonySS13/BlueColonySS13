datum/track
	var/title
	var/sound

datum/track/New(var/title_name, var/audio)
	title = title_name
	sound = audio

/obj/machinery/media/jukebox
	name = "Funkmaster 9000 jukebox"
	desc = "An immense, standalone touchscreen on a swiveling base, equipped with phased array speakers. Embossed on one corner of the ultrathin bezel is the brand name, 'Funkmaster 9000'."
	description_info = "Click the jukebox and then select a track on the interface. You can choose to play or stop the track, or set the volume. Use a wrench to attach or detach the jukebox to the floor. The room it is installed in must have power for it to operate!"
	description_fluff = "The Funkmaster 9000, putting a modern spin on the ancient retro curved plasmascreen design."
	description_antag = "Slide a cryptographic sequencer into the jukebox to overload its speakers. Instead of music, it'll produce a hellish blast of noise and explode!"
	icon = 'icons/obj/jukebox_new.dmi'
	icon_state = "jukebox3-nopower"
	var/state_base = "jukebox3"
	anchored = 0
	density = 1
	power_channel = EQUIP
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 100
	circuit = /obj/item/weapon/circuitboard/jukebox
	pixel_x = -8

	var/playing = 0
	var/volume = 20

	// Vars for hacking
	var/datum/wires/jukebox/wires = null
	var/hacked = 0 // Whether to show the hidden songs or not
	var/freq = 0

	table_drag = TRUE
	plane = ABOVE_MOB_PLANE

	var/datum/track/current_track
	var/list/datum/track/tracks = list(
		new/datum/track("Bluespace Ocean", 'sound/music/disco/Bluespace Ocean.ogg'),
		new/datum/track("Cyber Revolt", 'sound/music/disco/Cyber_Revolt.ogg'),
		new/datum/track("Displaced", 'sound/music/disco/Displaced.ogg'),
		new/datum/track("Electrified", 'sound/music/disco/Electrified.ogg'),
		new/datum/track("Hack or be Hacked", 'sound/music/disco/Hack_or_be_hacked.ogg'),
		new/datum/track("Hyper", 'sound/music/disco/Hyper.ogg'),
		new/datum/track("Lilium", 'sound/music/disco/Lilium.ogg'),
		new/datum/track("Moments In Love", 'sound/music/disco/Moments In Love.ogg'),
		new/datum/track("Psionic Souls", 'sound/music/disco/Psionic_souls.ogg'),
		new/datum/track("Scavenger Hideout", 'sound/music/disco/Scavenger_hideout.ogg'),
		new/datum/track("Sunyo", 'sound/music/disco/Sunyo.ogg'),
		new/datum/track("Syn", 'sound/music/disco/Syn.ogg'),
		new/datum/track("System Collapse", 'sound/music/disco/System_Collapse.ogg'),
		new/datum/track("This is Rain", 'sound/music/disco/This is Rain.ogg'),
		new/datum/track("VHS Dreams", 'sound/music/disco/vhsdreams.ogg'),
		new/datum/track("Spacedman", 'sound/music/disco/spacedman.ogg'),
		new/datum/track("Phortitude", 'sound/music/disco/phortitude.ogg'),
		new/datum/track("Nightchaser", 'sound/music/disco/nightchaser.ogg'),
		new/datum/track("The Man Who Sold the World", 'sound/music/disco/The Man Who Sold the World.ogg'),
		new/datum/track("Space Oddity", 'sound/music/disco/Space Oddity.ogg'),
		new/datum/track("The Place Where There Is No Darkness", 'sound/music/disco/The Place Where There Is No Darkness.ogg'),
		new/datum/track("Hikings Song", 'sound/music/disco/1984 The Hiking Song.ogg'),
		new/datum/track("Duel of the Fates", 'sound/music/disco/Duel of the Fates.ogg'),
		new/datum/track("The Bounty Hunter", 'sound/music/disco/The Mandalorian OST - Main Theme.ogg'),
		new/datum/track("The Rebel Path", 'sound/music/disco/The Rebel Path.ogg'),
		new/datum/track("Yacht Song", 'sound/music/disco/Yacht Song.ogg'),
	)

	// Only visible if hacked
	var/list/datum/track/secret_tracks = list(
		new/datum/track("The Forbidden One", 'sound/music/Despacito.ogg'),
		new/datum/track("The Sex Defender Shuffle", 'sound/music/disco/Sex Defender Shuffle.ogg'),
		new/datum/track("Play Me", 'sound/music/disco/Rick Astley.ogg')
	)

/obj/machinery/media/jukebox/New()
	..()
	default_apply_parts()
	wires = new/datum/wires/jukebox(src)
	update_icon()

/obj/machinery/media/jukebox/Destroy()
	StopPlaying()
	qdel(wires)
	wires = null
	..()

/obj/machinery/media/jukebox/proc/set_hacked(var/newhacked)
	if (hacked == newhacked) return
	hacked = newhacked
	if (hacked)
		tracks.Add(secret_tracks)
	else
		tracks.Remove(secret_tracks)
	updateDialog()

/obj/machinery/media/jukebox/attackby(obj/item/W as obj, mob/user as mob)
	src.add_fingerprint(user)

	if(default_deconstruction_screwdriver(user, W))
		return
	if(default_deconstruction_crowbar(user, W))
		return
	if(istype(W, /obj/item/weapon/wirecutters))
		return wires.Interact(user)
	if(istype(W, /obj/item/device/multitool))
		return wires.Interact(user)
	if(istype(W, /obj/item/weapon/wrench))
		if(playing)
			StopPlaying()
		user.visible_message("<span class='warning'>[user] has [anchored ? "un" : ""]secured \the [src].</span>", "<span class='notice'>You [anchored ? "un" : ""]secure \the [src].</span>")
		anchored = !anchored
		playsound(src, W.usesound, 50, 1)
		power_change()
		update_icon()
		return
	return ..()

/obj/machinery/media/jukebox/power_change()
	if(!powered(power_channel) || !anchored)
		stat |= NOPOWER
	else
		stat &= ~NOPOWER

	if(stat & (NOPOWER|BROKEN) && playing)
		StopPlaying()
	update_icon()

/obj/machinery/media/jukebox/update_icon()
	overlays.Cut()
	if(stat & (NOPOWER|BROKEN) || !anchored)
		if(stat & BROKEN)
			icon_state = "[state_base]-broken"
		else
			icon_state = "[state_base]-nopower"
		return
	icon_state = state_base
	if(playing)
		if(emagged)
			overlays += "[state_base]-emagged"
		else
			overlays += "[state_base]-running"
	if (panel_open)
		overlays += "panel_open"

/obj/machinery/media/jukebox/Topic(href, href_list)
	if(..() || !(Adjacent(usr) || istype(usr, /mob/living/silicon)))
		return

	if(!anchored)
		usr << "<span class='warning'>You must secure \the [src] first.</span>"
		return

	if(stat & (NOPOWER|BROKEN))
		usr << "\The [src] doesn't appear to function."
		return

	if(href_list["change_track"])
		for(var/datum/track/T in tracks)
			if(T.title == href_list["title"])
				current_track = T
				StartPlaying()
				break
	else if(href_list["stop"])
		StopPlaying()
	else if(href_list["play"])
		if(emagged)
			playsound(src.loc, 'sound/items/AirHorn.ogg', 100, 1)
			for(var/mob/living/carbon/M in ohearers(6, src))
				if(M.get_ear_protection() >= 2)
					continue
				M.sleeping = 0
				M.stuttering += 20
				M.ear_deaf += 30
				M.Weaken(3)
				if(prob(30))
					M.Stun(10)
					M.Paralyse(4)
				else
					M.make_jittery(500)
			spawn(15)
				explode()
		else if(current_track == null)
			usr << "No track selected."
		else
			StartPlaying()

	return 1

/obj/machinery/media/jukebox/interact(mob/user)
	if(stat & (NOPOWER|BROKEN))
		usr << "\The [src] doesn't appear to function."
		return

	ui_interact(user)

/obj/machinery/media/jukebox/ui_interact(mob/user, ui_key = "jukebox", var/datum/nanoui/ui = null, var/force_open = 1)
	var/title = "RetroBox - Space Style"
	var/data[0]

	if(!(stat & (NOPOWER|BROKEN)))
		data["current_track"] = current_track != null ? current_track.title : ""
		data["playing"] = playing

		var/list/nano_tracks = new
		for(var/datum/track/T in tracks)
			nano_tracks[++nano_tracks.len] = list("track" = T.title)

		data["tracks"] = nano_tracks

	// update the ui if it exists, returns null if no ui is passed/found
	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		// the ui does not exist, so we'll create a new() one
        // for a list of parameters and their descriptions see the code docs in \code\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "jukebox.tmpl", title, 450, 600)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()

/obj/machinery/media/jukebox/attack_ai(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/media/jukebox/attack_hand(var/mob/user as mob)
	interact(user)

/obj/machinery/media/jukebox/proc/explode()
	walk_to(src,0)
	src.visible_message("<span class='danger'>\the [src] blows apart!</span>", 1)

	explosion(src.loc, 0, 0, 1, rand(1,2), 1)

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(3, 1, src)
	s.start()

	new /obj/effect/decal/cleanable/blood/oil(src.loc)
	qdel(src)

/obj/machinery/media/jukebox/attackby(obj/item/W as obj, mob/user as mob)
	src.add_fingerprint(user)

	if(default_deconstruction_screwdriver(user, W))
		return
	if(default_deconstruction_crowbar(user, W))
		return
	if(istype(W, /obj/item/weapon/wrench))
		if(playing)
			StopPlaying()
		user.visible_message("<span class='warning'>[user] has [anchored ? "un" : ""]secured \the [src].</span>", "<span class='notice'>You [anchored ? "un" : ""]secure \the [src].</span>")
		anchored = !anchored
		playsound(src, W.usesound, 50, 1)
		power_change()
		update_icon()
		return
	return ..()

/obj/machinery/media/jukebox/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		emagged = 1
		StopPlaying()
		visible_message("<span class='danger'>\The [src] makes a fizzling sound.</span>")
		update_icon()
		return 1

/obj/machinery/media/jukebox/proc/StopPlaying()
	var/area/main_area = get_area(src)
	// Always kill the current sound
	for(var/mob/living/M in mobs_in_area(main_area))
		M << sound(null, channel = 1)

		main_area.forced_ambience = null
	playing = 0
	update_use_power(1)
	update_icon()


/obj/machinery/media/jukebox/proc/StartPlaying()
	StopPlaying()
	if(!current_track)
		return

	var/area/main_area = get_area(src)
	if(freq)
		var/sound/new_song = sound(current_track.sound, channel = 1, repeat = 1, volume = 15,)
		new_song.frequency = freq
		main_area.forced_ambience = list(new_song)
	else
		main_area.forced_ambience = list(current_track.sound)

	for(var/mob/living/M in mobs_in_area(main_area))
		if(M.mind)
			main_area.play_ambience(M)

	playing = 1
	update_use_power(2)
	update_icon()

// Advance to the next track - Don't start playing it unless we were already playing
/obj/machinery/media/jukebox/proc/NextTrack()
	if(!tracks.len) return
	var/curTrackIndex = max(1, tracks.Find(current_track))
	var/newTrackIndex = (curTrackIndex % tracks.len) + 1  // Loop back around if past end
	current_track = tracks[newTrackIndex]
	if(playing)
		StartPlaying()
	updateDialog()

// Advance to the next track - Don't start playing it unless we were already playing
/obj/machinery/media/jukebox/proc/PrevTrack()
	if(!tracks.len) return
	var/curTrackIndex = max(1, tracks.Find(current_track))
	var/newTrackIndex = curTrackIndex == 1 ? tracks.len : curTrackIndex - 1
	current_track = tracks[newTrackIndex]
	if(playing)
		StartPlaying()
	updateDialog()

/obj/machinery/media/jukebox/cyberpunk
	name = "Punkmaster 9077 jukebox"
	desc = "An immense, standalone touchscreen on a swiveling base, equipped with phased array speakers. Embossed on one corner of the ultrathin bezel is the brand name, 'Punkmaster 9077'."
	//description_info = "Click the jukebox and then select a track on the interface. You can choose to play or stop the track, or set the volume. Use a wrench to attach or detach the jukebox to the floor. The room it is installed in must have power for it to operate!"
	description_fluff = "The Punkmaster 9077, putting a modern spin on the ancient retro curved plasmascreen design."
	//description_antag = "Slide a cryptographic sequencer into the jukebox to overload its speakers. Instead of music, it'll produce a hellish blast of noise and explode!"
	//icon = 'icons/obj/jukebox_new.dmi'
	//icon_state = "jukebox3-nopower"
	//var/state_base = "jukebox3"
	circuit = /obj/item/weapon/circuitboard/jukebox/cyberpunk

	tracks = list(
		// STANDARD SONGS
		new/datum/track("Bluespace Ocean", 'sound/music/disco/Bluespace Ocean.ogg'),
		new/datum/track("Cyber Revolt", 'sound/music/disco/Cyber_Revolt.ogg'),
		new/datum/track("Displaced", 'sound/music/disco/Displaced.ogg'),
		new/datum/track("Electrified", 'sound/music/disco/Electrified.ogg'),
		new/datum/track("Hack or be Hacked", 'sound/music/disco/Hack_or_be_hacked.ogg'),
		new/datum/track("Hyper", 'sound/music/disco/Hyper.ogg'),
		new/datum/track("Psionic Souls", 'sound/music/disco/Psionic_souls.ogg'),
		new/datum/track("Scavenger Hideout", 'sound/music/disco/Scavenger_hideout.ogg'),
		new/datum/track("Sunyo", 'sound/music/disco/Sunyo.ogg'),
		new/datum/track("Syn", 'sound/music/disco/Syn.ogg'),
		new/datum/track("System Collapse", 'sound/music/disco/System_Collapse.ogg'),
		new/datum/track("This is Rain", 'sound/music/disco/This is Rain.ogg'),
		new/datum/track("VHS Dreams", 'sound/music/disco/vhsdreams.ogg'),
		new/datum/track("Spacedman", 'sound/music/disco/spacedman.ogg'),
		new/datum/track("Phortitude", 'sound/music/disco/phortitude.ogg'),
		new/datum/track("Nightchaser", 'sound/music/disco/nightchaser.ogg'),
		new/datum/track("The Man Who Sold the World", 'sound/music/disco/The Man Who Sold the World.ogg'),
		new/datum/track("Space Oddity", 'sound/music/disco/Space Oddity.ogg'),
		new/datum/track("The Place Where There Is No Darkness", 'sound/music/disco/The Place Where There Is No Darkness.ogg'),
		new/datum/track("Hikings Song", 'sound/music/disco/1984 The Hiking Song.ogg'),
		new/datum/track("Duel of the Fates", 'sound/music/disco/Duel of the Fates.ogg'),
		new/datum/track("The Bounty Hunter", 'sound/music/disco/The Mandalorian OST - Main Theme.ogg'),
		new/datum/track("The Rebel Path", 'sound/music/disco/The Rebel Path.ogg'),
		new/datum/track("Yacht Song", 'sound/music/disco/Yacht Song.ogg'),
		// 'RAVE' SONGS
		new/datum/track("Adrenalized", 'sound/music/disco/Adrenalized.ogg'),
		new/datum/track("All That I Need", 'sound/music/disco/All That I Need.ogg'),
		new/datum/track("Dopamine", 'sound/music/disco/Dopamine.ogg'),
		new/datum/track("It Went", 'sound/music/disco/It Went.ogg'),
		new/datum/track("Jurassic Park", 'sound/music/disco/Jurassic Park.ogg'),
		new/datum/track("Mr Vain", 'sound/music/disco/Mr Vain.ogg'),
		new/datum/track("Party With Us", 'sound/music/disco/Party With Us.ogg'),
		new/datum/track("Pit Stop", 'sound/music/disco/Pit Stop.ogg'),
		new/datum/track("Punch the Gas", 'sound/music/disco/Punch the Gas.ogg'),
		new/datum/track("Request", 'sound/music/disco/Request.ogg'),
		new/datum/track("Schadenfreude", 'sound/music/disco/Schadenfreude.ogg'),
		new/datum/track("Speechless", 'sound/music/disco/Speechless.ogg'),
		new/datum/track("Waifu", 'sound/music/disco/Waifu.ogg'),
		new/datum/track("When I Die", 'sound/music/disco/When I Die.ogg'),
		new/datum/track("You're My Superhero", 'sound/music/disco/You\'re My Superhero.ogg'),
		// CYBERPUNK 2077 OST SONGS
		new/datum/track("Chippin In-2022 Version", 'sound/music/disco/Chippin In-2022.ogg'),
		new/datum/track("Chippin In", 'sound/music/disco/Chippin In.ogg'),
		new/datum/track("A Like Supreme", 'sound/music/disco/Like A Supreme.ogg'),
		new/datum/track("Never Fade Away", 'sound/music/disco/Never Fade Away.ogg'),
		new/datum/track("The Ballad of Buck Ravers", 'sound/music/disco/The Ballad of Buck Ravers.ogg'),
		new/datum/track("Bells of Laguna Bend", 'sound/music/disco/Bells of Laguna Bend.ogg'),
		new/datum/track("Cyberwildlife Park", 'sound/music/disco/Cyberwildlife Park.ogg'),
		new/datum/track("Code Red Initiated", 'sound/music/disco/Code Red Initiated.ogg'),
		new/datum/track("Hole in the Sun", 'sound/music/disco/Hole in the Sun.ogg'),
		new/datum/track("I Really Want to Stay at Your House", 'sound/music/disco/I Really Want to Stay at Your House.ogg'),
		new/datum/track("GR4VES", 'sound/music/disco/GR4VES.ogg'),
		new/datum/track("Dinero", 'sound/music/disco/Dinero.ogg'),
		new/datum/track("Major Crimes", 'sound/music/disco/Major Crimes.ogg')
	)
