//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:33

//All devices that link into the R&D console fall into thise type for easy identification and some shared procs.

/obj/machinery/r_n_d
	name = "R&D Device"
	icon = 'icons/obj/machines/research.dmi'
	density = 1
	anchored = 1
	use_power = 1
	var/busy = 0
	var/obj/machinery/computer/rdconsole/linked_console

	var/list/materials = list()

/obj/machinery/r_n_d/attack_hand(mob/user as mob)
	return

/obj/machinery/r_n_d/proc/getMaterialType(var/name)
	switch(name)
		if(DEFAULT_WALL_MATERIAL)
			return /obj/item/stack/material/steel
		if("glass")
			return /obj/item/stack/material/glass
		if("plastic")
			return /obj/item/stack/material/plastic
		if("gold")
			return /obj/item/stack/material/gold
		if("silver")
			return /obj/item/stack/material/silver
		if("osmium")
			return /obj/item/stack/material/osmium
		if("phoron")
			return /obj/item/stack/material/phoron
		if("uranium")
			return /obj/item/stack/material/uranium
		if("diamond")
			return /obj/item/stack/material/diamond
		if("copper")
			return /obj/item/stack/material/copper
		if("aluminium")
			return /obj/item/stack/material/aluminium
		if("void opal")
			return /obj/item/stack/material/void_opal
		if("titanium")
			return /obj/item/stack/material/titanium
	return null

/obj/machinery/r_n_d/proc/getMaterialName(var/type)
	switch(type)
		if(/obj/item/stack/material/steel)
			return DEFAULT_WALL_MATERIAL
		if(/obj/item/stack/material/glass)
			return "glass"
		if(/obj/item/stack/material/plastic)
			return "plastic"
		if(/obj/item/stack/material/gold)
			return "gold"
		if(/obj/item/stack/material/silver)
			return "silver"
		if(/obj/item/stack/material/osmium)
			return "osmium"
		if(/obj/item/stack/material/phoron)
			return "phoron"
		if(/obj/item/stack/material/uranium)
			return "uranium"
		if(/obj/item/stack/material/diamond)
			return "diamond"
		if(/obj/item/stack/material/copper)
			return "copper"
		if(/obj/item/stack/material/aluminium)
			return "aluminium"
		if(/obj/item/stack/material/void_opal)
			return "void opal"
		if(/obj/item/stack/material/titanium)
			return "titanium"

/obj/machinery/r_n_d/proc/eject(var/material, var/amount)
	if(!(material in materials))
		return
	var/obj/item/stack/material/sheetType = getMaterialType(material)
	var/perUnit = initial(sheetType.perunit)
	var/eject = round(materials[material] / perUnit)
	eject = amount == -1 ? eject : min(eject, amount)
	if(eject < 1)
		return
	var/obj/item/stack/material/S = new sheetType(loc)
	S.amount = eject
	materials[material] -= eject * perUnit