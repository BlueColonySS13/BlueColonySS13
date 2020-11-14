/datum/artifact_effect/precursor
	name = "precursor's knowledge"

/datum/artifact_effect/precursor/New()
	..()
	effect = EFFECT_TOUCH
	omegalevel = rand(0.230,0.333)
	effect_type = EFFECT_PSIONIC

/datum/artifact_effect/precursor/DoEffectTouch(var/mob/toucher)
	if(toucher)
		var/weakness = GetAnomalySusceptibility(toucher)
		if(iscarbon(toucher) && prob(weakness * 100))
			var/mob/living/carbon/C = toucher

			to_chat(C, "<span class='danger'>A wave of pain washes over your mind!</span>")

			var/lang = locate(/datum/language/precursor) in C.languages

			if(lang)
				C.adjustBrainLoss(0.25 * weakness)
			else
				C.add_language("Precursor")
				C.adjustBrainLoss(rand(1,3) * weakness)
		else
			to_chat(usr, "<span class='notice'>Nothing happens.</span>")
