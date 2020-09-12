// chips for various games.

/obj/item/stack/chip
	name = "black gambling chip"
	icon_state = "chip"
	stack_color = COLOR_DARK_GRAY
	var/chip_worth = 100

/obj/item/stack/chip/examine(mob/user)
	..()
	to_chat(user, "It is worth <b>[chip_worth]CR</b> per chip.")
	to_chat(user, "Approx <b>[chip_worth * amount]CR</b> in value.")

/obj/item/stack/chip/red
	name = "red gambling chip"
	stack_color = COLOR_NT_RED
	chip_worth = 50

/obj/item/stack/chip/yellow
	name = "yellow gambling chip"
	stack_color = COLOR_YELLOW
	chip_worth = 200

/obj/item/stack/chip/green
	name = "green gambling chip"
	stack_color = COLOR_GREEN
