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