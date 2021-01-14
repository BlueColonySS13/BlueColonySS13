/obj/structure/curtain
	name = "curtain"
	icon = 'icons/obj/curtain.dmi'
	icon_state = "closed"
	layer = SHOWER_OPEN_LAYER
	plane = ABOVE_PLANE
	opacity = 1
	density = 0
	var/open_state = "open"
	var/closed_state = "closed"
	var/open = FALSE
	var/sheet_material = /obj/item/stack/material/cotton

	unique_save_vars = list("open")

/obj/structure/curtain/New()
	..()
	update_icon()

/obj/structure/curtain/on_persistence_load()
	update_icon()

/obj/structure/curtain/open
	open = TRUE

/obj/structure/curtain/bullet_act(obj/item/projectile/P, def_zone)
	if(!P.nodamage)
		visible_message("<span class='warning'>[P] tears [src] down!</span>")
		qdel(src)
	else
		..(P, def_zone)

/obj/structure/curtain/attack_hand(mob/user)
	playsound(get_turf(loc), "rustle", 15, 1, -5)
	toggle()
	..()

/obj/structure/curtain/proc/toggle()
	open = !open
	update_icon()

/obj/structure/curtain/update_icon()
	if(open)
		set_opacity(1)
		icon_state = closed_state
		layer = SHOWER_CLOSED_LAYER
	else
		set_opacity(0)
		icon_state = open_state
		layer = SHOWER_OPEN_LAYER

/obj/structure/curtain/attackby(obj/item/P, mob/user)

	if(istype(P, /obj/item/weapon/wirecutters))
		playsound(src, P.usesound, 50, 1)
		user << "<span class='notice'>You start to cut \the [src].</span>"
		if(do_after(user, 10))
			user << "<span class='notice'>You cut \the [src].</span>"
			var/obj/item/stack/material/A = new sheet_material( src.loc )
			A.amount = 3
			A.stack_color = color
			qdel(src)
		return

	if(istype(P, /obj/item/weapon/screwdriver))
		user.visible_message("<span class='warning'>[user] uses [P] on [src].</span>", "<span class='notice'>You use [P] on [src]</span>", "You hear rustling noises.")
		if(do_after(user, 10))
			anchored = !anchored
			to_chat(user, "<span class='notice'>You [anchored ? "screw" : "unscrewed"] [src] to the floor.</span>")

/obj/structure/curtain/black
	name = "black curtain"
	color = "#222222"

/obj/structure/curtain/medical
	name = "plastic curtain"
	color = "#B8F5E3"
	alpha = 200

/obj/structure/curtain/open/bed
	name = "bed curtain"
	color = "#854636"

/obj/structure/curtain/open/privacy
	name = "privacy curtain"
	color = "#B8F5E3"

/obj/structure/curtain/open/shower
	name = "shower curtain"
	color = "#ACD1E9"
	alpha = 200
	sheet_material = /obj/item/stack/material/plastic

/obj/structure/curtain/open/shower/engineering
	color = "#FFA500"

/obj/structure/curtain/open/shower/medical
	color = "#B8F5E3"

/obj/structure/curtain/open/shower/security
	color = "#AA0000"

//COLORS. We're freaky like that.

/obj/structure/curtain/color/beige
	color = COLOR_BEIGE
/obj/structure/curtain/open/color/beige
	color = COLOR_BEIGE

/obj/structure/curtain/color/red
	color = COLOR_RED_GRAY
/obj/structure/curtain/open/color/red
	color = COLOR_RED_GRAY

/obj/structure/curtain/color/pale_blue
	color = COLOR_PALE_BLUE_GRAY
/obj/structure/curtain/open/color/pale_blue
	color = COLOR_PALE_BLUE_GRAY

/obj/structure/curtain/color/green
	color = COLOR_GREEN_GRAY
/obj/structure/curtain/open/color/green
	color = COLOR_GREEN_GRAY

/obj/structure/curtain/color/lime
	color = COLOR_PALE_GREEN_GRAY
/obj/structure/curtain/open/color/lime
	color = COLOR_PALE_GREEN_GRAY

/obj/structure/curtain/color/pink
	color = COLOR_PALE_RED_GRAY
/obj/structure/curtain/open/color/pink
	color = COLOR_PALE_RED_GRAY

/obj/structure/curtain/color/purple
	color = COLOR_PURPLE_GRAY
/obj/structure/curtain/open/color/purple
	color = COLOR_PURPLE_GRAY

/obj/structure/curtain/color/orange
	color = COLOR_DARK_ORANGE
/obj/structure/curtain/open/color/orange
	color = COLOR_DARK_ORANGE

/obj/structure/curtain/color/yellow
	color = COLOR_BROWN
/obj/structure/curtain/open/color/yellow
	color = COLOR_BROWN

/obj/structure/curtain/color/brown
	color = COLOR_DARK_BROWN
/obj/structure/curtain/open/color/brown
	color = COLOR_DARK_BROWN

/obj/structure/curtain/color/burgandy
	color = "#4C0000"
/obj/structure/curtain/open/color/burgandy
	color = "#4C0000"

/obj/structure/curtain/color/forest
	color = "#204f13"
/obj/structure/curtain/open/color/forest
	color = "#204f13"


/obj/structure/curtain/blinds
	name = "blinds"
	desc = "What goes on behind these? Who knows. All people have secrets."
	icon_state = "blinds_closed"
	open_state = "blinds_open"
	closed_state = "blinds_closed"
	sheet_material = /obj/item/stack/material/plastic

/obj/structure/curtain/blinds/open
	icon_state = "blinds_open"
	layer = SHOWER_CLOSED_LAYER
	open = TRUE


#undef SHOWER_OPEN_LAYER
#undef SHOWER_CLOSED_LAYER
