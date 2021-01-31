
/mob/new_player/proc/ShowReferendums()
	if(!SSpersistent_options)
		return

	var/dat = "<center><h1>Active Referendums:</h1></center><hr>"

	var/list/the_ballots = SSpersistent_options.get_ballots(active_only = TRUE)

	if(!LAZYLEN(the_ballots))
		dat += "No active ballots on the system."

	for(var/datum/voting_ballot/VO in the_ballots)
		var/already_voted = FALSE
		if(lowertext(ckey) in VO.ckeys_voted)
			already_voted = TRUE

		dat += "<fieldset style='width: 80%; border: 2px solid #515151; display: inline'>"
		dat += "<legend align='left' style='color: #fff'><h4>[VO.name]:</h4></legend>"

		var/status = VO.get_status()
		var/winner = VO.check_winner()
		var/datum/persistent_option/PO = VO.get_persistent_option()

		dat += "<b>Description:</b> [VO.desc]<br>"

		dat += "<b>Status:</b> [VO.get_status_text()]<br> "
		dat += "<b>Author:</b> [VO.author]<br>"

		var/preview_text_one = VO.get_current_option_formatted_value()
		var/preview_text_two = PO.get_proposed_value_formatting()

		if(PO.compact_listing)
			dat += "<b>Current Value:</b><br> <div class='statusDisplay'>[TextPreview(preview_text_one,PO.compact_listing)] \
			[(length(preview_text_one) > PO.compact_listing) ? " <a href='?src=\ref[src];action=view_full;ballot=\ref[PO]'>View Full</a>" : ""]</div><br><br>"
		else
			dat += "<b>Current Value:</b><br> <div class='statusDisplay'>[preview_text_one]</div><br><br>"

		if(PO.compact_listing)
			dat += "<b>Proposed Value:</b><br> <div class='statusDisplay'>[TextPreview(preview_text_two,PO.compact_listing)] \
			[(length(preview_text_two) > PO.compact_listing) ? " <a href='?src=\ref[src];action=view_ref_full;ballot=\ref[VO]'>View Full</a>" : ""]</div><br><br>"
		else
			dat += "<b>Proposed Value:</b><br> <div class='statusDisplay'>[preview_text_two]</div><br><br>"

		if(status)
			dat += "<b>Expires:</b> [VO.expiry_days()] day(s)<br>"

		dat += "<b>Creation Date:</b> [VO.creation_date]<br>"

		dat += "<b>Current Votes</b><br><ul>"

		for(var/O in VO.options)
			dat += "<li> - <b>[O]</b>: [VO.get_option_amount(O)] vote(s)"
			if(!already_voted)
				dat += " <a href='?src=\ref[src];action=add_vote;ballot=\ref[VO];vote=[O]'>Vote</a>"

			dat += "</li>"

		dat += "</ul>"

		if(already_voted)
			dat += "<br><b>You have already voted in this referendum, thanks for participating!</b>"

		if(winner)
			dat += "<br><br>The <b>[status ? "projected winner" : "winner"]</b> is: \"[winner]\"."


		dat += "</fieldset><br><br>"

	var/datum/browser/popup = new(usr, "showreferendums", "Referendum Menu", 750, 930, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(usr, "showreferendums")



