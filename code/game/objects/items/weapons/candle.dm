/obj/item/weapon/flame/candle
	name = "candle"
	desc = "a small pillar candle. Its specially-formulated fuel-oxidizer wax mixture allows continued combustion in airless environments."
	icon = 'icons/obj/candle.dmi'
	icon_state = "candle1"
	w_class = ITEMSIZE_TINY
	light_color = "#E09D37"
	var/wax = 2000

	unique_save_vars = list("wax", "wax_color")

	var/wax_color = COLOR_RED

	var/candle_base = ""
	var/candle_state = "candle"

	var/trash_state = /obj/item/trash/candle
	var/color_trash = TRUE

/obj/item/weapon/flame/candle/New()
	..()
	update_icon()

/obj/item/weapon/flame/candle/random/New()
	wax_color = pick(list(COLOR_WHITE, COLOR_BLACK, COLOR_DARK_GRAY, COLOR_RED, COLOR_ORANGE, COLOR_YELLOW, COLOR_GREEN, COLOR_BLUE, COLOR_VIOLET))
	..()

/obj/item/weapon/flame/candle/black
	wax_color = COLOR_BLACK

/obj/item/weapon/flame/candle/update_icon()
	overlays.Cut()
	if(candle_base)
		icon_state = candle_base
	else
		icon_state = null

	var/i = 1

	switch(wax)
		if(1500 to INFINITY)
			i = 1
		if(800 to 1500)
			i = 2
		else
			i = 3

	var/image/I = image(icon, "[candle_state][i]")
	I.color = wax_color
	overlays |= I

	if(lit)
		overlays |= image(icon, "[candle_state][i]_lit")

/obj/item/weapon/flame/candle/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.isOn()) //Badasses dont get blinded by lighting their candle with a welding tool
			light("<span class='notice'>\The [user] casually lights the [src] with [W].</span>")
	else if(istype(W, /obj/item/weapon/flame/lighter))
		var/obj/item/weapon/flame/lighter/L = W
		if(L.lit)
			light()
	else if(istype(W, /obj/item/weapon/flame/match))
		var/obj/item/weapon/flame/match/M = W
		if(M.lit)
			light()
	else if(istype(W, /obj/item/weapon/flame/candle))
		var/obj/item/weapon/flame/candle/C = W
		if(C.lit)
			light()


/obj/item/weapon/flame/candle/proc/light(var/flavor_text = "<span class='notice'>\The [usr] lights the [src].</span>")
	if(!wax)
		visible_message("<span class='notice'>\The [usr] struggles the light [src].</span>")
		return

	if(!lit)
		lit = TRUE
		visible_message(flavor_text)
		set_light(CANDLE_LUM)
		processing_objects.Add(src)

/obj/item/weapon/flame/candle/process()
	if(!lit)
		return
	wax--
	if(!wax)
		var/obj/item/trash/candle/candle_trash = new trash_state(src.loc)
		if(color_trash)
			candle_trash.color = wax_color

		if(istype(src.loc, /mob))
			src.dropped()
		qdel(src)

		lit = 0
		processing_objects.Remove(src)

	update_icon()
	if(istype(loc, /turf)) //start a fire if possible
		var/turf/T = loc
		T.hotspot_expose(700, 5)

/obj/item/weapon/flame/candle/attack_self(mob/user as mob)
	if(lit)
		lit = 0
		update_icon()
		set_light(0)

/obj/item/weapon/flame/candle/candelabra
	name = "candelabra"
	desc = "a small gold candelabra. The cups that hold the candles save some of the wax from dripping off, allowing the candles to burn longer."
	icon = 'icons/obj/candle.dmi'
	icon_state = "candelabra"
	w_class = ITEMSIZE_SMALL
	wax = 20000

	trash_state = /obj/item/trash/candle/candelabra_stand
	color_trash = FALSE
	candle_base = "candelabra_stand"

/obj/item/weapon/flame/candle/candelabra/random/New()
	wax_color = pick(list(COLOR_WHITE, COLOR_DARK_GRAY, COLOR_BLACK, COLOR_RED, COLOR_ORANGE, COLOR_YELLOW, COLOR_GREEN, COLOR_BLUE, COLOR_VIOLET))
	..()

/obj/item/weapon/flame/candle/candelabra/black
	wax_color = COLOR_BLACK

/obj/item/weapon/flame/candle/candelabra/update_icon()
	overlays.Cut()

	if(candle_base)
		icon_state = candle_base
	else
		icon_state = null

	if(wax == 0)
		var/image/I = image(icon, "candelabra_melted")
		I.color = wax_color
		overlays |= I

	else
		var/image/I = image(icon, "candelabra_wax")
		I.color = wax_color
		overlays |= I

		if(lit)
			overlays |= image(icon, "candelabra_lit")

/obj/item/weapon/flame/candle/everburn
	wax = 99999

/obj/item/weapon/flame/candle/everburn/initialize()
	. = ..()
	light("<span class='notice'>\The [src] mysteriously lights itself!.</span>")

/obj/item/weapon/flame/candle/candelabra/everburn
	wax = 99999

/obj/item/weapon/flame/candle/candelabra/everburn/initialize()
	. = ..()
	light("<span class='notice'>\The [src] mysteriously lights itself!.</span>")
