var/datum/lore/numbers_station/numbers = new/datum/lore/numbers_station

/datum/lore/numbers_station
	var/delay_max = 5 MINUTES
	var/delay_min = 9 MINUTES
	var/backoff_delay = 5 MINUTES
	var/next_message
	var/force_mystery = 0
	var/message_type
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

	force_mystery = rand(1,50)

	if(force_mystery > 45)
		message_type = 4
	else
		message_type = rand(1,4)

	switch(message_type)
		if(1)//Numbers broadcast
			msg(pick("[pick(special)] [pick(numbers)], [pick(letters)], [pick(numbers)], [pick(special)]",
					 "[pick(numbers)], [pick(numbers)], [pick(numbers)], [pick(numbers)], [pick(numbers)], [pick(numbers)], [pick(numbers)]",
					 "[pick(letters)], [pick(letters)], [pick(letters)], [pick(letters)], [pick(letters)], [pick(letters)], [pick(letters)]",
					 "[pick(special)], [pick(special)], [pick(special)], [pick(special)], [pick(special)], [pick(special)], [pick(special)]",
					 "Whiskey Alpha Lima Lima",
					 "Sierra Tango Alpha November Delta"))
		if(2)//strange songs
			msg(pick("<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>Your web is strung and I'll take the bait....<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>",
				     "<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>Your trap is sprung now, so don't you hesitate.<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>",
				     "<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>Your cruelty festoons my fetid feelings...<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>",
				     "<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>Otherwise, why leave you here to die?<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>",
				     "<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>Everything that's born must die! And it isn't I, who made the world that way...<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>",
				     "<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>Don't let it grab you! It's in the cracks! Don't let it take you! It thinks you taste like snacks!<img class=icon src=\ref['icons/emoji.dmi'] iconstate='music_radio'>"))
		if(3)//messages from nowhere and neverweres
			msg(pick("Heightened tensions in Europia today as the Norfington guard approach.",
					 "Always use Coronal Displacement when lubricating. Not CD will leave you squeaky.",
					 "Death is too easy for them. I feel like you'll be a great dictator. I couldn't agree more.",
					 "I thought I was deranged. I guess we should go to Talamaha to see.",
					 "Stella? Hey, hey... Shh... I see you now.",
					 "It all started a long time ago in 2125. I was on a mining colony you see... on Mars!",
					 "My friends call me Salsa.",
					 "HONK!",
					 "Sqwuaaaak! It's loose!",
					 "Are we even alive? It's so cold.",
					 "I feel sick."))
		if(4)//the mystery
			msg(pick("Don't touch that dial now.",
				     "Tasty little morsels. They always walk around in my veins.",
				     "A wonderful day for a walk in the park.",
				     "Can't you see the thing in the walls?",
				     "It folded them up like a piece of paper. Astounding. Truly. I'll be shipping it away soon.",
				     "I don't think they'll ever know what happened. Their bones still cry.",
				     "The only name that matters is the one you choose. I've only just arrived to one myself.",
				     "The museum pieces are wonderful. Careful observation is all one really needs, hm?",
				     "I still hear the beating beneath the floorboards. Skittering all the damn time.",
				     "You have to do some digging. Dig deep in its belly and pull it out. Ah, there you go. Just like that.",
				     "Uranium fever got you down? Rave!"))
/*		if(5)//emotions
			msg(pick("!makes a sound but it is obscured by heavy static.",
					 "!emits a heavy droning noise.",
					 "!weeps.",
					 "!screams!",
					 "!moans in pain.",
					 "!growls.",
					 "!breathes heavily.",
					 "!coughs violently and retches. You hear thick, wet thuds on the ground.",
					 "!laughs. You hear the sound of snapping bones.",
					 "!broadcasts the sound of heavy thudding footsteps. Heavy wind can be heard in the background."))
*/
	return