/obj/structure/stack_holder
	name = "stack holder"
	desc = "Allows you to hold a large number of materials, less fuss!"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "stack_holder"
	var/base_icon_state = "stack_holder"
	var/static_state = FALSE

	anchored = FALSE
	density = TRUE

	var/holder_title = "Stack Holder"

	var/list/stacks_excluded = list()
	var/list/stack_types_allowed = list() // if this is populated, it will only accept from these stacks
	var/list/stacks_held = list()

	unique_save_vars = list("stacks_held")

	var/busy = FALSE

// types

/obj/structure/stack_holder/metals
	name = "metals holder"
	holder_title = "Solid Metals Holder"

	stack_types_allowed = list(
	/obj/item/stack/material/steel,
	/obj/item/stack/material/plasteel,
	/obj/item/stack/material/durasteel,
	/obj/item/stack/material/deuterium,
	/obj/item/stack/material/osmium,
	/obj/item/stack/material/tritium,
	/obj/item/stack/material/mhydrogen,
	/obj/item/stack/material/aluminium,
	/obj/item/stack/material/titanium,
	/obj/item/stack/material/platinum,
	/obj/item/stack/material/silver,
	/obj/item/stack/material/gold,
	/obj/item/stack/material/iron,
	/obj/item/stack/material/lead,
	/obj/item/stack/material/copper,
	/obj/item/stack/material/tin,
	/obj/item/stack/material/bronze,
	/obj/item/stack/rods,

	)

/obj/structure/stack_holder/gem
	name = "gemstone cabinet"
	holder_title = "Precious Gems and Stones Cabinet"

	static_state = TRUE
	icon_state = "gemstone_holder"
	base_icon_state = "gemstone_holder"

	stack_types_allowed = list(
	/obj/item/stack/material/diamond,
	/obj/item/stack/material/uranium,
	/obj/item/stack/material/phoron,
	/obj/item/stack/material/painite,
	/obj/item/stack/material/void_opal,
	/obj/item/stack/material/quartz,
	/obj/item/stack/material/sandstone,
	/obj/item/stack/material/marble,


	)

/obj/structure/stack_holder/refined
	name = "refined materials holder"
	holder_title = "Wood, Glass and Refined Materials Holder"

	static_state = TRUE
	icon_state = "refined_holder"
	base_icon_state = "refined_holder"

	stack_types_allowed = list(
	/obj/item/stack/material/glass,
	/obj/item/stack/material/wood,
	/obj/item/stack/material/log,
	/obj/item/stack/material/cardboard,
	/obj/item/stack/material/snow,
	/obj/item/stack/material/snowbrick,
	/obj/item/stack/material/plastic,
	/obj/item/stack/wax,
	)

/obj/structure/stack_holder/fabric
	name = "fabrics storage"
	holder_title = "Fabrics Storage"

	static_state = TRUE
	icon_state = "fabric_holder"
	base_icon_state = "fabric_holder"

	stack_types_allowed = list(
	/obj/item/stack/material/leather,
	/obj/item/stack/material/silk,
	/obj/item/stack/material/cotton,
	/obj/item/stack/material/denim,
	/obj/item/stack/material/wool,
	/obj/item/stack/material/polychromatic_thread,
	/obj/item/stack/material/animalhide,
	/obj/item/stack/material/hairlesshide,

	)

/obj/structure/stack_holder/tiles
	name = "tiles holder"
	holder_title = "Tiles Storage"

	static_state = TRUE
	icon_state = "tiles_holder"
	base_icon_state = "tiles_holder"

	stack_types_allowed = list(
	/obj/item/stack/tile,

	)

/obj/structure/stack_holder/medical
	name = "medical cabinet"
	holder_title = "Medical Cabinet"

	static_state = TRUE
	icon_state = "medical_holder"
	base_icon_state = "medical_holder"

	stack_types_allowed = list(
	/obj/item/stack/medical,
	/obj/item/stack/nanopaste,

	)

// structural code

/obj/structure/stack_holder/on_persistence_load()
	..()
	sanitize_stacks()

/obj/structure/stack_holder/update_icon()
	if(!static_state)
		if(LAZYLEN(stacks_held) >= 5)
			icon_state = "[base_icon_state]5"
		else
			icon_state = "[base_icon_state][LAZYLEN(stacks_held)]"
	else
		icon_state = base_icon_state

/obj/structure/stack_holder/initialize()
	. = ..()
	update_icon()

/obj/structure/stack_holder/proc/sanitize_stacks()
	if(!stacks_held)
		stacks_held = list()

	if(LAZYLEN(stacks_held))
		for(var/S in stacks_held)
			if(!is_path_in_list(S, stack_types_allowed))
				remove_stack(S, stacks_held[S])


/obj/structure/stack_holder/attack_hand(mob/user)
	..()
	src.add_fingerprint(user)

	interact(user)
	updateDialog()

/obj/structure/stack_holder/interact(mob/user)
	var/dat

	dat = get_full_data(user)

	var/datum/browser/popup = new(user, "stack_holder", "[src]", 400, 480, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "stack_holder")

/obj/structure/stack_holder/proc/get_full_data(mob/user)
	var/dat = "<h1>[holder_title]</h1><hr>"

	dat += "<table>"
	if(LAZYLEN(stacks_held))
		for(var/S in stacks_held)
			var/amount = stacks_held[S]
			if(!amount || 1 > amount)
				continue

			dat += "<tr><td>"
			var/obj/item/stack/tmp = S
			var/stack_name = initial(tmp.name)
			var/max_stack = initial(tmp.max_amount)
			dat += "<b>[stack_name]</b>: [amount] stack(s) | Retrieve: "

			dat += "<a href='?src=\ref[src];choice=retrieve;stack=[S];amount=1'>x1</a>"

			if(amount > 5 && !(5 > max_stack))
				dat += "<a href='?src=\ref[src];choice=retrieve;stack=[S];amount=5'>x5</a>"

			if(amount > 10 && !(10 > max_stack))
				dat += "<a href='?src=\ref[src];choice=retrieve;stack=[S];amount=10'>x10</a>"

			if(amount > 30 && !(30 > max_stack))
				dat += "<a href='?src=\ref[src];choice=retrieve;stack=[S];amount=30'>x30</a>"

			if(max_stack && !(max_stack > amount))
				dat += "<a href='?src=\ref[src];choice=retrieve;stack=[S];amount=[max_stack]'>x[max_stack]</a>"

			dat += "</td></tr>"
	else
		dat += "There are no stacks in this holder."
	dat += "</table>"

	return dat

/obj/structure/stack_holder/attackby(obj/item/I, mob/user)
	if(!I)
		return

	if(busy)
		to_chat(user,"<span class='notice'>\The [src] is currently being used, please wait.</span>")
		return

	if (istype(I, /obj/item/weapon/wrench))
		if(trigger_lot_security_system(user, /datum/lot_security_option/theft, "Attempted to unwrench [src] with \the [I]."))
			return

		playsound(src.loc, I.usesound, 50, 1)
		to_chat(user,"<span class='notice'>You begin to [anchored ? "loosen" : "tighten"] \the [src]'s fixtures...</span>")
		if (do_after(user, 40 * I.toolspeed))
			user.visible_message( \
				"[user] [anchored ? "loosens" : "tightens"] \the [src]'s casters.", \
				"<span class='notice'>You have [anchored ? "loosened" : "tightened"] \the [src]. It is [anchored ? "now secured" : "moveable"].</span>", \
				"You hear ratchet.")
			anchored = !anchored

		return

	if(I.dont_save)
		to_chat(user,"<span class='notice'>\The [I] is protected from entering this unit.</span>")
		return

	if(!istype(I, /obj/item/stack))
		return

	var/obj/item/stack/stack = I

	if(!stack.stacktype)
		return


	if(!is_type_in_list(stack, stack_types_allowed))
		to_chat(user,"<span class='notice'>\The [src] does not accept this kind of stack.</span>")
		return

	if(is_type_in_list(stack, stacks_excluded))
		to_chat(user,"<span class='notice'>You cannot put \the [stack] in [src].</span>")
		return

	if(istype(stack, /obj/item/stack) && add_stack(stack, user))
		to_chat(user,"<span class='notice'>You add [stack] to \the [src].</span>")
		return




/obj/structure/stack_holder/proc/add_stack(var/obj/item/stack/stack, mob/user)
	if(busy || !stack || !istype(stack) || !stack.amount || !stack.stacktype )
		return

	busy = TRUE

	if(user)
		user.drop_from_inventory(stack, src)
	stack.forceMove(src)

	stacks_held[stack.stacktype] += stack.amount

	qdel(stack)
	update_icon()

	busy = FALSE

	updateDialog()

	return TRUE

/obj/structure/stack_holder/proc/remove_stack(stack_type, amount)
	if(busy || !stack_type || !amount || (0 > amount) || !(stack_type in stacks_held))
		return

	if(amount > stacks_held[stack_type])
		amount = stacks_held[stack_type]

	if(!amount)
		return

	busy = TRUE

	var/obj/item/stack/stack = new stack_type(get_turf(src))

	stack.amount = amount
	stack.update_icon()

	stacks_held[stack.stacktype] -= stack.amount

	if(0 > stacks_held[stack.type])
		stacks_held -= stack.stacktype

	update_icon()

	busy = FALSE

	return TRUE


/obj/structure/stack_holder/Topic(var/href, var/href_list)
	if(..())
		return 1

	// Choices menus
	if(href_list["choice"])
		switch(href_list["choice"])
			if("retrieve")
				var/S = text2path(href_list["stack"])
				var/amount = text2num(href_list["amount"])

				if(!(S in stacks_held) || !amount)
					return

				if(trigger_lot_security_system(usr, /datum/lot_security_option/theft, "Attempted to remove items from \the [src]."))
					return

				remove_stack(S, amount)

	updateDialog()

