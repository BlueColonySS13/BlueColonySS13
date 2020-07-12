/obj/machinery/status_display/supply_display
	ignore_friendc = 1

/obj/machinery/status_display/supply_display/update()
	message1 = "Supply"
	message2 = ""

	if(supply_controller)
		var/datum/shuttle/ferry/supply/shuttle = supply_controller.shuttle
		if(!shuttle)
			message2 = "Error"
		else if(shuttle.has_arrive_time())
			message2 = "[shuttle.eta_minutes()] min"
			if(length(message2) > CHARS_PER_LINE)
				message2 = "Error"
		else if(shuttle.is_launching())
			if(shuttle.at_station())
				message2 = "Launch"
			else
				message2 = "ETA"
		else
			if(shuttle.at_station())
				message2 = "Docked"
			else
				message1 = ""


	update_display(message1, message2)

/obj/machinery/status_display/supply_display/receive_signal/(datum/signal/signal)
	if(signal.data["command"] == "supply")
		mode = STATUS_DISPLAY_CUSTOM
	else
		..(signal)
