var/datum/category_collection/crafting/sewing_machine/sewing_recipes

/obj/machinery/autolathe/sewing_machine
	name = "Sewing Machine"
	desc = "It produces clothing and cloth pieces using various materials."
	icon_state = "sewing_machine"

	category_type = /datum/category_collection/crafting/sewing_machine

	circuit = /obj/item/weapon/circuitboard/autolathe/sewing_machine

	stored_material = list("silk" = 0, "cotton" = 0, "leather" = 0, "synthetic leather" = 0, "denim" = 0, "wool" = 0, "polychromatic thread" = 0)
	storage_capacity = list("silk" = 9000, "cotton" = 9000, "leather" = 9000, "synthetic leather" = 9000, "denim" = 9000, "wool" = 9000, "polychromatic thread" = 9000)

	process_sound = 'sound/machines/copier.ogg'

/obj/machinery/autolathe/sewing_machine/update_recipe_list()
	if(!machine_recipes)
		if(!sewing_recipes)
			sewing_recipes = new category_type()
		machine_recipes = sewing_recipes
		current_category = machine_recipes.categories[1]

/obj/machinery/autolathe/sewing_machine/commercial
	name = "Sew-Mate"
	desc = "A state-of-the-art automatic clothing stitching and craft machine, prints clothing and utilities on demand!"
	icon_state = "sewmate"
	commercial = TRUE
	circuit = /obj/item/weapon/circuitboard/autolathe/sewing_machine/commercial

	storage_capacity = list("silk" = 19000, "cotton" = 19000, "leather" = 19000, "synthetic leather" = 19000, "denim" = 19000, "wool" = 19000, "polychromatic thread" = 19000)
