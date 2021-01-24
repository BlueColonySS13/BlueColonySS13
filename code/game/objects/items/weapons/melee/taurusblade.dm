/*   The blade has enough code to warrant its own file   */

/obj/item/weapon/melee/taurusblade
	name = "Taurus"
	desc = "A blade made with the bone of some great creature. Its surface shifts and morphs before your very eyes."
	icon_state = "taurus_ein"
	item_state = "taurus_ein"
	slot_flags = SLOT_BELT | SLOT_BACK
	force = 25
	throwforce = 10
	w_class = ITEMSIZE_LARGE
	sharp = 1
	edge = 1
	attack_verb = list("sliced", "slashed", "cut", "pierced", "diced", "torn")
	hitsound = 'sound/weapons/bladeslice.ogg'
	unacidable = TRUE
	origin_tech = list(TECH_ARCANE = 5, TECH_COMBAT = 5, TECH_MATERIAL = 7, TECH_BLUESPACE = 4) //shapeshifting redspace sword
	var/current_form = "longsword"
	var/maturity = 0 //The power of the blade. Increases when fed with souls.
	unique_save_vars = list("maturity")
	var/list/voice_mobs = list()
	can_speak = 1

/obj/item/weapon/melee/taurusblade/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(default_parry_check(user, attacker, damage_source) && prob(50))
		user.visible_message("<span class='danger'>\The [user] parries [attack_text] with \the [src]!</span>")
		playsound(user.loc, 'sound/weapons/punchmiss.ogg', 50, 1)
		return 1
	return 0

/obj/item/weapon/melee/taurusblade/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/device/soulstone))
		var/mob/living/simple_mob/construct/A = locate() in W
		if(!A)
			to_chat(user,"<span class='notice'>\The [W] does nothing to \the [src]</span>")
		else
			maturity += 5
			user.visible_message("<span class='danger'>[user]'s [W] glows menacingly and shatters as [A] is pulled out of \the [W] and into \the [src].</span>", \
			"<span class='danger'>Your [W] glows menacingly and shatters as [A] is pulled out of \the [W] and into \the [src].</span>")
			playsound(user.loc, 'sound/hallucinations/wail.ogg', 50, 1)
			user.drop_item()
			qdel(W)

	if(istype(W, /obj/item/weapon/melee/cursedblade))
		var/obj/item/weapon/melee/cursedblade/CB = W
		if(!CB.voice_mobs)
			to_chat(user,"<span class='notice'>\The [W] does nothing to \the [src]</span>")
		else
			maturity += 15
			user.visible_message("<span class='danger'>[user]'s [W] glows menacingly and shatters as the soul inside is pulled out of [W] and into \the [src].</span>", \
			"<span class='danger'>Your [W] glows menacingly and shatters as the soul inside is pulled out of [W] and into \the [src].</span>")
			playsound(user.loc, 'sound/hallucinations/wail.ogg', 50, 1)
			user.drop_item()
			qdel(W)
			new /obj/item/device/soulstone(get_turf(user))

/obj/item/weapon/melee/taurusblade/suicide_act(mob/user)
	var/datum/gender/TU = gender_datums[user.get_visible_gender()]
	user.visible_message("<span class='danger'>[user] is falling on \the [src]! It looks like [TU.he] [TU.is] trying to commit suicide.</span>")
	return(BRUTELOSS)

/* /obj/item/weapon/melee/taurusblade/verb/veilshift()
	set name = "Veilshift"
	set category = "Taurus"
	set desc = "Tear the Veil asunder with the Taurus and transport yourself to a new location in Redspace."
	set src in usr

	usr.forcesay("Op'nau til Sie'Hei-Rot nost!") */

/obj/item/weapon/melee/taurusblade/verb/morph_form()
	set name = "Any: Transmogrify Blade"
	set category = "Taurus"
	set desc = "Exploit the non-euclidean nature of the Taurus to change its weapon form."
	set src in usr

	var/mob/living/M = loc

	if(maturity < 30)
		to_chat(usr, "\The [src] hums menacingly and doesn't respond to your mental command.")
		return
	else
		transmogrify(current_form)
		M.update_inv_l_hand()
		M.update_inv_r_hand()

/*/obj/item/weapon/melee/taurusblade/verb/boomerang(var/mob/living/carbon/target in living_mobs(7))
	set name = "Chakram: Boomerang"
	set category = "Taurus"
	set desc = "Launch the deadly Taurus Chakram at a target and have it return to your hand."
	set src in usr

	var/mob/living/M = loc

	if(current_form != "chakram")
		to_chat(usr, "\The [src] must be in its chakram form to utilize this ability!")
		return
	else
		if(usr.incapacitated())
			to_chat(usr, "<span class='warning'>You can't use this ability while incapacitated!</span>")
			return
		else
			if(maturity < 100)
				to_chat(usr, "\The [src] is far too weak for you to utilize this ability!")

			else
				visible_message("<span class='danger'>\The [src] roars to life and flies out of [usr]'s hand towards [target]!</span>")
				bangarang(target, M)

/obj/item/weapon/melee/taurusblade/proc/bangarang(var/target, var/mob/living/carbon/human/user)
	embed_chance = 100
	user.drop_from_inventory(src, src.loc)
	throw_at(target, 7, 4)
	if(ishuman(src.loc)) //Stolen code from Yank Out Object verb - hehehehe
		var/mob/living/carbon/human/H = src.loc
		var/obj/item/organ/external/affected

		for(var/obj/item/organ/external/organ in H.organs) //Grab the organ holding the implant.
			for(var/obj/item/O in organ.implants)
				if(O == src)
					affected = organ

		affected.implants -= src
		H.shock_stage+=20
		affected.take_damage((src.w_class * 3), 0, 0, 1, "Embedded object extraction")

		if(prob(src.w_class * 5) && (affected.robotic < ORGAN_ROBOT)) //I'M SO ANEMIC I COULD JUST -DIE-.
			var/datum/wound/internal_bleeding/I = new (min(src.w_class * 5, 15))
			affected.wounds += I
			H.custom_pain("Something tears wetly in your [affected] as \the [src] is pulled free!", 50)
			src.forceMove(get_turf(H))
			src.throwforce = 0 //Don't let it hurt you on the way back!
			src.embed_chance = 0 //Normal embed chance
			throw_at(user,7,4)
			user.put_in_active_hand(src)
			visible_message("<span class='warning'>[user] catches \the [src]!</span>")
			src.throwforce = 25
*/

/obj/item/weapon/melee/taurusblade/proc/transmogrify(var/current)

	switch(current)
		if("longsword") //Transforms into a heavy, wielded two-handed blade. Slows you down but is extremely powerful.
			usr.visible_message("<span class='danger'>[usr]'s \the [src] quivers and morphs into a great and imposing zweihander.", \
			"Your \the [src] quivers and morphs into a great and imposing zweihander.</span>")
			icon_state = "taurus_zwei"
			item_state = "taurus_zwei"
			w_class = ITEMSIZE_HUGE
			attack_verb = list("cleaved", "sundered", "hacked", "carved", "dissevered", "hewn", "gored")
			desc = "A massive blade made with the bone of some great creature. Its surface shifts and morphs before your very eyes."
			slot_flags = SLOT_BACK
			can_cleave = TRUE
			force = 60
			throwforce = 15
			throw_range = 1
			slowdown = 1
			reach = 2
			current_form = "zweihander"
			return

		if("zweihander") //Transforms into a lightweight throwing weapon. Not the best in direct combat but is a god-like throwing weapon with some unique abilities.
			usr.visible_message("<span class='danger'>[usr]'s \the [src] quivers and morphs into a razor sharp double-sided chakram.", \
			"Your \the [src] quivers and morphs into a razor sharp double-sided chakram.</span>")
			icon_state = "taurus_chakram"
			item_state = "taurus_chakram"
			desc = "A curved, double-sided blade made with the bone of some great creature. Its surface shifts and morphs before your very eyes."
			w_class = ITEMSIZE_NORMAL
			attack_verb = list("sliced", "diced", "cut", "shaved", "ribboned", "filleted", "shorn")
			slot_flags = SLOT_BELT
			can_cleave = FALSE
			force = 15
			throwforce = 25
			throw_range = 7
			throw_speed = 4
			slowdown = 0
			reach = 1
			current_form = "chakram"
			return

		if("chakram") //Transforms back into its base form.
			usr.visible_message("<span class='danger'>[usr]'s \the [src] quivers and morphs into a perfectly balanced longsword.", \
			"Your \the [src] quivers and morphs into a perfectly balanced longsword.</span>")
			icon_state = "taurus_ein"
			item_state = "taurus_ein"
			desc = "A blade made with the bone of some great creature. Its surface shifts and morphs before your very eyes."
			w_class = ITEMSIZE_LARGE
			slot_flags = SLOT_BELT | SLOT_BACK
			attack_verb = list("sliced", "slashed", "cut", "pierced", "diced", "torn")
			force = 25
			throwforce = 10
			throw_speed = 1
			current_form = "longsword"
			return

		else
			to_chat(usr, "<span class='warning'>UH OH! THIS SHOULDN'T HAVE HAPPENED! Report it here: https://github.com/GeneriedJenelle/The-World-Server-Redux/issues</span>")
			return "FAILED"

/obj/item/weapon/melee/taurusblade/proc/ghost_inhabit(var/mob/candidate)  //shamelesslly ripped from the cursedblade
	if(!isobserver(candidate))
		return
	//Handle moving the ghost into the new shell.
	announce_ghost_joinleave(candidate, 0, "They are occupying the Taurus now.")
	var/mob/living/voice/new_voice = new /mob/living/voice(src) 	//Make the voice mob the ghost is going to be.
	new_voice.transfer_identity(candidate) 	//Now make the voice mob load from the ghost's active character in preferences.
	new_voice.mind = candidate.mind			//Transfer the mind, if any.
	new_voice.ckey = candidate.ckey			//Finally, bring the client over.
	new_voice.name = "Taurus"			//Cursed swords shouldn't be known characters.
	new_voice.real_name = "Taurus"
	voice_mobs.Add(new_voice)
	listening_objects |= src