
/datum/website/ntoogle
	name = "ntoogle.nt"
	title = "Ntoogle Search"
//	path = "websites/ntoogle.txt"


/datum/website/ntoogle/on_access()

	content = "<table border=\"1\" style=\"height: 80px; width: 100%; border-collapse: collapse; background-color: #181818; color: black;\">"
	content += "<tbody><tr style=\"height: 20%;\"><td style=\"width: 100%; height: 100%px;\"></td></tr></tbody></table>"
	content += "<table border=\"1\" style=\"height: 360px; width: 100%; border-collapse: collapse; background-color: #323639; color: black;\">"
	content += "<tbody>	<tr style=\"height: 80%;\"><td style=\"width: 100%; height: 100%;\"><center>"
	content += "<p><img src=\"ntoogle_logo.png\" style=\"display: block; margin-left: auto; margin-right: auto;\" /></p>"
	content += "<p><a href='?src=\ref[src];browse=1'><img src=\"ntoogle_search.png\"/></a></p></center></td></tr></tbody></table>"

	..()


/datum/website/ntoogle/Topic(href, href_list)
	if(..())
		return 1
	if(href_list["browse"])
		. = 1

		var/datum/nano_module/nt_explorer/nm = get_browser_window(usr)
		nm.search(usr)
		return