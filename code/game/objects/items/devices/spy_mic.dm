GLOBAL_LIST_EMPTY(voicebugs)
GLOBAL_LIST_EMPTY(voicebug_devices)

/obj/item/device/voicebug
	name = "microphone bug"
	desc = "A very small microphone that is designed to be concealable. It transcribes audio and sends it to a remote device."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "camgrenade"
	item_state = "empgrenade"

	var/list/voice_log = list()

	var/broken = FALSE

	var/reciever_id = ""
	var/obj/item/device/voicebug_device/voice_reciever

/obj/item/device/voicebug/on_persistence_load()
	GLOB.voicebugs[reciever_id] = src

/obj/item/device/voicebug/hear_talk(mob/living/M as mob, msg, var/verb="says")
	if(!broken && voice_reciever && voice_reciever.recording)
		voice_reciever.record_speech("[M.name] [verb], \"[msg]\"")



/obj/item/device/voicebug_device
	name = "remote microphone reciever device"
	desc = "A digital device that transcribes audio that is remotely sent to it by microphones. You can swipe a microphone bug to link it."

	var/list/voice_bugs = list()
	var/recording = FALSE

	var/transmit_id = ""

	var/max_logs = 80

/obj/item/device/voicebug/New()
	if(installed
	GLOB.voicebug_devices[transmit_id] = src

/obj/item/device/voicebug_device/proc/record_speech(text)
	recording += "\[[time2text("mm:ss")]\] [text]"
	truncate_oldest(recording, max_logs)


