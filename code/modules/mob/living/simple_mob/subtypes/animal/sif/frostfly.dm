// Frostflies are large, flightless insects with glittering wings, used as a means of deploying their gaseous self-defense mechanism.
/mob/living/simple_mob/animal/sif/frostfly
	name = "frostfly"
	desc = "A large insect with glittering wings."
	tt_desc = "S Carabidae glacios"

	faction = "diyaab"

	icon_state = "firefly"
	icon_living = "firefly"
	icon_dead = "firefly_dead"
	icon_rest = "firefly_dead"
	icon = 'icons/mob/animal.dmi'
	has_eye_glow = TRUE

	maxHealth = 65
	health = 65

	pass_flags = PASSTABLE

	var/energy = 100
	var/max_energy = 100

	movement_cooldown = 0.5

	melee_damage_lower = 5
	melee_damage_upper = 10
	base_attack_cooldown = 1.5 SECONDS
	attacktext = list("nipped", "bit", "pinched")

	special_attack_cooldown = 5 SECONDS
	special_attack_min_range = 0
	special_attack_max_range = 4

	armor = list(
		"melee" = 20,
		"bullet" = 10,
		"laser" = 5,
		"energy" = 0,
		"bomb" = 10,
		"bio" = 100,
		"rad" = 100
		)

	// The frostfly's body is incredibly cold at all times, natural resistance to things trying to burn it.
	armor_soak = list(
		"melee" = 0,
		"bullet" = 0,
		"laser" = 15,
		"energy" = 0,
		"bomb" = 0,
		"bio" = 0,
		"rad" = 0
		)

	var/datum/effect/effect/system/smoke_spread/frost/smoke_special

	say_list_type = /datum/say_list/frostfly
	ai_holder_type = /datum/ai_holder/simple_mob/ranged/kiting/threatening/frostfly

/mob/living/simple_mob/animal/sif/frostfly/get_cold_protection()
	return 1	// It literally produces a cryogenic mist inside itself. Cold doesn't bother it.

/mob/living/simple_mob/animal/sif/frostfly/initialize()
	..()
	verbs += /mob/living/proc/ventcrawl
	verbs += /mob/living/proc/hide

/datum/say_list/frostfly
	speak = list("Zzzz.", "Kss.", "Zzt?")
	emote_see = list("flutters its wings","looks around", "rubs its mandibles")
	emote_hear = list("chitters", "clicks", "chirps")

	say_understood = list("Ssst.")
	say_cannot = list("Zzrt.")
	say_maybe_target = list("Ki?")
	say_got_target = list("Ksst!")
	say_threaten = list("Kszsz.","Kszzt...","Kzzi!")
	say_stand_down = list("Sss.","Zt.","! clicks.")
	say_escalate = list("Rszt!")

	threaten_sound = 'sound/effects/refill.ogg'
	stand_down_sound = 'sound/effects/sparks5.ogg'

/mob/living/simple_mob/animal/sif/frostfly/handle_special()
	..()

	if(energy < max_energy)
		energy++

/mob/living/simple_mob/animal/sif/frostfly/Stat()
	..()
	if(client.statpanel == "Status")
		statpanel("Status")
		if(emergency_shuttle)
			var/eta_status = emergency_shuttle.get_status_panel_eta()
			if(eta_status)
				stat(null, eta_status)
		stat("Energy", energy)

/mob/living/simple_mob/animal/sif/frostfly/should_special_attack(atom/A)
	if(energy >= 20)
		return TRUE
	return FALSE

/mob/living/simple_mob/animal/sif/frostfly/do_special_attack(atom/A)
	. = TRUE
	switch(a_intent)
		if(I_DISARM)
			if(energy < 20)
				return FALSE

			energy -= 20

			return FALSE

/datum/ai_holder/simple_mob/ranged/kiting/threatening/frostfly
	can_flee = TRUE
	dying_threshold = 0.5
	flee_when_outmatched = TRUE
	run_if_this_close = 3

/datum/ai_holder/simple_mob/ranged/kiting/threatening/frostfly/special_flee_check()
	var/mob/living/simple_mob/animal/sif/frostfly/F = holder
	if(F.energy < F.max_energy * 0.2)
		return TRUE
	return FALSE

/datum/ai_holder/simple_mob/ranged/kiting/threatening/frostfly/pre_special_attack(atom/A)
	if(isliving(A))
		holder.a_intent = I_DISARM
	else
		holder.a_intent = I_HURT

/datum/ai_holder/simple_mob/ranged/kiting/threatening/frostfly/post_ranged_attack(atom/A)
	var/mob/living/simple_mob/animal/sif/frostfly/F = holder
	if(istype(A,/mob/living))
		var/new_dir = turn(F.dir, -90)
		if(prob(50))
			new_dir = turn(F.dir, 90)
		holder.IMove(get_step(holder, new_dir))
		holder.face_atom(A)

	F.energy = max(0, F.energy - 1)	// The AI will eventually flee.

