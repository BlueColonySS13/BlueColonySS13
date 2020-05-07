var/datum/lore/numbers_station/numbers = new/datum/lore/numbers_station

/datum/lore/numbers_station
	var/delay_max = 5 MINUTES
	var/delay_min = 15 MINUTES
	var/backoff_delay = 5 MINUTES
	var/next_message
	var/force_chatter_type
//see air_traffic.dm to see what these variables do

/datum/lore/numbers_station/New()
	spawn(10 SECONDS) //Lots of lag at the start of a shift.
		msg("Romeo Echo Sierra Uniform Mike India November Golf...")
	next_message = world.time + rand(delay_min,delay_max)
	process()

/datum/lore/numbers_station/process()
	if(world.time >= next_message)
		next_message = world.time + rand(delay_min,delay_max)
		random_convo()

	spawn(1 MINUTE) //We don't really need high-accuracy here.
		process()

/datum/lore/numbers_station/proc/msg(var/message,var/sender)
	ASSERT(message)
	global_announcer.autosay("[message]", "unknown", "Unknown Broadcast Station")

/datum/lore/numbers_station/proc/random_convo()
	var/list/letters = list("Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliett", "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "X-ray", "Yankee","Zulu")
	var/list/numbers = list("One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen")
	var/list/special = list("Red", "Town", "City", "Earth", "Space", "Preceed", "Lines", "Maker", "Bull", "Mother", "Father", "Child", "Ocean", "Mist", "Devil", "Angel", "Cuba", "Melon", "Dwarf")

	msg(pick("[pick(special)] [pick(numbers)], [pick(letters)], [pick(numbers)], [pick(special)]",
			 "[pick(numbers)], [pick(numbers)], [pick(numbers)], [pick(numbers)], [pick(numbers)], [pick(numbers)], [pick(numbers)]",
			 "[pick(letters)], [pick(letters)], [pick(letters)], [pick(letters)], [pick(letters)], [pick(letters)], [pick(letters)]",
			 "[pick(special)], [pick(special)], [pick(special)], [pick(special)], [pick(special)], [pick(special)], [pick(special)]"))
	return