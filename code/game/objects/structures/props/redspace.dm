/obj/structure/prop/redspace
	name = "highly advanced machine"
	desc = "You have no idea what this is."
	density = 1
	anchored = 1

/obj/structure/prop/redspace/containment_pylon
	name = "enigmatic machine"
	desc = "A towering pylon that hums with a strange energy. A thick, viscous fluid flows through massive cables at its center."
	icon = 'icons/obj/props/redspace_containment_pylon.dmi'
	interaction_message = "<span class='warning'>The machine's humming increases in amplitude after you touch it. It would be wise to leave it alone.</span>"

/obj/structure/prop/redspace/artillery
	name = "esoteric cannon"
	desc = "A machine that looks like a laser gun, only scaled up thousands of times. It looks like it could do some serious damage, should it be fired."
	icon = 'icons/obj/props/redspace_artillery.dmi'
	interaction_message = "<span class='notice'>You think twice before touching the machine.</span>"

/obj/item/device/redspace_key
	name = "mysterious object"
	desc = "What does it do?"
	icon = 'icons/obj/props/redspace_key.dmi'
	icon_state = "key1"
	var/active = 1

/obj/item/device/redspace_key/New()
	if(prob(25))
		active = 0

/obj/item/device/redspace_key/update_icon()
	if(active)
		icon_state = "key1"
	else
		icon_state = "key0"