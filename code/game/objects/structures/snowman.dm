/obj/structure/snowman
	name = "snowman"
	icon = 'icons/obj/snowman.dmi'
	icon_state = "snowman"
	desc = "A happy little snowman smiles back at you!"
	var/tophat = 0
	anchored = 1

/obj/structure/snowman/attack_hand(mob/user as mob)
	if(user.a_intent == I_HURT)
		user << "<span class='notice'>In one hit, [src] easily crumples into a pile of snow. You monster.</span>"
		var/turf/simulated/floor/F = get_turf(src)
		if (istype(F))
			new /obj/item/stack/material/snow(F)
			if(tophat)
				new /obj/item/clothing/head/that(F)
		qdel(src)

/obj/structure/snowman/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/clothing/head/that))
		if(tophat == 0)
			src.icon_state = "[icon_state]-tophat"
			tophat = 1
			usr << "<span class = 'notice'>You put the tophat on the [name]. It looks quite dapper now.</span>"
			user.drop_item(W)
			qdel(W)
		else
			usr << "<span class = 'notice'>[name] already has a tophat!</span>"

/obj/structure/snowman/borg
	name = "snowborg"
	icon_state = "snowborg"
	desc = "A snowy little robot. It even has a monitor for a head."

/obj/structure/snowman/spider
	name = "snow spider"
	icon_state = "snowspider"
	desc = "An impressively crafted snow spider. Not nearly as creepy as the real thing."