/obj/structure/flora
	layer = OBJ_LAYER
	plane = ABOVE_MOB_PLANE
	burn_state = 0 //Burnable
	burntime = SHORT_BURN




//bushes
/obj/structure/flora/bush
	name = "bush"
	icon = 'icons/obj/flora/snowflora.dmi'
	icon_state = "snowbush1"
	anchored = 1
	plane = MOB_PLANE

/obj/structure/flora/bush/New()
	..()
	icon_state = "snowbush[rand(1, 6)]"

/obj/structure/flora/pottedplant
	name = "potted plant"
	desc = "Really ties the room together."
	icon = 'icons/obj/plants.dmi'
	icon_state = "plant-26"


//newbushes

/obj/structure/flora/ausbushes
	name = "bush"
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "firstbush_1"
	anchored = 1
	plane = MOB_PLANE

/obj/structure/flora/ausbushes/attackby(obj/item/I as obj, mob/user as mob)
	..()
	if(is_sharp(I))
		to_chat(user, "You slash away [src] with [I].")
		qdel(src)

/obj/structure/flora/ausbushes/New()
	..()
	icon_state = "firstbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/reedbush
	icon_state = "reedbush_1"

/obj/structure/flora/ausbushes/reedbush/New()
	..()
	icon_state = "reedbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/leafybush
	icon_state = "leafybush_1"

/obj/structure/flora/ausbushes/leafybush/New()
	..()
	icon_state = "leafybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/palebush
	icon_state = "palebush_1"

/obj/structure/flora/ausbushes/palebush/New()
	..()
	icon_state = "palebush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/stalkybush
	icon_state = "stalkybush_1"

/obj/structure/flora/ausbushes/stalkybush/New()
	..()
	icon_state = "stalkybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/grassybush
	icon_state = "grassybush_1"

/obj/structure/flora/ausbushes/grassybush/New()
	..()
	icon_state = "grassybush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/fernybush
	icon_state = "fernybush_1"

/obj/structure/flora/ausbushes/fernybush/New()
	..()
	icon_state = "fernybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/sunnybush
	icon_state = "sunnybush_1"

/obj/structure/flora/ausbushes/sunnybush/New()
	..()
	icon_state = "sunnybush_[rand(1, 3)]"

/obj/structure/flora/ausbushes/genericbush
	icon_state = "genericbush_1"

/obj/structure/flora/ausbushes/genericbush/New()
	..()
	icon_state = "genericbush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/pointybush
	icon_state = "pointybush_1"

/obj/structure/flora/ausbushes/pointybush/New()
	..()
	icon_state = "pointybush_[rand(1, 4)]"

/obj/structure/flora/ausbushes/lavendergrass
	icon_state = "lavendergrass_1"

/obj/structure/flora/ausbushes/lavendergrass/New()
	..()
	icon_state = "lavendergrass_[rand(1, 4)]"

/obj/structure/flora/ausbushes/ywflowers
	icon_state = "ywflowers_1"

/obj/structure/flora/ausbushes/ywflowers/New()
	..()
	icon_state = "ywflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/brflowers
	icon_state = "brflowers_1"

/obj/structure/flora/ausbushes/brflowers/New()
	..()
	icon_state = "brflowers_[rand(1, 3)]"

/obj/structure/flora/ausbushes/ppflowers
	icon_state = "ppflowers_1"

/obj/structure/flora/ausbushes/ppflowers/New()
	..()
	icon_state = "ppflowers_[rand(1, 4)]"

/obj/structure/flora/ausbushes/sparsegrass
	icon_state = "sparsegrass_1"

/obj/structure/flora/ausbushes/sparsegrass/New()
	..()
	icon_state = "sparsegrass_[rand(1, 3)]"

/obj/structure/flora/ausbushes/fullgrass
	icon_state = "fullgrass_1"

/obj/structure/flora/ausbushes/fullgrass/New()
	..()
	icon_state = "fullgrass_[rand(1, 3)]"

/obj/structure/flora/skeleton
	name = "hanging skeleton model"
	icon = 'icons/obj/plants.dmi' //what an interesting plant
	icon_state = "hangskele"
	desc = "It's an anatomical model of a human skeletal system made of plaster."

/obj/structure/flora/worm1
	name = "polluxian sea worm fossil"
	icon = 'icons/obj/plants.dmi' //what an interesting plant
	icon_state = "worm1"
	desc = "It's an actual polluxian sea worm fossil, but its just a hatchling."

/obj/structure/flora/worm2
	name = "polluxian sea worm fossil"
	icon = 'icons/obj/plants.dmi' //what an interesting plant
	icon_state = "worm2"
	desc = "It's an actual polluxian sea worm fossil, but its just a hatchling."

/obj/structure/flora/velociraptor
	name = "velociraptor skeleton model"
	icon = 'icons/obj/plants.dmi' //what an interesting plant
	icon_state = "velociraptor"
	desc = "It's an anatomical model of a small Dromaeosaurid skeletal system made of fossilized bone."

/obj/structure/flora/naut1
	name = "Nautilus Fossil display"
	icon = 'icons/obj/plants.dmi' //what an interesting plant
	icon_state = "naut1"
	desc = "It's an  nautilius fossil of a large member of the Nautilidae."

/obj/structure/flora/naut2
	name = "Nautilus Fossil display "
	icon = 'icons/obj/plants.dmi' //what an interesting plant
	icon_state = "naut2"
	desc = "It's an  nautilius fossil of a large member of the Nautilidae."

/obj/structure/flora/naut3
	name = "Nautilus Fossil display "
	icon = 'icons/obj/plants.dmi' //what an interesting plant
	icon_state = "naut3"
	desc = "It's a nautilius fossil of a small member of the Nautilidae."

/obj/structure/flora/naut4
	name = "Nautilus Fossil display "
	icon = 'icons/obj/plants.dmi' //what an interesting plant
	icon_state = "naut4"
	desc = "It's a nautilius fossil of a small member of the Nautilidae."

//potted plants credit: Flashkirby
/obj/structure/flora/pottedplant
	name = "potted plant"
	desc = "Really brings the room together."
	icon = 'icons/obj/plants.dmi'
	icon_state = "plant-01"

	plane = ABOVE_MOB_PLANE

	var/obj/item/stored_item
	table_drag = TRUE

/obj/structure/flora/pottedplant/on_persistence_load()
	if(isemptylist(contents))
		return TRUE

	if(contents[1])
		stored_item = contents[1]

/obj/structure/flora/pottedplant/examine(mob/user)
	..()
	if(in_range(user, src) && stored_item)
		to_chat(user, "<i>You can see something in there...</i>")

/obj/structure/flora/pottedplant/attackby(obj/item/I, mob/user)
	if(stored_item)
		to_chat(user, "<span class='notice'>[I] won't fit in. There already appears to be something in here...</span>")
		return

	if(I.w_class > ITEMSIZE_SMALL)
		to_chat(user, "<span class='notice'>[I] is too big to fit inside [src].</span>")
		return

	if(do_after(user, 10))
		user.drop_from_inventory(I, src)
		I.forceMove(src)
		stored_item = I
		src.visible_message("\icon[src] \icon[I] [user] places [I] into [src].")
		return
	else
		to_chat(user, "<span class='notice'>You refrain from putting things into the plant pot.</span>")
		return



/obj/structure/flora/pottedplant/attack_hand(mob/user)
	if(!stored_item)
		to_chat(user, "<b>You see nothing of interest in [src]...</b>")
	else
		if(do_after(user, 10))
			to_chat(user, "You find \icon[stored_item] [stored_item] in [src]!")
			stored_item.forceMove(get_turf(src))
			stored_item = null
	..()

/obj/structure/flora/pottedplant/large
	name = "large potted plant"
	desc = "This is a large plant. Three branches support pairs of waxy leaves."
	icon_state = "plant-26"

/obj/structure/flora/pottedplant/fern
	name = "potted fern"
	desc = "This is an ordinary looking fern. It looks like it could do with some water."
	icon_state = "plant-02"

/obj/structure/flora/pottedplant/overgrown
	name = "overgrown potted plants"
	desc = "This is an assortment of colourful plants. Some parts are overgrown."
	icon_state = "plant-03"

/obj/structure/flora/pottedplant/bamboo
	name = "potted bamboo"
	desc = "These are bamboo shoots. The tops looks like they've been cut short."
	icon_state = "plant-04"

/obj/structure/flora/pottedplant/largebush
	name = "large potted bush"
	desc = "This is a large bush. The leaves stick upwards in an odd fashion."
	icon_state = "plant-05"

/obj/structure/flora/pottedplant/thinbush
	name = "thin potted bush"
	desc = "This is a thin bush. It appears to be flowering."
	icon_state = "plant-06"

/obj/structure/flora/pottedplant/mysterious
	name = "mysterious potted bulbs"
	desc = "This is a mysterious looking plant. Touching the bulbs cause them to shrink."
	icon_state = "plant-07"

/obj/structure/flora/pottedplant/smalltree
	name = "small potted tree"
	desc = "This is a small tree. It is rather pleasant."
	icon_state = "plant-08"

/obj/structure/flora/pottedplant/unusual
	name = "unusual potted plant"
	desc = "This is an unusual plant. It's bulbous ends emit a soft blue light."
	icon_state = "plant-09"
	light_range = 2
	light_power = 1
	light_color = "#33CCFF"

/obj/structure/flora/pottedplant/orientaltree
	name = "potted oriental tree"
	desc = "This is a rather oriental style tree. Its flowers are bright pink."
	icon_state = "plant-10"

/obj/structure/flora/pottedplant/smallcactus
	name = "small potted cactus"
	desc = "This is a small cactus. Its needles are sharp."
	icon_state = "plant-11"

/obj/structure/flora/pottedplant/tall
	name = "tall potted plant"
	desc = "This is a tall plant. Tiny pores line its surface."
	icon_state = "plant-12"

/obj/structure/flora/pottedplant/sticky
	name = "sticky potted plant"
	desc = "This is an odd plant. Its sticky leaves trap insects."
	icon_state = "plant-13"

/obj/structure/flora/pottedplant/smelly
	name = "smelly potted plant"
	desc = "This is some kind of tropical plant. It reeks of rotten eggs."
	icon_state = "plant-14"

/obj/structure/flora/pottedplant/small
	name = "small potted plant"
	desc = "This is a pot of assorted small flora. Some look familiar."
	icon_state = "plant-15"

/obj/structure/flora/pottedplant/aquatic
	name = "aquatic potted plant"
	desc = "This is apparently an aquatic plant. It's probably fake."
	icon_state = "plant-16"

/obj/structure/flora/pottedplant/shoot
	name = "small potted shoot"
	desc = "This is a small shoot. It still needs time to grow."
	icon_state = "plant-17"

/obj/structure/flora/pottedplant/flower
	name = "potted flower"
	desc = "This is a slim plant. Sweet smelling flowers are supported by spindly stems."
	icon_state = "plant-18"

/obj/structure/flora/pottedplant/crystal
	name = "crystalline potted plant"
	desc = "These are rather cubic plants. Odd crystal formations grow on the end."
	icon_state = "plant-19"

/obj/structure/flora/pottedplant/subterranean
	name = "subterranean potted plant"
	desc = "This is a subterranean plant. It's bulbous ends glow faintly."
	icon_state = "plant-20"
	light_range = 2
	light_power = 1
	light_color = "#FF6633"

/obj/structure/flora/pottedplant/minitree
	name = "potted tree"
	desc = "This is a miniature tree. Apparently it was grown to 1/5 scale."
	icon_state = "plant-21"

/obj/structure/flora/pottedplant/stoutbush
	name = "stout potted bush"
	desc = "This is a stout bush. Its leaves point up and outwards."
	icon_state = "plant-22"

/obj/structure/flora/pottedplant/drooping
	name = "drooping potted plant"
	desc = "This is a small plant. The drooping leaves make it look like its wilted."
	icon_state = "plant-23"

/obj/structure/flora/pottedplant/tropical
	name = "tropical potted plant"
	desc = "This is some kind of tropical plant. It hasn't begun to flower yet."
	icon_state = "plant-24"

/obj/structure/flora/pottedplant/dead
	name = "dead potted plant"
	desc = "This is the dried up remains of a dead plant. Someone should replace it."
	icon_state = "plant-25"

/obj/structure/flora/pottedplant/blueflower
	name = "blue flower plant"
	icon_state = "plant-26"

/obj/structure/flora/pottedplant/redflower
	name = "red flower plant"
	icon_state = "plant-27"

/obj/structure/flora/pottedplant/bigleafy
	name = "big leafy plant"
	icon_state = "plant-28"

/obj/structure/flora/pottedplant/fernyplant
	name = "ferny plant"
	icon_state = "plant-29"

/obj/structure/flora/pottedplant/winepalm
	name = "wine palm plant"
	icon_state = "plant-30"

/obj/structure/flora/pottedplant/lily
	name = "lily plant"
	icon_state = "plant-31"

/obj/structure/flora/pottedplant/greensakura
	name = "green sakura plant"
	icon_state = "plant-32"

/obj/structure/flora/pottedplant/brownsakura
	name = "brown sakura plant"
	icon_state = "plant-33"

/obj/structure/flora/pottedplant/pinksakura
	name = "pink sakura plant"
	icon_state = "plant-34"

/obj/structure/flora/pottedplant/purple
	name = "purple plant"
	icon_state = "plant-35"

/obj/structure/flora/pottedplant/decorative
	name = "decorative potted plant"
	desc = "This is a decorative shrub. It's been trimmed into the shape of an apple."
	icon_state = "applebush"

/obj/structure/flora/pottedplant/xmas
	name = "small christmas tree"
	desc = "This is a tiny well lit decorative christmas tree."
	icon_state = "plant-xmas"
	density = 1
	anchored = 0
	light_range = 2
	light_power = 1

/obj/structure/flora/pottedplant/xmas/large
	name = "large christmas tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_c"

/obj/structure/flora/pottedplant/mistletoe
	name = "mistletoe"
	desc = "Now, this REALLY brings the room together."
	icon_state = "mistletoe"

/obj/structure/flora/sif
	icon = 'icons/obj/flora/sifflora.dmi'

/obj/structure/flora/sif/subterranean
	name = "subterranean plant"
	desc = "This is a subterranean plant. It's bulbous ends glow faintly."
	icon_state = "glowplant"
	light_range = 2
	light_power = 1
	light_color = "#FF6633"

/obj/structure/flora/sif/subterranean/initialize()
	icon_state = "[initial(icon_state)][rand(1,2)]"
	. = ..()

/obj/structure/flora/sif/eyes
	name = "mysterious bulbs"
	desc = "This is a mysterious looking plant. They kind of look like eyeballs. Creepy."
	icon_state = "eyeplant"

/obj/structure/flora/sif/eyes/initialize()
	icon_state = "[initial(icon_state)][rand(1,3)]"
	. = ..()
