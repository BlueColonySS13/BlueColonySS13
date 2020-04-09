/obj/machinery/artifact/alien_codex
	name = "precursor codex"
	desc = "A strange machine made of an unknown alloy."
	icon = 'icons/obj/xenoarchaeology32x64.dmi'
	icon_state = "codex"
	density = 1
	predefined = 1

/obj/machinery/artifact/alien_codex/New()
	var/effecttype = /datum/artifact_effect/precursor
	my_effect = new effecttype(src)
	my_effect.trigger = TRIGGER_TOUCH

	effecttype = /datum/artifact_effect/badfeeling
	secondary_effect = new effecttype(src)
	secondary_effect.trigger = TRIGGER_ENERGY
