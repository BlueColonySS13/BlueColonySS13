
/datum/website/news
	var/datum/feed_channel/news_source
	var/current_news_page

/datum/website/news/geminus_standard
	title = "Geminus Standard"
	name = "geminus-standard.nt"


/datum/website/news/New()
	if(!news_source && news_data)
		news_source = news_data.city_newspaper

	if(news_source)
		title = "[news_source.channel_name]"

	if(!current_news_page)
		if(news_source.messages)
			current_news_page = news_source.messages.len

	if(!current_news_page || !news_source.messages)
		content += "No current available news."
	else
		content += get_news_page(news_source, news_source.messages[current_news_page], current_news_page)
		if(current_news_page > news_source.messages.len || (news_source.messages.len > 1) && !(current_news_page == 1))
			content += "<a href='?src=\ref[src];previous_news=1;prevpage=\ref[news_source]'>Previous Issue</a>  "
		if(news_source.messages.len > current_news_page)
			content += "<a href='?src=\ref[src];next_news=1;nextpage=\ref[news_source]'>Next Issue</a>"

		content += "  (Page <b>[current_news_page]</b> out of <b>[news_source.messages.len]</b>)"

/datum/website/news/Topic(href, href_list[])
	..()

	if(href_list["next_news"])
		var/datum/feed_channel/next_page = locate(href_list["nextpage"])
		if(!next_page)
			return
		if(!current_news_page)
			return
		if(!next_page.messages)
			return

		if(current_news_page == next_page.messages.len)
			return
		else
			current_news_page++

	if(href_list["previous_news"])
		var/datum/feed_channel/prev_page = locate(href_list["prevpage"])
		if(!prev_page)
			return
		if(!current_news_page)
			return
		if(!prev_page.messages)
			return
		if(1 >= current_news_page)
			return
		else
			current_news_page--


