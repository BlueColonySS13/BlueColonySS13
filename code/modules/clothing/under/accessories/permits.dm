//This'll be used for gun permits, such as for heads of staff, antags, and bartenders

/obj/item/clothing/accessory/permit
	name = "permit"
	desc = "A permit for something."
	icon = 'icons/obj/card.dmi'
	icon_state = "permit"
	w_class = ITEMSIZE_TINY
	var/owner = 0	//To prevent people from just renaming the thing if they steal it
	var/tiered = TRUE // If this is true, this will have different tiers
	var/tier = 0	// different tiers allow different things

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
	desc = "A card indicating that the owner is allowed to carry a firearm."
	tier = 0
	price_tag = 200

/obj/item/clothing/accessory/permit/gun/tier_one
	name = "tier one weapon permit"
	desc = "A card indicating that the owner is allowed to carry a flash."
	tier = 1
	price_tag = 400

/obj/item/clothing/accessory/permit/gun/tier_two
	name = "tier two weapon permit"
	desc = "A card indicating that the owner is allowed to carry a flash and a pepperspray."
	tier = 2
	price_tag = 700

/obj/item/clothing/accessory/permit/gun/tier_three
	name = "tier three weapon permit"
	desc = "A card indicating that the owner is allowed to carry a ballistic pistols for self-defense and energy stun weaponry/energy weapons that only have a stun setting."
	tier = 3
	price_tag = 1000

/obj/item/clothing/accessory/permit/gun/tier_four
	name = "tier four weapon permit"
	desc = "A card indicating that the owner is allowed to carry flashes, pepperspray, ballistic pistols, and both stun and lethal energy guns."
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

/obj/item/clothing/accessory/permit/gun/tier_three/bar
	name = "bar shotgun permit"
	desc = "A card indicating that the owner is allowed to carry a shotgun in the bar."
	tier = 3
  
/obj/item/clothing/accessory/permit/gun/planetside
	name = "planetside gun permit"
	desc = "A card indicating that the owner is allowed to carry a firearm while on the surface."
	tiered = FALSE

/obj/item/clothing/accessory/permit/drone
	name = "drone identification card"
	desc = "A card issued by the government, indicating that the owner is a Drone Intelligence. Drones are mandated to carry this card on PolGov colonies, by law."
	icon_state = "permit_drone"
	tiered = FALSE

/obj/item/clothing/accessory/permit/synth
	name = "synth identification card"
	desc = "A card issued by the government, indicating that the owner is a Synthetic. Synths are mandated to carry this card on PolGov colonies, by law."
	icon_state = "permit_drone"
	tiered = FALSE

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
