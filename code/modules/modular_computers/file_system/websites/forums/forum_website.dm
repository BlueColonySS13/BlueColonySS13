

/datum/website/forums/on_access()
	content = forum_generate_content()
	..()


/datum/website/forums/proc/forum_generate_content()

	//HEADER

	content = "<table width=\"100%\" cellspacing=\"5\" cellpadding=\"5px\" style=\"height: 64px; color: white; background-color: navy; width: 100%;\"> \
			<tbody><tr style=\"height: 64px;\"><td style=\"height: 64px;\"><h1 style=\"text-align: center;\">[title]</h1></td></tr></tbody> \
			</table>"


	//TOP LINKS

	content += "<h4>Register - Login - Search - Member List - View Newest Posts<br /><br /></h4>"


	//CATEGORY

	for(var/C in available_categories)
		for(var/datum/forum/F in get_forums_by_cat(C))
			content += "[F.title]<br>"
			content += "[F.desc]"

	return content

