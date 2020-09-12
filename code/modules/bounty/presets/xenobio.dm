/datum/bounty/xenobio
	category = CAT_XENOBIO

/datum/bounty/xenobio/yacht_yourself
	name = "Yacht Yourself"
	author = "Admiral Trout Icebreaker of the New Newport Yacht Club"
	description = "Yes they still make boats. Yes us fancy people still have yacht clubs. Yes people still sink sometimes. \
	The newest fad is putting metal slime cores on the inside of the hull to seal any gaps when you carelessly ram things in \
	your overpriced mid life crisis machine. Do not really know if it works but I want to wrangle this market like that 4 foot \
	pike I caught last spring."

	items_wanted = list(
	/obj/item/slime_extract/metal = 1
	)

	department_reward = 150
	individual_reward = 60

	days_until_expiry = 2

/datum/bounty/xenobio/environment_monkey
	name = "Envirom-Eh-ntalism"
	author = "Janus Canadian"
	description = "Sorry for making a fuss but I think our Biodome is missing some animals. \
	Not many animals will travel the entire distance very well, so I was thinking of something that you just add water to. \
	If the time permits please send me some monkey cubes. Sorry."

	items_wanted = list(
	/obj/item/weapon/reagent_containers/food/snacks/monkeycube = 8)

	department_reward = 150	// monkey cubes aren't scarce
	individual_reward = 60

	days_until_expiry = 1

/datum/bounty/xenobio/default_extract
	name = "Extracts Wanted"
	author = "BlandCo."
	description = "Basic extracts wanted. Payment will be rendered upon delivery of assets. End communications."

	items_wanted = list(/obj/item/slime_extract/grey = 10)

	department_reward = 300
	individual_reward = 110

	days_until_expiry = 2

/datum/bounty/xenobio/frost_metals
	name = "Frost Metals"
	author = "Nordstrom Metallurgy"
	description = "We've heard that blue slime extracts can be used to solidify liquid metals. We beleive that the extract has \
	a potential use in our industry. Please send us some samples for us to test."

	items_wanted = list(/obj/item/slime_extract/blue = 10)

	department_reward = 450
	individual_reward = 260

	days_until_expiry = 2

/datum/bounty/xenobio/firewalk_with_me
	name = "Firewalk With Me"
	author = "Charlie Kain"
	description = "I need some orange slime extracts. My friends and I are going down to the beach next week to celebrate the passing \
	of one of our buddies. He used to love walking on coals and had always planned on walking on burning orange slime cores. In his honor, \
	we're gonna take the 30 meter slime challenge."

	items_wanted = list(/obj/item/slime_extract/orange = 10)

	department_reward = 400
	individual_reward = 210

	days_until_expiry = 2

/datum/bounty/xenobio/new_energy_source
	name = "New Energy Source?"
	author = "Goop LLC."
	description = "We have been trying to produce yellow slimes with our breeding program but have failed at every turn. We know that the yellow \
	slime cores function as organic batteries and we would like some extracts to test their sustainability."

	items_wanted = list(/obj/item/slime_extract/yellow = 7)

	department_reward = 760
	individual_reward = 570

	days_until_expiry = 2

/datum/bounty/xenobio/organic_phoron
	name = "Organic Phoron!"
	author = "Goop LLC."
	description = "Once again, we've failed to produce anything but grey slimes in our labs. We are seeking dark purple slimes in order to determine \
	how they manage to produce phoron! Phoron mining may be a thing of the past if we can find a way to reproduce this biological function in other animals! \
	Phoron milk? Phoron spider silk? The possibilities are endless!"

	items_wanted = list(/obj/item/slime_extract/dark_purple = 3) // this is a rare slime

	department_reward = 400
	individual_reward = 210

	days_until_expiry = 2

/datum/bounty/xenobio/slime_conditioning
	name = "Slime Conditioning"
	author = "Goop LLC."
	description = "We'll get the hang of breeding slimes eventually! We need dark blue slime cores this time. They reduce the ambient temperature of the room when \
	exposed to phoron and it may be useful in various industries where extreme cold is required. A new line of slime powered air conditioners also isn't out of the \
	question. We don't think they'd sell well on this planet, however."

	items_wanted = list(/obj/item/slime_extract/dark_blue = 3)	// an uncommon slime

	department_reward = 350
	individual_reward = 180

	days_until_expiry = 2

/datum/bounty/xenobio/unnatural_selection
	name = "Unnatural Seleciton"
	author = "Goop LLC."
	description = "Eureka! We've figured it out! Red slime extracts result in a 12% increase in genetic mutation in slimes! Send us some red slime extracts A.S.A.P. \
	We can finally get our slime breeding program off the ground!"

	items_wanted = list(/obj/item/slime_extract/red = 3)

	department_reward = 300
	individual_reward = 110

	days_until_expiry = 2

/datum/bounty/xenobio/uranium_fever
	name = "Uranium Fever"
	author = "Goop LLC."
	description = "Our researchers have been doing research into how these slimes are able to produce radioactive elements as a byproduct of their biological functions. \
	Send us some green slime extracts. We believe they may be useful in applications requiring uranium."

	items_wanted = list(/obj/item/slime_extract/green = 7)

	department_reward = 620
	individual_reward = 430

	days_until_expiry = 2

/datum/bounty/xenobio/healing_goop
	name = "Healing Goop"
	author = "Goop LLC."
	description = "Another test in the usefulness of the slime species. We need pink slime extracts this time. They produce beneficial substances during their metabolic \
	processes. We could get rid of Big Pharma with a breeding program comprised of these slimes. Don't tell them we said that, though."

	items_wanted = list(/obj/item/slime_extract/pink = 5)

	department_reward = 550
	individual_reward = 360

	days_until_expiry = 2

/datum/bounty/xenobio/big_booms
	name = "Big Booms"
	author = "Goop LLC."
	description = "We don't see any useful application for these slimes but some of the researchers over in R&D are big fans of pyrotechnics. Send us some oil slime extracts \
	so we can put on a show to boost morale. We hear the explosions are pretty big when these extracts are exposed to phoron."

	items_wanted = list(/obj/item/slime_extract/oil = 5)

	department_reward = 400
	individual_reward = 210

	days_until_expiry = 2

/datum/bounty/xenobio/slime_snax
	name = "Slime Snax"
	author = "Goop LLC."
	description = "We actually discovered this one by accident but amber slime extracts are delicious! Send us as many as you can. We think these might actually be a pretty good \
	snack, if we're right about it. Hey, you may even see Goop LLC. Slime Snax in a vending machine near you some day!"

	items_wanted = list(/obj/item/slime_extract/amber = 10)

	department_reward = 700
	individual_reward = 510

	days_until_expiry = 2

/datum/bounty/xenobio/project_promethean
	name = "Project Promethean"
	author = "Goop LLC."
	description = "The following is purely speculative and confidential! By reading this, you're accepting our terms of service, including a non-disclosure agreement! We aren't even \
	sure if this actually exists, but if you somehow manage to breed this particular slime - let's just say, you'll be pretty happy with the reward. We need a sapphire slime extract. \
	Our researchers have been looking at the slime genome and when the blue color gene is slightly modified, other genes in the slime genome unravel! We think we could fit in genes \
	from other species into the gaps!"

	items_wanted = list(/obj/item/slime_extract/sapphire = 2)

	department_reward = 2000
	individual_reward = 1000

	days_until_expiry = 3


/datum/bounty/xenobio/docility_potion
	name = "Friendly Slimes"
	author = "PetCorp"
	description = "At PetCorp we're looking for well-behaved slimes to sell to kind and loving owners. Emphasis on well-behaved, since the media scandal of 2560 \
	regarding a slime that tried to eat an owner and his two kids we've had to extensively work on our PR. We believe slimes can re-enter the market but they must \
	be docile. Send up one of the docility potions so we can start with our first proje- pet!"

	items_wanted = list(/obj/item/slimepotion/docility = 1)

	department_reward = 1200
	individual_reward = 600

	days_until_expiry = 3
