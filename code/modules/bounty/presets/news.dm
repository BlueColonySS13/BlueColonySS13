/datum/bounty/news
	category = CAT_NEWS

/datum/bounty/news/spare_newspapers
	name = "Spare Newspapers?"
	author = "Sol Chippy"
	description = "Here in Neo-England, we pride ourselves in the ancient recipe of fish and chips. To sell the aesthetic we need \
	twenty newspapers shipped over for wrapping our fish and chips. Should do us 'til our supplier gives us our own. \
	We're not hipsters, we swear!"

	items_wanted = list(/obj/item/weapon/newspaper = 20)

	department_reward = 50
	individual_reward = 20

	days_until_expiry = 2

/datum/bounty/news/horror_mag
	name = "Gruesome Pictures Wanted!"
	author = "BlueHorror Magazine"
	description = "Yeah, we didn't really want to search on the deepweb for this one since everyone has seen them already, \
	we need some pictures of something gory. I don't know, bloody scenes, bodies, death, something actually scary for christ's sake!"

	items_wanted = list(/obj/item/weapon/photo = 5)

	department_reward = 200
	individual_reward = 30

	days_until_expiry = 3

/datum/bounty/news/horror_mag/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/weapon/photo))
		var/obj/item/weapon/photo/photo = O

		if(photo && photo.gruesome)
			return TRUE

	return FALSE


/datum/bounty/news/moonhub_scandal
	name = "Scandalous Picture Wanted"
	author = "Spotlight!"
	description = "You know what the media needs? Gossip. We need something that will get people the right kind of talking... \
	that is, jeering, laughing or whispering. Something scandalous is needed, possibly even embarrassing, illegal or career-compromising. \
	We'll pay handsomely"

	items_wanted = list(/obj/item/weapon/photo = 3)

	department_reward = 300
	individual_reward = 150

	days_until_expiry = 5

/datum/bounty/news/moonhub_scandal/meets_standards(var/obj/O) // additional custom checks
	if(istype(O, /obj/item/weapon/photo))
		var/obj/item/weapon/photo/photo = O

		if(photo && photo.scandalous)
			return TRUE

	return FALSE