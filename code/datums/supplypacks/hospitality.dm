/*
*	Here is where any supply packs related
*		to being hospitable tasks live
*/


/datum/supply_pack/hospitality
	group = "Hospitality"

/datum/supply_pack/hospitality/party
	name = "Party equipment"
	contains = list(
			/obj/item/weapon/storage/box/mixedglasses = 2,
			/obj/item/weapon/storage/box/glasses/square,
			/obj/item/weapon/reagent_containers/food/drinks/shaker,
			/obj/item/weapon/reagent_containers/food/drinks/flask/barflask,
			/obj/item/weapon/reagent_containers/food/drinks/bottle/patron,
			/obj/item/weapon/reagent_containers/food/drinks/bottle/goldschlager,
			/obj/item/weapon/reagent_containers/food/drinks/bottle/specialwhiskey,
			/obj/item/weapon/storage/fancy/cigarettes/dromedaryco,
			/obj/item/weapon/lipstick/random,
			/obj/item/weapon/reagent_containers/food/drinks/bottle/small/ale = 2,
			/obj/item/weapon/reagent_containers/food/drinks/bottle/small/beer = 4,
			)
	cost = 100
	containertype = /obj/structure/closet/crate
	containername = "Party equipment"

/datum/supply_pack/hospitality/barsupplies
	name = "Bar supplies"
	contains = list(
			/obj/item/weapon/storage/box/glasses/cocktail,
			/obj/item/weapon/storage/box/glasses/rocks,
			/obj/item/weapon/storage/box/glasses/square,
			/obj/item/weapon/storage/box/glasses/pint,
			/obj/item/weapon/storage/box/glasses/wine,
			/obj/item/weapon/storage/box/glasses/shake,
			/obj/item/weapon/storage/box/glasses/shot,
			/obj/item/weapon/storage/box/glasses/mug,
			/obj/item/weapon/storage/box/glasses/meta,
			/obj/item/weapon/reagent_containers/food/drinks/shaker,
			/obj/item/weapon/storage/box/glass_extras/straws,
			/obj/item/weapon/storage/box/glass_extras/sticks
			)
	cost = 100
	containertype = /obj/structure/closet/crate
	containername = "crate of bar supplies"

/datum/supply_pack/randomised/hospitality/
	group = "Hospitality"

/datum/supply_pack/randomised/hospitality/pizza
	num_contained = 5
	contains = list(
			/obj/item/pizzabox/margherita,
			/obj/item/pizzabox/mushroom,
			/obj/item/pizzabox/meat,
			/obj/item/pizzabox/vegetable
			)
	name = "Surprise pack of five pizzas"
	cost = 45
	containertype = /obj/structure/closet/crate/freezer
	containername = "Pizza crate"

/datum/supply_pack/hospitality/cascington_alcohol
	name = "Cascington Alcoholic Imports"
	contains = list(
		/obj/item/weapon/reagent_containers/food/drinks/bottle/amontillado = 3,
		/obj/item/weapon/reagent_containers/food/drinks/bottle/vodkakora = 3,
		/obj/item/weapon/reagent_containers/food/drinks/bottle/goldfinger = 3,
		/obj/item/weapon/reagent_containers/food/drinks/bottle/serpentspirit = 3,
		/obj/item/weapon/reagent_containers/food/drinks/bottle/blackrose = 3
		)
	cost = 2000
	containertype = /obj/structure/closet/crate/gold
	containername = "Cascington Alcoholic Imports"

/datum/supply_pack/hospitality/cascington_smoke
	name = "Cascington Smoking Imports"
	contains = list(
		/obj/item/weapon/storage/fancy/cigar/havana = 3,
		/obj/item/weapon/storage/fancy/cigar/cohiba = 3,
		/obj/item/weapon/storage/box/tobacco_box = 3,
		/obj/item/clothing/mask/smokable/pipe = 6
		)
	cost = 400
	containertype = /obj/structure/closet/crate/gold
	containername = "Cascington Smoking Imports"

/datum/supply_pack/hospitality/cascington_food
	name = "Cascington Confectionaries"
	contains = list(
		/obj/item/weapon/storage/box/multigrain = 3,
		/obj/item/weapon/storage/box/caviar/red = 3,
		/obj/item/weapon/storage/box/caviar = 3,
		/obj/item/weapon/reagent_containers/food/snacks/sliceable/cheesewheel/pule = 2
		)
	cost = 1300
	containertype = /obj/structure/closet/crate/gold
	containername = "Cascington Confectionaries"


/datum/supply_pack/hospitality/sol_Food
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
	cost = 250
	containertype = /obj/structure/closet/crate/gold
	containername = "Sol Confectionaries"

/datum/supply_pack/hospitality/baking_supplies
	name = "Baking Supplies"
	contains = list(
		/obj/item/weapon/reagent_containers/food/condiment/flour = 5,
		/obj/item/weapon/reagent_containers/food/condiment/sugar = 5,
		/obj/item/weapon/reagent_containers/food/condiment/cornoil = 1,
		/obj/item/weapon/reagent_containers/food/condiment/enzyme = 1,
		/obj/item/weapon/reagent_containers/food/condiment/hotsauce = 1,
		/obj/item/weapon/reagent_containers/food/condiment/soysauce = 1,
		/obj/item/weapon/reagent_containers/food/condiment/ketchup = 1,
		/obj/item/weapon/reagent_containers/food/condiment/small/peppermill = 1,
		/obj/item/weapon/reagent_containers/food/condiment/small/saltshaker = 1,
		/obj/item/weapon/reagent_containers/food/condiment/small/sugar = 1
		)
	cost = 150
	containertype = /obj/structure/closet/crate
	containername = "Baking Supplies"

/datum/supply_pack/hospitality/beer_keg
	name = "Beer Keg"
	contains = list(
		/obj/structure/reagent_dispensers/beerkeg = 1,
		)
	cost = 100
	containertype = /obj/structure/closet/crate/large
	containername = "Beer Keg"

/datum/supply_pack/hospitality/animal_produce
	name = "Animal Produce"
	contains = list(
		/obj/item/weapon/reagent_containers/food/snacks/meat = 10,
		/obj/item/weapon/storage/fancy/egg_box = 2,
		/obj/item/weapon/reagent_containers/food/drinks/milk = 8,
		/obj/item/weapon/reagent_containers/food/drinks/soymilk = 8
		)
	cost = 50
	containertype = /obj/structure/closet/crate
	containername = "Animal Produce"

/datum/supply_pack/hospitality/gifts
	name = "Gift crate"
	contains = list(
		/obj/item/toy/bouquet = 3,
		/obj/item/weapon/storage/fancy/heartbox = 2,
		/obj/item/weapon/paper/card/smile,
		/obj/item/weapon/paper/card/heart,
		/obj/item/weapon/paper/card/cat,
		/obj/item/weapon/paper/card/flower
		)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "crate of gifts"


/datum/supply_pack/hospitality/jukebox
	name = "Jukebox"
	contains = list(/obj/machinery/media/jukebox)
	cost = 2000
	containertype = /obj/structure/largecrate
	containername = "\improper Jukebox Crate"


/datum/supply_pack/hospitality/zippo_collection
	name = "Zippo Collection"
	contains = list(
		/obj/item/weapon/flame/lighter/zippo,
		/obj/item/weapon/flame/lighter/zippo/black,
		/obj/item/weapon/flame/lighter/zippo/blue,
		/obj/item/weapon/flame/lighter/zippo/engraved,
		/obj/item/weapon/flame/lighter/zippo/gold,
		/obj/item/weapon/flame/lighter/zippo/moff,
		/obj/item/weapon/flame/lighter/zippo/red,
		/obj/item/weapon/flame/lighter/zippo/ironic,
		/obj/item/weapon/flame/lighter/zippo/capitalist,
		/obj/item/weapon/flame/lighter/zippo/communist,
		/obj/item/weapon/flame/lighter/zippo/royal,
		/obj/item/weapon/flame/lighter/zippo/rainbow,
		/obj/item/weapon/flame/lighter/zippo/heartbreaker,
		/obj/item/weapon/flame/lighter/zippo/sol,
		/obj/item/weapon/flame/lighter/zippo/corgi,
		/obj/item/weapon/flame/lighter/zippo/usa,
		/obj/item/weapon/flame/lighter/zippo/clown,
		/obj/item/weapon/flame/lighter/zippo/fox
		)
	cost = 300
	containertype = /obj/structure/closet/crate/gold
	containername = "Zippo Collection"
