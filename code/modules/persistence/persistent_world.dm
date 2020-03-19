
/proc/save_world()
	//saves all political data - TODO: Move this into law subsystem
	persistent_economy.save_economy()

	//saves all political data - TODO: Move this into law subsystem
	SSeconomy.save_economy()

	//save politics related data
	SSelections.save_data.save_candidates()

	//save news
	news_data.save_main_news()

	//save emails
	SSemails.save_all_emails()

	SSlaw.save_warrants()

	if(config.lot_saving)
		SSlots.save_all_lots()

	//saves all characters
	for (var/mob/living/carbon/human/H in mob_list) //only humans, we don't really save AIs or robots.

		if(H.mind)
			// collects all the money on your person and puts it in your bank account for you. You're welcome.
			var/money_on_person = 0
			for(var/obj/item/weapon/spacecash/C in H.get_contents())
				money_on_person += C.worth
				qdel(C)

			H.mind.initial_account.money += money_on_person

		handle_jail(H)	// make sure the pesky criminals get what's coming to them.
		H.save_mob_to_prefs()

	return 1
