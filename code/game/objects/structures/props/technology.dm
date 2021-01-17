/obj/structure/prop/tech
	name = "Technology Prop"
	desc = "You shouldn't be seeing this"


// Consoles - Edit any further info in the map editor. (i.e. Name, Desc, Interaction Message) //
/obj/structure/prop/tech/console
	name = "console"
	desc = "A stationary computer console."
	icon = 'icons/obj/props/consoles.dmi'
	icon_state = "standby"
	density = TRUE
	anchored = TRUE
	interaction_message = "<span class='notice'>There is nothing of importance on this console.</span>"

/obj/structure/prop/tech/console/crew
	desc = "A stationary computer console. It seems to be linked to some sort of auxiliary biometrics hardware."
	icon_state = "crew"
	interaction_message = "<span class='notice'>An endless stream of biometrics data can be seen on the screen.</span>"

/obj/structure/prop/tech/console/crew/warning
	icon_state = "crew-red"
	interaction_message = "<span class='notice'>The screen flashes a warning concerning the biometrics data on the screen.</span>"

/obj/structure/prop/tech/console/bsod
	desc = "A stationary computer console. An error message is displayed."
	icon_state = "bsod"
	interaction_message = "<span class='notice'>There is no hope of troubleshooting this console. Nothing can be gained from it.</span>"

/obj/structure/prop/tech/console/bsod/error
	icon_state = "error"

/obj/structure/prop/tech/console/bluespace
	icon_state = "teleport"
	desc = "A stationary computer console. It seems to be linked to some sort of auxiliary Bluespace hardware."
	interaction_message = "<span class='notice'>Information regarding whatever auxiliary Bluespace hardware this console is linked to can be seen on the screen. \
						  Only a skilled Bluespace Technician can make sense of it, however.</span>"

/obj/structure/prop/tech/console/comms
	desc = "A stationary computer console. It seems to be some form of communications monitor."
	icon_state = "comm_monitor"
	interaction_message = "<span class='notice'>The information on this console is in its raw form and is undecipherable without additional hardware or software support.</span>"

/obj/structure/prop/tech/console/nanotrasen
	desc = "A stationary computer console. The NanoTrasen logo flashes on it."
	icon_state = "standby"
	interaction_message = "<span class='notice'>The NanoTrasen logo can be seen on the screen.</span>"

/obj/structure/prop/tech/console/off
	desc = "A station computer console. It is turned off."
	icon_state = "off"
	interaction_message = "<span class='notice'>The console does not respond.</span>"

/obj/structure/prop/tech/console/broken
	desc = "A broken stationary computer console."
	icon_state = "broken"
	interaction_message = "<span class='notice'>The screen is cracked and burns are visible across the interface. There's no hope of repair for this console.</span>"

/obj/structure/prop/tech/console/laptop
	name = "laptop"
	desc = "A portable laptop computer"
	icon_state = "lapmon1"
	interaction_message = "<span class='notice'>There is nothing of importance on this laptop.</span>"

/obj/structure/prop/tech/console/laptop/monitor_1
	icon_state = "lapmon1"
	interaction_message = "<span class='notice'>There is some data on the screen but you have no context for it.</span>"

/obj/structure/prop/tech/console/laptop/monitor_2
	icon_state = "lapmon2"
	interaction_message = "<span class='notice'>There is some data on the screen but you have no context for it. It is flashing a warning.</span>"

/obj/structure/prop/tech/console/laptop/monitor_3
	icon_state = "lapmon3"
	interaction_message = "<span class='notice'>There is some data on the screen but you have no context for it. There seems to be a critical error.</span>"

/obj/structure/prop/tech/dna_vault
	name = "engimatic machine"
	desc = "A very large machine covered in flashing lights and buttons."
	icon = 'icons/obj/props/dna_vault.dmi'
	icon_state = "vault 0,0" //Generate new instances via icon_state
	interaction_message = "<span class='notice'>The amount of data being processed on this machine is astronomical. There appears to be a countless number \
							of genetic combinations being tested. The question is... why?</span>"
	light_range = 2
	light_power = 2
	light_color = "#b2ebf2"

/obj/structure/prop/tech/turret_destroyed
	name = "destroyed turret"
	desc = "A very tough looking turret that was made to be more durable that standard variants. This one looks destroyed, thankfully."
	icon = 'icons/obj/turrets.dmi'
	icon_state = "destroyed"
	interaction_message = "<span class='notice'>This turret has seen better days. It looks like any useful components have been stripped from it, leaving only \
	damaged wiring and a chassis useful only for melting down.</span>"