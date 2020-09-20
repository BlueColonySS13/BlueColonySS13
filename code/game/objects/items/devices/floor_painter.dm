/obj/item/device/floor_painter
	name = "paint gun"
	icon = 'icons/obj/device.dmi'
	icon_state = "floor_painter"

	var/decal =        "remove all decals"
	var/paint_dir =    "precise"
	var/paint_colour = "#FFFFFF"

	var/color_picker = 0

	var/list/decals = list(
		"full tile" =         list("path" = /obj/effect/floor_decal/full, "coloured" = 1),
		"quarter-turf" =      list("path" = /obj/effect/floor_decal/corner, "precise" = 1, "coloured" = 1),
		"diagonal tile" =     list("path" = /obj/effect/floor_decal/corner/diagonal, "coloured" = 1),
		"hazard stripes" =    list("path" = /obj/effect/floor_decal/industrial/warning),
		"corner, hazard" =    list("path" = /obj/effect/floor_decal/industrial/warning/corner),
		"hatched marking" =   list("path" = /obj/effect/floor_decal/industrial/hatch, "coloured" = 1),
		"dotted outline" =    list("path" = /obj/effect/floor_decal/industrial/outline, "coloured" = 1),
		"loading sign" =      list("path" = /obj/effect/floor_decal/industrial/loading),
		"border floor" =      list("path" = /obj/effect/floor_decal/borderfloorwhite, "coloured" = 1),
		"plaque" =            list("path" = /obj/effect/floor_decal/plaque),
		"1" =                 list("path" = /obj/effect/floor_decal/sign),
		"2" =                 list("path" = /obj/effect/floor_decal/sign/two),
		"A" =                 list("path" = /obj/effect/floor_decal/sign/a),
		"B" =                 list("path" = /obj/effect/floor_decal/sign/b),
		"C" =                 list("path" = /obj/effect/floor_decal/sign/c),
		"D" =                 list("path" = /obj/effect/floor_decal/sign/d),
		"Ex" =                list("path" = /obj/effect/floor_decal/sign/ex),
		"M" =                 list("path" = /obj/effect/floor_decal/sign/m),
		"CMO" =               list("path" = /obj/effect/floor_decal/sign/cmo),
		"V" =                 list("path" = /obj/effect/floor_decal/sign/v),
		"Psy" =               list("path" = /obj/effect/floor_decal/sign/p),
		"remove all decals" = list("path" = /obj/effect/floor_decal/reset)
		)
	var/list/paint_dirs = list(
		"north" =       NORTH,
		"northwest" =   NORTHWEST,
		"west" =        WEST,
		"southwest" =   SOUTHWEST,
		"south" =       SOUTH,
		"southeast" =   SOUTHEAST,
		"east" =        EAST,
		"northeast" =   NORTHEAST,
		"precise" = 0
		)

	var/list/preset_colors = list(
		"beasty brown" = 	COLOR_BEASTY_BROWN,
		"blue" = 			COLOR_BLUE_GRAY,
		"civvie green" =   	COLOR_CIVIE_GREEN,
		"command blue" = 	COLOR_COMMAND_BLUE,
		"cyan" =        	COLOR_CYAN,
		"green" =      	COLOR_GREEN,
		"NT red" =   		COLOR_NT_RED,
		"orange" = 		COLOR_ORANGE,
		"pale orange" =   	COLOR_PALE_ORANGE,
		"red" = 			COLOR_RED,
		"sky blue" =   	COLOR_DEEP_SKY_BLUE,
		"titanium" =     	COLOR_TITANIUM,
		"hull blue" = 		COLOR_HULL,
		"violet" = 		COLOR_VIOLET,
		"white" =        	COLOR_WHITE,
		"black" =        	COLOR_BLACK,
		"yellow" =       	COLOR_AMBER,
		"wood" = 			WOOD_COLOR_GENERIC,
		"rich wood" = 		WOOD_COLOR_RICH,
		"pale wood" = 		WOOD_COLOR_PALE,
		"paler wood" = 	WOOD_COLOR_PALE2,
		"ebony wood" = 	WOOD_COLOR_BLACK,
		"chocolate wood" = 	WOOD_COLOR_CHOCOLATE,
		"wheat" = 		COLOR_WHEAT
		)


/obj/item/device/floor_painter/afterattack(var/atom/A, var/mob/user, proximity, params)
	if(!proximity)
		return

	add_fingerprint(user)

	if(color_picker)
		paint_colour = A.get_color()
		to_chat(usr, "<span class='notice'>You set \the [src] to paint with <font color='[paint_colour]'>a new colour</font>.</span>")
		return

	if(A.trigger_lot_security_system(user, /datum/lot_security_option/graffiti, "Painting \the [A] with \a [src]."))
		return

	var/obj/machinery/electronic_display_case/DC = A
	if(istype(DC))
		var/choice = input(user, "What do you wish to paint?") as null|anything in list("Glass", "Frame")
		if(choice == "Glass")
			DC.glass_color = paint_colour
			DC.update_icon()
		if(choice == "Frame")
			DC.frame_color = paint_colour
			DC.update_icon()
		return

	var/turf/simulated/wall/W = A
	if(istype(W))
		var/choice = input(user, "What do you wish to paint?") as null|anything in list("Wall","Stripe","Remove Stripe")
		if(choice == "Wall")
			W.paint_color = paint_colour
			W.update_icon()
		if(choice == "Stripe")
			W.stripe_color = paint_colour
			W.update_icon()
		if(choice == "Remove Stripe")
			W.stripe_color = null
			W.update_icon()
		return

	var/obj/structure/wall_frame/WF = A
	if(istype(WF))
		WF.color = paint_colour
		return

	var/obj/machinery/door/blast/gate/G = A
	if(istype(G))
		G.color = paint_colour
		return

	var/obj/machinery/door/window/DW = A
	if(istype(DW))
		DW.color = paint_colour
		return

	var/obj/structure/window/WD = A
	if(istype(WD))
		WD.color = paint_colour
		WD.material_color = paint_colour
		WD.update_icon()
		return

	var/obj/structure/fence/FE = A
	if(istype(FE))
		FE.color = paint_colour
		return

	var/obj/machinery/door/airlock/D = A
	if(istype(D))
		var/choice
		if(!D.paintable)
			to_chat(user, "<span class='warning'>You can't paint this airlock type.</span>")
			return
		if(D.paintable == AIRLOCK_PAINTABLE)
			choice = "Paint"
		else if(D.paintable == AIRLOCK_STRIPABLE)
			choice = "Stripe"
		else if(D.paintable == AIRLOCK_PAINTABLE|AIRLOCK_STRIPABLE)
			choice = input(user, "What do you wish to paint?") as null|anything in list("Paint","Stripe")
		if(user.incapacitated())
			return
		if(choice == "Paint")
			D.paint_airlock(paint_colour)
		else if(choice == "Stripe")
			D.stripe_airlock(paint_colour)
		return

	var/turf/simulated/floor/F = A
	if(!istype(F) || !F.flooring)
		to_chat(user, "<span class='warning'>\The [src] can only be used on floors, walls or certain airlocks.</span>")
		return

	if(!F.flooring || !F.flooring.can_paint || F.broken || F.burnt)
		to_chat(user, "<span class='warning'>\The [src] cannot paint \the [F.name].</span>")
		return

	var/list/decal_data = decals[decal]
	var/config_error
	if(!islist(decal_data))
		config_error = 1
	var/painting_decal
	if(!config_error)
		painting_decal = decal_data["path"]
		if(!ispath(painting_decal))
			config_error = 1

	if(config_error)
		to_chat(user, "<span class='warning'>\The [src] flashes an error light. You might need to reconfigure it.</span>")
		return

	if(F.decals && F.decals.len > 5 && painting_decal != /obj/effect/floor_decal/reset)
		to_chat(user, "<span class='warning'>\The [F] has been painted too much; you need to clear it off.</span>")
		return

	var/painting_dir = 0
	if(paint_dir == "precise")
		if(!decal_data["precise"])
			painting_dir = user.dir
		else
			var/list/mouse_control = params2list(params)
			var/mouse_x = text2num(mouse_control["icon-x"])
			var/mouse_y = text2num(mouse_control["icon-y"])
			if(isnum(mouse_x) && isnum(mouse_y))
				if(mouse_x <= 16)
					if(mouse_y <= 16)
						painting_dir = WEST
					else
						painting_dir = NORTH
				else
					if(mouse_y <= 16)
						painting_dir = SOUTH
					else
						painting_dir = EAST
			else
				painting_dir = user.dir
	else if(paint_dirs[paint_dir])
		painting_dir = paint_dirs[paint_dir]

	var/painting_colour
	if(decal_data["coloured"] && paint_colour)
		painting_colour = paint_colour

	playsound(get_turf(src), 'sound/effects/spray3.ogg', 30, 1, -6)
	new painting_decal(F, painting_dir, painting_colour)

/obj/item/device/floor_painter/attack_self(var/mob/user)
	var/choice = input("What do you wish to change?") as null|anything in list("Decal","Direction", "Colour", "Preset Colour")
	if(choice == "Decal")
		choose_decal()
	else if(choice == "Direction")
		choose_direction()
	else if(choice == "Colour")
		choose_colour()
	else if(choice == "Preset Colour")
		choose_preset_colour()
	else if(choice == "Mode")
		toggle_mode()

/obj/item/device/floor_painter/examine(mob/user)
	. = ..(user)
	to_chat(user, "It is configured to produce the '[decal]' decal with a direction of '[paint_dir]' using [paint_colour] paint.")

/obj/item/device/floor_painter/verb/choose_preset_colour()
	set name = "Choose Preset Colour"
	set desc = "Choose a paintgun colour."
	set category = "Object"
	set src in usr

	if(usr.incapacitated())
		return
	var/new_colour = input(usr, "Choose a colour.", "paintgun", paint_colour) as color|anything in preset_colors
	if(new_colour && new_colour != paint_colour)
		paint_colour = preset_colors[new_colour]
		to_chat(usr, "<span class='notice'>You set \the [src] to paint with <font color='[paint_colour]'>a new colour</font>.</span>")


/obj/item/device/floor_painter/verb/choose_colour()
	set name = "Choose Colour"
	set desc = "Choose a floor painter colour."
	set category = "Object"
	set src in usr

	if(usr.incapacitated())
		return
	var/new_colour = input(usr, "Choose a colour.", "Floor painter", paint_colour) as color|null
	if(new_colour && new_colour != paint_colour)
		paint_colour = new_colour
		to_chat(usr, "<span class='notice'>You set \the [src] to paint with <font color='[paint_colour]'>a new colour</font>.</span>")

/obj/item/device/floor_painter/verb/choose_decal()
	set name = "Choose Decal"
	set desc = "Choose a paintgun decal."
	set category = "Object"
	set src in usr

	if(usr.incapacitated())
		return

	var/new_decal = input("Select a decal.") as null|anything in decals
	if(new_decal && !isnull(decals[new_decal]))
		decal = new_decal
		to_chat(usr, "<span class='notice'>You set \the [src] decal to '[decal]'.</span>")

/obj/item/device/floor_painter/verb/choose_direction()
	set name = "Choose Direction"
	set desc = "Choose a paintgun direction."
	set category = "Object"
	set src in usr

	if(usr.incapacitated())
		return

	var/new_dir = input("Select a direction.") as null|anything in paint_dirs
	if(new_dir && !isnull(paint_dirs[new_dir]))
		paint_dir = new_dir
		to_chat(usr, "<span class='notice'>You set \the [src] direction to '[paint_dir]'.</span>")


/obj/item/device/floor_painter/verb/toggle_mode()
	set name = "Toggle Painter Mode"
	set desc = "Choose a paintgun mode."
	set category = "Object"
	set src in usr

	if(usr.incapacitated())
		return
	color_picker = !color_picker
	if(color_picker)
		to_chat(usr, "<span class='notice'>You set \the [src] to color picker mode, scanning colors off objects.</span>")
	else
		to_chat(usr, "<span class='notice'>You set \the [src] to painting mode.</span>")