/datum/gm_action/dust
	name = "dust"
	departments = list(ROLE_ENGINEERING)
	chaotic = 10
	reusable = TRUE

/datum/gm_action/dust/announce()
	if(SSpersistent_options && SSpersistent_options.get_persistent_option_value("protect_meteor_proofing"))
		command_announcement.Announce("Debris resulting from activity on another nearby asteroid have been destroyed pre-emptively.", "Dust Alert")
		end()
		return
	command_announcement.Announce("Debris resulting from activity on another nearby asteroid is approaching your colony.", "Dust Alert")

/datum/gm_action/dust/get_weight()
	var/engineers = metric.count_people_in_department(ROLE_ENGINEERING)
	var/weight = 30 + (engineers * 25)
	return weight

/datum/gm_action/dust/start()
	..()
	dust_swarm("norm")