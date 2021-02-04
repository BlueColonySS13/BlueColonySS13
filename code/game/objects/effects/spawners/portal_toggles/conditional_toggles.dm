/obj/effect/spawner/conditional_spawn
	name = "Conditional Spawner"
	desc = "Technically you shouldn't see this. Report to an admin if you do."
	icon = 'icons/effects/conditional_spawners.dmi'
	icon_state = "template"
	var/things_to_spawn = list()
	var/portal_id = "" // needs portal id here. if set to "TRUE" it will spawn this item

/obj/effect/spawner/conditional_spawn/New()
	var/enabled = 0
	if(portal_id)
		enabled = SSpersistent_options.get_persistent_option_value(portal_id)

	if(enabled)
		for(var/V in things_to_spawn)
			new V(loc)

	qdel(src)

// Council spawners
/obj/effect/spawner/conditional_spawn/council
	name = "Council Spawner"

/obj/effect/spawner/conditional_spawn/council/water_coolers
	name = "Water Cooler Spawner"
	icon_state = "water_cooler"
	portal_id = "qol_water_coolers"
	things_to_spawn = list(/obj/structure/reagent_dispensers/water_cooler/full)

/obj/effect/spawner/conditional_spawn/council/food_stamps
	name = "Food Stamps Machine Spawner"
	icon_state = "food_stamps"
	portal_id = "qol_food_stamps"
	things_to_spawn = list(/obj/machinery/vending/foodstamp/rations)

/obj/effect/spawner/conditional_spawn/council/cleaning_bots
	name = "City Cleaning Bots Spawner"
	icon_state = "cleanbot"
	portal_id = "qol_cleaning_bots"
	things_to_spawn = list(/mob/living/bot/cleanbot)

/obj/effect/spawner/conditional_spawn/council/sec_bots
	name = "City Secbots Spawner"
	icon_state = "secbot"
	portal_id = "sec_securitrons"
	things_to_spawn = list(/mob/living/bot/secbot)

/obj/effect/spawner/conditional_spawn/council/sec_bots
	name = "City Secbots Spawner"
	icon_state = "secbot"
	portal_id = "sec_securitrons"
	things_to_spawn = list(/mob/living/bot/secbot)