/*
*	Here is where any supply packs related
*		to being hospitable tasks live
*/


/datum/supply_pack/hospitality
	group = "Hospitality"
	spend_type = SPEND_FOODDRINK

/datum/supply_pack/hospitality/party
	name = "Party equipment"
	contains = list(
			/obj/item/weapon/storage/box/mixedglasses = 2,
			/obj/item/weapon/storage/box/glasses/square,
			/obj/item/weapon/reagent_containers/food/drinks/shaker,
			/obj/item/weapon/reagent_containers/food/drinks/flask/barflask
			)
	cost = 1000
	containertype = /obj/structure/closet/crate
	containername = "Party equipment"
	spend_type = SPEND_HOSPITALITY

/datum/supply_pack/hospitality/standard_cutlery
	name = "Standard Cutlery"
	contains = list(
			/obj/item/weapon/material/kitchen/utensil/fork = 8,
			/obj/item/weapon/material/kitchen/utensil/spoon = 8,
			/obj/item/weapon/material/knife = 8
			)
	cost = 300
	containertype = /obj/structure/closet/crate
	containername = "Standard Cutlery"
	spend_type = SPEND_HOSPITALITY

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
	cost = 1000
	containertype = /obj/structure/closet/crate
	containername = "crate of bar supplies"
	spend_type = SPEND_HOSPITALITY



/datum/supply_pack/hospitality/cascington_alcohol
	name = "Cascington Alcoholic Imports"
	contains = list(
		/obj/item/weapon/reagent_containers/food/drinks/bottle/amontillado = 3,
		/obj/item/weapon/reagent_containers/food/drinks/bottle/vodkakora = 3,
		/obj/item/weapon/reagent_containers/food/drinks/bottle/goldfinger = 3,
		/obj/item/weapon/reagent_containers/food/drinks/bottle/serpentspirit = 3,
		/obj/item/weapon/reagent_containers/food/drinks/bottle/blackrose = 3
		)
	cost = 9000
	containertype = /obj/structure/closet/crate/gold
	containername = "Cascington Alcoholic Imports"
	spend_type = SPEND_ALCOHOL

/datum/supply_pack/hospitality/cascington_smoke
	name = "Cascington Smoking Imports"
	contains = list(
		/obj/item/weapon/storage/fancy/cigar/havana = 3,
		/obj/item/weapon/storage/fancy/cigar/cohiba = 3,
		/obj/item/weapon/storage/box/tobacco_box = 3,
		/obj/item/clothing/mask/smokable/pipe = 6
		)
	cost = 3000
	containertype = /obj/structure/closet/crate/gold
	containername = "Cascington Smoking Imports"
	spend_type = SPEND_TOBACCO

/*
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
	cost = 50
	containertype = /obj/structure/closet/crate
	containername = "Baking Supplies"
*/

/datum/supply_pack/hospitality/bulk_rollingpapers
	name = "Bulk Rolling Paper"
	contains = list(
		/obj/item/weapon/storage/rollingpapers = 5,
				)
	cost = 300
	containertype = /obj/structure/closet/crate
	containername = "Bulk Rolling Paper"

/*
/datum/supply_pack/hospitality/animal_produce
	name = "Animal Produce"
	contains = list(
		/obj/item/weapon/reagent_containers/food/snacks/meat = 10,
		/obj/item/weapon/storage/fancy/egg_box = 2,
		/obj/item/weapon/reagent_containers/food/drinks/milk = 8,
		)
	cost = 50
	containertype = /obj/structure/closet/crate
	containername = "Animal Produce"

/datum/supply_pack/hospitality/vegan_produce
	name = "Vegan Produce"
	contains = list(
			/obj/item/weapon/reagent_containers/food/drinks/soymilk = 8,
			/obj/item/weapon/reagent_containers/food/snacks/tofu = 10,
			)
	cost = 40
	containertype = /obj/structure/closet/crate/freezer
	containername = "Vegan Produce"

*/
/datum/supply_pack/hospitality/bouquet
	name = "Bouquets Crate"
	contains = list(
		/obj/item/toy/bouquet = 3,
		/obj/item/toy/bouquet/fake = 3,

		)
	cost = 200
	containertype = /obj/structure/closet/crate
	containername = "crate of bouquets"
	spend_type = SPEND_HOSPITALITY


/datum/supply_pack/hospitality/heartbox
	name = "Boxes of Chocolates"
	contains = list(
		/obj/item/weapon/storage/fancy/heartbox = 5,
		)
	cost = 400
	containertype = /obj/structure/closet/crate
	containername = "crate of chocolates"


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
	cost = 1000
	containertype = /obj/structure/closet/crate/gold
	containername = "Zippo Collection"
	spend_type = SPEND_HOSPITALITY


/datum/supply_pack/hospitality/cigarette_bulk
	name = "Standard Cigarettes (Bulk)"
	contains = list(
		/obj/item/weapon/storage/fancy/cigarettes = 5,
		/obj/item/weapon/storage/fancy/cigarettes/dromedaryco = 5,
		/obj/item/weapon/storage/fancy/cigarettes/killthroat = 5,
		/obj/item/weapon/storage/fancy/cigarettes/luckystars = 5,
		/obj/item/weapon/storage/fancy/cigarettes/jerichos = 5,
		/obj/item/weapon/storage/fancy/cigarettes/menthols = 5,
		)
	cost = 1000
	containertype = /obj/structure/closet/crate
	containername = "Standard Cigarettes (Bulk)"
	spend_type = SPEND_TOBACCO

/datum/supply_pack/hospitality/tobacco_paraphernalia
	name = "Lighter Set"
	contains = list(
				/obj/item/weapon/storage/box/matches = 10,
				/obj/item/weapon/flame/lighter/random = 5,
				)
	cost = 10
	containertype = /obj/structure/closet/crate
	containername = "Lighter Set"
	spend_type = SPEND_HOSPITALITY
/*
/datum/supply_pack/hospitality/deluxe_cigarettes
	name = "Deluxe Cigarettes (Bulk)"
	contains = list(/obj/item/weapon/storage/fancy/cigar = 5,
				/obj/item/weapon/storage/fancy/cigarettes/carcinomas = 5,
				/obj/item/weapon/storage/fancy/cigarettes/professionals = 5,
				/obj/item/weapon/storage/fancy/cigarettes/nightshade = 5)
	cost = 150
	containertype = /obj/structure/closet/crate
	containername = "Deluxe Cigarettes set"
	spend_type = SPEND_TOBACCO
*/
/datum/supply_pack/hospitality/bingo_machine
	name = "Bingo Machine"
	contains = list(/obj/machinery/bingo_machine)
	cost = 5000
	containertype = /obj/structure/closet/crate
	containername = "Bingo Machine"
	spend_type = SPEND_HOSPITALITY

/datum/supply_pack/hospitality/daubers
	name = "Bingo Daubers"
	contains = list(/obj/item/weapon/pen/crayon/marker/red/dauber = 10)
	cost = 1000
	containertype = /obj/structure/closet/crate
	containername = "Bingo Daubers"
	spend_type = SPEND_HOSPITALITY


/datum/supply_pack/hospitality/trickbag
	name = "Halloween Trick O' Treat Bags (Bulk of 10)"
	contains = list(/obj/item/weapon/storage/spooky = 10)
	cost = 1500
	containertype = /obj/structure/closet/crate
	containername = "Halloween Trick O' Treat Bags"
