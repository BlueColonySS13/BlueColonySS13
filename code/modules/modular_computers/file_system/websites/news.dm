
/datum/website/news
	var/datum/feed_channel/news_source

/datum/website/news/geminus_standard
	title = "Geminus Standard"
	name = "geminus-standard.nt"

/datum/website/news/geminus_standard/New()
	..()

	if(!news_source && news_data)
		news_source = news_data.city_newspaper

/datum/website/news/get_website_title()
	if(!news_source)
		return title

	return "[news_source.channel_name]"

/datum/website/news/get_website_content(mob/user)
	var/dat = ""
	var/datum/nano_module/nt_explorer/nm = get_browser_window(user)

	if(!nm)
		return dat

	var/page_metadata = nm.page_metadata

	if(!news_source || isemptylist(news_source.messages))
		dat += "No current available news."
		return dat

	if(!page_metadata)
		page_metadata = news_source.messages.len

	if(page_metadata)
		dat += get_news_page(news_source, news_source.messages[page_metadata], page_metadata)
		if(page_metadata > news_source.messages.len || (news_source.messages.len > 1) && !(page_metadata == 1))
			var/prev = page_metadata - 1
			dat += "<a href='?src=\ref[src];choice=switch_page;page=[prev]'>Previous Issue</a>  "

		if(news_source.messages.len > page_metadata)
			var/next = page_metadata + 1
			dat += "<a href='?src=\ref[src];choice=switch_page;page=[next]'>Next Issue</a>"

		dat += "  (Page <b>[page_metadata]</b> out of <b>[news_source.messages.len]</b>)"
	else
		dat += "Error loading newspaper page, please contact an administrator."
		return dat

	return dat


/datum/website/news/Topic(var/href, var/href_list)
	if(..())
		return 1

	var/datum/nano_module/nt_explorer/nm = get_browser_window(usr)

	if(href_list["choice"])
		switch(href_list["choice"])
			if("switch_page")
				var/E = text2num(href_list["page"])
				var/meta_num = E
				nm.page_metadata = meta_num



	nm.refresh(usr)




