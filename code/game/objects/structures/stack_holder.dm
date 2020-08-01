/obj/structure/stack_holder
	name = "stack holder"
	desc = "Allows you to hold a large number of materials, less fuss!"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "stack_holder"
	var/base_icon_state = "stack_holder"

	anchored = TRUE
	density = TRUE

	var/stacks_held = list()
	var/stacks_excluded = list()

/obj/structure/stack_holder/update_icon()
	if(LAZYLEN(stacks_held) >= 5)
		icon_state = "[base_icon_state]5"
	else
		icon_state = "[base_icon_state][LAZYLEN(stacks_held)]"

/obj/structure/stack_holder/initialize()
	. = ..()
	update_icon()


/obj/structure/stack_holder/attack_hand(mob/user as mob)
	var/dat = "<center><table>"
	if(LAZYLEN(stacks_held))
		for(var/S in stacks_held)
			dat += "<tr><td><a href='?src=\ref[src];retrieve=\ref[S]'>[S]</a></td></tr>"
	else
		dat += "There are no stacks in this holder."
	dat += "</table></center>"
	user << browse("<html><head><title>[name]</title></head><body>[dat]</body></html>", "window=filingcabinet;size=350x300")

	return


/obj/structure/stack_holder/proc/add_stack(var/obj/item/stack/stack)
	if(!stack || !istype(stack) || !stack.amount)
		return

	if(stack.type in stacks_excluded)
		return

	stacks_held[stack.type] += stack.amount

	qdel(stack)
	update_icon()

	return TRUE

/obj/structure/stack_holder/proc/remove_stack(stack_type, amount)
	if(!stack_type || !amount || (0 > amount) || !(stack_type in stacks_held))
		return

	if(amount > stacks_held[stack_type])
		amount = stacks_held[stack_type]

	var/obj/item/stack/stack = new stack_type(get_turf(src))

	stack.amount = amount
	stack.update_icon()

	stacks_held[stack.type] -= stack.amount

	if(0 > stacks_held[stack.type])
		stacks_held -= stack.type

	return TRUE


