/obj/machinery/web_cinema
	name = "stream cinema screen"
	desc = "Finally, cat videos served by the NTnet."

	var/screen_url = "https://app.kosmi.io/room/tu4ux0"

	icon = 'icons/obj/machines/web_cinema.dmi'
	icon_state = "steam_cinema_animate"

	var/frame_width = "100%"
	var/frame_height = "600px"

/obj/machinery/web_cinema/Click(location, control, params)
	..()
	var/dat = {"

		<html><head>
		</head>

		<body>
		<iframe width='[frame_width]' height='[frame_height]' src="[screen_url]" frameborder="1" id="main_frame"></iframe>
		</body>

		</html>

		"}

	usr << browse(dat, "window=stream_cinema;size=600x640")
	onclose(usr, "stream_cinema")