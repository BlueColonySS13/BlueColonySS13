/datum/job

	//The name of the job
	var/title = "NOPE"
	//Job access. The use of minimal_access or access is determined by a config setting: config.jobs_have_minimal_access
	var/list/minimal_access = list()      // Useful for servers which prefer to only have access given to the places a job absolutely needs (Larger server population)
	var/list/access = list()              // Useful for servers which either have fewer players, so each person needs to fill more than one role, or servers which like to give more access, so players can't hide forever in their super secure departments (I'm looking at you, chemistry!)
	var/flag = 0 	                       // Bitflags for the job
	var/department_flag = 0
	var/faction = "None"	             // Players will be allowed to spawn in as jobs that are set to "City"
	var/total_positions = 0               // How many players can be this job
	var/spawn_positions = 0               // How many players can spawn in as this job
	var/tmp/current_positions = 0         // How many players have this job
	var/supervisors = null                // Supervisors, who this person answers to directly
	var/subordinates = null			   // If you are a supervisor, who do you command?
	var/selection_color = "#ffffff"       // Selection screen color
	var/idtype = /obj/item/weapon/card/id // The type of the ID the player will have
	var/list/alt_titles                   // List of alternate titles, if any
	var/req_admin_notify                  // If this is set to 1, a text is printed to the player when jobs are assigned, telling him that he should let admins know that he has to disconnect.
	var/minimal_player_age = 0            // If you have use_age_restriction_for_jobs config option enabled and the database set up, this option will add a requirement for players to be at least minimal_player_age days old. (meaning they first signed in at least that many days before.)
	var/department = null                 // Does this position have a department tag?
	var/head_position = 0             	   // Is this position Command?
	var/minimum_character_age = 18
	var/ideal_character_age = 30
	var/account_allowed = 1		  		// Does this job type come with a station account?
	var/wage = 20					    // Per Hour
	var/outfit_type

	var/hard_whitelisted = 0 			// jobs that are hard whitelisted need players to be added to hardjobwhitelist.txt with the format [ckey] - [job] in order to work.
	var/clean_record_required = FALSE		// This job needs a clean record.

	var/no_shuttle = FALSE

	var/description = ""
	var/list/duties = list()
	var/enabled = TRUE
	var/business						// if this is linked to a business, business ID is here.
	var/list/exclusive_employees = list()	// if this job has uids in it, only people of these UIDs can become employees.

/datum/job/proc/sanitize_job()
	if(!exclusive_employees)
		exclusive_employees = list()
	if(!duties)
		duties = list()
	if(!idtype)
		idtype = initial(idtype)
	if(!access)
		access = list()
	if(!minimal_access)
		minimal_access = list()

	return


/datum/job/proc/get_job_email()			// whatever this is set to will be the job's communal email. should be persistent.
	return

/datum/job/proc/get_department()
	return dept_by_id(department)

/datum/job/proc/equip(var/mob/living/carbon/human/H, var/alt_title)
	var/decl/hierarchy/outfit/outfit = get_outfit(H, alt_title)
	if(!outfit)
		return FALSE
	. = outfit.equip(H, title, alt_title)
	return 1

/datum/job/proc/get_outfit(var/mob/living/carbon/human/H, var/alt_title)
	if(alt_title && alt_titles)
		. = alt_titles[alt_title]
	. = . || outfit_type
	. = outfit_by_type(.)

/datum/job/proc/equip_backpack(var/mob/living/carbon/human/H)
	switch(H.backbag)
		if(2) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack(H), slot_back)
		if(3) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel/norm(H), slot_back)
		if(4) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		if(5) H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/messenger(H), slot_back)

/datum/job/proc/setup_account(var/mob/living/carbon/human/H)
	if(!account_allowed || (H.mind && H.mind.initial_account))
		return
	// To prevent abuse, no one recieves wages at roundstart and must play for at least an hour.
	// We'll see how this goes.
	var/money_amount = H.mind.prefs.money_balance
	var/datum/money_account/M
	var/already_joined

	for(var/datum/money_account/A in GLOB.all_money_accounts)
		if(A.account_number == H.mind.prefs.bank_account)
			M = A
			already_joined = 1
			break

	if(!M)
		M = create_account(H.real_name, money_amount, null)
		M.load_persistent_account(H)

	if(check_persistent_account(H.mind.prefs.bank_account))
		money_amount = get_persistent_acc_balance(H.mind.prefs.bank_account)	// so people can actually recieve money they made offline.
	var/income = 0
	if(!H.mind.prefs.played)
		switch(H.mind.prefs.social_class)
			if(CLASS_UPPER)
				income = 10000

			if(CLASS_MIDDLE)
				income = 4000

			if(CLASS_WORKING)
				income = 200

		M.money += income

	if(H.mind)
		var/remembered_info = ""
		remembered_info += "<b>Your account ID is:</b> #[M.account_number]<br>"
		remembered_info += "<b>Your account pin is:</b> [M.remote_access_pin]<br>"
		remembered_info += "<b>Your account funds are:</b> [cash2text( M.money, FALSE, TRUE, TRUE )]<br>"
		H.mind.store_memory(remembered_info)

		H.mind.initial_account = M
		H.mind.initial_bank_details = list("id" = M.account_number, "pin" = M.remote_access_pin)

	to_chat(H, "<span class='notice'><b>Your account number is: [M.account_number], your account pin is: [M.remote_access_pin]</b></span>")

	if(!already_joined && income)
		to_chat(H, "<span class='notice'>You recieved <b>[income] credits</b> in inheritance. <b>Spend it wisely, you only get this once.</b></span>")


// overrideable separately so AIs/borgs can have cardborg hats without unneccessary new()/qdel()
/datum/job/proc/equip_preview(mob/living/carbon/human/H, var/alt_title, var/additional_skips)
	var/decl/hierarchy/outfit/outfit = get_outfit(H, alt_title)
	if(!outfit)
		return FALSE
	. = outfit.equip_base(H, title, alt_title)

/datum/job/proc/get_access()
	if(!config || config.jobs_have_minimal_access)
		return src.minimal_access.Copy()
	else
		return src.access.Copy()

//If the configuration option is set to require players to be logged as old enough to play certain jobs, then this proc checks that they are, otherwise it just returns 1
/datum/job/proc/player_old_enough(client/C)
	return (available_in_days(C) == 0) //Available in 0 days = available right now = player is old enough to play.

/datum/job/proc/available_in_days(client/C)
	if(C && config.use_age_restriction_for_jobs && isnum(C.player_age) && isnum(minimal_player_age))
		return max(0, minimal_player_age - C.player_age)
	return 0

/datum/job/proc/apply_fingerprints(var/mob/living/carbon/human/target)
	if(!istype(target))
		return 0
	for(var/obj/item/item in target.contents)
		apply_fingerprints_to_item(target, item)
	return 1

/datum/job/proc/apply_fingerprints_to_item(var/mob/living/carbon/human/holder, var/obj/item/item)
	item.add_fingerprint(holder,1)
	if(item.contents.len)
		for(var/obj/item/sub_item in item.contents)
			apply_fingerprints_to_item(holder, sub_item)

/datum/job/proc/is_position_available()
	return (current_positions < total_positions) || (total_positions == -1)

/datum/job/proc/has_alt_title(var/mob/H, var/supplied_title, var/desired_title)
	return (supplied_title == desired_title) || (H.mind && H.mind.role_alt_title == desired_title)

//	Creates mannequin with equipment for current job and stores it for future reference
//	used for preview
//	You can use getflaticon(mannequin) to get icon out of it
/datum/job/proc/get_job_mannequin()
	if(!SSjobs.job_mannequins[title])
		var/mob/living/carbon/human/dummy/mannequin/mannequin = get_mannequin("#job_icon_[title]")
		mannequin.gender = pick(MALE,FEMALE)
		mannequin.s_tone = random_skin_tone()
		mannequin.h_style = random_hair_style(mannequin.gender, "Human")
		if(mannequin.gender != FEMALE)
			mannequin.f_style = random_facial_hair_style(mannequin.gender, "Human")

		dress_mannequin(mannequin)


		SSjobs.job_mannequins[title] = mannequin
	return SSjobs.job_mannequins[title]

/datum/job/proc/dress_mannequin(var/mob/living/carbon/human/dummy/mannequin/mannequin)
	mannequin.delete_inventory(TRUE)
	equip_preview(mannequin)


/datum/job/proc/get_full_description()
	var/dat

	if(description)
		dat += "[description]<br><br>"

	if(!isemptylist(duties))
		for(var/V in duties)
			dat += "     - [V].<br>"
	if(wage)
		dat += "<br><br><b>Wage:</b> [cash2text( wage, FALSE, TRUE, TRUE )] PH (per hour)"
	if(head_position && subordinates)
		dat += "<br><br>You are in charge of <b>[subordinates].</b>"
	if(supervisors)
		dat += "<br><br>You follow the orders of <b>[supervisors].</b>"
	if(clean_record_required)
		dat += "<br>You need a <b>clean criminal record</b> to work in this job.</b>"
	return dat

/datum/job/proc/get_active()
	var/active = 0

	for(var/mob/M in player_list)
		if(M.mind && M.client && M.mind.assigned_role == title && M.client.inactivity <= 10 * 60 * 10)
			active++

	return active