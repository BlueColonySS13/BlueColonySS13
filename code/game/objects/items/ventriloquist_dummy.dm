/obj/item/toy/dummy
	name = "ventriloquist dummy"
	desc = "It's a dummy, dummy. Use :d to talk through the dummy."
	icon = 'icons/obj/toy.dmi'
	icon_state = "assistant"
	item_state = "doll"
	var/mob/living/dummy_voice/voice = null
	var/doll_name = "Puppet Man"

/obj/item/toy/dummy/cursed
	desc = " Yer here fer one reason and one reason only, ya dumb broad \
	and that's to keep yer hand up my backside and not speak unless spoken to--ya get me? Use :d to talk through the dummy."
	canremove = 0
	nodrop = 1

/obj/item/toy/dummy/New(loc)
	voice = new /mob/living/dummy_voice(loc)
	voice.forceMove(src)
	..()

//Add changing looks when i feel suicidal about making 20 inhands for these.
/obj/item/toy/dummy/attack_self(mob/user)
	var/message = "squints."
	message = sanitize(input(usr,"Visible emote by the dummy.","Anything!", message) as null|text)
	if(message)
		voice.visible_message("<b>[voice.name]</b> [message]")

/obj/item/toy/dummy/proc/say_thing(mob/user, var/message)
	message = sanitize(message)
	if(message)
		voice.say(message)


/obj/item/toy/dummy/verb/rename_dummy()
	set name = "Rename Dummy"
	set category = "Object"
	set desc = "Click to rename your dummy."
	set src in usr

	var/new_name = sanitizeName(input(usr,"What would you like to name the dummy?","Input a name", doll_name) as null|text)
	if(!new_name)
		return
	voice.name = "Puppet [new_name]"
	voice.real_name = voice.name
	to_chat(usr, "<span class='notice'>You name the dummy as \"[voice.name]\".</span>")
	name = "[initial(name)] - [voice.name]"

/mob/living/dummy_voice
	name = "Dummy"
	desc = "How are you examining me, you dummy?"
	see_invisible = SEE_INVISIBLE_LIVING
	var/obj/item/toy/dummy/doll = null

	emote_type = 2 //This lets them emote through containers.  The communicator has a image feed of the person calling them so...

/mob/living/dummy_voice/New()
	add_language(LANGUAGE_GALCOM)
	set_default_language(all_languages[LANGUAGE_GALCOM])

	if(istype(loc, /obj/item/toy/dummy))
		doll = src.loc
	..()

/mob/living/dummy_voice/say(var/message, var/datum/language/speaking = null, var/verb="says", var/alt_name="", var/whispering=0)
	//Speech bubbles.
	if(doll)
		var/speech_bubble_test = say_test(message)
		var/speech_type = speech_bubble_appearance()
		var/image/speech_bubble = image('icons/mob/talk.dmi',doll,"[speech_type][speech_bubble_test]")
		spawn(30)
			qdel(speech_bubble)

		for(var/mob/M in hearers(doll)) //simplifed since it's just a speech bubble
			M << speech_bubble
		src << speech_bubble

	..(message, speaking, verb, alt_name, whispering) //mob/living/say() can do the actual talking.

// Proc: speech_bubble_appearance()
// Parameters: 0
// Description: Gets the correct icon_state information for chat bubbles to work.
/mob/living/dummy_voice/speech_bubble_appearance()
	return "normal"

/mob/living/dummy_voice/say_understands(var/other,var/datum/language/speaking = null)
	//These only pertain to common. Languages are handled by mob/say_understands()
	if (!speaking)
		if (istype(other, /mob/living/carbon))
			return 1
		if (istype(other, /mob/living/silicon))
			return 1
		if (istype(other, /mob/living/carbon/brain))
			return 1
	return ..()

/mob/living/dummy_voice/custom_emote(var/m_type=1,var/message = null,var/range=world.view)
	if(!doll) return
	..(m_type,message,range)