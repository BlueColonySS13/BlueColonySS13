/*
*	Here is where any supply packs
*	related to recreation live.
*/


/datum/supply_pack/recreation
	group = "Recreation"

/datum/supply_pack/randomised/recreation
	group = "Recreation"

/datum/supply_pack/recreation/foam_weapons
	name = "Foam Weapon Crate"
	contains = list(
			/obj/item/weapon/material/sword/foam = 2,
			/obj/item/weapon/material/twohanded/baseballbat/foam = 2,
			/obj/item/weapon/material/twohanded/spear/foam = 2,
			/obj/item/weapon/material/twohanded/fireaxe/foam = 2
			)
	cost = 50
	containertype = /obj/structure/closet/crate
	containername = "foam weapon crate"


/datum/supply_pack/recreation/fortune_teller
	name = "Fortune Teller Set"
	contains = list(
			/obj/item/toy/crystal_ball,
			/obj/item/clothing/head/skull,
			/obj/item/weapon/flame/candle/black = 2,
			/obj/item/weapon/flame/candle/candelabra/black = 1,


			)
	containertype = /obj/structure/closet/crate
	containername = "Fortune Teller Set"
	cost = 300

/datum/supply_pack/recreation/lasertag
	name = "Lasertag equipment"
	contains = list(
			/obj/item/weapon/gun/energy/lasertag/red,
			/obj/item/clothing/suit/redtag,
			/obj/item/weapon/gun/energy/lasertag/blue,
			/obj/item/clothing/suit/bluetag
			)
	containertype = /obj/structure/closet
	containername = "Lasertag Closet"
	cost = 40

/datum/supply_pack/recreation/artscrafts
	name = "Arts and Crafts supplies"
	contains = list(
			/obj/item/weapon/storage/fancy/crayons,
			/obj/item/weapon/storage/fancy/markers,
			/obj/item/device/camera,
			/obj/item/device/camera_film = 2,
			/obj/item/weapon/storage/photo_album,
			/obj/item/weapon/packageWrap,
			/obj/item/weapon/reagent_containers/glass/paint/red,
			/obj/item/weapon/reagent_containers/glass/paint/green,
			/obj/item/weapon/reagent_containers/glass/paint/blue,
			/obj/item/weapon/reagent_containers/glass/paint/yellow,
			/obj/item/weapon/reagent_containers/glass/paint/purple,
			/obj/item/weapon/reagent_containers/glass/paint/black,
			/obj/item/weapon/reagent_containers/glass/paint/white,
			/obj/item/weapon/contraband/poster,
			/obj/item/weapon/wrapping_paper = 3
			)
	cost = 10
	containertype = "/obj/structure/closet/crate"
	containername = "Arts and Crafts crate"

/datum/supply_pack/recreation/painters
	name = "City Painting Supplies"
	cost = 30
	containername = "city painting supplies crate"
	containertype = /obj/structure/closet/crate
	contains = list(
			/obj/item/device/pipe_painter = 2,
			/obj/item/device/floor_painter = 2,
			/obj/item/device/closet_painter = 2
			)

/datum/supply_pack/recreation/gym_equipment
	name = "Gym Equipment"
	cost = 1200
	containername = "gym equipment crate"
	containertype = /obj/structure/largecrate
	contains = list(
			/obj/item/frame/plastic/punchingbag = 2,
			/obj/item/frame/weightlifter = 2
			)
