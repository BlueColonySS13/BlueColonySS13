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

/obj/structure/mystery_point/Crossed(var/mob/living/L)
	if(!istype(L, /mob/living/carbon/human))
		return
	else
		illuminate(L)
		active = 0
		sleep(45 MINUTES)
		visible_message("<span class='alien'>Something has changed near you.</span>")
		active = 1
		..()

/obj/structure/mystery_point/proc/illuminate(var/mob/living/carbon/human/A)
	var/mob/living/carbon/human/O = A
	if(active)
		O.emote(pick("shiver"))
		mystery_type = rand(1,5)

		switch(mystery_type)
			if(1) //The rain dance
				to_chat(O, "<span class='alien'>Dance. Bring the rain.</span>")
				var/choice = alert("Do you want to dance?", "Rain Dance", "Yes", "No")
				switch(choice)
					if("Yes")
						visible_message("<b>[O]</b> dances furiously, looking up to the sky in anticipation.", "You dance furiously and look up at the sky in anticipation.")
						sleep(60 SECONDS)
						for(var/datum/planet/planet in SSplanets.planets)
							planet.weather_holder.change_weather(WEATHER_RAIN)
						for(var/mob/living/carbon/human/L in living_mob_list)
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
			if(5) //the best things in life
				var/choice = alert("You find a moment to reflect. What do you want most in life?", "Introspection", "Money", "Power", "Friendship", "Love")
				switch(choice)
					if("Money")
						to_chat(O, "<span class='alien'>You look at the ground under you and find a crisp 10 credit bill. Lucky!</span>")
						new /obj/item/weapon/spacecash/bundle/c10(loc)
					if("Power")
						to_chat(O, "<span class='alien'>Re-evaluate your pathetic life.</span>")
						lightning_strike(get_turf(usr), "Yes (Cosmetic)")
					if("Friendship")
						to_chat(O, "<span class='alien'>A friendly creature appears from upside and without you. You're not sure which direction that is.</span>")
						var/friend_type = rand(1,4)
						switch(friend_type)
							if(1)
								var/mob/living/simple_mob/animal/passive/dog/corgi/C = new /mob/living/simple_mob/animal/passive/dog/corgi(loc)
								C.name = "Friend"
								C.desc = "He looks like he's been wandering for a few days."
							if(2)
								var/mob/living/simple_mob/animal/passive/cow/C = new /mob/living/simple_mob/animal/passive/cow(loc)
								C.name = "Wonder Cow"
								C.desc = "A cow with a strange brand on its flank. You have the slightest suspicion that it can talk."
							if(3)
								var/mob/living/simple_mob/animal/passive/cat/C = new /mob/living/simple_mob/animal/passive/cat(loc)
								C.name = "Stray"
								C.desc = "This feline radiates authority. Be aware - You didn't find it. It found you."
							if(4)
								var/mob/living/simple_mob/animal/passive/mouse/M = new /mob/living/simple_mob/animal/passive/mouse(loc)
								M.name = "Stu"
								M.desc = "The most loyal of rodents."
					if("Love")
						to_chat(O, "<span class='alien'>You'll know when.</span>")
						var/obj/item/weapon/storage/trinketbox/T = new /obj/item/weapon/storage/trinketbox(loc)
						new /obj/item/clothing/gloves/ring/engagement(T)
