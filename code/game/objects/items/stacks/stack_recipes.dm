
var/global/list/datum/stack_recipe/rods_recipes = list( \
	new/datum/stack_recipe("grille", /obj/structure/grille, 2, time = 10, one_per_turf = 1, on_floor = 0),
	new/datum/stack_recipe("electric grille", /obj/structure/grille/electric, 2, time = 10, one_per_turf = 1, on_floor = 0),
	new/datum/stack_recipe("catwalk", /obj/structure/catwalk, 2, time = 80, one_per_turf = 1, on_floor = 1))

var/global/list/datum/stack_recipe/wax_recipes = list( \
	new/datum/stack_recipe("candle", /obj/item/weapon/flame/candle, time = 2, colour_var = "wax_color"), \
	new/datum/stack_recipe("candelabra", /obj/item/weapon/flame/candle/candelabra, time = 2, colour_var = "wax_color"), \
	new/datum/stack_recipe("lipstick", /obj/item/weapon/lipstick, time = 2, colour_var = "colour") \
)