/material/proc/get_recipes()
	if(!recipes)
		generate_recipes()
	return recipes

/material/proc/generate_recipes()
	recipes = list()

	// If is_brittle() returns true, these are only good for a single strike.
	recipes += new/datum/stack_recipe("[display_name] baseball bat", /obj/item/weapon/material/twohanded/baseballbat, 10, time = 20, one_per_turf = 0, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] ashtray", /obj/item/weapon/material/ashtray, 2, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] spoon", /obj/item/weapon/material/kitchen/utensil/spoon/plastic, 10, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] armor plate", /obj/item/weapon/material/armor_plating, 1, time = 20, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] whip", /obj/item/weapon/material/whip, 30, time = 15, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] grave marker", /obj/item/weapon/material/gravemarker, 5, time = 50, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] ring", /obj/item/clothing/gloves/ring/material, 20, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] blinds", /obj/structure/curtain/blinds, 15, on_floor = 1, supplied_material = "[name]", apply_material_color = TRUE)


	if(integrity>=50)
		recipes += new/datum/stack_recipe("[display_name] door", /obj/structure/simple_door, 10, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("[display_name] barricade", /obj/structure/barricade, 5, time = 50, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("[display_name] stool", /obj/item/weapon/stool, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("[display_name] chair", /obj/structure/bed/chair, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("[display_name] bed", /obj/structure/bed, 2, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("[display_name] double bed", /obj/structure/bed/double, 4, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("[display_name] wall girders", /obj/structure/girder, 2, time = 50, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")

	if(hardness>50)
		recipes += new/datum/stack_recipe("[display_name] fork", /obj/item/weapon/material/kitchen/utensil/fork/plastic, 1, on_floor = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("[display_name] knife", /obj/item/weapon/material/knife/plastic, 1, on_floor = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("[display_name] blade", /obj/item/weapon/material/butterflyblade, 6, time = 20, one_per_turf = 0, on_floor = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("[display_name] barber's scissors", /obj/item/weapon/scissors/barber, 25, on_floor = 1, apply_material_color = TRUE, prefix = TRUE)
	recipes += new/datum/stack_recipe("[display_name] dangle earrings", /obj/item/clothing/ears/earring/dangle, 20, on_floor = 1, apply_material_color = TRUE, prefix = TRUE)
	recipes += new/datum/stack_recipe("[display_name] stud earrings", /obj/item/clothing/ears/earring/stud, 20, on_floor = 1, apply_material_color = TRUE, prefix = TRUE)
	recipes += new/datum/stack_recipe("[display_name] bracelet", /obj/item/clothing/accessory/bracelet/material, 15, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] necklace", /obj/item/clothing/accessory/necklace, 15, on_floor = 1, supplied_material = "[name]")


/material/steel/generate_recipes()
	..()
	recipes += new/datum/stack_recipe_list("office chairs",list( \
		new/datum/stack_recipe("dark office chair", /obj/structure/bed/chair/office/dark, 5, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("light office chair", /obj/structure/bed/chair/office/light, 5, one_per_turf = 1, on_floor = 1) \
		))
	recipes += new/datum/stack_recipe_list("comfy chairs", list( \
		new/datum/stack_recipe("beige comfy chair", /obj/structure/bed/chair/comfy/beige, 2, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("black comfy chair", /obj/structure/bed/chair/comfy/black, 2, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("brown comfy chair", /obj/structure/bed/chair/comfy/brown, 2, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("lime comfy chair", /obj/structure/bed/chair/comfy/lime, 2, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("teal comfy chair", /obj/structure/bed/chair/comfy/teal, 2, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("red comfy chair", /obj/structure/bed/chair/comfy/red, 2, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("blue comfy chair", /obj/structure/bed/chair/comfy/blue, 2, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("purple comfy chair", /obj/structure/bed/chair/comfy/purp, 2, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("green comfy chair", /obj/structure/bed/chair/comfy/green, 2, one_per_turf = 1, on_floor = 1), \
		))

	recipes += new/datum/stack_recipe_list("Tools",list( \
		new/datum/stack_recipe("tray", 				/obj/item/weapon/tray, 				1, time = 2),\
		new/datum/stack_recipe("IV Drip", 			/obj/machinery/iv_drip, 			3, time = 15, one_per_turf = 1, on_floor = 1),\
		new/datum/stack_recipe("Roller Bed", 		/obj/structure/bed/roller, 			2, time = 10, one_per_turf = 1, on_floor = 1),\
		))
	recipes += new/datum/stack_recipe("table frame", /obj/structure/table, 1, time = 10, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("bench frame", /obj/structure/table/bench, 1, time = 10, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("rack", /obj/structure/table/rack, 1, time = 5, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("closet", /obj/structure/closet, 2, time = 15, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("personal closet", /obj/structure/closet/secure_closet/personal, 2, time = 15, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("canister", /obj/machinery/portable_atmospherics/canister, 10, time = 15, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("cannon frame", /obj/item/weapon/cannonframe, 10, time = 15, one_per_turf = 0, on_floor = 0)
	recipes += new/datum/stack_recipe("regular floor tile", /obj/item/stack/tile/floor, 1, 4, 20)
	recipes += new/datum/stack_recipe("roofing tile", /obj/item/stack/tile/roofing, 3, 4, 20)
	recipes += new/datum/stack_recipe("metal rod", /obj/item/stack/rods, 1, 2, 60)
	recipes += new/datum/stack_recipe("scooter frame", /obj/item/scooter_frame, 15, time = 15, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("frame", /obj/item/frame, 5, time = 25, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("low wall frame", /obj/structure/wall_frame, 2, time = 50, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("mirror frame", /obj/item/frame/mirror, 1, time = 5, one_per_turf = 0, on_floor = 1)
	recipes += new/datum/stack_recipe("fire extinguisher cabinet frame", /obj/item/frame/extinguisher_cabinet, 4, time = 5, one_per_turf = 0, on_floor = 1)
	//recipes += new/datum/stack_recipe("fire axe cabinet frame", /obj/item/frame/fireaxe_cabinet, 4, time = 5, one_per_turf = 0, on_floor = 1)
	recipes += new/datum/stack_recipe("railing", /obj/structure/railing, 2, time = 50, one_per_turf = 0, on_floor = 1)
	recipes += new/datum/stack_recipe("turret frame", /obj/machinery/porta_turret_construct, 5, time = 25, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe_list("airlock assemblies", list( \
		new/datum/stack_recipe("standard airlock assembly", /obj/structure/door_assembly, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("airtight hatch assembly", /obj/structure/door_assembly/door_assembly_hatch, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("high security airlock assembly", /obj/structure/door_assembly/door_assembly_highsecurity, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("emergency firedoor shutter", /obj/structure/firedoor_assembly, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("multi-tile airlock assembly", /obj/structure/door_assembly/multi_tile, 4, time = 50, one_per_turf = 1, on_floor = 1), \

		))
	recipes += new/datum/stack_recipe_list("modular computer frames", list( \
		new/datum/stack_recipe("modular console frame", /obj/machinery/modular_computer/console/buildable, 20),\
		new/datum/stack_recipe("modular laptop frame", /obj/machinery/modular_computer/laptop/buildable, 10),\
		new/datum/stack_recipe("modular tablet frame", /obj/item/modular_computer/tablet, 5),\
	))


	recipes += new/datum/stack_recipe("blast shutters frame", /obj/item/frame/shutters, 4, time = 50, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("blast door frame", /obj/item/frame/shutters/regular, 4, time = 50, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("thick gate frame", /obj/item/frame/thick_gate, 4, time = 50, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("thin gate frame", /obj/item/frame/thin_gate, 4, time = 50, one_per_turf = 1, on_floor = 1)

	recipes += new/datum/stack_recipe("desk bell", /obj/item/weapon/deskbell, 1, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("IV drip", /obj/machinery/iv_drip, 4, time = 20, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("conveyor switch", /obj/machinery/conveyor_switch, 2, time = 20, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("grenade casing", /obj/item/weapon/grenade/chem_grenade)
	recipes += new/datum/stack_recipe("light fixture frame", /obj/item/frame/light, 2)
	recipes += new/datum/stack_recipe("floor light fixture frame", /obj/machinery/light_construct/floor, 2)
	recipes += new/datum/stack_recipe("small light fixture frame", /obj/item/frame/light/small, 1)
	recipes += new/datum/stack_recipe("floor lamp fixture frame", /obj/machinery/light_construct/flamp, 2)
	recipes += new/datum/stack_recipe("apc frame", /obj/item/frame/apc, 2)
	recipes += new/datum/stack_recipe("secure safe frame", /obj/item/frame/wallsafe, 5)
	recipes += new/datum/stack_recipe("atm frame", /obj/item/frame/atm, 5)
	recipes += new/datum/stack_recipe("thick gate frame", /obj/item/frame/thick_gate, 25, time = 10)
	recipes += new/datum/stack_recipe("thin gate frame", /obj/item/frame/thin_gate, 25, time = 10)
	recipes += new/datum/stack_recipe("display case frame", /obj/item/frame/display_case, 25, time = 10)
	recipes += new/datum/stack_recipe("metal book case", /obj/structure/bookcase/metal, 5, time = 15, one_per_turf = 1, on_floor = 1)


	recipes += new/datum/stack_recipe_list("fences", list( \
		new/datum/stack_recipe("fence", /obj/structure/fence, 5, time = 10, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("fence corner", /obj/structure/fence/corner, 5, time = 10, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("fence post", /obj/structure/fence/post, 5, time = 10, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("fence end", /obj/structure/fence/end, 5, time = 10, one_per_turf = 1, on_floor = 1), \
		))

	recipes += new/datum/stack_recipe_list("filing cabinets", list( \
		new/datum/stack_recipe("filing cabinet", /obj/structure/filingcabinet, 4, time = 20, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("tall filing cabinet", /obj/structure/filingcabinet/filingcabinet, 4, time = 20, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("chest drawer", /obj/structure/filingcabinet/chestdrawer, 4, time = 20, one_per_turf = 1, on_floor = 1), \
		))

	recipes += new/datum/stack_recipe_list("vehicle bed", list( \
		new/datum/stack_recipe("race car bed", /obj/structure/bed/racecar, 20, time = 10, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("classic race car bed", /obj/structure/bed/racecar/classic, 20, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("shuttle bed", /obj/structure/bed/racecar/shuttle,20, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("fire truck bed",/obj/structure/bed/racecar/firetruck,20, one_per_turf = 1, on_floor = 1), \
		))

/material/plasteel/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("AI core", /obj/structure/AIcore, 4, time = 50, one_per_turf = 1)
	recipes += new/datum/stack_recipe("Metal crate", /obj/structure/closet/crate, 10, time = 50, one_per_turf = 1)
	recipes += new/datum/stack_recipe("knife grip", /obj/item/weapon/material/butterflyhandle, 4, time = 20, one_per_turf = 0, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("dark floor tile", /obj/item/stack/tile/floor/dark, 1, 4, 20)
	recipes += new/datum/stack_recipe("roller bed", /obj/item/roller, 5, time = 30, on_floor = 1)
	recipes += new/datum/stack_recipe("whetstone", /obj/item/weapon/whetstone, 2, time = 10)
	recipes += new/datum/stack_recipe("blast shutters frame", /obj/item/frame/shutters, 25, time = 10)
	recipes += new/datum/stack_recipe("blast door frame", /obj/item/frame/shutters/regular, 22, time = 10)

/material/stone/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("planting bed", /obj/machinery/portable_atmospherics/hydroponics/soil, 3, time = 10, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("eyeshadow", /obj/item/weapon/lipstick/eyeshadow, time = 2, colour_var = "colour")
	recipes += new/datum/stack_recipe("blusher", /obj/item/weapon/lipstick/blusher, time = 2, colour_var = "colour")


/material/plastic/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("plastic crate", /obj/structure/closet/crate/plastic, 10, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("freezer crate", /obj/structure/closet/crate/freezer, 5, time = 20, on_floor = 1)
	recipes += new/datum/stack_recipe("portable freezer", /obj/item/weapon/storage/box/freezer, 20, on_floor = 1)
	recipes += new/datum/stack_recipe("blood pack", /obj/item/weapon/reagent_containers/blood/empty, 4, on_floor = 0)
	recipes += new/datum/stack_recipe("baggie", /obj/item/weapon/reagent_containers/drugs/baggie, 1, on_floor = 0)
	recipes += new/datum/stack_recipe("reagent dispenser cartridge (large)", /obj/item/weapon/reagent_containers/chem_disp_cartridge,        5, on_floor=0) // 500u
	recipes += new/datum/stack_recipe("reagent dispenser cartridge (med)",   /obj/item/weapon/reagent_containers/chem_disp_cartridge/medium, 3, on_floor=0) // 250u
	recipes += new/datum/stack_recipe("reagent dispenser cartridge (small)", /obj/item/weapon/reagent_containers/chem_disp_cartridge/small,  1, on_floor=0) // 100u
	recipes += new/datum/stack_recipe("white floor tile", /obj/item/stack/tile/floor/white, 1, 4, 20)
	recipes += new/datum/stack_recipe("freezer floor tile", /obj/item/stack/tile/floor/freezer, 1, 4, 20)
	recipes += new/datum/stack_recipe("shower curtain", /obj/structure/curtain, 4, time = 15, one_per_turf = 1, on_floor = 1, apply_material_color = TRUE)
	recipes += new/datum/stack_recipe("plastic flaps", /obj/structure/plasticflaps, 4, time = 25, one_per_turf = 1, on_floor = 1, apply_material_color = TRUE)
	recipes += new/datum/stack_recipe("airtight plastic flaps", /obj/structure/plasticflaps/mining, 5, time = 25, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("water-cooler", /obj/structure/reagent_dispensers/water_cooler, 4, time = 10, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("lampshade", /obj/item/weapon/lampshade, 1, time = 1)
	recipes += new/datum/stack_recipe("sink", /obj/item/frame/plastic/sink, 12, time = 20, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("kitchen sink", /obj/item/frame/plastic/kitchensink, 15, time = 20, on_floor = 1)
	recipes += new/datum/stack_recipe("toilet", /obj/item/frame/plastic/toilet, 15, time = 20, on_floor = 1, apply_material_color = TRUE)
	recipes += new/datum/stack_recipe("urinal", /obj/item/frame/plastic/urinal, 15, time = 20, on_floor = 1, apply_material_color = TRUE)
	recipes += new/datum/stack_recipe("tape", /obj/item/device/tape/random, 15, time = 20, on_floor = 1)
	recipes += new/datum/stack_recipe("mop bucket", /obj/structure/mopbucket, 5, time = 20, on_floor = 1)
	recipes += new/datum/stack_recipe("fridge", /obj/structure/closet/secure_closet/freezer/fridge, 5, time = 20, on_floor = 1)
	recipes += new/datum/stack_recipe("freezer", /obj/structure/closet/secure_closet/freezer, 5, time = 20, on_floor = 1)
	recipes += new/datum/stack_recipe("umbrella", /obj/item/weapon/melee/umbrella, 15, time = 20, on_floor = 1, apply_material_color = TRUE)
	recipes += new/datum/stack_recipe("balloon", /obj/item/toy/balloon, 15, time = 20, on_floor = 1, apply_material_color = TRUE)
	recipes += new/datum/stack_recipe("[display_name] friendship bracelet", /obj/item/clothing/accessory/bracelet/friendship, 2, on_floor = 1)
	recipes += new/datum/stack_recipe("plastic net", /obj/item/weapon/material/fishing_net, 15, time = 1 MINUTE, on_floor = 1)



	recipes += new/datum/stack_recipe_list("Containers",list( \
		new/datum/stack_recipe("plastic bag", 							/obj/item/weapon/storage/bag/plasticbag, 						3, on_floor=1),\
		new/datum/stack_recipe("laundry basket",						/obj/item/weapon/storage/laundry_basket,						5, time = 15, 	on_floor=0),\
		new/datum/stack_recipe("blood pack", 							/obj/item/weapon/reagent_containers/blood/empty, 				4, on_floor=0),\
		new/datum/stack_recipe("reagent dispenser cartridge (large)", 	/obj/item/weapon/reagent_containers/chem_disp_cartridge,        5, time = 15, 	on_floor=0),\
		new/datum/stack_recipe("reagent dispenser cartridge (med)",   	/obj/item/weapon/reagent_containers/chem_disp_cartridge/medium, 3, time = 10, 	on_floor=0),\
		new/datum/stack_recipe("reagent dispenser cartridge (small)", 	/obj/item/weapon/reagent_containers/chem_disp_cartridge/small,  1, time = 5,	on_floor=0),\
		new/datum/stack_recipe("lunchbox", 								/obj/item/weapon/storage/toolbox/lunchbox,        						5, time = 15, 	on_floor=0),\
		new/datum/stack_recipe("lunchbox (heart)", 						/obj/item/weapon/storage/toolbox/lunchbox/heart,        				5, time = 15, 	on_floor=0),\
		new/datum/stack_recipe("lunchbox (cat)", 						/obj/item/weapon/storage/toolbox/lunchbox/cat,        					5, time = 15, 	on_floor=0),\
		new/datum/stack_recipe("lunchbox (NT)", 						/obj/item/weapon/storage/toolbox/lunchbox/nt,        					5, time = 15, 	on_floor=0),\
		new/datum/stack_recipe("lunchbox (Mars)", 						/obj/item/weapon/storage/toolbox/lunchbox/mars,        					5, time = 15, 	on_floor=0),\
		new/datum/stack_recipe("lunchbox (bluespace)", 						/obj/item/weapon/storage/toolbox/lunchbox/bluespace_lunchbox,        					5, time = 15, 	on_floor=0),\
		))

/material/glass/generate_recipes()
	..()
	if(!is_reinforced())
		recipes += new/datum/stack_recipe("basic window", /obj/structure/window/basic, 1, time = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("full window", /obj/structure/window/basic/full, 1, time = 1, supplied_material = "[name]", ignore_direction = TRUE)

	else
		recipes += new/datum/stack_recipe("reinforced basic window", /obj/structure/window/reinforced, 1, time = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("reinforced full window", /obj/structure/window/reinforced/full, 1, time = 1, supplied_material = "[name]", ignore_direction = TRUE)
		recipes += new/datum/stack_recipe("tinted window", /obj/structure/window/reinforced/tinted , 1, time = 1, supplied_material = "[name]")
		recipes += new/datum/stack_recipe("tinted full window", /obj/structure/window/reinforced/tinted/full , 1, time = 1, supplied_material = "[name]")

	recipes += new/datum/stack_recipe("framed window", /obj/structure/window/framed, 4, time = 1, supplied_material = "[name]")

	recipes += new/datum/stack_recipe_list("windoor assemblies", list( \
		new/datum/stack_recipe("standard windoor assembly", /obj/structure/windoor_assembly, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("secure windoor assembly", /obj/structure/windoor_assembly/secure, 4, time = 50, one_per_turf = 1, on_floor = 1), \

		))

	recipes += new/datum/stack_recipe("glass jar", /obj/item/glass_jar, 15, time = 20, on_floor = 1)
	recipes += new/datum/stack_recipe("dye bottle", /obj/item/dye_bottle, 1, time = 5, one_per_turf = 1, on_floor = 1)

	recipes += new/datum/stack_recipe("glass bottle", /obj/item/weapon/reagent_containers/glass/bottle, 1, time = 25, one_per_turf = 1, on_floor = 1)

	recipes += new/datum/stack_recipe_list("Eyeglasses",list( \
		recipes += new/datum/stack_recipe("regular glasses", /obj/item/clothing/glasses/regular, 5, time = 5, one_per_turf = 1, on_floor = 1),
		recipes += new/datum/stack_recipe("hipster glasses", /obj/item/clothing/glasses/regular/hipster, 5, time = 5, one_per_turf = 1, on_floor = 1),
		recipes += new/datum/stack_recipe("green glasses", /obj/item/clothing/glasses/gglasses, 5, time = 5, one_per_turf = 1, on_floor = 1),
		recipes += new/datum/stack_recipe("3D glasses", /obj/item/clothing/glasses/threedglasses, 5, time = 5, one_per_turf = 1, on_floor = 1),
		recipes += new/datum/stack_recipe("monocle", /obj/item/clothing/glasses/monocle, 5, time = 5, one_per_turf = 1, on_floor = 1),
		recipes += new/datum/stack_recipe("stylish sunglasses", /obj/item/clothing/glasses/fakesunglasses, 5, time = 5, one_per_turf = 1, on_floor = 1),
		recipes += new/datum/stack_recipe("stylish sunglasses", /obj/item/clothing/glasses/fakesunglasses, 5, time = 5, one_per_turf = 1, on_floor = 1),
		recipes += new/datum/stack_recipe("big stylish sunglasses", /obj/item/clothing/glasses/fakesunglasses/big, 5, time = 5, one_per_turf = 1, on_floor = 1),


		))

	recipes += new/datum/stack_recipe("[display_name] bottle necklace", /obj/item/clothing/accessory/necklace/bottle, 15, on_floor = 1)



/material/wood/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("oar", /obj/item/weapon/oar, 2, time = 30, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("boat", /obj/vehicle/boat, 20, time = 10 SECONDS, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("dragon boat", /obj/vehicle/boat/dragon, 50, time = 30 SECONDS, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("wooden sandals", /obj/item/clothing/shoes/sandal, 1)
	recipes += new/datum/stack_recipe("wood circlet", /obj/item/clothing/head/woodcirclet, 1)
	recipes += new/datum/stack_recipe("clipboard", /obj/item/weapon/clipboard, 1)
	recipes += new/datum/stack_recipe("wooden chair", /obj/structure/bed/chair/wood, 3, time = 10, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("crossbow frame", /obj/item/weapon/crossbowframe, 5, time = 25, one_per_turf = 0, on_floor = 0)
	recipes += new/datum/stack_recipe("coffin", /obj/structure/closet/coffin, 5, time = 15, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("beehive assembly", /obj/item/beehive_assembly, 4)
	recipes += new/datum/stack_recipe("beehive frame", /obj/item/honey_frame, 1)
	recipes += new/datum/stack_recipe("book shelf", /obj/structure/bookcase, 5, time = 15, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("noticeboard frame", /obj/item/frame/noticeboard, 4, time = 5, one_per_turf = 0, on_floor = 1)
	recipes += new/datum/stack_recipe("wooden bucket", /obj/item/weapon/reagent_containers/glass/bucket/wood, 2, time = 4, one_per_turf = 0, on_floor = 0)
	recipes += new/datum/stack_recipe("coilgun stock", /obj/item/weapon/coilgun_assembly, 5)
	recipes += new/datum/stack_recipe("easel", /obj/structure/easel, 3, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("coat rack", /obj/structure/coatrack, 3, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("drying rack", /obj/machinery/smartfridge/drying_rack, 3, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("wood floor tile", /obj/item/stack/tile/wood, 1, 4, 20)
	recipes += new/datum/stack_recipe("tiled wood floor tile", /obj/item/stack/tile/wood/woodtile, 1, 4, 20)
	recipes += new/datum/stack_recipe("checkered wood floor tile", /obj/item/stack/tile/wood/woodcheck, 1, 4, 20)
	recipes += new/datum/stack_recipe("underwear wardrobe", /obj/structure/undies_wardrobe, 3, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("large crate", /obj/structure/largecrate, 3, one_per_turf = 1, on_floor = 1)

	recipes += new/datum/stack_recipe_list("Tools",list( \
		new/datum/stack_recipe("rolling pin", 		/obj/item/weapon/material/kitchen/rollingpin, 	2, time = 5, supplied_material = "[name]"),\
		new/datum/stack_recipe("gavel hammer", 		/obj/item/weapon/gavelhammer, 							2, time = 5),\
		new/datum/stack_recipe("gavel block", 		/obj/item/weapon/gavelblock, 							2, time = 3),\
		new/datum/stack_recipe("crude fishing rod",		/obj/item/weapon/material/fishing_rod, 2, time = 5, supplied_material = "[name]"),\
		))

/material/wood/ebony/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("[display_name] floor tile", /obj/item/stack/tile/wood/ebony, 1, 4, 20)

/material/wood/mahogany/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("[display_name] floor tile", /obj/item/stack/tile/wood/mahogany, 1, 4, 20)

/material/wood/maple/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("[display_name] floor tile", /obj/item/stack/tile/wood/maple, 1, 4, 20)

/material/wood/walnut/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("[display_name] floor tile", /obj/item/stack/tile/wood/walnut, 1, 4, 20)

/material/wood/bamboo/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("[display_name] floor tile", /obj/item/stack/tile/wood/bamboo, 1, 4, 20)

/material/wood/yew/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("[display_name] floor tile", /obj/item/stack/tile/wood/yew, 1, 4, 20)

/material/wood/log/generate_recipes()
	recipes = list()
	recipes += new/datum/stack_recipe("bonfire", /obj/structure/bonfire, 5, time = 50, supplied_material = "[name]")

/material/cardboard/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("box", /obj/item/weapon/storage/box)
	recipes += new/datum/stack_recipe("large box", /obj/item/weapon/storage/box/large, 3)

	recipes += new/datum/stack_recipe("donut box", /obj/item/weapon/storage/box/donut/empty)
	recipes += new/datum/stack_recipe("egg box", /obj/item/weapon/storage/fancy/egg_box)
	recipes += new/datum/stack_recipe("light tubes box", /obj/item/weapon/storage/box/lights/tubes)
	recipes += new/datum/stack_recipe("light bulbs box", /obj/item/weapon/storage/box/lights/bulbs)
	recipes += new/datum/stack_recipe("mouse traps box", /obj/item/weapon/storage/box/mousetraps)

	recipes += new/datum/stack_recipe("meat box", /obj/item/weapon/storage/box/meat_box)
	recipes += new/datum/stack_recipe("produce box", /obj/item/weapon/storage/box/produce_box)

	recipes += new/datum/stack_recipe("cardborg suit", /obj/item/clothing/suit/cardborg, 3)
	recipes += new/datum/stack_recipe("cardborg helmet", /obj/item/clothing/head/cardborg)
	recipes += new/datum/stack_recipe("pizza box", /obj/item/pizzabox)
	recipes += new/datum/stack_recipe("candle box", /obj/item/weapon/storage/box/candle_box/empty)
	recipes += new/datum/stack_recipe("picket sign", /obj/item/weapon/picket_sign)


	recipes += new/datum/stack_recipe("19px by 19px canvas", /obj/item/weapon/canvas/nineteenXnineteen, 3, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("23px by 19px canvas", /obj/item/weapon/canvas/twentythreeXnineteen, 3, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe("23px by 23px canvas", /obj/item/weapon/canvas/twentythreeXtwentythree, 3, one_per_turf = 1, on_floor = 1)
	recipes += new/datum/stack_recipe_list("folders",list( \
		new/datum/stack_recipe("blue folder", /obj/item/weapon/folder/blue), \
		new/datum/stack_recipe("grey folder", /obj/item/weapon/folder), \
		new/datum/stack_recipe("red folder", /obj/item/weapon/folder/red), \
		new/datum/stack_recipe("white folder", /obj/item/weapon/folder/white), \
		new/datum/stack_recipe("yellow folder", /obj/item/weapon/folder/yellow), \
		))
	recipes += new/datum/stack_recipe_list("paper cards",list( \
		new/datum/stack_recipe("card", /obj/item/weapon/paper/card), \
		new/datum/stack_recipe("smile card", /obj/item/weapon/paper/card/smile), \
		new/datum/stack_recipe("heart card", /obj/item/weapon/paper/card/heart), \
		new/datum/stack_recipe("cat card", /obj/item/weapon/paper/card/flower), \
		new/datum/stack_recipe("business card", /obj/item/weapon/paper/card/business),
		new/datum/stack_recipe("invitation card", /obj/item/weapon/paper/card/invitation), \
		new/datum/stack_recipe("poster", /obj/item/weapon/paper/card/poster), \
		))
/material/snow/generate_recipes()
	recipes = list()
	recipes += new/datum/stack_recipe("snowball", /obj/item/weapon/material/snow/snowball, 1, time = 10)
	recipes += new/datum/stack_recipe("snow brick", /obj/item/stack/material/snowbrick, 2, time = 10)
	recipes += new/datum/stack_recipe("snowman", /obj/structure/snowman, 2, time = 15)
	recipes += new/datum/stack_recipe("snow robot", /obj/structure/snowman/borg, 2, time = 10)
	recipes += new/datum/stack_recipe("snow spider", /obj/structure/snowman/spider, 3, time = 20)

/material/snowbrick/generate_recipes()
	recipes = list()
	recipes += new/datum/stack_recipe("[display_name] door", /obj/structure/simple_door, 10, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] barricade", /obj/structure/barricade, 5, time = 50, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] stool", /obj/item/weapon/stool, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] chair", /obj/structure/bed/chair, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] bed", /obj/structure/bed, 2, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] double bed", /obj/structure/bed/double, 4, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] wall girders", /obj/structure/girder, 2, time = 50, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")
	recipes += new/datum/stack_recipe("[display_name] ashtray", /obj/item/weapon/material/ashtray, 2, one_per_turf = 1, on_floor = 1, supplied_material = "[name]")

/material/wood/sif/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("alien wood floor tile", /obj/item/stack/tile/wood/sif, 1, 4, 20)
	recipes -= new/datum/stack_recipe("wood floor tile", /obj/item/stack/tile/wood, 1, 4, 20)
	recipes -= new/datum/stack_recipe("wooden chair", /obj/structure/bed/chair/wood, 3, time = 10, one_per_turf = 1, on_floor = 1)


/material/diamond/generate_recipes()
	..()
	recipes += new/datum/stack_recipe("[display_name] engagement ring", /obj/item/clothing/gloves/ring/engagement, 25, on_floor = 1)

/material/cotton/generate_recipes()
	recipes = list()

	recipes += new/datum/stack_recipe("[display_name] dog bed", /obj/structure/dogbed, 10, time = 20, one_per_turf = 0, on_floor = 1)
	recipes += new/datum/stack_recipe("[display_name] rag", /obj/item/weapon/reagent_containers/glass/rag, 2, time = 2, one_per_turf = 0, on_floor = 1, apply_material_color = TRUE, prefix = TRUE)
	recipes += new/datum/stack_recipe("[display_name] towel", /obj/item/clothing/suit/towel, 10, time = 20, one_per_turf = 0, on_floor = 1, apply_material_color = TRUE, prefix = TRUE)
	recipes += new/datum/stack_recipe("woven net", /obj/item/weapon/material/fishing_net, 10, time = 30 SECONDS, one_per_turf = 0, on_floor = 1, apply_material_color = TRUE)


/material/silk/generate_recipes()
	recipes = list()
	recipes += new/datum/stack_recipe("[display_name] rag", /obj/item/weapon/reagent_containers/glass/rag, 2, time = 2, one_per_turf = 0, on_floor = 1, apply_material_color = TRUE, prefix = TRUE)


/material/denim/generate_recipes()
	recipes = list()

	recipes += new/datum/stack_recipe("[display_name] rag", /obj/item/weapon/reagent_containers/glass/rag, 2, time = 2, one_per_turf = 0, on_floor = 1, apply_material_color = TRUE, prefix = TRUE)
