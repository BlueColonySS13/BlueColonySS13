/obj/item/device/calories_scanner
	name = "calories scanner"
	desc = "Calculates the sugars, fats and lipids and their calorific value so dieters can be even pickier."
	icon_state = "calorie_scanner"
	origin_tech = list(TECH_MATERIAL = 6)
	var/scan_sound = 'sound/effects/checkout.ogg'
	var/on = TRUE

/obj/item/device/calories_scanner/attack_self(mob/user)
	if(user.incapacitated())
		return

	on = !on
	if(on)
		to_chat(user, "<span class='notice'>You turn \the [src] on.</span>")
	else
		to_chat(user, "<span class='notice'>You turn \the [src] off.</span>")


/obj/item/device/calories_scanner/afterattack(obj/item/weapon/reagent_containers/target, mob/user)
	if(!on)
		return

	var/calories = 0
	calories += target.get_calories()
	user.show_message("\The [target]: [calories] calories.")
	playsound(src, scan_sound, 25)