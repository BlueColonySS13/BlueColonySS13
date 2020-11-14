/client/verb/trapped()
	set name = "I'm Trapped!"
	set category = "OOC"
	set desc = "Teleports you back to Geminus if you end up in Nullspace."

	var/voided = usr.loc
	if(istype(usr, /mob/living))
		if(voided)
			to_chat(usr, "<span class='warning'>This verb can only be used if you are in Nullspace!</span>")
		else if(!voided)
			to_chat(usr, "<span class='notice'>You feel a guiding hand pull you out of the void and find yourself back in the city.</span>")
			usr.x = 291
			usr.y = 57
			usr.z = 2
	else
		to_chat(usr, "<span class='warning'>This verb can only be used by living mobs! If you are a ghost, please use the Teleport or Follow verb!</span>")
