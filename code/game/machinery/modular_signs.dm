/obj/machinery/modular_sign/
	name = "sign"
	desc = "A high tech sign that has a large range of uses."

	icon = 'icons/obj/modular_signs.dmi'

	pixel_y = -5
	maptext_height = 25
	maptext_width = 53
	maptext_x = 6
	maptext_y = 4
	density = FALSE
	plane = ABOVE_PLANE

	wall_drag = TRUE

	var/sign_text = "Sign Here"
	var/sign_desc = "This is a preset sign that needs a description."


	var/glowing = FALSE

	//pick system fonts only for compatibility
	var/sign_font = "Arial Black"
	var/font_color = "#FFFFFF"
	var/font_size = "5"
	var/text_align = "center"
	var/text_v_align = "middle"

	var/max_text_length = 22

	var/sign_base = "base_solid"
	var/base_color = "#FFFFFF"

	var/sign_frame = "frame"
	var/frame_color = "#FFFFFF"

	var/decor = null
	var/decor_color = "#FFFFFF"

	var/static_icon = null	// if it has a set icon instead of composite images

	var/maint_icon = "maint"
	var/maint_mode = FALSE

	var/sign_light_range = 4
	var/sign_light_power = 2

	unique_save_vars = list("maptext_height", "maptext_width", "maptext_x", "maptext_y", "sign_text", "sign_desc", "glowing", "sign_font", "font_color", "font_size", \
	"text_align", "text_v_align", "sign_base", "base_color", "sign_frame", "frame_color", "decor", "decor_color", "maint_icon", "maint_mode", "sign_light_range", "sign_light_power", \
	"owner_name", "owner_uid")

/obj/machinery/modular_sign/New()
	update_sign()

/obj/machinery/modular_sign/on_persistence_load()
	update_sign()

/obj/machinery/modular_sign/ex_act(severity)
	return // no more deleted signs by lightning

/obj/machinery/modular_sign/proc/update_sign()
	update_icon()
	update_sign_text()
	update_glow()

/obj/machinery/modular_sign/proc/update_glow()
	set_light(0)

	if(!glowing)
		return
	else
		set_light(sign_light_range, sign_light_power, font_color)

/obj/machinery/modular_sign/examine(mob/user)
	..()
	if(sign_text)
		to_chat(user, "The sign says \"<b>[sign_text]</b>\".")
	if(sign_desc)
		to_chat(user, "A description subtitled under it says \"<b>[sign_desc]</b>\".")

/obj/machinery/modular_sign/proc/update_sign_text()
	name = "[sign_text] [initial(name)]"
	maptext = {"<div style="font-size:[font_size]pt;color:[font_color];[glowing ? "text-shadow:0 0 2px [font_color];" : ""]font:'[sign_font]';text-align:[text_align];vertical-align: [text_v_align];">[sign_text]</div>"}

/obj/machinery/modular_sign/update_icon()
	overlays.Cut()
	icon_state = null

	if(static_icon)
		icon_state = static_icon
		return

	if(sign_base)
		// add base first
		var/image/G =  image(icon, sign_base)
		G.color = base_color
		G.layer = layer - 0.1
		overlays |= G

	if(sign_frame)
		// add frame
		var/image/F =  image(icon, "[glowing ? "[sign_frame]_ani" : sign_frame]")
		F.color = frame_color
		overlays |= F

	if(decor)
		var/image/S =  image(icon, "[glowing ? "[decor]_ani" : decor]")
		S.color = decor_color
		overlays |= S

	if(maint_mode && maint_icon)
		var/image/M =  image(icon, maint_icon)
		M.color = frame_color
		overlays |= M


/obj/machinery/modular_sign/business
	name = "business sign"
	desc = "A business sign that can be claimed using an ID card. It can morph into many shapes and be affixed onto walls."

	// owner info
	var/owner_name = ""
	var/owner_uid = ""

/obj/machinery/modular_sign/business/examine(mob/user)
	..()
	if(owner_name)
		to_chat(user, "[name] belongs to <b>[owner_name]</b>.")

/obj/machinery/modular_sign/business/attack_hand(mob/user as mob)
	add_fingerprint(usr)

	if(istype(user, /mob/living/silicon))
		to_chat (user, "<span class='warning'>A firewall prevents you from interfacing with this device!</span>")
		return

	interact(user)
	updateDialog()

/obj/machinery/modular_sign/business/proc/set_new_owner(obj/item/weapon/card/id/I)
	if(!I)
		return
	owner_name = I.registered_name
	owner_uid = I.unique_ID
	visible_message("<span class='info'>New owner set to '[I.registered_name]'.</span>")
	playsound(src, 'sound/machines/chime.ogg', 25)

/obj/machinery/modular_sign/business/interact(mob/user as mob)
	var/dat

	dat = get_vend_data(user)

	var/datum/browser/popup = new(user, "modular_sign", "[src]", 550, 650, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "modular_sign")

/obj/machinery/modular_sign/business/proc/get_vend_data(mob/user as mob)
	var/dat

	if(sign_text)
		dat += "<B>[sign_text]</B><br>"
	if(sign_desc)
		dat += "<I>[sign_desc]</I><br>"

	if(!owner_uid)
		dat += "Please swipe your ID to claim ownership of this sign.<br>"
		return dat

	if(maint_mode)
		dat += "Welcome to maintenance mode. Please choose from the options below, please don't forget to lock this sign when you are done.<br>"
		dat += "<a href='?src=\ref[src];edit_text=1'>Edit Sign Text</a> "
		dat += "<a href='?src=\ref[src];edit_desc=1'>Edit Sign Description</a> "
		dat += "<a href='?src=\ref[src];toggle_anchor=1'>Toggle Anchors</a> "
		dat += "<a href='?src=\ref[src];reset_owner=1'>Reset Ownership</a> "
		dat += "<a href='?src=\ref[src];exit_maint_mode=1'>Exit Maintenance Mode</a> <BR><BR>"

		dat += "<B>Customization Options</B><br>"
		dat += "<a href='?src=\ref[src];toggle_glow=1'>Toggle Glow</a> "
		dat += "<a href='?src=\ref[src];base_type=1'>Set Base Type</a> "
		dat += "<a href='?src=\ref[src];frame_type=1'>Set Frame Type</a> "
		dat += "<a href='?src=\ref[src];decor_type=1'>Set Decoration Type</a> <br>"



		dat += "<a href='?src=\ref[src];sign_text_color=1'>Change Text Color</a> "
		if(sign_base)
			dat += "<a href='?src=\ref[src];sign_base_color=1'>Change Base Color</a> "
		if(sign_frame)
			dat += "<a href='?src=\ref[src];sign_frame_color=1'>Change Frame Color</a> "
		if(decor)
			dat += "<a href='?src=\ref[src];sign_decor_color=1'>Change Decor Color</a> "
	else
		dat += "<br><b>Swipe your ID to enter maintenance mode.</b>"


	return dat


/obj/machinery/modular_sign/business/attackby(obj/item/weapon/W as obj, mob/user as mob)
	var/obj/item/weapon/card/id/I = W.GetID()

	if(!owner_uid && I)
		if(!I.unique_ID || !I.registered_name || !I.associated_account_number || !check_account_exists(I.associated_account_number))
			visible_message("<span class='notice'>There is an issue with setting your ownership on this message, it could be due to a lack of details on the card like \
			a unique id or name. Please contact a technician for more details.</span>")
			return
		else
			set_new_owner(I)
			update_sign()
			updateDialog()
		return

	if(I && (I.unique_ID == owner_uid))
		maint_mode = TRUE
		update_sign()
		updateDialog()
	else
		visible_message("<span class='notice'>Error: Unrecognised unique ID or authorization mismatch.</span>")
		return TRUE

/obj/machinery/modular_sign/business/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["exit_maint_mode"])
		if(!maint_mode)
			return

		maint_mode = FALSE


	if(href_list["edit_text"])
		if(!maint_mode)
			return

		var/new_name = sanitize(input("Enter a new name for this sign ([max_text_length] characters max)", "Set Name", sign_text) as text, max_text_length)

		if(!new_name)
			return

		sign_text = new_name
		alert("New name: \"[sign_text]\" has been set to this sign.")


	if(href_list["edit_desc"])
		if(!maint_mode)
			return

		var/new_desc = sanitize(input("Enter a new desc for this sign (150 characters max)", "Set Name", sign_desc) as text, 150)

		if(!new_desc)
			return

		sign_desc = new_desc
		alert("New name: \"[sign_desc]\" has been set to this sign.")

	if(href_list["toggle_anchor"])
		if(!maint_mode)
			return

		anchored = !anchored
		playsound(src, 'sound/items/drill_use.ogg', 25)

		if(anchored)
			to_chat(usr, "<b>The anchor the sign. It is now secured.</b>")
		else
			to_chat(usr, "<b>You toggle the anchors of the sign. It can now be moved.</b>")

	if(href_list["reset_owner"])
		if(!maint_mode)
			return

		owner_name = ""
		owner_uid = ""

		to_chat(usr, "<b>Ownership reset.</b>")

		maint_mode = FALSE

	if(href_list["exit_maint_mode"])
		maint_mode = FALSE

	if(href_list["toggle_glow"])
		if(!maint_mode)
			return

		glowing = !glowing

		if(glowing)
			to_chat(usr, "<b>The sign now glows...</b>")
		else
			to_chat(usr, "<b>The sign no longer glows.</b>")


	if(href_list["base_type"])
		if(!maint_mode)
			return
		var/list/base_types = list("solid", "striped") // this can be optimised
		var/new_base = input(usr, "Please select which base to use.", "Base Types") as null|anything in base_types

		if(!new_base)
			return

		switch(new_base)
			if("solid")
				sign_base = "base_solid"
			if("striped")
				sign_base = "base_striped"

		to_chat(usr, "<b>Changed base type to [new_base].</b>")

	if(href_list["frame_type"])
		if(!maint_mode)
			return
		var/list/frame_types = list("none","regular","thick","thin","embossed","neon") // this can be optimised
		var/new_frame = input(usr, "Please select which frame to use.", "Frame Types") as null|anything in frame_types

		if(!new_frame)
			return

		switch(new_frame)
			if("none")
				sign_frame = null
			if("regular")
				sign_frame = "frame"
			if("thick")
				sign_frame = "thickframe"
			if("thin")
				sign_frame = "thinframe"
			if("embossed")
				sign_frame = "embossedframe"
			if("neon")
				sign_frame = "neonframe"
		to_chat(usr, "<b>Changed base type to [new_frame].</b>")

	if(href_list["decor_type"])
		if(!maint_mode)
			return
		var/list/decor_types = list("none", "line", "dotted") // this can be optimised
		var/new_decor = input(usr, "Please select which frame to use.", "Frame Types") as null|anything in decor_types

		if(!new_decor)
			return

		switch(new_decor)
			if("none")
				decor = null
			if("line")
				decor = "line"
			if("dotted")
				decor = "dotted"


		to_chat(usr, "<b>Changed base type to [new_decor].</b>")

	if(href_list["sign_text_color"])
		if(!maint_mode)
			return
		var/new_colour = input(usr, "Choose a colour.", "Text Color", font_color) as color|null
		if(!new_colour)
			return

		font_color = new_colour
		to_chat(usr, "<b>Changed text color to <font color='[base_color]'>a new colour</font>.</b>")


	if(href_list["sign_base_color"])
		if(!maint_mode)
			return
		var/new_colour = input(usr, "Choose a colour.", "Base Color", base_color) as color|null
		if(!new_colour)
			return

		base_color = new_colour
		to_chat(usr, "<b>Changed base color to <font color='[base_color]'>a new colour</font>.</b>")

	if(href_list["sign_frame_color"])
		if(!maint_mode)
			return
		var/new_colour = input(usr, "Choose a colour.", "Base Color", frame_color) as color|null
		if(!new_colour)
			return

		frame_color = new_colour
		to_chat(usr, "<b>Changed frame color to <font color='[base_color]'>a new colour</font>.</b>")

	if(href_list["sign_decor_color"])
		if(!maint_mode)
			return
		var/new_colour = input(usr, "Choose a colour.", "Base Color", decor_color) as color|null
		if(!new_colour)
			return

		decor_color = new_colour
		to_chat(usr, "<b>Changed decor color to <font color='[base_color]'>a new colour</font>.</b>")


	update_sign()
	updateDialog()