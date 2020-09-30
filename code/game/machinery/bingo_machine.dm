// A simple thing that announces random numbers and prints bingo cards.

/obj/machinery/bingo_machine
	name = "bingo announcer"
	desc = "A simple machine used to help automate running games of Bingo (the 75 ball variant). Is this a retirement home?"
	icon = 'icons/obj/bingo.dmi'
	icon_state = "bingo"
	density = TRUE
	anchored = FALSE
	maptext_x = 6
	maptext_y = 7
	var/list/potential_numbers = list()
	var/list/numbers_used = list()
	var/list/letter_to_color = list(
		"B" = "#66CCFF",
		"I" = "#DE4E28",
		"N" = "#FFFF00",
		"G" = "#66FF66",
		"O" = "#FF9933"
	)

/obj/machinery/bingo_machine/initialize(mapload)
	init_new_game()
	return ..()

/obj/machinery/bingo_machine/attack_hand(mob/living/user)
	interact(user)

/obj/machinery/bingo_machine/interact(mob/living/user)
	var/list/html = build_window(user)

	var/datum/browser/popup = new(user, "bingo_machine", "[src]", 340, 640, src)
	popup.set_content(html.Join())
	popup.open()

	onclose(user, "bingo_machine")

/obj/machinery/bingo_machine/proc/build_window(mob/user)
	. = list()
	. += "<h2>Settings</h2>"
	. += href(src, list("reset" = 1), "Restart Game")
	. += href(src, list("print_board" = 1), "Print Bingo Board")
	. += "<hr>"
	. += "Numbers called: [numbers_used.len]<br>"
	. += "Numbers remaining: [potential_numbers.len]<br>"
	. += href(src, list("next_number" = 1), "Call Next Number")
	. += "<h2>Numbers Called</h2>"
	for(var/number in numbers_used)
		. += "<font color='[letter_to_color[get_bingo_letter(number)]]'>[get_bingo_letter(number)] [number]<br>"

/obj/machinery/bingo_machine/Topic(href, href_list)
	if(..())
		return
	
	var/mob/living/L = usr
	if(!istype(L))
		return
	
	if(href_list["reset"])
		if(!numbers_used.len)
			to_chat(L, SPAN_WARNING("The game hasn't started yet and you want to restart?"))
			return
		
		if(alert(L, "Really abort the current game and start over?", "Restart Confirmation", "No", "Yes") == "No")
			return
		init_new_game()
		fake_say("Resetting state of game.")
	
	if(href_list["next_number"])
		get_next_number(potential_numbers)
	
	if(href_list["print_board"])
		var/obj/item/bingo_board/board = new(get_turf(src))
		board.dont_save = TRUE // So a billion boards don't accumulate over time.
		playsound(src, "sound/effects/printer.ogg", 50, TRUE)
	
	interact(L)
	


// Call to abort any game in progress and start a new one.
/obj/machinery/bingo_machine/proc/init_new_game()
	numbers_used = list()
	potential_numbers = list()
	// This may or may not be faster than the more obvious method but it probably doesn't matter too much.
	potential_numbers.len = 75
	for(var/i = 1 to 75)
		potential_numbers[i] = i

/obj/machinery/bingo_machine/proc/get_next_number(list/input_list)
	var/next_number = pick(input_list)
	potential_numbers -= next_number // So the machine doesn't announce the same number twice.
	numbers_used += next_number

	announce_next_number(next_number)

/obj/machinery/bingo_machine/proc/announce_next_number(next_number)
	var/letter = get_bingo_letter(next_number)
	var/message = "[letter] [next_number]"
	fake_say("<b>[message]</b>")
	message = replacetext(message, " ", "") // Trimming the whitespace.
	set_maptext(message, letter_to_color[letter])

/obj/machinery/bingo_machine/proc/set_maptext(input, color)
	maptext = "<span style='color:[color]; font-size:7pt'>[input]</span>"

/obj/machinery/bingo_machine/proc/fake_say(message)
	var/rendered = "\The [src] states, '[message]'."
	var/deaf_rendered = "\The [src] flashes on the screen, '[message]'."
	audible_message(rendered, deaf_rendered)

/obj/machinery/bingo_machine/proc/get_bingo_letter(input)
	switch(input)
		if(1 to 15)
			return "B"
		if(16 to 30)
			return "I"
		if(31 to 45)
			return "N"
		if(46 to 60)
			return "G"
		if(61 to 75)
			return "O"

