#define LOC_KITCHEN 0
#define LOC_FITNESS 1
#define LOC_CHAPEL 2
#define LOC_PARK 3
#define LOC_RESEARCH 4
#define LOC_SECURITY 5
#define LOC_CARGO 6
#define LOC_MEDICAL 7
#define LOC_CITYHALL 8

#define VERM_MICE 0
#define VERM_LIZARDS 1
#define VERM_SPIDERS 2

/datum/event/infestation
	announceWhen = 10
	endWhen = 11
	var/location
	var/locstring
	var/vermin
	var/vermstring

/datum/event/infestation/start()

	location = rand(0,8)
	var/list/turf/simulated/floor/turfs = list()
	var/spawn_area_type
	switch(location)
		if(LOC_KITCHEN)
			spawn_area_type = /area/crew_quarters/kitchen
			locstring = "the kitchen"
		if(LOC_FITNESS)
			spawn_area_type = /area/crew_quarters/fitness
			locstring = "fitness area"
		if(LOC_CHAPEL)
			spawn_area_type = /area/chapel/main
			locstring = "the chapel"
		if(LOC_PARK)
			spawn_area_type = /area/planets/Geminus/outdoor/park
			locstring = "the recreation area"
		if(LOC_RESEARCH)
			spawn_area_type = /area/rnd/research_foyer
			locstring = "the research facility"
		if(LOC_SECURITY)
			spawn_area_type = /area/security/main
			locstring = "the police department"
		if(LOC_CARGO)
			spawn_area_type = /area/quartermaster/storage
			locstring = "the supply terminal"
		if(LOC_MEDICAL)
			spawn_area_type = /area/medical/medbay2
			locstring = "the medical area"
		if(LOC_CITYHALL)
			spawn_area_type = /area/planets/Geminus/indoor/city_hall
			locstring = "the city hall"

	for(var/areapath in typesof(spawn_area_type))
		var/area/A = locate(areapath)
		for(var/turf/simulated/floor/F in A.contents)
			if(turf_clear(F))
				turfs += F

	var/list/spawn_types = list()
	var/max_number
	vermin = rand(0,2)
	switch(vermin)
		if(VERM_MICE)
			spawn_types = list(/mob/living/simple_mob/animal/passive/mouse/gray, /mob/living/simple_mob/animal/passive/mouse/brown, /mob/living/simple_mob/animal/passive/mouse/white)
			max_number = 12
			vermstring = "mice"
		if(VERM_LIZARDS)
			spawn_types = list(/mob/living/simple_mob/animal/passive/lizard)
			max_number = 6
			vermstring = "lizards"
		if(VERM_SPIDERS)
			spawn_types = list(/obj/effect/spider/spiderling)
			max_number = 3
			vermstring = "spiders"

	spawn(0)
		var/num = rand(2,max_number)
		while(turfs.len > 0 && num > 0)
			var/turf/simulated/floor/T = pick(turfs)
			turfs.Remove(T)
			num--

			if(vermin == VERM_SPIDERS)
				var/obj/effect/spider/spiderling/S = new(T)
				S.amount_grown = -1
			else
				var/spawn_type = pick(spawn_types)
				new spawn_type(T)


/datum/event/infestation/announce()
	//should it be announced in public? maybe, use global_announcer.autosay(warnmessage, "Pest Control", "Engineering")
	command_announcement.Announce("Bioscans indicate that [vermstring] have been breeding in [locstring]. Clear them out, before this starts to affect productivity.", "Vermin infestation")

#undef LOC_KITCHEN
#undef LOC_FITNESS
#undef LOC_CHAPEL
#undef LOC_PARK
#undef LOC_RESEARCH
#undef LOC_SECURITY
#undef LOC_CARGO
#undef LOC_MEDICAL
#undef LOC_CITYHALL

#undef VERM_MICE
#undef VERM_LIZARDS
#undef VERM_SPIDERS
