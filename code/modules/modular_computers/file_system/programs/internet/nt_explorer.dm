// See websites.dm for websites list


/datum/computer_file/program/nt_explorer
	filename = "nt_explorer"					// File name, as shown in the file browser program.
	filedesc = "NT Explorer"				// User-Friendly name. In this case, we will generate a random name in constructor.
	extended_desc = "The go-to browser for your everyday NTnet browsing."		// A nice description.
	size = 5								// Size in GQ. Integers only. Smaller sizes should be used for utility/low use programs (like this one), while large sizes are for important programs.
	requires_ntnet = 1
	available_on_ntnet = 1					// ... but we want it to be available for download.
	nanomodule_path = /datum/nano_module/nt_explorer/	// Path of relevant nano module. The nano module is defined further in the file.
	usage_flags = PROGRAM_ALL



/datum/nano_module/nt_explorer
	var/datum/website/current_website
	var/access_deepweb = FALSE

	var/homepage = "ntoogle.nt"

	var/browser_content
	var/browser_title
	var/browser_url

	var/page_metadata = 0

/datum/nano_module/nt_explorer/New()
	..()
	browse_url(homepage)

/datum/nano_module/nt_explorer/proc/fetch_website_data(mob/user)
	if(current_website)
		browser_content = current_website.get_website_content(user)
		browser_title = current_website.get_website_title(user)
		browser_url = current_website.get_visible_url(user)


/datum/nano_module/nt_explorer/proc/handle_website_visit(mob/user)
	if(!current_website)
		return
	if(user)
		current_website.traffic_hits++

	current_website.on_access(user)

/datum/nano_module/nt_explorer/proc/clear_page_metadata()
	page_metadata = 0

/datum/nano_module/nt_explorer/proc/browse_url(url, mob/user)
	if(!url)
		return

	var/new_website = get_website_by_url(url)

	if(current_website && (new_website != current_website))
		clear_page_metadata()

	current_website = new_website

	if(!current_website || (current_website.deepweb && !access_deepweb))
		current_website = SSwebsites.get_error_page()

	if(current_website && current_website.password && user)
		var/entered_pass = input("This website requires a password to access. Please enter it below.", "Password Restricted", null, null) as text
		if(!entered_pass || entered_pass != current_website.password)
			current_website = SSwebsites.get_denied_page()


	handle_website_visit(user)
	refresh(user)


/datum/nano_module/nt_explorer/proc/search(mob/user)
	var/search = input("Enter a URL", "NT search engine", null, null)  as text
	if(!search)
		return

	browse_url(search, user)

/datum/nano_module/nt_explorer/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = default_state)
	var/list/data = list()
	if(program)
		data = program.get_header_data()

	data["website_content"] = browser_content
	data["website_title"] = browser_title
	data["website_url"] = browser_url

	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "ntnet_explorer.tmpl", "NtNet Explorer", 690, 680, state = state)
		if(program.update_layout())
			ui.auto_update_layout = 1
		ui.set_auto_update(1)
		ui.set_initial_data(data)
		ui.open()

/datum/nano_module/nt_explorer/proc/refresh(mob/user)
	fetch_website_data(user)

/datum/nano_module/nt_explorer/Topic(href, href_list)
	if(..())
		return 1
	if(href_list["Browse"])
		. = 1
		search(usr)
		return 1

	if(href_list["Refresh"])
		. = 1
		refresh(usr)
		return 1

	if(href_list["go_homepage"])
		. = 1
		browse_url(homepage, usr)
		return 1


	if(href_list["set_homepage"])
		. = 1
		var/new_homepage = sanitize(input("Current homepage is [homepage], enter a url for a new one.", "Set Homepage", homepage) as text, MAX_URL_LENGTH)
		homepage = new_homepage

		return 1
