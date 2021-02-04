/*
*	Here is where any supply packs
*	related to hydroponics tasks live.
*/


/datum/supply_pack/hydro
	group = "Hydroponics"
	spend_type = SPEND_HYDROPONICS

/datum/supply_pack/hydro/monkey
	name = "Monkey crate"
	contains = list (/obj/item/weapon/storage/box/monkeycubes)
	cost = 100
	containertype = /obj/structure/closet/crate/freezer
	containername = "Monkey crate"

/datum/supply_pack/hydro/lisa
	name = "Corgi Crate"
	contains = list()
	cost = 70
	containertype = /obj/structure/largecrate/animal/corgi
	containername = "Corgi Crate"

/datum/supply_pack/hydro/hydroponics
	name = "Hydroponics Supply Crate"
	contains = list(
			/obj/item/weapon/reagent_containers/spray/plantbgone = 4,
			/obj/item/weapon/reagent_containers/glass/bottle/ammonia = 2,
			/obj/item/weapon/material/knife/machete/hatchet,
			/obj/item/weapon/material/minihoe,
			/obj/item/device/analyzer/plant_analyzer,
			/obj/item/clothing/gloves/botanic_leather,
			/obj/item/clothing/suit/storage/apron,
			/obj/item/weapon/material/minihoe,
			/obj/item/weapon/storage/box/botanydisk
			)
	cost = 150
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Hydroponics crate"

/datum/supply_pack/hydro/cow
	name = "Cow crate"
	cost = 100
	containertype = /obj/structure/largecrate/animal/cow
	containername = "Cow crate"

/datum/supply_pack/hydro/goat
	name = "Goat crate"
	cost = 90
	containertype = /obj/structure/largecrate/animal/goat
	containername = "Goat crate"

/datum/supply_pack/hydro/chicken
	name = "Chicken crate"
	cost = 50
	containertype = /obj/structure/largecrate/animal/chick
	containername = "Chicken crate"


/datum/supply_pack/hydro/weedcontrol
	name = "Weed control crate"
	contains = list(
			/obj/item/weapon/material/knife/machete/hatchet = 2,
			/obj/item/weapon/reagent_containers/spray/plantbgone = 4,
			/obj/item/clothing/mask/gas = 2,
			/obj/item/weapon/grenade/chem_grenade/antiweed = 2,
			/obj/item/weapon/material/twohanded/fireaxe/scythe
			)
	cost = 300
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Weed control crate"


/datum/supply_pack/hydro/watertank
	name = "Water tank crate"
	contains = list(/obj/structure/reagent_dispensers/watertank)
	cost = 250
	containertype = /obj/structure/largecrate
	containername = "water tank crate"

/datum/supply_pack/hydro/bee_keeper
	name = "Beekeeping crate"
	contains = list(
			/obj/item/beehive_assembly,
			/obj/item/bee_smoker,
			/obj/item/honey_frame = 5,
			/obj/item/bee_pack
			)
	cost = 360
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Beekeeping crate"

/datum/supply_pack/hydro/tray
	name = "Empty hydroponics trays"
	cost = 500
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Hydroponics tray crate"
	contains = list(/obj/machinery/portable_atmospherics/hydroponics{anchored = 0} = 3)


/datum/supply_pack/hydro/fish
	name = "Fish Set"
	cost = 150
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Fish Set"
	contains = list(/obj/item/fishfood = 10, /obj/machinery/fishtank/bowl = 3, /obj/item/weapon/storage/firstaid/aquatic_kit/full =5, /obj/item/fish_eggs/goldfish = 5,
					/obj/item/fish_eggs/clownfish = 5, /obj/item/fish_eggs/shark = 5, /obj/item/fish_eggs/feederfish = 10,
					/obj/item/fish_eggs/salmon = 5, /obj/item/fish_eggs/catfish = 5, /obj/item/fish_eggs/glofish = 5,
					/obj/item/fish_eggs/electric_eel = 5, /obj/item/fish_eggs/shrimp = 10, /obj/item/toy/pet_rock = 5)


/datum/supply_pack/hydro/veg_seeds
	name = "Vegetable Seed Crate (2 packets each)"
	cost = 250
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Vegetable Seed Crate"
	contains = list(/obj/item/seeds/chiliseed = 2,
	/obj/item/seeds/cabbageseed = 2,
	/obj/item/seeds/eggplantseed = 2,
	/obj/item/seeds/cornseed = 2,
	/obj/item/seeds/potatoseed = 2,
	/obj/item/seeds/soyaseed = 2,
	/obj/item/seeds/wheatseed = 2,
	/obj/item/seeds/riceseed = 2,
	/obj/item/seeds/carrotseed = 2,
	/obj/item/seeds/chantermycelium = 2,
	/obj/item/seeds/towermycelium = 2,
	/obj/item/seeds/plumpmycelium = 2,
	/obj/item/seeds/whitebeetseed = 2,
	/obj/item/seeds/sugarcaneseed = 2,
	/obj/item/seeds/pumpkinseed = 2,
	/obj/item/seeds/onionseed = 2,
	/obj/item/seeds/cocoapodseed = 2)

/datum/supply_pack/hydro/fruit_seeds
	name = "Fruit Seed Crate (2 packets each)"
	cost = 250
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Fruit Seed Crate"
	contains = list(/obj/item/seeds/grapeseed = 2,
	/obj/item/seeds/berryseed = 2,
	/obj/item/seeds/bananaseed = 2,
	/obj/item/seeds/tomatoseed = 2,
	/obj/item/seeds/appleseed = 2,
	/obj/item/seeds/limeseed = 2,
	/obj/item/seeds/lemonseed = 2,
	/obj/item/seeds/orangeseed = 2,
	/obj/item/seeds/cherryseed = 2)

/datum/supply_pack/hydro/mushroom_spores
	name = "Various Mushroom Spores (2 packets each)"
	cost = 250
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Mushroom Seed Crate"
	contains = list(/obj/item/seeds/chantermycelium = 2,
	/obj/item/seeds/reishimycelium = 2,
	/obj/item/seeds/amanitamycelium = 2,
	/obj/item/seeds/angelmycelium = 2,
	/obj/item/seeds/libertymycelium = 2,
	/obj/item/seeds/chantermycelium = 2,
	/obj/item/seeds/towermycelium = 2,
	/obj/item/seeds/glowshroom = 2,
	/obj/item/seeds/plumpmycelium = 2,
	/datum/seed/mushroom/plastic = 2)


/datum/supply_pack/hydro/tobacco_seeds
	name = "Tobacco Seed Crate (5 packets)"
	cost = 70
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Tobacco Seed Crate"
	contains = list(/obj/item/seeds/tobaccoseed = 3)

/datum/supply_pack/hydro/fine_tobacco_seeds
	name = "Fine Tobacco Seed Crate (5 packets)"
	cost = 240
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Fine Tobacco Seed Crate"
	contains = list(/obj/item/seeds/finetobaccoseed = 3)

/datum/supply_pack/hydro/pure_tobacco_seeds
	name = "Pure Tobacco Seed Crate (5 packets)"
	cost = 490
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Pure Tobacco Seed Crate"
	contains = list(/obj/item/seeds/puretobaccoseed = 3)

/datum/supply_pack/hydro/cannabis_seeds
	name = "Cannabis Seed Crate"
	cost = 420 // lol
	containertype = /obj/structure/closet/crate/hydroponics
	containername = "Cannabis Seed Crate"
	contains = list(/obj/item/seeds/cannabisseed = 3)
