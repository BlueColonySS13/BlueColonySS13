/datum/artifact_effect
	var/name = "unknown"
	var/effect = EFFECT_TOUCH
	var/effectrange = 4
	var/trigger = TRIGGER_TOUCH
	var/atom/holder
	var/activated = 0
	var/chargelevel = 0
	var/chargelevelmax = 10
	var/artifact_id = ""
	var/effect_type = 0
	var/omegalevel //How different from baseline reality is this object? 1 is baseline, 0 is completely unreal. No object will ever meet the extremes. 1 is suspiciously real and warrants investigation, 0 is reality-ending bad.

	var/contraband_level = CONTRABAND_ARTIFACTSBENIGN

/datum/artifact_effect/New(var/atom/location)
	..()
	holder = location
	effect = rand(0, MAX_EFFECT)
	trigger = rand(0, MAX_TRIGGER)

	//this will be replaced by the excavation code later, but it's here just in case
	artifact_id = "[pick("kappa","sigma","antaeres","beta","omicron","iota","epsilon","omega","gamma","delta","tau","alpha")]-[rand(100,999)]"
	omegalevel = rand(200, 999)/1000
	//random charge time and distance
	switch(pick(100;1, 50;2, 25;3))
		if(1)
			//short range, short charge time
			chargelevelmax = rand(3, 20)
			effectrange = rand(1, 3)
		if(2)
			//medium range, medium charge time
			chargelevelmax = rand(15, 40)
			effectrange = rand(5, 15)
		if(3)
			//large range, long charge time
			chargelevelmax = rand(20, 120)
			effectrange = rand(20, 200)

/datum/artifact_effect/proc/ToggleActivate(var/reveal_toggle = 1)
	//so that other stuff happens first
	spawn(0)
		if(activated)
			activated = 0
		else
			activated = 1
		if(reveal_toggle && holder)
			if(istype(holder, /obj/machinery/artifact))
				var/obj/machinery/artifact/A = holder
				if(!A.predefined)
					A.icon_state = "ano[A.icon_num][activated]"

			/*var/display_msg
			if(activated)
				display_msg = pick("momentarily glows brightly!","distorts slightly for a moment!","flickers slightly!","vibrates!","shimmers slightly for a moment!")
			else
				display_msg = pick("grows dull!","fades in intensity!","suddenly becomes very still!","suddenly becomes very quiet!")
			var/atom/toplevelholder = holder
			while(!istype(toplevelholder.loc, /turf))
				toplevelholder = toplevelholder.loc
			toplevelholder.visible_message("<font color='red'>\icon[toplevelholder] [toplevelholder] [display_msg]</font>")*/

/datum/artifact_effect/proc/DoEffectTouch(var/mob/user)
/datum/artifact_effect/proc/DoEffectAura(var/atom/holder)
/datum/artifact_effect/proc/DoEffectPulse(var/atom/holder)
/datum/artifact_effect/proc/UpdateMove()

/datum/artifact_effect/process()
	if(chargelevel < chargelevelmax)
		chargelevel++

	if(activated)
		if(effect == EFFECT_AURA)
			DoEffectAura()
		else if(effect == EFFECT_PULSE && chargelevel >= chargelevelmax)
			chargelevel = 0
			DoEffectPulse()

/datum/artifact_effect/proc/getAnomaly()
	. = "<b>"
	switch(effect_type)
		if(EFFECT_ENERGY)
			. += "Concentrated energy emission"
		if(EFFECT_PSIONIC)
			. += "Intermittent psionic wavefront"
		if(EFFECT_ELECTRO)
			. += "Electromagnetic energy"
		if(EFFECT_PARTICLE)
			. += "High frequency particle cluster"
		if(EFFECT_ORGANIC)
			. += "Organically reactive exotic particle cluster"
		if(EFFECT_BLUESPACE)
			. += "Interdimensional phasing"
		if(EFFECT_SYNTH)
			. += "Atomic synthesis"
		else
			. += "Low level energy emission"

	. += "</b> has been detected <b>"

	switch(effect)
		if(EFFECT_TOUCH)
			. += "interspersed throughout substructure and shell."
		if(EFFECT_AURA)
			. += "emitting in an ambient energy field."
		if(EFFECT_PULSE)
			. += "emitting in periodic bursts."
		else
			. += "emitting in an unknown way."

	. += "</b>"

/datum/artifact_effect/proc/getActivation()
	. = ""
	switch(trigger)
		if(TRIGGER_TOUCH)
			. += " Increase in anomalous activity detected while interfacting with Xenoarch Sapience Emulator. \
				Postulated activation index involves <b>physical interaction</b> with artifact surface."
		if(TRIGGER_WATER)
			. += " Increase in anomalous activity detected during water cycling. \
				Postulated activation index involves <b>underwater immersion or water contact</b> with artifact surface."
		if(TRIGGER_ACID)
			. += " Increase in anomalous activity detected during pH cycling. \
				Postulated activation index involves <b>immersion or acid contact</b> with artifact surface."
		if(TRIGGER_VOLATILE)
			. += " Increase in anomalous activity detected during volatile chemicals testing. \
				Postulated activation index involves <b>volatile chemical exposure</b> to artifact surface."
		if(TRIGGER_TOXIN)
			. += " Increase in anomalous activity detected during toxic chemicals testing. \
				Postulated activation index involves <b>toxic chemical exposure</b> to artifact surface."
		if(TRIGGER_FORCE)
			. += " Increase in anomalous activity detected during kinetic bombardment. \
				Postulated activation index involves <b>high kinetic interaction</b> with artifact surface."
		if(TRIGGER_ENERGY)
			. += " Increase in anomalous activity detected during electrosweep. \
				Postulated activation index involves <b>energetic interaction</b> with artifact surface."
		if(TRIGGER_HEAT)
			. += " Increase in anomalous activity detected under intense temperatures. \
				Postulated activation index involves <b>precise temperature interaction</b> with artifact surface."
		if(TRIGGER_COLD)
			. += " Increase in anomalous activity detected in low-kinetic environment simulation. \
				Postulated activation index involves <b>precise temperature interaction</b> with artifact surface."
		if(TRIGGER_PHORON, TRIGGER_OXY, TRIGGER_CO2, TRIGGER_NITRO)
			. += " Increase in anomalous activity detected during atmospheric simulation. \
				Postulated activation index involves <b>precise local atmospheric conditions</b>."
		else
			. += " Unable to determine any data about activation trigger."

/datum/artifact_effect/proc/getInternalScan()
	. = ""
	switch(effect_type)
		if(EFFECT_ENERGY)
			. += "Unknown energy fluctuations detected within internal structure of the object."
		if(EFFECT_PSIONIC)
			. += "Psionic fluctuations detected within internal structure of the object."
		if(EFFECT_ELECTRO)
			. += "Notable electromagnetic activity detected within internal structure of the object."
		if(EFFECT_PARTICLE)
			. += "High frequency particle emission detected within internal structure of the object."
		if(EFFECT_ORGANIC)
			. += "Organically reactive exotic particles detected permeating internal structure of the object."
		if(EFFECT_BLUESPACE)
			. += "Significant psi level deviation detected within internal structure of the object."
		if(EFFECT_SYNTH)
			. += "Fourth-dimensional restructuring matrix detected within internal structure of the object."
		else
			. += "Internal scan failure."

//returns 0..1, with 1 being no protection and 0 being fully protected
/proc/GetAnomalySusceptibility(var/mob/living/carbon/human/H)
	if(!istype(H))
		return 1

	var/protected = 0

	//absolute exclusion harnesses provide complete protection, anomaly suits give great protection, and excavation suits are almost as good
	if(istype(H.back,/obj/item/weapon/rig/hazmat))
		var/obj/item/weapon/rig/hazmat/rig = H.back
		if(rig.suit_is_deployed() && !rig.offline)
			protected += 1

	if(istype(H.wear_suit,/obj/item/clothing/suit/anomaly))
		protected += 0.7
	if(istype(H.wear_suit,/obj/item/clothing/head/anomaly))
		protected += 0.4

	if(istype(H.wear_suit,/obj/item/clothing/suit/bio_suit/anomaly))
		protected += 0.6
	else if(istype(H.wear_suit,/obj/item/clothing/suit/space/anomaly))
		protected += 0.5

	if(istype(H.head,/obj/item/clothing/head/bio_hood/anomaly))
		protected += 0.3
	else if(istype(H.head,/obj/item/clothing/head/helmet/space/anomaly))
		protected += 0.2

	//latex gloves, xenoarch jumpsuits, and science goggles also give a bit of bonus protection
	if(istype(H.w_uniform,/obj/item/clothing/under/rank/xenoarchaeologist))
		protected += 0.1

	if(istype(H.gloves,/obj/item/clothing/gloves/sterile))
		protected += 0.1

	if(istype(H.glasses,/obj/item/clothing/glasses/science))
		protected += 0.1

	return 1 - protected
