////////////////////////////////////////
//  		Modular sites!			 //
//////////////////////////////////////

//--To make a site, either write the HTML in "content" or make a .txt file and rewrite "path" to point to it--//

var/global/list/websites = list()

/proc/instantiate_websites()
	for(var/instance in subtypesof(/datum/website))
		new instance

/datum/website
	var/name = "coolsite.biz" //The """"URL"""" they have to search for. CONTENT is any HTML you want to show on the site, anything that works with IE8 will work here, so go nuts.
	var/title = "Cool Site!"
	var/content = "<h1>A heading!</h1>\
	<h2>Any standard HTML works here!</h2>\
	<p>Sign our guestbook!</p>"
	var/path = null // If you want to load your site from a TXT, make a txt file in websites/ and edit path to point to it.
	var/password = null //Set this if you require a password.
	var/max_length = 10000 //Feel free to remove this. This limits your HTML to 1000 lines to prevent gigaspam.

	var/searchable = TRUE // If this is 1 it will appear on public search engines

	var/deepweb // If this is 1 this website can be found on the deepweb


/datum/website/proc/on_access(var/mob/user, password) //Special code for sites, this is used for the site making site.
	return TRUE

/datum/website/proc/get_browser_window(mob/user) //returns browser window that the mob is seeing.
	if(!user) return 0

	var/datum/nanoui/browser

	for(var/datum/nanoui/uidatum in user.open_uis)
		browser = uidatum.src_object
		if(istype(browser, /datum/nano_module/nt_explorer))
			return browser

	return FALSE

/datum/website/New()
	. = ..()
	websites += src
	if(path)
		content = file2text("[path]")


/datum/website/error
	name = "404"
	title = "Error - Page not found"
	path = "websites/404.txt"
	searchable = FALSE

/datum/website/denied
	name = "Access Denied"
	title = "Error - Access Denied"
	path = "<h3>Access Denied</h3> <br> Password for website was either incorrect or left blank."
	searchable = FALSE
