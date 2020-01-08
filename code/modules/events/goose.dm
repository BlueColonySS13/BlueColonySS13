/datum/event/goose_is_loose
	endWhen = 1000
	var/list/geese = list()

/datum/event/goose_is_loose/start()
	//spawn them at the same place as carp
	var/list/possible_spawns = list()
	for(var/obj/effect/landmark/C in landmarks_list)
		if(C.name == "carpspawn")
			possible_spawns.Add(C)

	//25% chance for this to be a false alarm
	var/num
	if(prob(25))
		num = 0
	else
		num = rand(1,3)
	for(var/i=0, i<num, i++)
		var/mob/living/simple_animal/hostile/goose/D = new(get_turf(pick(possible_spawns)))
		geese.Add(D)

/datum/event/goose_is_loose/announce()
	return

/datum/event/goose_is_loose/end()
	return