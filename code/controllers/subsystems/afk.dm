SUBSYSTEM_DEF(afk_tracking)
	name = "Inactivity Tracking"
	wait = 600
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	priority = FIRE_PRIORITY_INACTIVITY

/datum/controller/subsystem/afk_tracking/Initialize(timeofday)
	. = ..()
	if(config.kick_inactive == 0)
		can_fire = FALSE

/datum/controller/subsystem/afk_tracking/fire() //This isn't great but it's lifted directly from the old ProcessScheduler afk tracker because I'm lazy
	for(var/I in GLOB.clients)
		var/client/C = I
		if(C.is_afk((config.kick_inactive MINUTES)))
			to_chat(C,"<span class='warning'>You have been inactive for more than [config.kick_inactive] minute\s and have been disconnected.</span>")
			var/information
	
			if(C.mob)
				if(ishuman(C.mob))
					var/job
					var/mob/living/carbon/human/H = C.mob
					var/datum/data/record/R = find_general_record("name", H.real_name)
					if(R)
						job = R.fields["real_rank"]
					if(!job && H.mind)
						job = H.mind.assigned_role
					if(!job && H.job)
						job = H.job
					if(job)
						information = " while [job]."

				else if(issilicon(C.mob))
					information = " while a silicon."

			var/adminlinks
			adminlinks = " (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[C.mob.x];Y=[C.mob.y];Z=[C.mob.z]'>JMP</a>|<A HREF='?_src_=holder;cryoplayer=\ref[C.mob]'>CRYO</a>)"

			log_and_message_admins("being kicked for AFK[information][adminlinks]", C.mob)

			qdel(C)
			
		CHECK_TICK