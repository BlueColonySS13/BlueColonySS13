/obj/item/weapon/reagent_containers/food/snacks/meat
	name = "meat"
	desc = "A slab of meat."
	icon_state = "meat"
	health = 180
	filling_color = "#FF1C1C"
	center_of_mass = list("x"=16, "y"=14)
	drop_sound = 'sound/items/drop/flesh.ogg'

	var/cutlet_type = /obj/item/weapon/reagent_containers/food/snacks/rawcutlet

/obj/item/weapon/reagent_containers/food/snacks/meat/New()
	..()
	reagents.add_reagent("protein", 9)
	src.bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/meat/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/material/knife))
		new cutlet_type(src)
		new cutlet_type(src)
		new cutlet_type(src)
		to_chat(user, "You cut the meat into thin strips.")
		qdel(src)
	else
		..()

/obj/item/weapon/reagent_containers/food/snacks/meat/syntiflesh
	name = "synthetic meat"
	desc = "A synthetic slab of flesh."

// Seperate definitions because some food likes to know if it's human.
// TODO: rewrite kitchen code to check a var on the meat item so we can remove
// all these sybtypes.
/obj/item/weapon/reagent_containers/food/snacks/meat/human
/obj/item/weapon/reagent_containers/food/snacks/meat/chicken
/obj/item/weapon/reagent_containers/food/snacks/meat/beef
/obj/item/weapon/reagent_containers/food/snacks/meat/lamb

/obj/item/weapon/reagent_containers/food/snacks/meat/fish
	name = "fish meat"
	icon_state = "fishfillet"

/obj/item/weapon/reagent_containers/food/snacks/meat/fish/salmon
/obj/item/weapon/reagent_containers/food/snacks/meat/fish/trout
/obj/item/weapon/reagent_containers/food/snacks/meat/fish/bass
/obj/item/weapon/reagent_containers/food/snacks/meat/fish/perch
/obj/item/weapon/reagent_containers/food/snacks/meat/fish/pike
/obj/item/weapon/reagent_containers/food/snacks/meat/fish/koi
/obj/item/weapon/reagent_containers/food/snacks/meat/fish/carp	// sigh

/obj/item/weapon/reagent_containers/food/snacks/meat/monkey
	//same as plain meat

/obj/item/weapon/reagent_containers/food/snacks/meat/corgi
	name = "corgi meat"
	desc = "Tastes like... well, you know."