////////////////////////////////////////
//  		Modular sites!			 //
//////////////////////////////////////

//--To make a site, either write the HTML in "content" or make a .txt file and rewrite "path" to point to it--//

/datum/website
	var/name = "" //The """"URL"""" they have to search for. CONTENT is any HTML you want to show on the site, anything that works with IE8 will work here, so go nuts.
	var/base_url
	var/title = "Cool Site!"
	var/content = "<h1>A heading!</h1>\
	<h2>Any standard HTML works here!</h2>\
	<p>Sign our guestbook!</p>"
	var/path = null // If you want to load your site from a TXT, make a txt file in websites/ and edit path to point to it.
	var/password = null //Set this if you require a password.
	var/max_length = 10000 //Feel free to remove this. This limits your HTML to 1000 lines to prevent gigaspam.

	var/searchable = TRUE // If this is 1 it will appear on public search engines

	var/deepweb // If this is 1 this website can be found on the deepweb

	var/traffic_hits = 0	// how many times your website has been accessed.

/datum/website/New(new_url, new_base_url, new_title, new_content, is_deepweb = FALSE, is_searchable = TRUE)
	. = ..()

	if(new_url)
		name = new_url
	if(base_url)
		base_url = new_base_url
	if(new_title)
		title = new_title
	if(new_content)
		content = new_content
	if(is_deepweb)
		deepweb = is_deepweb
	if(is_searchable)
		searchable = is_searchable


	if(name)
		GLOB.websites += src

	if(!base_url)
		base_url = name

	if(path)
		content = file2text("[path]")

/datum/website/proc/get_website_content(mob/user)
	return content

/datum/website/proc/get_website_title(mob/user)
	return title

/datum/website/proc/get_visible_url(mob/user)	// this is what appears on the browser, may be different from actual url
	return name

/datum/website/proc/on_access(var/mob/user) //Special code for sites, this is used for the site making site.
	return TRUE

/datum/website/proc/set_browser_metadata(new_value, var/mob/user)
	var/datum/nano_module/nt_explorer/nm = get_browser_window(user)

	nm.page_metadata = new_value
	return nm.page_metadata

/datum/website/proc/get_browser_window(mob/user) //returns browser window that the mob is seeing.
	if(!user) return 0

	var/datum/nanoui/browser

	for(var/datum/nanoui/uidatum in user.open_uis)
		browser = uidatum.src_object
		if(istype(browser, /datum/nano_module/nt_explorer))
			return browser

	return FALSE

/proc/get_website_by_url(url)
	for(var/datum/website/W in GLOB.websites)
		if(W.name == url)
			return W

/proc/get_websites_by_baseurl(baseurl)
	var/list/all_webs = list()
	for(var/datum/website/W in GLOB.websites)
		if(W.base_url == baseurl)
			all_webs += W
	return all_webs

/proc/create_website(new_url, new_base_url, new_title, new_content, is_deepweb = FALSE, is_searchable = TRUE)
	if(!new_url)
		return

	var/datum/website/new_website = new(new_url, new_base_url, new_title, new_content, is_deepweb, is_searchable)

	return new_website



