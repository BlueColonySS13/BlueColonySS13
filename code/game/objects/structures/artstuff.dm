/////////////////
// NEW DEFINES //
/////////////////

/client
	var/viewingCanvas = 0 //If this is 1, as soon as client /TRIES/ to move the view resets.

///////////
// EASEL //
///////////

/obj/structure/easel
	name = "easel"
	desc = "only for the finest of art!"
	icon = 'icons/obj/artstuff.dmi'
	icon_state = "easel"
	density = 1
	var/obj/item/weapon/canvas/painting = null


//Adding canvases
/obj/structure/easel/attackby(var/obj/item/I, var/mob/user, params)
	if(istype(I, /obj/item/weapon/canvas))
		var/obj/item/weapon/canvas/C = I
		user.unEquip(C)
		painting = C
		C.loc = get_turf(src)
		C.layer = layer+0.1
		user.visible_message("<span class='notice'>[user] puts \the [C] on \the [src].</span>","<span class='notice'>You place \the [C] on \the [src].</span>")
		return

	..()


//Stick to the easel like glue
/obj/structure/easel/Move()
	var/turf/T = get_turf(src)
	..()
	if(painting && painting.loc == T) //Only move if it's near us.
		painting.loc = get_turf(src)
	else
		painting = null


//////////////
// CANVASES //
//////////////

#define AMT_OF_CANVASES	4 //Keep this up to date or shit will break.

//To safe memory on making /icons we cache the blanks..
var/global/list/globalBlankCanvases[AMT_OF_CANVASES]

/obj/item/weapon/canvas
	name = "11px by 11px canvas"
	desc = "Draw out your soul on this canvas! Only crayons can draw on it. Examine it to focus on the canvas."
	icon = 'icons/obj/artstuff.dmi'
	icon_state = "11x11"
	var/whichGlobalBackup = 1 //List index

	var/pixX			//last X of click
	var/pixY			//last Y of click

	var/image_id

	unique_save_vars = list("image_id", "desc") // makes the imagine persistent

/obj/item/weapon/canvas/on_persistence_save()
	if(!image_id) // If it already has an image_id, it got saved before, so don't make duplicates.
		image_id = "[game_id]-[rand(34,299)]-[get_game_second()]"
	SSpersistence.save_image(build_composite_icon(src), image_id, PERSISTENT_PAINTINGS_DIRECTORY)
	return ..()

/obj/item/weapon/canvas/on_persistence_load()
	if(image_id)
		icon = SSpersistence.load_image(image_id, PERSISTENT_PAINTINGS_DIRECTORY)
	return ..()

/obj/item/weapon/canvas/nineteenXnineteen
	name = "19px by 19px canvas"
	icon_state = "19x19"
	whichGlobalBackup = 2

/obj/item/weapon/canvas/twentythreeXnineteen
	name = "23px by 19px canvas"
	icon_state = "23x19"
	whichGlobalBackup = 3

/obj/item/weapon/canvas/twentythreeXtwentythree
	name = "23px by 23px canvas"
	icon_state = "23x23"
	whichGlobalBackup = 4


//Find the right size blank canvas
/obj/item/weapon/canvas/proc/getGlobalBackup()
	. = null
	if(globalBlankCanvases[whichGlobalBackup])
		. = globalBlankCanvases[whichGlobalBackup]
	else
		var/icon/I = icon(initial(icon),initial(icon_state))
		globalBlankCanvases[whichGlobalBackup] = I
		. = I



/obj/item/weapon/canvas/Click(location, control, params)
	..()
	//Click info
	var/list/mouse_control = params2list(params)

	if(mouse_control["icon-x"])
		pixX = text2num(mouse_control["icon-x"])

	if(mouse_control["icon-y"])
		pixY = text2num(mouse_control["icon-y"])

/obj/item/weapon/canvas/attack_hand(mob/user)
	if(anchored)
		return

	..()


//One pixel increments
/obj/item/weapon/canvas/attackby(var/obj/item/I, var/mob/user)

	if (istype(I, /obj/item/weapon/wrench))
		if(trigger_lot_security_system(user, /datum/lot_security_option/theft, "Attempted to unwrench [src] with \the [I]."))
			return

		playsound(src.loc, I.usesound, 50, 1)
		to_chat(user,"<span class='notice'>You begin to [anchored ? "loosen" : "tighten"] \the [src] to the wall...</span>")
		if (do_after(user, 40 * I.toolspeed))
			user.visible_message( \
				"[user] [anchored ? "loosens" : "tightens"] \the [src]'s casters.", \
				"<span class='notice'>You have [anchored ? "loosened" : "tightened"] \the [src]. It is [anchored ? "now secured" : "moveable"].</span>", \
				"You hear ratchet.")
			anchored = !anchored

	//Should always be true, otherwise you didn't click the object, but let's check because SS13~
	if(!pixY || !pixX)
		return

	var/icon/masterpiece = icon(icon,icon_state)
	//Cleaning one pixel with a soap or rag
	if(istype(I, /obj/item/weapon/soap) || istype(I, /obj/item/weapon/reagent_containers/glass/rag))
		//Pixel info created only when needed
		var/thePix = masterpiece.GetPixel(pixX,pixY)
		var/icon/Ico = getGlobalBackup()
		if(!Ico)
			qdel(masterpiece)
			return

		var/theOriginalPix = Ico.GetPixel(pixX,pixY)
		if(thePix != theOriginalPix) //colour changed
			DrawPixelOn(theOriginalPix,pixX,pixY)
		qdel(masterpiece)
		return

	//Drawing one pixel with a crayon
	if(istype(I, /obj/item/weapon/pen/crayon))
		var/obj/item/weapon/pen/crayon/C = I
		if(masterpiece.GetPixel(pixX, pixY)) // if the located pixel isn't blank (null))
			DrawPixelOn(C.shadeColour, pixX, pixY)
			playsound(loc, 'sound/items/drop/paper.ogg', 20, 1)
		return

	..()

//Clean the whole canvas
/obj/item/weapon/canvas/attack_self(var/mob/user)
	if(!user)
		return
	var/confirm = alert(src, "Would you like to clear the canvas?.", "Clear Canvas", "Yes", "No")
	if(confirm != "Yes")
		return

	var/icon/blank = getGlobalBackup()
	if(blank)
		//it's basically a giant etch-a-sketch
		icon = blank
		user.visible_message("<span class='notice'>[user] cleans the canvas.</span>","<span class='notice'>You clean the canvas.</span>")


/obj/item/weapon/canvas/afterattack(var/turf/A, var/mob/user, var/flag, var/params)

	if(!iswall(A))
		return

	var/turf/target_turf = A
	var/turf/source_turf = get_turf(user)

	var/dir_offset = 0
	if(target_turf != source_turf)
		dir_offset = get_dir(source_turf, target_turf)
		if(!(dir_offset in GLOB.cardinal))
			to_chat(user, SPAN_WARNING("You cannot reach that from here."))
			return

	if(user.unEquip(src, source_turf))
		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				pixel_x = text2num(mouse_control["icon-x"]) - 16
				if(dir_offset & EAST)
					pixel_x += 32
				else if(dir_offset & WEST)
					pixel_x -= 32
			if(mouse_control["icon-y"])
				pixel_y = text2num(mouse_control["icon-y"]) - 16
				if(dir_offset & NORTH)
					pixel_y += 32
				else if(dir_offset & SOUTH)
					pixel_y -= 32

#undef AMT_OF_CANVASES