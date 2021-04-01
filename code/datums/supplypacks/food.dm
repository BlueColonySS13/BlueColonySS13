/datum/supply_pack/food_drinks
	group = "Food and Drink"
	spend_type = SPEND_FOODDRINK

/datum/supply_pack/randomised/food_drinks/pizza
	num_contained = 5
	contains = list(
			/obj/item/pizzabox/margherita,
			/obj/item/pizzabox/mushroom,
			/obj/item/pizzabox/meat,
			/obj/item/pizzabox/vegetable
			)
	name = "Surprise pack of five pizzas"
	cost = 500
	containertype = /obj/structure/closet/crate/refrigerated
	containername = "Pizza crate"

/datum/supply_pack/food_drinks/cascington_food
	name = "Cascington Confectionaries"
	contains = list(
		/obj/item/weapon/storage/box/multigrain = 3,
		/obj/item/weapon/storage/box/caviar/red = 3,
		/obj/item/weapon/storage/box/caviar = 3,
		/obj/item/weapon/reagent_containers/food/snacks/sliceable/cheesewheel/pule = 2
		)
	cost = 5000
	containertype = /obj/structure/closet/crate/gold
	containername = "Cascington Confectionaries"


/datum/supply_pack/food_drinks/sol_Food
	name = "Sol Confectionaries"
	contains = list(
		/obj/item/weapon/storage/box/sushi = 1,
		/obj/item/weapon/reagent_containers/food/snacks/beans = 1,
		/obj/item/weapon/reagent_containers/food/condiment/soysauce = 1,
		/obj/item/weapon/reagent_containers/food/snacks/croissant = 2,
		/obj/item/weapon/reagent_containers/food/snacks/fishandchips = 2,
		/obj/item/weapon/reagent_containers/food/snacks/hotdog = 2,
		/obj/item/weapon/reagent_containers/food/snacks/nachos = 2,
		/obj/item/weapon/reagent_containers/food/snacks/baguette = 2
		)
	cost = 1500
	containertype = /obj/structure/closet/crate/gold
	containername = "Sol Confectionaries"


/datum/supply_pack/food_drinks/bulk_flour
	name = "Bulk Flour"
	contains = list(
		/obj/item/weapon/reagent_containers/food/condiment/flour = 6,
				)
	cost = 1000
	containertype = /obj/structure/closet/crate
	containername = "Bulk Flour"

/datum/supply_pack/food_drinks/bulk_meat
	name = "Bulk meat"
	contains = list(
		/obj/item/weapon/reagent_containers/food/snacks/meat = 10,
				)
	cost = 400
	containertype = /obj/structure/closet/crate/refrigerated
	containername = "Bulk meat"

/datum/supply_pack/food_drinks/bulk_eggs
	name = "Bulk Eggs"
	contains = list(
		/obj/item/weapon/storage/fancy/egg_box = 2,
				)
	cost = 300
	containertype = /obj/structure/closet/crate/refrigerated
	containername = "Bulk eggs"

/datum/supply_pack/food_drinks/bulk_milk
	name = "Bulk milk"
	contains = list(
		/obj/item/weapon/reagent_containers/food/drinks/milk = 8,
				)
	cost = 300
	containertype = /obj/structure/closet/crate/refrigerated
	containername = "Bulk Milk"

/datum/supply_pack/food_drinks/bulk_soymilk
	name = "Bulk soymilk"
	contains = list(
		/obj/item/weapon/reagent_containers/food/drinks/soymilk = 8,
				)
	cost = 200
	containertype = /obj/structure/closet/crate/refrigerated
	containername = "Bulk soymilk"

/datum/supply_pack/food_drinks/bulk_tofu
	name = "Bulk Tofu"
	contains = list(
		/obj/item/weapon/reagent_containers/food/snacks/tofu = 6,
				)
	cost = 200
	containertype = /obj/structure/closet/crate/refrigerated
	containername = "Bulk Tofu"


/datum/supply_pack/food_drinks/beer_keg
	name = "Beer Keg"
	contains = list(
		/obj/structure/reagent_dispensers/beerkeg = 1,
		)
	cost = 1000
	containertype = /obj/structure/closet/crate/large
	containername = "Beer Keg"
	spend_type = SPEND_ALCOHOL

/datum/supply_pack/food_drinks/alcohol_set
	name = "Standard Alcohol Set"
	cost = 7000
	containertype = /obj/structure/closet/crate/large
	containername = "Standard Alcohol Set"

	contains = list(
					/obj/item/weapon/reagent_containers/food/drinks/bottle/gin,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/absinthe,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/bluecuracao,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/cognac,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/grenadine,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/kahlua,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/melonliquor,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/peppermintschnapps,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/peachschnapps,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/lemonadeschnapps,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/small/cider,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/rum,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/sake,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/specialwhiskey,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/tequilla,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/vermouth,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/vodka,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/wine,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/small/ale,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/small/beer,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/patron,
					/obj/item/weapon/reagent_containers/food/drinks/bottle/goldschlager
					)

	spend_type = SPEND_ALCOHOL

/datum/supply_pack/food_drinks/soft_drinks
	name = "Soft Drinks Set"
	cost = 1000	// high resell value!
	containertype = /obj/structure/closet/crate/refrigerated
	containername = "Soft Drinks Set"

	contains = list(/obj/item/weapon/reagent_containers/food/drinks/cans/cola,/obj/item/weapon/reagent_containers/food/drinks/cans/space_mountain_wind,
					/obj/item/weapon/reagent_containers/food/drinks/cans/dr_gibb,/obj/item/weapon/reagent_containers/food/drinks/cans/starkist,
					/obj/item/weapon/reagent_containers/food/drinks/cans/waterbottle,/obj/item/weapon/reagent_containers/food/drinks/cans/space_up,
					/obj/item/weapon/reagent_containers/food/drinks/cans/iced_tea, /obj/item/weapon/reagent_containers/food/drinks/cans/grape_juice,
					/obj/item/weapon/reagent_containers/food/drinks/cans/gingerale, /obj/item/weapon/reagent_containers/food/drinks/bottle/cola
					)

datum/supply_pack/food_drinks/condiments
	name = "Condiments"
	contains = list(
		/obj/item/weapon/reagent_containers/food/condiment/sugar = 5,
		/obj/item/weapon/reagent_containers/food/condiment/cornoil = 1,
		/obj/item/weapon/reagent_containers/food/condiment/hotsauce = 1,
		/obj/item/weapon/reagent_containers/food/condiment/soysauce = 1,
		/obj/item/weapon/reagent_containers/food/condiment/ketchup = 1,
		/obj/item/weapon/reagent_containers/food/condiment/small/peppermill = 1,
		/obj/item/weapon/reagent_containers/food/condiment/small/saltshaker = 1,
		/obj/item/weapon/reagent_containers/food/condiment/small/sugar = 1
		)
	cost = 500
	containertype = /obj/structure/closet/crate
	containername = "Baking Supplies"