/******************************Lantern*******************************/

/obj/item/device/flashlight/lantern
	name = "lantern"
	icon_state = "lantern"
	desc = "A mining lantern."
	brightness_on = 6			// luminosity when on
	light_color = "FF9933" // A slight yellow/orange color.

/*****************************Pickaxe********************************/

/obj/item/weapon/pickaxe
	name = "mining drill"
	desc = "The most basic of mining drills, for short excavations and small mineral extractions."
	icon = 'icons/obj/items.dmi'
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 15.0
	throwforce = 4.0
	icon_state = "pickaxe"
	item_state = "jackhammer"
	w_class = ITEMSIZE_LARGE
	matter = list(DEFAULT_WALL_MATERIAL = 3750)
	digspeed = 40 //moving the delay to an item var so R&D can make improved picks. --NEO
	origin_tech = list(TECH_MATERIAL = 1, TECH_ENGINEERING = 1)
	attack_verb = list("hit", "pierced", "sliced", "attacked")
	var/drill_sound = 'sound/weapons/Genhit.ogg'
	var/drill_verb = "drilling"
	sharp = 1
	price_tag = 200
	var/excavation_amount = 200

/obj/item/weapon/pickaxe/hammer
	name = "sledgehammer"
	//icon_state = "sledgehammer" Waiting on sprite
	desc = "A mining hammer made of reinforced metal. You feel like smashing your boss in the face with this."

/obj/item/weapon/pickaxe/silver
	name = "silver pickaxe"
	icon_state = "spickaxe"
	item_state = "spickaxe"
	digspeed = 30
	origin_tech = list(TECH_MATERIAL = 3)
	desc = "This makes no metallurgic sense."

/obj/item/weapon/pickaxe/drill
	name = "advanced mining drill" // Can dig sand as well!
	icon_state = "handdrill"
	item_state = "jackhammer"
	digspeed = 30
	origin_tech = list(TECH_MATERIAL = 2, TECH_POWER = 3, TECH_ENGINEERING = 2)
	desc = "Yours is the drill that will pierce through the rock walls."
	drill_verb = "drilling"

/obj/item/weapon/pickaxe/jackhammer
	name = "sonic jackhammer"
	icon_state = "jackhammer"
	item_state = "jackhammer"
	digspeed = 20 //faster than drill, but cannot dig
	origin_tech = list(TECH_MATERIAL = 3, TECH_POWER = 2, TECH_ENGINEERING = 2)
	desc = "Cracks rocks with sonic blasts, perfect for killing cave lizards."
	drill_verb = "hammering"

/obj/item/weapon/pickaxe/gold
	name = "golden pickaxe"
	icon_state = "gpickaxe"
	item_state = "gpickaxe"
	digspeed = 20
	origin_tech = list(TECH_MATERIAL = 4)
	desc = "This makes no metallurgic sense."
	drill_verb = "picking"

/obj/item/weapon/pickaxe/plasmacutter
	name = "plasma cutter"
	icon_state = "plasmacutter"
	item_state = "gun"
	w_class = ITEMSIZE_NORMAL //it is smaller than the pickaxe
	damtype = "fire"
	digspeed = 20 //Can slice though normal walls, all girders, or be used in reinforced wall deconstruction/ light thermite on fire
	origin_tech = list(TECH_MATERIAL = 4, TECH_PHORON = 3, TECH_ENGINEERING = 3)
	desc = "A rock cutter that uses bursts of hot plasma. You could use it to cut limbs off of xenos! Or, you know, mine stuff."
	drill_verb = "cutting"
	drill_sound = 'sound/items/Welder.ogg'
	sharp = 1
	edge = 1

/obj/item/weapon/pickaxe/diamond
	name = "diamond pickaxe"
	icon_state = "dpickaxe"
	item_state = "dpickaxe"
	digspeed = 10
	origin_tech = list(TECH_MATERIAL = 6, TECH_ENGINEERING = 4)
	desc = "A pickaxe with a diamond pick head."
	drill_verb = "picking"

/obj/item/weapon/pickaxe/diamonddrill //When people ask about the badass leader of the mining tools, they are talking about ME!
	name = "diamond mining drill"
	icon_state = "diamonddrill"
	item_state = "jackhammer"
	digspeed = 5 //Digs through walls, girders, and can dig up sand
	origin_tech = list(TECH_MATERIAL = 6, TECH_POWER = 4, TECH_ENGINEERING = 5)
	desc = "Yours is the drill that will pierce the heavens!"
	drill_verb = "drilling"

/obj/item/weapon/pickaxe/borgdrill
	name = "enhanced sonic jackhammer"
	icon_state = "jackhammer"
	item_state = "jackhammer"
	digspeed = 15
	desc = "Cracks rocks with sonic blasts. This one seems like an improved design."
	drill_verb = "hammering"

/obj/item/weapon/pickaxe/steel
	name = "pickaxe"
	desc = "A pickaxe with a reinforced steel head."
	drill_verb = "picking"
	origin_tech = list(TECH_MATERIAL = 1, TECH_ENGINEERING = 1)
	icon_state = "stpickaxe"
	item_state = "syringe_0"
	digspeed = 45

/*****************************Shovel********************************/

/obj/item/weapon/shovel
	name = "shovel"
	desc = "A large tool for digging and moving dirt."
	icon = 'icons/obj/items.dmi'
	icon_state = "shovel"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 8.0
	throwforce = 4.0
	item_state = "shovel"
	w_class = ITEMSIZE_NORMAL
	origin_tech = list(TECH_MATERIAL = 1, TECH_ENGINEERING = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 500)
	attack_verb = list("bashed", "bludgeoned", "thrashed", "whacked")
	sharp = 0
	edge = 1
	digspeed = 40
	price_tag = 100

/obj/item/weapon/shovel/spade
	name = "spade"
	desc = "A small tool for digging and moving dirt."
	icon_state = "spade"
	item_state = "spade"
	force = 5.0
	throwforce = 7.0
	w_class = ITEMSIZE_SMALL
	digspeed = 60
	price_tag = 60

/**********************Mining car (Crate like thing, not the rail car)**************************/

/obj/structure/closet/crate/miningcar
	desc = "A mining car. This one doesn't work on rails, but has to be dragged."
	name = "Mining car (not for rails)"
	icon = 'icons/obj/storage.dmi'
	icon_state = "miningcar"
	density = 1
	icon_opened = "miningcaropen"
	icon_closed = "miningcar"

// Flags.

/obj/item/stack/flag
	name = "flags"
	desc = "Some colourful flags."
	singular_name = "flag"
	amount = 10
	max_amount = 10
	icon = 'icons/obj/mining.dmi'
	var/upright = 0
	var/base_state

/obj/item/stack/flag/New()
	..()
	base_state = icon_state

/obj/item/stack/flag/blue
	name = "blue flags"
	singular_name = "blue flag"
	icon_state = "blueflag"

/obj/item/stack/flag/red
	name = "red flags"
	singular_name = "red flag"
	icon_state = "redflag"

/obj/item/stack/flag/yellow
	name = "yellow flags"
	singular_name = "yellow flag"
	icon_state = "yellowflag"

/obj/item/stack/flag/green
	name = "green flags"
	singular_name = "green flag"
	icon_state = "greenflag"

/obj/item/stack/flag/attackby(obj/item/W as obj, mob/user as mob)
	if(upright && istype(W,src.type))
		src.attack_hand(user)
	else
		..()

/obj/item/stack/flag/attack_hand(user as mob)
	if(upright)
		upright = 0
		icon_state = base_state
		anchored = 0
		src.visible_message("<b>[user]</b> knocks down [src].")
	else
		..()

/obj/item/stack/flag/attack_self(mob/user as mob)

	var/obj/item/stack/flag/F = locate() in get_turf(src)

	var/turf/T = get_turf(src)
	if(!T || !istype(T,/turf/simulated/mineral))
		user << "The flag won't stand up in this terrain."
		return

	if(F && F.upright)
		user << "There is already a flag here."
		return

	var/obj/item/stack/flag/newflag = new src.type(T)
	newflag.amount = 1
	newflag.upright = 1
	anchored = 1
	newflag.name = newflag.singular_name
	newflag.icon_state = "[newflag.base_state]_open"
	newflag.visible_message("<b>[user]</b> plants [newflag] firmly in the ground.")
	src.use(1)

/******************************Sculpting*******************************/
/obj/item/weapon/pickaxe/autochisel
	name = "auto-chisel"
	icon_state = "jackhammer"
	item_state = "jackhammer"
	desc = "With an integrated AI chip and hair-trigger precision, this baby makes sculpting almost automatic!"

/obj/structure/sculpting_block
	name = "sculpting block"
	desc = "A finely chiselled sculpting block, it is ready to be your canvas."
	icon = 'icons/obj/mining.dmi'
	icon_state = "sculpting_block"
	density = 1
	opacity = 1
	anchored = 0
	var/sculpted = FALSE
	var/presculpted = FALSE
	var/mob/living/T
	var/times_carved = 0
	var/last_struck = 0

	var/apply_colors = list(
					    0.35, 0.3, 0.25,
					    0.35, 0.3, 0.25,
					    0.35, 0.3, 0.25
					)

	var/image_id = ""

	unique_save_vars = list("desc", "sculpted", "image_id") // colors should apply normally, i think

/obj/structure/sculpting_block/on_persistence_save()
	if(presculpted)
		return
	if(!image_id) // If it already has an image_id, it got saved before, so don't make duplicates.
		image_id = "[game_id]-[T ? T.name : ""][rand(34,299)]-[get_game_second()]"
		remove_pedestal()
		SSpersistence.save_image(getCompoundIcon(src), image_id, PERSISTENT_SCULPTURES_DIRECTORY, forcedir = null)
		add_pedestal()
	return ..()

/obj/structure/sculpting_block/on_persistence_load()
	if(presculpted)
		return
	if(image_id)
		icon = SSpersistence.load_image(image_id, PERSISTENT_SCULPTURES_DIRECTORY)

	add_pedestal()
	return ..()

/obj/structure/sculpting_block/verb/rotate()
	set name = "Rotate"
	set category = "Object"
	set src in oview(1)

	if (src.anchored || usr:stat)
		to_chat(usr, "It is fastened to the floor!")
		return 0
	src.set_dir(turn(src.dir, 90))
	return 1

/obj/structure/sculpting_block/attackby(obj/item/C as obj, mob/user as mob)

	if(istype(C, /obj/item/weapon/wrench))
		playsound(src.loc, C.usesound, 100, 1)
		to_chat(user, "<span class='notice'>You [anchored ? "un" : ""]anchor the [name].</span>")
		anchored = !anchored

	if (istype(C, /obj/item/weapon/pickaxe/autochisel))
		if(!sculpted || !presculpted)
			if(last_struck)
				return

			if(!T)
				var/list/choices = list()
				for(var/mob/living/M in view(7,user))
					choices += M
				T = input(user,"Who do you wish to sculpt?") as null|anything in choices
				user.visible_message("<span class='notice'>[user] begins sculpting.</span>",
					"<span class='notice'>You begin sculpting.</span>")

			var/sculpting_coefficient = get_dist(user,T)
			if(sculpting_coefficient <= 0)
				sculpting_coefficient = 1

			if(sculpting_coefficient >= 7)
				to_chat(user, "<span class='warning'>You hardly remember what [T] really looks like! Bah!</span>")
				T = null

			user.visible_message("<span class='notice'>[user] carves away at the sculpting block!</span>",
				"<span class='notice'>You continue sculpting.</span>")

			if(prob(25))
				playsound(user, 'sound/items/Screwdriver.ogg', 20, 1)
			else
				playsound(user, "sound/weapons/drill[rand(1,2)].ogg", 20, 1)
				spawn(3)
					playsound(user, "sound/weapons/drill[rand(1,2)].ogg", 20, 1)
					spawn(3)
						playsound(user, "sound/weapons/drill[rand(1,2)].ogg", 20, 1)

			last_struck = 1
			if(do_after(user,(20)))
				last_struck = 0
				if(times_carved <= 9)
					times_carved += 1
					if(times_carved < 1)
						to_chat(user, "<span class='notice'>You review your work and see there is more to do.</span>")
					return
				else
					sculpted = 1
					user.visible_message("<span class='notice'>[user] finishes sculpting their magnum opus!</span>",
						"<span class='notice'>You finish sculpting a masterpiece.</span>")


					make_statue(T)

					var/title = sanitize(input(usr, "If you would like to name your art, do so here.", "Christen Your Sculpture", "") as text|null)
					if(title)
						name = title
					else
						name = "*[T.name]*"
					var/legend = sanitize(input(usr, "If you would like to describe your art, do so here.", "Story Your Sculpture", "") as message|null)
					if(legend)
						desc = legend
					else
						desc = "This is a sculpture of [T.name]. All craftsmanship is of the highest quality. It is decorated with rock and more rock. It is covered with rock. On the item is an image of a rock. The rock is [T.name]."
			else
				last_struck = 0
		return

/obj/structure/sculpting_block/proc/make_statue(var/mob/living/T)
	appearance = T
	color = apply_colors
	pixel_y += 8

	add_pedestal()

/obj/structure/sculpting_block/proc/add_pedestal()
	if(presculpted)
		return

	remove_pedestal()

	var/image/pedestal_underlay = image('icons/obj/mining.dmi', icon_state = "pedestal")
	pedestal_underlay.appearance_flags = RESET_COLOR
	pedestal_underlay.pixel_y -= 8
	underlays += pedestal_underlay

/obj/structure/sculpting_block/proc/remove_pedestal()
	underlays.Cut()


/obj/structure/sculpting_block/sculpted
	presculpted = TRUE
	anchored = FALSE
	icon = 'icons/obj/statue.dmi'

/obj/structure/sculpting_block/sculpted/bust
	icon_state = "bust"
	name = "greek bust"
	desc = "A replica of a famous ancient art piece."


/obj/structure/sculpting_block/sculpted/large
	icon = 'icons/obj/statuelarge.dmi'
	icon_state = "pillar"
	plane = ABOVE_PLANE
	layer = ABOVE_MOB_LAYER

/obj/structure/sculpting_block/sculpted/large/pillar
	icon_state = "pillar"
	name = "marble pillar"
	desc = "A fine greek style pillar."

/obj/structure/sculpting_block/sculpted/large/lion
	icon_state = "lion"
	name = "golden lion"
	desc = "Looks like one of those chinese new year celebrations."

/obj/structure/sculpting_block/sculpted/large/venus
	icon_state = "venus"
	name = "statue of venus"
	desc = "The goddess takes form, where's her toolbox?"
