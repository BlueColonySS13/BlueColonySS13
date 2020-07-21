/datum/bounty/health_pharma
	category = CAT_HEALTH

/datum/bounty/health_pharma/tricord_contractor
	name = "Contractor Work"
	author = "Lazy Guillaume, MD"
	description = "People keep coming into my office complaining about pains and horrible lacerations and how I should do my job. \
	I just need an easy way to get them out. I was talking to Shady Guy Behind the Market but he said I would have to go somewhere \
	like behind the market to get anything from him and that is too far. Please send me some Tricordrazine pills so I will not \
	actually have to do my job."

	reagents_wanted = list("tricordrazine" = 200)

	department_reward = 200
	individual_reward = 50

	days_until_expiry = 1


/datum/bounty/health_pharma/mental_asylum
	name = "Definitely A Medical Emergency"
	author = "Falsus Mental Asylum"
	description = "We’re running dangerously low on Chloral Hydrate, and some of our more... interesting patients are starting to wake up. \
	We need a restock in order to keep our \"patients\" completely sedated until they’re ready for \"treatment\". Yes. Treatment."

	reagents_wanted = list("chloralhydrate" = 300)

	department_reward = 800
	individual_reward = 250

	days_until_expiry = 1

/datum/bounty/health_pharma/bitter_medicine
	name = "Bitter Medicine"
	author = "Pollux Charitable Foundation"
	description = "We’re running low on basic medical supplies for our people. We need Bicardine and Trauma Kits desperately, \
	but we don’t have much money. We hope this will suffice."

	items_wanted = list(/obj/item/stack/medical/advanced/bruise_pack = 5)

	reagents_wanted = list("bicaridine" = 120)

	department_reward = 300
	individual_reward = 60

	days_until_expiry = 1

/datum/bounty/health_pharma/frosthome_ammonia
	name = "EZ-Nutrient This Ain't"
	author = "Frosthome Enclave"
	description = "Out of season blizzards have disrupted the Courier Network providing us an ample supply of EZ-Nutrient for our \
	crops. We need to stock up fast before the next storm hits us in approximately 48 hours. We need as much fertilizer as you can spare."

	reagents_wanted = list("ammonia" = 480)

	department_reward = 200	//ammonia is easy to make. reducing this a bit
	individual_reward = 80

	days_until_expiry = 1

/datum/bounty/health_pharma/supermatter_failure
	name = "URGENT: Supermatter Delamination!"
	author = "NSS Experience"
	description = "This is an urgent request from the NSS Experience! Our Supermatter Engine has delaminated and a vast majority of our crew \
	is suffering from radiation poisoning. Our Medbay was destroyed by the blast and we are under strict quarantine orders! Please send us \
	Arithrazine A.S.A.P! We aren't going to make it without your help!"

	reagents_wanted = list("arithrazine" = 300)

	department_reward = 300
	individual_reward = 60

	days_until_expiry = 1

/datum/bounty/health_pharma/vampire
	name = "All Donations Velcome"
	author = "Vladislav Vanburg"
	description = "Our... hospital is low on BLOOD. Donate to our cause. Stick your neck out for BLOOD hungry people in need."

	reagents_wanted = list("blood" = 500)

	department_reward = 650   //Reagent is hard to accumulate in vast quantities such as this. High reward. // Vatborn cubes can offset blood accumilation.
	individual_reward = 150

	days_until_expiry = 3

/datum/bounty/health_pharma/pain_pain_go_away
	name = "Pain, Pain, Go Away"
	author = "Parker Peterson"
	description = "Even the best spider hunter gets hurt in the call of duty. Spider venom really burns when it's flowing through your body and \
	turning your blood into jelly. Tramadol is the cure to what ails me. Please send me some before I pass out."

	reagents_wanted = list("tramadol" = 60)

	department_reward = 200
	individual_reward = 50

	days_until_expiry = 2

/datum/bounty/health_pharma/side_effects_shmide_effects
	name = "Side Effects, Shmide Effects"
	author = "Parker Peterson"
	description = "Little known side effect of Synaptizine. In VERY large doses, it functions as a pretty powerful blood thinner - enough to combat \
	Western Spider venom! With enough charcoal, it keep bring even the most jellied victims out of the cold, bony hands of the grim reaper. Obviously, \
	I don't plan on using it that way, otherwise you wouldn't send me the synaptizine. Heh. Please send - this venom burns."

	reagents_wanted = list("synaptizine" = 100)

	department_reward = 100
	individual_reward = 20

	days_until_expiry = 1