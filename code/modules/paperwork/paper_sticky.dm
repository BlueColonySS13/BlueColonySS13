/obj/item/sticky_pad
	name = "sticky note pad"
	desc = "A pad of densely packed sticky notes."
	color = COLOR_YELLOW
	icon = 'icons/obj/stickynotes.dmi'
	icon_state = "pad"
	item_state = "paper"
	w_class = ITEMSIZE_SMALL

	var/papers = 50
	var/written_text
	var/written_by
	var/paper_type = /obj/item/weapon/paper/sticky
	price_tag = 1

/obj/item/sticky_pad/poster
	name = "adhesive posters"
	icon_state = "poster"
	desc = "A pad of posters with a adhesive back to them."
	paper_type = /obj/item/weapon/paper/sticky/poster

/obj/item/sticky_pad/New()
	..()
	update_icon()

/obj/item/sticky_pad/update_icon()
	if(papers <= 15)
		icon_state = "[initial(icon_state)]_empty"
	else if(papers <= 50)
		icon_state = "[initial(icon_state)]_used"
	else
		icon_state = "[initial(icon_state)]_full"
	if(written_text)
		icon_state = "[icon_state]_writing"

/obj/item/sticky_pad/attackby(var/obj/item/weapon/thing, var/mob/user)
	if(istype(thing, /obj/item/weapon/pen))

		if(jobban_isbanned(user, "Graffiti"))
			to_chat(user, SPAN_WARNING("You are banned from leaving persistent information across rounds."))
			return

		var/writing_space = MAX_MESSAGE_LEN - length(written_text)
		if(writing_space <= 0)
			to_chat(user, SPAN_WARNING("There is no room left on \the [src]."))
			return
		var/text = sanitizeSafe(input("What would you like to write?") as text, writing_space)
		if(!text || thing.loc != user || (!Adjacent(user) && loc != user) || user.incapacitated())
			return
		user.visible_message(SPAN_NOTICE("\The [user] jots a note down on \the [src]."))
		written_by = user.ckey
		if(written_text)
			written_text = "[written_text] [text]"
		else
			written_text = text
		update_icon()
		return
	..()

/obj/item/sticky_pad/examine(var/mob/user)
	. = ..()
	if(.)
		to_chat(user, SPAN_NOTICE("It has [papers] sticky note\s left."))
		to_chat(user, SPAN_NOTICE("You can click it on grab intent to pick it up."))

/obj/item/sticky_pad/attack_hand(var/mob/user)
	if(user.a_intent == I_GRAB)
		..()
	else
		var/obj/item/weapon/paper/paper = new paper_type(get_turf(src))
		paper.set_content(written_text, "sticky note")
		paper.last_modified_ckey = written_by
		paper.color = color
		written_text = null
		user.put_in_hands(paper)
		to_chat(user, SPAN_NOTICE("You pull \the [paper] off \the [src]."))
		papers--
		if(papers <= 0)
			qdel(src)
		else
			update_icon()

/obj/item/sticky_pad/random/initialize()
	. = ..()
	color = pick(COLOR_WHITE, COLOR_YELLOW, COLOR_LIME, COLOR_CYAN, COLOR_ORANGE, COLOR_PINK)

/obj/item/sticky_pad/poster/random/initialize()
	. = ..()
	color = pick(COLOR_WHITE, COLOR_GRAY, COLOR_RED, COLOR_DARK_ORANGE, COLOR_PURPLE_GRAY, COLOR_CYAN_BLUE, COLOR_PALE_RED_GRAY)

/obj/item/weapon/paper/sticky
	name = "sticky note"
	desc = "Note to self: buy more sticky notes."
	icon = 'icons/obj/stickynotes.dmi'
	color = COLOR_YELLOW
	icon_state = "paper"
	slot_flags = 0

/obj/item/weapon/paper/sticky/initialize()
	. = ..()
	GLOB.moved_event.register(src, src, /obj/item/weapon/paper/sticky/proc/reset_persistence_tracking)

/obj/item/weapon/paper/sticky/proc/reset_persistence_tracking()
	SSpersistence.forget_value(src, /datum/persistent/paper/sticky)
//	pixel_x = 0
//	pixel_y = 0

/obj/item/weapon/paper/sticky/Destroy()
	reset_persistence_tracking()
	GLOB.moved_event.unregister(src, src)
	. = ..()

/obj/item/weapon/paper/sticky/update_icon()
	if(icon_state != scrap_state)
		icon_state = info ? "[initial(icon_state)]_words" : "[initial(icon_state)]"

// Copied from duct tape.
/obj/item/weapon/paper/sticky/attack_hand()
	. = ..()
	if(!istype(loc, /turf))
		reset_persistence_tracking()

/obj/item/weapon/paper/sticky/proc/track_value()
	SSpersistence.track_value(src, /datum/persistent/paper/sticky)

var/global/list/disallowed_sticky_items = list(/obj/item/weapon/storage, /obj/machinery/inventory_machine, /obj/machinery/door)

/obj/item/weapon/paper/sticky/afterattack(var/A, var/mob/user, var/flag, var/params)

	if(!in_range(user, A) || icon_state == scrap_state)
		return

	for(var/V in disallowed_sticky_items)
		if(istype(A, V))
			return

	var/turf/target_turf = get_turf(A)
	var/turf/source_turf = get_turf(user)

	var/dir_offset = 0
	if(target_turf != source_turf)
		dir_offset = get_dir(source_turf, target_turf)
		if(!(dir_offset in GLOB.cardinal))
			to_chat(user, SPAN_WARNING("You cannot reach that from here."))
			return

	if(user.unEquip(src, source_turf))
		track_value()
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


/obj/item/weapon/paper/sticky/poster
	name = "adhesive poster"
	desc = "Goodness, what is it saying now?"
	icon = 'icons/obj/stickynotes.dmi'
	icon_state = "poster"
	color = COLOR_WHITE
	scrap_state = "scrap_poster"


/obj/item/weapon/paper/sticky/poster/reset_persistence_tracking()
	SSpersistence.forget_value(src, /datum/persistent/paper/sticky/sticky_posters)

/obj/item/weapon/paper/sticky/poster/track_value()
	SSpersistence.track_value(src, /datum/persistent/paper/sticky/sticky_posters)