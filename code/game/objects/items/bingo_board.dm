#define GRID_SIZE 5
#define COLUMN_RANGE 15

/obj/item/bingo_board
	name = "bingo board"
	desc = "A 75-ball Bingo board, that can be used alongside a dauber to play Bingo."
	icon = 'icons/obj/bingo.dmi'
	icon_state = "bingo_card"
	var/list/bingo_grid = null // Initialized into a two dimensional array of 5x5.
	var/list/marked_coordinates = list() // Assoc list, with key being the coordinate marked in string storm, and value being the color of the mark.

/obj/item/bingo_board/initialize(mapload)
	bingo_grid = new /list(GRID_SIZE, GRID_SIZE)
	var/list/used_numbers = list()
	var/safety = 50
	for(var/i = 1 to GRID_SIZE) // X axis.
		for(var/j = 1 to GRID_SIZE) // Y axis.
			// Exception for the center of the board being the 'free' space.
			if(i == CEILING(GRID_SIZE / 2, 1) && j == CEILING(GRID_SIZE / 2, 1))
				bingo_grid[i][j] = "Free"
			else
				while(bingo_grid[i][j] == null)
					var/new_number = rand(1, COLUMN_RANGE) + ((j - 1) * COLUMN_RANGE)
					if(!(new_number in used_numbers))
						bingo_grid[i][j] = new_number
						used_numbers += new_number
						break
					if(safety <= 0)
						CRASH("Infinite loop prevention in bingo card generation.")
					safety--
	return ..()

/obj/item/bingo_board/examine(mob/user, distance)
	..()
	display_board(user)

/obj/item/bingo_board/attack_self(mob/user)
	display_board(user)

/obj/item/bingo_board/proc/display_board(mob/user)
	var/list/html = build_window(user)
	// Deliberately not using the browser datum to get the default black and white window.
	user << browse(html.Join(), "window=bingoboard")

/obj/item/bingo_board/proc/build_window(mob/user)
	. = list()
	. += "<head>"
	. += "<title>BINGO Card</title>"
	. += "</head>"
	. += "<center>"

	. += "<table border='0' style='width:90%'>"
	. += "<tr>"
	. += "<th style='width:20%'><h1><font color='#66CCFF'>B</font></h1></th>"
	. += "<th style='width:20%'><h1><font color='#DE4E28'>I</font></h1></th>"
	. += "<th style='width:20%'><h1><font color='#FFFF00'>N</font></h1></th>"
	. += "<th style='width:20%'><h1><font color='#66FF66'>G</font></h1></th>"
	. += "<th style='width:20%'><h1><font color='#FF9933'>O</font></h1></th>"
	. += "</tr>"
	for(var/i = 1 to GRID_SIZE)
		. += "<tr>"
		for(var/j = 1 to GRID_SIZE)
			if(marked_coordinates["[i],[j]"])
				var/mark_color = marked_coordinates["[i],[j]"]
				. += "<td style='background-color:[mark_color]'><center><font size='5' color='#FFFFFF'>"
				. += bingo_grid[i][j]
			else
				. += "<td><center><font size='5'>"
				. += href(src, list("mark" = 1, "x" = i, "y" = j), bingo_grid[i][j])
			. += "</font></center></td>"

		. += "</tr>"

	. += "</table>"
	. += "</center>"

/obj/item/bingo_board/Topic(href, href_list)
	if(..())
		return
	var/mob/living/L = usr
	if(!istype(L))
		return
	
	if(href_list["mark"])
		var/x_coord = text2num(href_list["x"])
		var/y_coord = text2num(href_list["y"])
		if(isnull(x_coord) || x_coord > GRID_SIZE || x_coord < 1)
			return
		if(isnull(y_coord) || y_coord > GRID_SIZE || y_coord < 1)
			return
		
		// Any crayon or subtype of crayon will work.
		var/obj/item/weapon/pen/crayon/C = L.is_holding_item_of_type(/obj/item/weapon/pen/crayon)

		if(!C)
			to_chat(L, SPAN_WARNING("You need to hold a dauber, or some other colored writing tool to mark your board."))
			return
		
		marked_coordinates["[x_coord],[y_coord]"] = C.shadeColour
		to_chat(L, SPAN_NOTICE("You place a [C.colourName] mark on [bingo_grid[x_coord][y_coord]]."))
		display_board(L) // To update the window.
	