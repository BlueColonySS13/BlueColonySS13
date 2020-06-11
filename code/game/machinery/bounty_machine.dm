/obj/machinery/bounty_machine
	name = "bount-T"
	desc = "The bount-T is a state-of-the-art bluespace technology based tech designed to enable trade between businesses \
	from very far distances. This is the commerical version you can buy for your own company."

	icon = 'icons/obj/buysell.dmi'
	icon_state = "bounty"
	unacidable = 1
	light_range = 3
	light_power = 7
	light_color = "#ebf7fe"  //white blue
	density = 1
	anchored = 1
	plane = ABOVE_PLANE
	layer = ABOVE_MOB_LAYER
	bound_width = 64

	circuit = /obj/item/weapon/circuitboard/bounty_machine

	var/datum/department/current_department
	var/datum/bounty/current_bounty

	var/business = TRUE

	var/atom/stored_thing
	var/starting_department = null

	unique_save_vars = list("starting_department")

	var/restrict_bounty_for_business = TRUE


/obj/machinery/bounty_machine/attackby(obj/item/I, mob/user, params)
	if(!I)
		return

	var/item_name = I.name
	var/obj/item/weapon/card/id/ID = user.GetIdCard()

	if(!ID || !ID.associated_account_number)
		to_chat(user,"<span class='notice'>Please wear a valid citizen ID card that is linked to your bank details.</span>")
		return

	var/bank_id = ID.associated_account_number

	if(!current_bounty)
		to_chat(user,"<span class='notice'>You need to select a bounty first!</span>")
		return

	if(current_bounty.check_for_completion())
		to_chat(user,"<span class='notice'>This bounty is already complete, please select \"Confirm Completion\" to redeem the reward!</span>")
		return

	if(current_bounty.check_item(I, bank_id))
		playsound(src, 'sound/machines/chime.ogg', 25)
		to_chat(user,"<span class='info'>[item_name] loses it's physical shape and morphs into a beam of light!</span>")
		visible_message("\icon[src] <b>[src]</b> beeps, \"Thank you, this product has been accepted!\"")

	else
		to_chat(user,"\icon[src] <span class='notice'><b>[src]</b> beeps, \"ERROR: Unable to accept this item.\"</span>")
		return


/obj/machinery/bounty_machine/attack_hand(mob/user)
	..()
	src.add_fingerprint(user)
	if(stat & (BROKEN|NOPOWER))
		return

	interact(user)
	updateDialog()

/obj/machinery/bounty_machine/interact(mob/user)
	var/dat

	dat = get_full_data(user)

	var/datum/browser/popup = new(user, "bounty_machine", "[src]", 680, 480, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "bounty_machine")

/obj/machinery/bounty_machine/proc/get_full_data(mob/user)
	var/dat

	if(!current_department && starting_department && dept_by_id(starting_department))
		current_department = dept_by_id(starting_department)

	if(!current_department)
		dat += "Welcome to [name], this allows you to trade with businesses all over the world."

		dat += "<br>To connect to your business, please authenticate below."

		dat += "<br><br><center><a href='?src=\ref[src];connect_business=1'>Connect to Business</a></center>"

		return dat

	var/datum/business/current_business = current_department.get_business()
	var/department_money

	if(current_department && current_department.bank_account)
		department_money = current_department.bank_account.money

	if(restrict_bounty_for_business && current_business && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!current_business.is_department_employee(H.unique_id, H))
			dat += "<br>Apologies, only employees of this business can complete bounties."
			return dat

	if(current_business && current_business.suspended)
		dat += "<br>It would appear your business is suspended, please view the business management program for more details."
		return dat

	if(current_department.bank_account)
		var/datum/money_account/bank_account = current_department.bank_account
		if(bank_account.suspended)
			dat += "<br>It would appear your business is suspended, please view the business management program for more details."
			return dat
	else
		dat += "<br>It appears this department does not have a bank account attached, please contact an administrator for details."
		return dat

	dat += "<br><b>Current Department:</b> [current_department.name]<br>"
	if(department_money)
		dat += "<br><b>Balance:</b> [cash2text(department_money, FALSE, TRUE, TRUE )]<br>"
	dat += "<br>"

	dat += get_bounty_screen(current_department)

	return dat

/obj/machinery/bounty_machine/proc/get_bounty_screen(var/datum/department/D)
	if(!D)
		return

	var/dat

	dat += {"<table style="width: 90%; background: #303030; outline-style: solid; outline-width: 3px; border-color: #e2e1d3;">

	<tbody>
	<tr>
	<td style="width: 15%; padding: 6px 6px;">"}

	for(var/datum/bounty/B in D.bounties)
		dat += {"<a href='?src=\ref[src];choice=select_bounty;bounty=\ref[B]'>[B.name]</a><br>"}

	dat += {"</td><td style="background: #232323; vertical-align: top; padding: 10px 10px; color: #ecebdd;">"}

	if(QDELETED(current_bounty))
		current_bounty = null

	if(current_bounty)

		dat += {"
		<center><h1 style = "color: #ecebdd;">[current_bounty.name]</h1><br>[current_bounty.get_author()]</center><br />
		<div class='statusDisplay' style= "padding: 9px;"><p>[current_bounty.get_description()]</p>"}

		dat += "<br>Expires in [current_bounty.expiry_days()] day(s).</div><br>"

		dat += "<span style=\"color:yellow\"><strong>Required:</strong></span>"

		if(LAZYLEN(current_bounty.items_wanted))
			dat += "<br><strong>Item(s) wanted:</strong><br>"
			for(var/V in current_bounty.items_wanted)
				var/atom/tmp = V
				dat += "<ol> - <b>[initial(tmp.name)]</b> "
				dat += "([current_bounty.items_given[V]]"
				dat += "/[current_bounty.items_wanted[V]])"
				dat += "</ol>"

		if(LAZYLEN(current_bounty.stacks_wanted))
			dat += "<br><strong>Materials wanted:</strong><br>"
			for(var/V in current_bounty.stacks_wanted)
				var/atom/tmp = V
				dat += "<ol> - <b>[initial(tmp.name)]</b> "
				dat += "([current_bounty.stacks_given[V]] out of"
				dat += " [current_bounty.stacks_wanted[V]] stacks)"
				dat += "</ol>"

		if(LAZYLEN(current_bounty.reagents_wanted))
			dat += "<br><strong>Reagents wanted:</strong><br>"
			for(var/V in current_bounty.reagents_wanted)
				if(!chemical_reagents_list[V]) // V should be the reagent's ID, always
					continue

				var/datum/reagent/reagent = chemical_reagents_list[V]
				dat += "<ol> - <b>[initial(reagent.name)]</b> "
				dat += "([current_bounty.reagents_given[V]] out of"
				dat += " [current_bounty.reagents_wanted[V]] units)"
				dat += "</ol>"

		if(LAZYLEN(current_bounty.seeds_wanted))
			dat += "<br><strong>Seeds wanted:</strong><br>"
			for(var/V in current_bounty.seeds_wanted)
				if(!plant_controller.seeds[V])
					continue
				var/datum/seed/seed = plant_controller.seeds[V]

				dat += "<ol> - Packet of <b>[seed.seed_name] [seed.seed_noun]</b> "
				dat += "([current_bounty.seeds_given[V]]"
				dat += "/[current_bounty.seeds_wanted[V]])"
				dat += "</ol>"

		if(LAZYLEN(current_bounty.grown_wanted))
			dat += "<br><strong>Produce wanted:</strong><br>"
			for(var/V in current_bounty.grown_wanted)
				if(!plant_controller.seeds[V])
					continue

				var/datum/seed/seed = plant_controller.seeds[V]

				dat += "<ol> - <b>[seed.seed_name]</b> "
				dat += "([current_bounty.grown_given[V]]"
				dat += "/[current_bounty.grown_wanted[V]])"
				dat += "</ol>"


		if(current_bounty.cash_wanted)
			dat += "<br><strong>Cash Wanted:</strong> [cash2text(current_bounty.cash_wanted, FALSE, TRUE, TRUE )] "
			dat += "([cash2text(current_bounty.cash_given, FALSE, TRUE, TRUE )] given) \n"

		dat += "<br><p><span style=\"color:yellow\"><strong>Reward(s):</strong></span></p>\n"

		if(current_bounty.department_reward)
			dat += "<b><span style=\"color:yellow\">[cash2text(current_bounty.department_reward, FALSE, TRUE, TRUE )]</span></b> for department.\n"
		if(current_bounty.individual_reward)
			dat += "<b><span style=\"color:yellow\">[cash2text(current_bounty.individual_reward, FALSE, TRUE, TRUE )]</span></b> shared between contributors.\n"

		if(LAZYLEN(current_bounty.item_rewards))
			dat += "<br>You will recieve:<br>"
			for(var/V in current_bounty.item_rewards)
				var/atom/tmp = V

				dat += " - [initial(tmp.name)]\n"

		dat += "<br><br><center><a href='?src=\ref[src];choice=complete_bounty;bounty=\ref[current_bounty]'>Confirm Completion</a></center><br>"

	else
		if(!LAZYLEN(D.bounties))
			dat += "No bounties selected, please choose one from the left hand side."
		else
			dat += "No bounties currently active, please try again later."

	dat += "</td></tr></tbody></table>"

	return dat


// SUBTYPES

/obj/machinery/bounty_machine/preset
	icon_state = "bounty_nanotrasen"

/obj/machinery/bounty_machine/preset/colony
	starting_department = DEPT_COLONY

/obj/machinery/bounty_machine/preset/city_council
	starting_department = DEPT_COUNCIL

/obj/machinery/bounty_machine/preset/public
	starting_department = DEPT_PUBLIC

/obj/machinery/bounty_machine/preset/legal
	starting_department = DEPT_LEGAL

/obj/machinery/bounty_machine/preset/maintenance
	starting_department = DEPT_MAINTENANCE

/obj/machinery/bounty_machine/preset/research
	starting_department = DEPT_RESEARCH

/obj/machinery/bounty_machine/preset/police
	starting_department = DEPT_POLICE

/obj/machinery/bounty_machine/preset/healthcare
	starting_department = DEPT_HEALTHCARE

/obj/machinery/bounty_machine/preset/factory
	starting_department = DEPT_FACTORY

/obj/machinery/bounty_machine/preset/solgov
	starting_department = DEPT_SOLGOV

/obj/machinery/bounty_machine/preset/nanotrasen
	starting_department = DEPT_NANOTRASEN

/obj/machinery/bounty_machine/preset/workersunion
	starting_department = DEPT_WORKERSUNION

/obj/machinery/bounty_machine/preset/bluemooncartel
	starting_department = DEPT_BLUEMOONCARTEL

/obj/machinery/bounty_machine/preset/trustfund
	starting_department = DEPT_TRUSTFUND

/obj/machinery/bounty_machine/preset/quercuscoalition
	starting_department = DEPT_QUERCUSCOALITION

/obj/machinery/bounty_machine/preset/houseofjoshua
	starting_department = DEPT_HOUSEOFJOSHUA

/obj/machinery/bounty_machine/Topic(var/href, var/href_list)
	if(..())
		return 1


	if(href_list["connect_business"])
		var/obj/item/weapon/card/id/ID = usr.GetIdCard()

		if(!ID || !ID.unique_ID)
			to_chat(usr,"<span class='notice'>Please wear a valid citizen ID card that is linked to your citizen details.</span>")
			return

		var/datum/business/new_business = get_business_by_owner_uid(ID.unique_ID)

		if(new_business)
			current_department = dept_by_id(new_business.department)
			starting_department = new_business.department

	// Choices menus
	if(href_list["choice"])
		switch(href_list["choice"])

			if("select_bounty")
				var/C = locate(href_list["bounty"])
				var/datum/bounty/bounty = C
				if(!bounty || !current_department || (!(bounty in current_department.bounties)))
					return

				current_bounty = bounty

			if("complete_bounty")
				var/C = locate(href_list["bounty"])
				var/datum/bounty/bounty = C
				if(!bounty || !current_department || (!(bounty in current_department.bounties)))
					return

				var/bounty_name = bounty.name

				if(bounty.complete_bounty(item_spawn_location = get_turf(src)))
					playsound(src, 'sound/machines/chime.ogg', 25)
					to_chat(usr, "\icon[src] <b>[bounty_name]</b> has been completed!")

					if(LAZYLEN(current_department.bounties))
						current_bounty = current_department.bounties[1]
					else
						current_bounty = null
				else
					playsound(src, 'sound/machines/buzz-sigh.ogg', 25)
					visible_message("<span class='notice'>This bounty is not complete, please view for more details!</span>")
					return


	updateDialog()
