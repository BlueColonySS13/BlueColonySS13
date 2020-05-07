/obj/item/weapon/rig/xenoarch
	name = "absolute exclusion harness control module"
	desc = "A rig suit designed to protect from the most powerful of anomalous energies."
	icon_state = "ninja_rig"
	suit_type = "light suit"
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit,/obj/item/weapon/cell)
	armor = list(melee = 50, bullet = 15, laser = 50, energy = 10, bomb = 25, bio = 100, rad = 100)
	emp_protection = 10
	slowdown = 0
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL
	offline_slowdown = 0
	offline_vision_restriction = 0

	chest_type = /obj/item/clothing/suit/space/rig/xenoarch
	helm_type =  /obj/item/clothing/head/helmet/space/rig/xenoarch
	boot_type =  /obj/item/clothing/shoes/magboots/rig/xenoarch
	glove_type = /obj/item/clothing/gloves/gauntlets/rig/xenoarch

/obj/item/clothing/suit/space/rig/xenoarch
	name = "absolute exclusion harness"
	desc = "The chestpiece of the absolute exclusion harness. A hefty reality anchor on the back insulates the suit from anomalous energies."
	breach_threshold = 18 //comparable to voidsuits

/obj/item/clothing/gloves/gauntlets/rig/xenoarch
	name = "absolute exclusion gauntlets"
	desc = "The gauntlets of the absolute exclusion harness. They contain various deployable modules."

/obj/item/clothing/shoes/magboots/rig/xenoarch
	name = "absolute exclusion boots"
	desc = "The boots of the absolute exclusion harness. They have powerful electromagnets in the event of spontaneous gravity loss or anomalous electromagnetic events."
	step_volume_mod = 0.8

/obj/item/clothing/head/helmet/space/rig/xenoarch
	name = "absolution exclusion hood"
	desc = "The hood of the absolute exclusion harness. It features an electronically deployable air mask."