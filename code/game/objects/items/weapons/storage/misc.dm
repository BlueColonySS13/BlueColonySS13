/*
 * Donut Box
 */

/obj/item/weapon/storage/box/donut
	icon = 'icons/obj/food.dmi'
	icon_state = "donutbox"
	name = "donut box"
	max_storage_space = ITEMSIZE_COST_SMALL * 6
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/donut)
	foldable = /obj/item/stack/material/cardboard
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/donut/normal = 6)

/obj/item/weapon/storage/box/donut/initialize()
	. = ..()
	update_icon()

/obj/item/weapon/storage/box/donut/update_icon()
	overlays.Cut()
	var/i = 0
	for(var/obj/item/weapon/reagent_containers/food/snacks/donut/D in contents)
		overlays += image('icons/obj/food.dmi', "[i][D.overlay_state]")
		i++

/obj/item/weapon/storage/box/donut/empty
	empty = TRUE

/obj/item/weapon/storage/box/multigrain
	icon = 'icons/obj/food.dmi'
	icon_state = "multigrainbox"
	name = "Salthill Farms Multigrain Crackers box"
	desc = "Delicious multi-grain crackers from the farm that never forgets!"
	max_storage_space = ITEMSIZE_COST_SMALL * 8
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/cracker/multigrain)
	foldable = /obj/item/stack/material/cardboard
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/cracker/multigrain = 8)

/obj/item/weapon/storage/box/tobacco_box
	name = "tobacco box"
	desc = "Storing all dried tobacco strains since 1990."
	icon_state = "tobacco_box"
	max_storage_space = ITEMSIZE_COST_SMALL * 4
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/grown/tobacco)
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/grown/tobacco/dry = 6)

/obj/item/weapon/storage/box/sushi
	icon = 'icons/obj/food.dmi'
	icon_state = "bentobox"
	name = "New Japan Bento Box"
	desc = "A bento box filled with a random assortment of sushi."
	max_storage_space = ITEMSIZE_COST_SMALL * 6
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/sushi)
	foldable = /obj/item/stack/material/cardboard
	starts_with = list(/obj/random/sushi = 6)

/obj/item/weapon/storage/box/caviar
	icon = 'icons/obj/food.dmi'
	icon_state = "caviarbox"
	name = "Imported Kaluva Royal Caviar tin"
	desc = "A tin of salty fish eggs. Pairs well with crackers."
	max_storage_space = ITEMSIZE_COST_SMALL * 4
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/caviar)
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/caviar = 4)
	var/opened = 0

/obj/item/weapon/storage/box/caviar/red
	icon_state = "roebox"
	name = "Noriaki Salmon Roe tin"
	desc = "A tin of salty salmon eggs. Pairs well with crackers"
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/caviar/red)
	starts_with = list(/obj/item/weapon/reagent_containers/food/snacks/caviar/red = 4)

/obj/item/weapon/storage/box/caviar/attack_self(mob/user)
	open(user)

/obj/item/weapon/storage/box/caviar/open(mob/user)
	if(!opened)
		to_chat(usr, "<span class='notice'>You peel back the lid of the tin.</span>")
		update_icon()
	. = ..()

/obj/item/weapon/storage/box/caviar/update_icon()
	if(!opened)
		icon_state = "[icon_state]_open"
		opened = 1
