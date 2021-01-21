// Different types of fish! They are all subtypes of this tho
/mob/living/simple_mob/animal/passive/fish
	name = "fish"
	desc = "Its a fishy.  No touchy fishy."
	icon = 'icons/mob/fish.dmi'
	item_state = "fish"

	mob_size = MOB_SMALL
	// So fish are actually underwater.
	plane = TURF_PLANE
	layer = UNDERWATER_LAYER

	holder_type = /obj/item/weapon/holder/fish
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/carpmeat/fish
	var/return_timer = 0 // After a certain time underwater, fish will disappear.

	// By default they can be in any water turf.  Subtypes might restrict to deep/shallow etc
	var/global/list/suitable_turf_types =  list(
		/turf/simulated/floor/beach/water,
		/turf/simulated/floor/beach/coastline,
		/turf/simulated/floor/holofloor/beach/water,
		/turf/simulated/floor/holofloor/beach/coastline,
		/turf/simulated/floor/water
	)

// Makes the AI unable to willingly go on land.
/mob/living/simple_mob/animal/passive/fish/IMove(newloc, safety)
	if(is_type_in_list(newloc, suitable_turf_types))
		return ..() // Procede as normal.
	return MOVEMENT_FAILED // Don't leave the water!

// Take damage if we are not in water
/mob/living/simple_mob/animal/passive/fish/handle_breathing()
	var/turf/T = get_turf(src)
	if(T && !is_type_in_list(T, suitable_turf_types))
		if(prob(50))
			say(pick("Blub", "Glub", "Burble"))
		adjustBruteLoss(unsuitable_atoms_damage)

/mob/living/simple_mob/animal/passive/fish/process()
	..()
	if(istype(get_turf(src), suitable_turf_types))
		return_timer++
	else
		return_timer = 0

	if(return_timer == 5 MINUTES)
		src.visible_message(span("notice", "\The [src] swims away into the water and vanishes beneath its surface."))
		qdel(src)

/mob/living/simple_mob/animal/passive/fish/death()
	layer = MOB_LAYER
	plane = MOB_PLANE
	..()

// Subtypes.
/mob/living/simple_mob/animal/passive/fish/bass
	name = "bass"
	tt_desc = "E Micropterus notius"
	icon_state = "bass-swim"
	icon_living = "bass-swim"
	icon_dead = "bass-dead"

/mob/living/simple_mob/animal/passive/fish/trout
	name = "trout"
	tt_desc = "E Salmo trutta"
	icon_state = "trout-swim"
	icon_living = "trout-swim"
	icon_dead = "trout-dead"

/mob/living/simple_mob/animal/passive/fish/salmon
	name = "salmon"
	tt_desc = "E Oncorhynchus nerka"
	icon_state = "salmon-swim"
	icon_living = "salmon-swim"
	icon_dead = "salmon-dead"

/mob/living/simple_mob/animal/passive/fish/perch
	name = "perch"
	tt_desc = "E Perca flavescens"
	icon_state = "perch-swim"
	icon_living = "perch-swim"
	icon_dead = "perch-dead"

/mob/living/simple_mob/animal/passive/fish/pike
	name = "pike"
	tt_desc = "E Esox aquitanicus"
	icon_state = "pike-swim"
	icon_living = "pike-swim"
	icon_dead = "pike-dead"

/mob/living/simple_mob/animal/passive/fish/koi
	name = "koi"
	tt_desc = "E Cyprinus rubrofuscus"
	icon_state = "koi-swim"
	icon_living = "koi-swim"
	icon_dead = "koi-dead"

/mob/living/simple_mob/animal/passive/fish/javelin
	name = "javelin shark"
	tt_desc = "S Cetusan minimalix"
	icon_state = "javelin-swim"
	icon_living = "javelin-swim"
	icon_dead = "javelin-dead"

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/carpmeat/sif

/mob/living/simple_mob/animal/passive/fish/icebass
	name = "glitter bass"
	tt_desc = "X Micropterus notius crotux"
	icon_state = "sifbass-swim"
	icon_living = "sifbass-swim"
	icon_dead = "sifbass-dead"

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/carpmeat/sif

	var/max_red = 150
	var/min_red = 50

	var/max_blue = 255
	var/min_blue = 50

	var/max_green = 150
	var/min_green = 50

	var/dorsal_color = "#FFFFFF"
	var/belly_color = "#FFFFFF"

	var/image/dorsal_image
	var/image/belly_image

/mob/living/simple_mob/animal/passive/fish/icebass/New()
	..()
	dorsal_color = rgb(rand(min_red,max_red), rand(min_green,max_green), rand(min_blue,max_blue))
	belly_color = rgb(rand(min_red,max_red), rand(min_green,max_green), rand(min_blue,max_blue))
	update_icon()

/mob/living/simple_mob/animal/passive/fish/icebass/update_icon()
	overlays.Cut()
	..()
	if(!dorsal_image)
		dorsal_image = image(icon, "[icon_state]_mask-body")
	if(!belly_image)
		belly_image = image(icon, "[icon_state]_mask-belly")

	dorsal_image.color = dorsal_color
	belly_image.color = belly_color

	overlays += dorsal_image
	overlays += belly_image

/mob/living/simple_mob/animal/passive/fish/rockfish
	name = "rock-fish"
	tt_desc = "S Tetraodontidae scopulix"
	icon_state = "rockfish-swim"
	icon_living = "rockfish-swim"
	icon_dead = "rockfish-dead"

	armor = list(
		"melee" = 90,
		"bullet" = 50,
		"laser" = -15,
		"energy" = 30,
		"bomb" = 30,
		"bio" = 100,
		"rad" = 100)

	var/max_red = 255
	var/min_red = 50

	var/max_blue = 255
	var/min_blue = 50

	var/max_green = 255
	var/min_green = 50

	var/head_color = "#FFFFFF"

	var/image/head_image

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/carpmeat/sif

/mob/living/simple_mob/animal/passive/fish/rockfish/New()
	..()
	head_color = rgb(rand(min_red,max_red), rand(min_green,max_green), rand(min_blue,max_blue))

/mob/living/simple_mob/animal/passive/fish/rockfish/update_icon()
	overlays.Cut()
	..()
	if(!head_image)
		head_image = image(icon, "[icon_state]_mask")

	head_image.color = head_color

	overlays += head_image

/mob/living/simple_mob/animal/passive/fish/solarfish
	name = "sun-fin"
	tt_desc = "S Exocoetidae solarin"
	icon_state = "solarfin-swim"
	icon_living = "solarfin-swim"
	icon_dead = "solarfin-dead"

	has_eye_glow = TRUE

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/carpmeat/sif

/mob/living/simple_mob/animal/passive/fish/murkin
	name = "murkin"
	tt_desc = "S Perca lutux"

	icon_state = "murkin-swim"
	icon_living = "murkin-swim"
	icon_dead = "murkin-dead"

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/carpmeat/sif/murkfish

/mob/living/simple_mob/animal/passive/fish/goldfish
	name = "goldfish"
	tt_desc = "E Carassius auratus"

	icon_state = "rockfish-swim"
	icon_living = "rockfish-swim"
	icon_dead = "rockfish-dead"

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/carpmeat/fish

/mob/living/simple_mob/animal/passive/fish/goldfish/New()
	..()
	color = rgb(255, 165, 0)
	adjust_scale(0.5)

/mob/living/simple_mob/animal/passive/fish/clownfish
	name = "clownfish"
	tt_desc = "E Amphiprion ocellaris"

	icon_state = "clown-swim"
	icon_living = "clown-swim"
	icon_dead = "clown-dead"

	meat_type = /obj/item/weapon/reagent_containers/food/snacks/carpmeat/fish