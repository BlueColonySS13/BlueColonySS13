
	/* EXAMPLE BOUNTY FORMAT FOR ITEMS

	items_wanted = list(/obj/item/weapon/reagent_containers/food/snacks/croissant = 6)
	seeds_wanted = list("apple" = 10)
	grown_wanted = list("orange" = 5)
	stacks_wanted = list(/obj/item/stack/material/lead = 160)	for 160 logs
	reagents_wanted = list("tramadol" = 30) 30 units of tramadol

	*/


	/* FORMAT FOR CONTRIBUTORS

	contributors_bankids = list("examplebankid" = 5,
	"anotherexamplebankid" = 5)	- if these people contributed 5 seeds out of 10 each. they will get half of the commission eacj

	*/

/datum/bounty
	var/name

	var/author = "NanoTrasen"
	var/description = "This is a bounty. You shouldn't see this."

	var/author_department = null 		// department ID

	var/category

	//contributors
	var/source_department = null
	var/list/contributors_bankids = list()

	//expiry stuff
	var/creation_date				// used for calculating vs the current day for bounties that last several days.
	var/days_until_expiry = 1		// difference between today and creation date, past this, it will expire.
	var/bounty_expires = TRUE

	//bounty item stuff
	var/custom_requirement = ""		// actually does nothing, is just there to give players direction, usually paired with a custom completion method.

	var/list/items_wanted = list()
	var/list/seeds_wanted = list()	// just uses seed id and then amount
	var/list/grown_wanted = list()
	var/list/stacks_wanted = list()
	var/list/reagents_wanted = list()
	var/cash_wanted = 0

	//randomisers
	var/list/random_items_wanted = list()	// picks an item from this list and adds it to items_wanted
	var/list/random_seeds_wanted = list()	// picks an item from this list and adds it to seeds_wanted
	var/list/random_grown_wanted = list()	// picks an item from this list and adds it to grown_wanted
	var/list/random_stacks_wanted = list()	// picks an item from this list and adds it to stacks_wanted
	var/list/random_reagents_wanted = list()	// picks an item from this list and adds it to reagents_wanted
	var/cash_min = 0
	var/cash_max = 0

	//reward stuff
	var/department_reward = 100 		// In credits.
	var/individual_reward = 40		// In credits
	var/list/item_rewards = list()
	var/cash_reward_min = 0
	var/cash_reward_max = 0

	//reward checks stuff
	var/list/items_given = list()
	var/list/stacks_given = list()
	var/list/reagents_given = list()
	var/list/seeds_given = list()
	var/list/grown_given = list()
	var/cash_given = 0

	var/completed = FALSE

	var/delete_upon_completion = TRUE

	var/allow_subtypes = FALSE // does this bounty search for strict types, or are subtypes allowed also? Only applies to item bounties.

	var/tax_type = BUSINESS_TAX // portal id of the tax type this bounty pays out to.

/datum/bounty/New(new_name, new_author, new_desc, new_author_department, new_items_wanted, \
	new_stacks_wanted, new_reagents_wanted, new_grown_wanted, new_seeds_wanted, new_cash_wanted, add_active_bounty_list = TRUE)

	setup_bounty()

	if(new_name)
		name = new_name
	if(new_author)
		author = new_author
	if(new_desc)
		description = new_desc
	if(dept_by_id(new_author_department))
		author_department = new_author_department
	if(LAZYLEN(new_items_wanted))
		items_wanted = new_items_wanted
	if(LAZYLEN(new_stacks_wanted))
		stacks_wanted = new_stacks_wanted
	if(LAZYLEN(new_reagents_wanted))
		reagents_wanted = new_reagents_wanted
	if(LAZYLEN(new_grown_wanted))
		grown_wanted = new_grown_wanted
	if(LAZYLEN(new_seeds_wanted))
		seeds_wanted = new_seeds_wanted
	if(new_cash_wanted)
		cash_wanted = new_cash_wanted

	reset_bounty()
	sanitize_bounty()

	if(add_active_bounty_list)
		SSbounties.active_bounties |= src

	..()

/datum/bounty/proc/replace_all_strings()
	description = replacetext(description, "’", "'")
	description = replacetext(description, "%DOCKNAME",using_map.dock_name)
	description = replacetext(description, "%BOSSNAME",using_map.boss_name)
	description = replacetext(description, "%BOSSSHORT",using_map.boss_short)
	description = replacetext(description, "%COMPNAME",using_map.company_name)
	description = replacetext(description, "%COMPSHORT",using_map.company_short)
	description = replacetext(description, "%AUTHOR",author)
	description = replacetext(description, "%CASHWANTED", "[cash2text(cash_wanted, FALSE, TRUE, TRUE )]")
	description = replacetext(description, "%CASHINDIE", "[cash2text(individual_reward, FALSE, TRUE, TRUE )]")
	description = replacetext(description, "%CASHDEPT", "[cash2text(department_reward, FALSE, TRUE, TRUE )]")

/datum/bounty/proc/setup_bounty()
	return

/datum/bounty/proc/get_author()
	return author

/datum/bounty/proc/get_description()
	return description

/datum/bounty/proc/check_for_completion()
	if(LAZYLEN(items_wanted))
		for(var/V in items_wanted)
			if(!(items_given[V] >= items_wanted[V]))
				return FALSE

	if(LAZYLEN(seeds_wanted))
		for(var/V in seeds_wanted)
			if(!(seeds_given[V] >= seeds_wanted[V]))
				return FALSE

	if(LAZYLEN(grown_wanted))
		for(var/V in grown_wanted)
			if(!(grown_given[V] >= grown_wanted[V]))
				return FALSE

	if(LAZYLEN(stacks_wanted))
		for(var/V in stacks_wanted)
			if(!(stacks_given[V] >= stacks_wanted[V]))
				return FALSE

	if(LAZYLEN(reagents_wanted))
		for(var/V in reagents_wanted)
			if(!(reagents_given[V] >= reagents_wanted[V]))
				return FALSE

	if(cash_wanted)
		if(!(cash_given >= cash_wanted))
			return FALSE

	return TRUE

/datum/bounty/proc/add_contributor(bank_id)
	if(!bank_id)
		return

	if(!(bank_id in contributors_bankids))
		contributors_bankids[bank_id] = 1
	else
		var/amount = contributors_bankids[bank_id]
		amount++
		contributors_bankids[bank_id] = amount

/datum/bounty/proc/expire_bounty()
	completed = TRUE

	if(source_department)
		var/datum/department/D = dept_by_id(source_department)

		if(!D)
			return

		pay_contributors(D)

		if(delete_upon_completion)
			if(src in D.bounties)
				D.bounties -= src


	if(delete_upon_completion)
		if(src in SSbounties.active_bounties)
			SSbounties.active_bounties -= src
		qdel(src)

	else
		reset_bounty()
		sanitize_bounty()

	return TRUE


/datum/bounty/proc/reset_bounty()
	items_given = list()
	seeds_given = list()
	grown_given = list()
	stacks_given = list()
	reagents_given = list()
	cash_given = 0
	contributors_bankids = list()

	if(LAZYLEN(random_items_wanted))
		items_wanted += pick(random_items_wanted)

	if(LAZYLEN(random_grown_wanted))
		grown_wanted += pick(random_grown_wanted)

	if(LAZYLEN(random_seeds_wanted))
		seeds_wanted += pick(random_seeds_wanted)

	if(LAZYLEN(random_stacks_wanted))
		stacks_wanted += pick(random_stacks_wanted)

	if(LAZYLEN(random_reagents_wanted))
		reagents_wanted += pick(random_reagents_wanted)

	if(cash_max)
		cash_wanted = rand(cash_min, cash_max)

	if(cash_reward_max)
		department_reward = rand(cash_reward_min, cash_reward_max)
		individual_reward = round(department_reward / 4)

	creation_date = full_real_time()
	replace_all_strings()



/datum/bounty/proc/complete_bounty(skip_completion_check = FALSE, turf/item_spawn_location = null, mob/user)
	if(!skip_completion_check)
		if(!check_for_completion())
			return FALSE

	if(!source_department)
		return FALSE

	var/datum/department/D = dept_by_id(source_department)

	if(!D || !D.bank_account)
		return

	var/tax_amt = SSpersistent_options.get_persistent_option_value(tax_type) * department_reward
	var/final_pay = department_reward

	if(D.business_taxed)
		final_pay = department_reward - tax_amt

	D.adjust_funds(final_pay, "Bounty Completion: [name] by [author][D.business_taxed ? " ([cash2text( tax_amt, FALSE, TRUE, TRUE )] tax)" : ""]")
	if(author_department)
		var/datum/department/DA = dept_by_id(author_department)
		if(!DA) return
		DA.adjust_funds(-department_reward, "Bounty Completion: [name] by [author]")

	if(!LAZYLEN(contributors_bankids) && individual_reward && user) // useful for custom objective bounties
		var/obj/item/weapon/card/id/ID = user.GetIdCard()

		if(ID && ID.associated_account_number)
			contributors_bankids += ID.associated_account_number
			contributors_bankids[ID.associated_account_number] = 1

	if(item_spawn_location && isturf(item_spawn_location))
		for(var/A in item_rewards)
			if(ispath(A))
				new A(item_spawn_location)

	expire_bounty()

	return TRUE


/datum/bounty/proc/pay_contributors(var/datum/department/D)
	if(!D || !D.bank_account)
		return

	var/hidden = D.bank_account.hidden

	if(LAZYLEN(contributors_bankids) && individual_reward)
		var/full_no = 0
		var/inv_money = 0
		for(var/C in contributors_bankids)
			full_no += contributors_bankids[C]

		if(full_no)
			inv_money = individual_reward / full_no

		for(var/V in contributors_bankids)
			var/division_number = contributors_bankids[V]
			if(!division_number)
				continue

			var/payment_owed = round(inv_money * division_number)

			if(payment_owed)
				charge_to_account(V, "Boun-T", "Bounty Completion Contribution: [name]/[D.name]", "BouNT Finances", payment_owed, !hidden)

		return TRUE


/datum/bounty/proc/expiry_days()
	var/days_open = Days_Difference(creation_date, full_real_time())

	return days_until_expiry - days_open

/datum/bounty/proc/check_item(the_thing, bank_id)
	if(!the_thing || !isobj(the_thing))
		return

	if(istype(the_thing, /obj/item/weapon/storage))
		if(check_item_contents(the_thing, bank_id))
			add_contributor(bank_id)
			return TRUE

	else if(check_single_item(the_thing))
		add_contributor(bank_id)
		return TRUE

	var/datum/department/D = dept_by_id(source_department)

	if(D.dept_type == PUBLIC_DEPARTMENT)
		if(istype(the_thing, /obj/item/weapon/redemption_box))
			if(check_redemption_box(the_thing, bank_id))
				add_contributor(bank_id)
				qdel(the_thing)
				return TRUE

	return FALSE


/datum/bounty/proc/meets_standards(var/obj/O)	// additional custom checks
	return TRUE


/datum/bounty/proc/check_item_contents(var/obj/item/weapon/storage/the_thing, bank_id)
	if(!the_thing || !isobj(the_thing))
		return

	if(!istype(the_thing, /obj/item/weapon/storage))
		return

	var/obj/item/weapon/storage/S = the_thing

	var/got_something = FALSE

	for(var/obj/O in S.GetAllContents())
		if(check_single_item(O))
			add_contributor(bank_id)
			got_something = TRUE

	if(got_something)
		return TRUE

	if(check_single_item(S))
		add_contributor(bank_id)
		return TRUE


/datum/bounty/proc/check_single_item(var/obj/the_thing)

	if(!the_thing || !isobj(the_thing))
		return

	if(!meets_standards(the_thing))
		return

	if(LAZYLEN(grown_wanted))
		if(istype(the_thing, /obj/item/weapon/reagent_containers/food/snacks/grown))
			var/obj/item/weapon/reagent_containers/food/snacks/grown/grown = the_thing

			if(grown.plantname in grown_wanted)
				if(!grown_given[grown.plantname])
					grown_given[grown.plantname] = 1
					qdel(grown)
					return TRUE

				else if(grown_wanted[grown.plantname] > grown_given[grown.plantname])
					grown_given[grown.plantname] += 1
					qdel(grown)
					return TRUE

	if(LAZYLEN(seeds_wanted))
		if(istype(the_thing, /obj/item/seeds))
			var/obj/item/seeds/seeds = the_thing

			if(seeds.seed_type in seeds_wanted)

				if(!seeds_given[seeds.seed_type])
					seeds_given[seeds.seed_type] = 1
					qdel(seeds)
					return TRUE
				else if(seeds_wanted[seeds.seed_type] > seeds_given[seeds.seed_type])
					seeds_given[seeds.seed_type] += 1
					qdel(seeds)
					return TRUE

	if(LAZYLEN(reagents_wanted))
		if(istype(the_thing, /obj/item/weapon/reagent_containers))
			var/obj/item/weapon/reagent_containers/container = the_thing

			if(container.reagents && LAZYLEN(container.reagents.reagent_list))
				for(var/datum/reagent/R in container.reagents.reagent_list)
					if(R.id in reagents_wanted)
						if(reagents_given[R.id] >= reagents_wanted[R.id]) // if given is more than wanted already
							return FALSE

						var/to_add = reagents_wanted[R.id] - reagents_given[R.id]
						var/delete_after = FALSE

						if(istype(container, /obj/item/weapon/reagent_containers/pill) || istype(container, /obj/item/weapon/reagent_containers/powder))
							delete_after = TRUE

						if(R.volume >= reagents_wanted[R.id])
							if(reagents_wanted[R.id] > reagents_given[R.id]) //
								reagents_given[R.id] += to_add

								container.reagents.remove_reagent(R.id, to_add)

								if(delete_after)
									qdel(container)
								return TRUE
						else
							reagents_given[R.id] += R.volume
							container.reagents.remove_reagent(R.id, to_add)

							if(delete_after)
								qdel(container)
							return TRUE



	if(LAZYLEN(stacks_wanted))
		if(istype(the_thing, /obj/item/stack/material))
			var/obj/item/stack/material/stack = the_thing
			if(stack.default_type in stacks_wanted)
				if(stack.amount >= stacks_wanted[stack.default_type])
					var/to_add = stacks_wanted[stack.default_type] - stacks_given[stack.default_type]
					stacks_given[stack.default_type] += to_add
					qdel(stack)
					return TRUE
				else
					stacks_given[stack.default_type] += stack.amount
					qdel(stack)
					return TRUE

	if(cash_wanted)
		if(istype(the_thing, /obj/item/weapon/spacecash/bundle))
			var/obj/item/weapon/spacecash/bundle/monie = the_thing
			if(monie.worth >= cash_wanted)
				var/to_add = cash_wanted - cash_given
				cash_given += to_add
				qdel(monie)
				return TRUE
			else
				cash_given += monie.worth
				qdel(monie)
				return TRUE

	if(LAZYLEN(items_wanted))
		var/obj/O = the_thing

		var/is_wanted_item = null

		if(allow_subtypes)
			for(var/V in items_wanted)
				if(istype(O, V))
					is_wanted_item = V
		else
			if(O.type in items_wanted)
				is_wanted_item = O.type

		if(is_wanted_item)
			if(!items_given[is_wanted_item])
				items_given[is_wanted_item] = 1
				qdel(O)
				return TRUE
			else if(items_wanted[is_wanted_item] > items_given[is_wanted_item])
				items_given[is_wanted_item] += 1
				qdel(O)
				return TRUE

	return FALSE

/datum/bounty/proc/check_redemption_box(var/obj/item/weapon/redemption_box/the_thing, bank_id)
	if(!the_thing || !isobj(the_thing))
		return

	if(!istype(the_thing, /obj/item/weapon/redemption_box))
		return

	var/obj/item/weapon/redemption_box/R = the_thing

	var/got_something = FALSE

	for(var/obj/O in R.GetAllContents())
		if(check_single_item(O))
			add_contributor(bank_id)
			got_something = TRUE

	if(got_something)
		return TRUE

	if(check_single_item(R))
		add_contributor(bank_id)
		return TRUE

/datum/bounty/proc/sanitize_bounty()
	if(!name)
		name = initial(name)
	if(!author)
		author = initial(author)
	if(author_department && !dept_by_id(author_department))
		author_department = null

	if(!creation_date)
		creation_date = full_real_time()

	var/days_expiry = expiry_days()

	if((1 > days_expiry) && bounty_expires)
		expire_bounty()

	//wanted
	if(!isnum(cash_wanted))
		cash_wanted = initial(cash_wanted)

	if(!items_wanted || !islist(items_wanted))
		items_wanted = initial(items_wanted)

	if(!stacks_wanted || !islist(stacks_wanted))
		stacks_wanted = initial(stacks_wanted)

	if(!reagents_wanted || !islist(reagents_wanted))
		reagents_wanted = initial(reagents_wanted)

	if(!seeds_wanted || !islist(seeds_wanted))
		seeds_wanted = initial(seeds_wanted)

	if(!grown_wanted || !islist(grown_wanted))
		grown_wanted = initial(grown_wanted)


	for(var/A in items_wanted)
		if(!items_given[A])
			items_given[A] = 0
		if(!items_wanted[A])
			items_wanted[A] = 1

	for(var/B in stacks_wanted)
		if(!stacks_given[B])
			stacks_given[B] = 0
		if(!stacks_wanted[B])
			stacks_wanted[B] = 1

	for(var/C in reagents_wanted)
		if(!reagents_given[C])
			reagents_given[C] = 0
		if(!reagents_wanted[C])
			reagents_wanted[C] = 1

	for(var/D in seeds_wanted)
		if(!seeds_given[D])
			seeds_given[D] = 0
		if(!seeds_wanted[D])
			seeds_wanted[D] = 1

	for(var/E in grown_wanted)
		if(!grown_given[E])
			grown_given[E] = 0
		if(!grown_wanted[E])
			grown_wanted[E] = 1