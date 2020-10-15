//This'll be used for gun permits, such as for heads of staff, antags, and bartenders

// this  can be expanded
GLOBAL_LIST_INIT(permit_types, list(
	"Weapons Permit - Tier 0" = /obj/item/clothing/accessory/permit/gun,
	"Weapons Permit - Tier 1" = /obj/item/clothing/accessory/permit/gun/tier_one,
	"Weapons Permit - Tier 2" = /obj/item/clothing/accessory/permit/gun/tier_two,
	"Weapons Permit - Tier 3" = /obj/item/clothing/accessory/permit/gun/tier_three,
	"Weapons Permit - Tier 4" = /obj/item/clothing/accessory/permit/gun/tier_four,
	"Weapons Permit - Tier 5" = /obj/item/clothing/accessory/permit/gun/tier_five,
))

/obj/item/clothing/accessory/permit
	name = "permit"
	desc = "A permit for something."
	icon = 'icons/obj/card.dmi'
	icon_state = "permit"
	w_class = ITEMSIZE_TINY
	var/owner = 0	//To prevent people from just renaming the thing if they steal it
	var/tiered = TRUE // If this is true, this will have different tiers
	var/tier = 0	// different tiers allow different things

//	dont_save = TRUE

	unique_save_vars = list("owner", "tier")

/obj/item/clothing/accessory/permit/New()
	..()
	update_icon()

/obj/item/clothing/accessory/permit/attack_self(mob/user as mob)
	if(isliving(user))
		if(!owner)
			set_name(user.name)
			to_chat(user, "[src] registers your name.")
		else
			to_chat(user, "[src] already has an owner!")

/obj/item/clothing/accessory/permit/proc/set_name(var/new_name)
	owner = 1
	if(new_name)
		src.name += " ([new_name])"
		desc += " It belongs to [new_name]."

/obj/item/clothing/accessory/permit/update_icon()
	if(tiered)
		icon_state = "[initial(icon_state)]_[tier]"

/obj/item/clothing/accessory/permit/emag_act(var/remaining_charges, var/mob/user)
	to_chat(user, "You reset the naming locks on [src]!")
	owner = 0

/obj/item/clothing/accessory/permit/gun
	name = "tier 0 weapon permit"
	desc = "A card indicating that the owner is allowed to carry simple equipment, such as a flash, pepper spray, telescopic batons, and wooden batons."
	tier = 0
	price_tag = 200

/obj/item/clothing/accessory/permit/gun/tier_one
	name = "tier one weapon permit"
	desc = "A card indicating that the owner is allowed to carry improved simple equipment, such as flashbang grenades, stunbatons, smoke grenades, and restraining equipment."
	tier = 1
	price_tag = 400

/obj/item/clothing/accessory/permit/gun/tier_two
	name = "tier two weapon permit"
	desc = "A card indicating that the owner is allowed to carry civilian-grade lethal equipment, such as 9mm non-suppressed pistols, Bolt action rifles, EMP grenades, small knives, and  .38 revolvers."
	tier = 2
	price_tag = 700

/obj/item/clothing/accessory/permit/gun/tier_three
	name = "tier three weapon permit"
	desc = "A card indicating that the owner is allowed to carry improved civilian-grade lethal equipment, such as  .45 non suppressed firearms, CS gas grenades, lever action rifles, Desert Eagles, civilian shotguns, large knives, and NT Mk30 NL Tasers. "
	tier = 3
	price_tag = 1000

/obj/item/clothing/accessory/permit/gun/tier_four
	name = "tier four weapon permit"
	desc = "A card indicating that the owner is allowed to carry police-restricted and low-tier military equipment such as submachine guns, taser rifles,  advanced energy guns, ion weaponry, energy guns, stun revolvers, combat shotguns, and grenade launchesr."
	tier = 4
	price_tag = 1500

/obj/item/clothing/accessory/permit/gun/tier_five
	name = "tier five weapon permit"
	desc = "A card indicating that the owner is allowed to carry flashes, pepperspray, ballistic pistols, all types of energy guns, and civilian grade shotguns."
	tier = 5
	price_tag = 7000

/obj/item/clothing/accessory/permit/gun/tier_five/police
	name = "tier five police weapon permit"
	desc = "A card indicating that the owner is allowed to any type of weapon provided by the police department as long as they remain on the police force."
	tier = 5
	price_tag = 7000
	dont_save = TRUE

/obj/item/clothing/accessory/permit/gun/tier_three/bar
	name = "bar shotgun permit"
	desc = "A card indicating that the owner is allowed to carry a shotgun in the bar."
	tier = 3
	dont_save = TRUE

/obj/item/clothing/accessory/permit/gun/planetside
	name = "planetside gun permit"
	desc = "A card indicating that the owner is allowed to carry a firearm while on the surface."
	tiered = FALSE

/obj/item/clothing/accessory/permit/drone
	name = "drone identification card"
	desc = "A card issued by the government, indicating that the owner is a Drone Intelligence. Drones are mandated to carry this card on PolGov colonies, by law."
	icon_state = "permit_drone"
	tiered = FALSE
	dont_save = TRUE

/obj/item/clothing/accessory/permit/synth
	name = "synth identification card"
	desc = "A card issued by the government, indicating that the owner is a Synthetic. Synths are mandated to carry this card on PolGov colonies, by law."
	icon_state = "permit_synth"
	tiered = FALSE
	dont_save = TRUE

/obj/item/clothing/accessory/permit/fbp
	name = "full body identification card"
	desc = "A card issued by the government. It signifies that the owner is human but has a full body prosthetic as a disability. It is used to differiate the owner from synths, it is optional to wear by law."
	icon_state = "permit_fbp"
	tiered = FALSE
	dont_save = TRUE


//Some spare gun permits in a box
/obj/item/weapon/storage/box/gun_permits
	name = "box of spare gun permits"
	desc = "A box of spare gun permits."
	icon = 'icons/obj/storage.dmi'
	icon_state = "permit"
	starts_with = list(
	/obj/item/clothing/accessory/permit/gun = 5,
	/obj/item/clothing/accessory/permit/gun/tier_one = 5,
	/obj/item/clothing/accessory/permit/gun/tier_two = 5,
	/obj/item/clothing/accessory/permit/gun/tier_three = 5,
	/obj/item/clothing/accessory/permit/gun/tier_four = 5
	)

//Business permits - We should streamline this at some point//

/obj/item/clothing/accessory/permit/retail
	name = "retail license"
	desc = "A card indicating the owner is allowed to sell a controlled substance."
	icon_state = "permit_3"
	tiered = FALSE

/obj/item/clothing/accessory/permit/retail/cannabis
	name = "cannabis retail license"
	desc = "A card indicating the owner is allowed to conduct retail sales of cannabis."
	price_tag = 800

/obj/item/clothing/accessory/permit/retail/tobacco
	name = "tobacco retail license"
	desc = "A card indicating the owner is allowed to conduct retail sales of tobacco."
	price_tag = 400

/obj/item/clothing/accessory/permit/retail/alcohol
	name = "alcohol retail license"
	desc = "A card indicating the owner is allowed to conduct retail sales of alcohol."
	price_tag = 400

/obj/item/clothing/accessory/permit/firearms
	name = "firearms retail license"
	desc = "A card indicating the owner is allowed to conduct retail sales of firearms."
	price_tag = 400

/obj/item/clothing/accessory/permit/production
	name = "production license"
	desc = "A card indicating the owner is allowed to produce and distribute a controlled substance to licensed industries."
	icon_state = "permit_5"
	tiered = FALSE

/obj/item/clothing/accessory/permit/production/cannabis
	name = "cannabis production license"
	desc = "A card indicating the owner is allowed to grow and distribute cannabis to licensed industries."
	price_tag = 800

/obj/item/clothing/accessory/permit/production/blades
	name = "bladed weapon production license"
	desc = "A card indicating the owner is allowed to manufacture and distribute bladed weapons to licensed industries."
	price_tag = 400

/obj/item/clothing/accessory/permit/production/firearms
	name = "firearms manufacturing license"
	desc = "A card indicating the owner is allowed to manufacture and distribute firearms to licensed industries."
	price_tag = 400

/obj/item/weapon/storage/box/permits
	name = "box of permits"
	desc = "A box of business related permits."
	icon = 'icons/obj/storage.dmi'
	icon_state = "permit"
	starts_with = list(
	/obj/item/clothing/accessory/permit/retail/cannabis = 5,
	/obj/item/clothing/accessory/permit/retail/tobacco = 5,
	/obj/item/clothing/accessory/permit/retail/alcohol = 5,
	/obj/item/clothing/accessory/permit/firearms = 5,
	/obj/item/clothing/accessory/permit/production = 5,
	/obj/item/clothing/accessory/permit/production/cannabis = 5,
	/obj/item/clothing/accessory/permit/production/blades = 5,
	/obj/item/clothing/accessory/permit/production/firearms = 5)