/mob/living/silicon/pai/say(var/msg, whispering)
	if(silence_time)
		src << "<font color=green>Communication circuits remain uninitialized.</font>"
	else
		..(msg)