/obj/structure/mystery_point
	name = "mystery point"
	desc = "When the stars align and the correct offering is brought, mysterious things happen here."
	invisibility = 100
	icon = 'icons/turf/redspace.dmi'
	icon_state = "mystery"
	anchored = TRUE
	density = FALSE
	var/active = 1
	var/mystery_type = 1

/obj/structure/mystery_point/process()
	var/turf/current_location = get_turf(src)
	for(var/A in current_location)
		if(active)
			if(istype(A, /mob/living/carbon/human))
				illuminate(A)
				active = 0
				sleep(45 MINUTES)
				visible_message("<span class='alien'>Something has changed near you.</span>")
				active = 1


/obj/structure/mystery_point/proc/illuminate(var/mob/living/carbon/human/A)
	var/mob/living/carbon/human/O = A
	if(active)
		O.emote(pick("shiver"))
		mystery_type = rand(1,3)

		switch(mystery_type)

			if(1) //The rain dance
				to_chat(O, "<span class='alien'>Dance. Bring the rain.</span>")
				var/choice = alert("Do you want to dance?", "Rain Dance", "Yes", "No")
				switch(choice)
					if("Yes")
						O.forcesay("!dances furiously, looking up to the sky in anticipation.")
						sleep(30 SECONDS)
						var/datum/planet/planet = /datum/planet/sif
						planet.weather_holder.change_weather(WEATHER_RAIN)
						for(var/mob/living/L in living_mob_list)
							to_chat(L, "<span class='alien'>Rain begins falling from the sky. Those clouds weren't there a second ago...</span>")
					if("No")
						to_chat(O, "<span class='alien'>Disappointing.</span>")

			if(2) //blast from the past
				var/lang = locate(/datum/language/precursor) in O.languages
				if(lang)
					to_chat(O, "<span class ='alien'>I thought you were one of them!</span>")
					playsound(src, 'sound/voice/human/gasp.ogg', 25)
				else
					illuminate(O)
			if(3) //owo what's this
				var/obj/item/weapon/paper/crumpled/bloody/P = new /obj/item/weapon/paper/crumpled/bloody(loc)
				var/paper_contents = rand(1,4)
				switch(paper_contents)
					if(1)
						P.info = "<I><font size = \"1\">please help</I></font>"
					if(2)
						P.info = "<I><B><center>STAY AWAY FROM THE WALLS ITS IN THE WALLS MOVE MOVE</center></I></B>"
					if(3)
						P.info = "<I><font size = \"1\">there are so many of us here</font></I>"
					if(4)
						P.info = "<I><font size = \"1\">lost track of time. take this. i hope it makes it through</font></I>"
			if(4) //terror
				to_chat(O, "<span class='alien'>No! It saw me, no!</span>")
				playsound(src, 'sound/voice/human/woman_scream.ogg', 25)
				sleep(2 SECONDS)
				playsound(src, 'sound/effects/bodyfall1.ogg', 25)
				sleep(2 SECONDS)
				playsound(src, 'sound/hallucinations/growl3.ogg', 25)