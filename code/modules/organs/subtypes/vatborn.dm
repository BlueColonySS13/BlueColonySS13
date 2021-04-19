/obj/item/organ/internal/brain/vatborn
	name = "cortical stack"
	icon_state = "cortical-stack"
	desc = "A receptacle for Vatborn consciousness."
	preserved = 1 //stacks cannot necrotize
	organ_tag = O_STACK
	robotic = 1
	origin_tech = list(TECH_BIO = 4, TECH_DATA = 4)
	dead_icon = null
	attack_verb = list("attacked")
	can_assist = FALSE

/obj/item/organ/internal/brain/vatborn/examine(mob/user) // -- TLE
	..(user)
	if(brainmob && brainmob.client)//if thar be a brain inside... the brain.
		user << "The stack glows with a bright blue hue signifying an active consciousness."
	else
		user << "The stock glows with a dim red hue signifying an inactive consciousness. Perhaps it will regain some of its luster later..."

/obj/item/organ/internal/fake_brain //a dummy brain for vatborn. the player will actually be stored in the stack but we can't have vatborn running around brainless!
	name = "brain"
	desc = "A piece of juicy meat found in a person's head."
	vital = 1
	organ_tag = "brain"
	parent_organ = BP_HEAD
	vital = 1
	icon_state = "brain2"
	force = 1.0
	w_class = ITEMSIZE_SMALL
	throwforce = 1.0
	throw_speed = 3
	throw_range = 5
	origin_tech = list(TECH_BIO = 3)
	attack_verb = list("attacked", "slapped", "whacked")
	var/defib_timer = -1
	var/can_assist = TRUE

/obj/item/organ/internal/fake_brain/process()
	..()
	if(owner && owner.stat != DEAD) // So there's a lower risk of ticking twice.
		tick_defib_timer()

// This is called by `process()` when the owner is alive, or brain is not in a body, and by `Life()` directly when dead.
/obj/item/organ/internal/fake_brain/proc/tick_defib_timer()
	if(preserved) // In an MMI/ice box/etc.
		return

	if(!owner || owner.stat == DEAD)
		defib_timer = max(--defib_timer, 0)
	else
		defib_timer = min(++defib_timer, (config.defib_timer MINUTES) / 2)

/obj/item/organ/internal/fake_brain/removed(var/mob/living/user)

	if(name == initial(name))
		name = "\the [owner.real_name]'s [initial(name)]"

	..()

/obj/item/organ/internal/fake_brain/handle_germ_effects()
	. = ..() //Up should return an infection level as an integer
	if(!.) return

	//Bacterial meningitis (more of a spine thing but 'brain infection' isn't a common thing)
	if (. >= 1)
		if(prob(1))
			owner.custom_pain("Your neck aches, and feels very stiff!",0)
	if (. >= 2)
		if(prob(1))
			owner.custom_pain("Your feel very dizzy for a moment!",0)
			owner.Confuse(2)

/obj/item/organ/internal/fake_brain/proc/get_control_efficiency()
	. = 0

	if(!is_broken())
		. = 1 - (round(damage / max_damage * 10) / 10)

	return .

/obj/item/organ/internal/fake_brain/proc/can_assist()
	return can_assist

/obj/item/organ/internal/fake_brain/proc/implant_assist(var/targ_icon_state = null)
	name = "[owner.real_name]'s assisted [initial(name)]"
	if(targ_icon_state)
		icon_state = targ_icon_state
		if(dead_icon)
			dead_icon = "[targ_icon_state]_dead"
	else
		icon_state = "[initial(icon_state)]_assisted"
	if(dead_icon)
		dead_icon = "[initial(dead_icon)]_assisted"