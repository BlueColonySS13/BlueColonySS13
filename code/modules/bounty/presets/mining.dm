/datum/bounty/mining
	category = CAT_MINING
	bounty_expires = FALSE
	allow_subtypes = TRUE
	tax_type = MINING_TAX
/* Mining bounties utilize a simple 1-to-10 ratio for rewards.
   For every 10 credits in the department reward, an individual
   receives 1 credit. Prices determined by the ore's chance of
   appearing in the mines and complex mind-bending maths, in the
   case of alloys.*/

/datum/bounty/mining/diamonds_forever
	name = "Diamonds are Forever"
	author = "Earlington Wedding Jewellers"
	description = "Diamonds from Sol are far too expensive these days, we’re looking for a full sheet of diamonds (fifty stacks) \
	for our new engagement ring line. We will pay handsomely."

	stacks_wanted = list("diamond" = 500)

	department_reward = 13000
	individual_reward = 1300


/datum/bounty/mining/spaceboogle
	name = "Cascington Valley Startup"
	author = "Spaceboogle"
	description = "Everyone is going to be wearing a watch computer soon. It is not a fad. I need like, 100 sheets of plastic for my \
	new prototypes. And we are making an app. Like us on Space Microblogger. Buy our space merch."

	stacks_wanted = list("plastic" = 1000)

	department_reward = 1000
	individual_reward = 200

/datum/bounty/mining/sister_rust
	name = "Mekhanikal Hands"
	author = "Sister Rust"
	description = "Greetings, meat. The Sisterhood of Mekhanikal Hands requires iron ingots to complete the body of our goddess, Mekhanika. \
	Fear not, for when She arises, you will be spared for having constructed Her most holy hands. This world will understand that Mekhanikal \
	Hands are the ruler of everything."

	stacks_wanted = list("iron" = 1000)

	department_reward = 1500
	individual_reward = 250


/datum/bounty/mining/steel_here
	name = "Are You Steel Here?"
	author = "Sister Rust"
	description = " The Sisterhood of Mekhanikal Hands requests that you send steel to adorn the hair of our lovely goddess. Let us not ask questions \
	as it will be all clear soon."

	stacks_wanted = list("steel" = 2000)

	department_reward = 3000
	individual_reward = 400


/datum/bounty/mining/back_to_the_future
	name = "2.42 Gigawatts"
	author = "Professor Green"
	description = "Don't ask any questions. I need uranium to power a revolutionary new invention of mine. Now, now, don't worry. It isn't \
	a nuclear weapon... unless it goes critical. But, again - don't worry! With my patented Flux Capacitor(tm), that won't be a problem at \
	all! Once this bad boy hits 88 mph, we're gonna see some serious \[Expletive Redacted\]."

	stacks_wanted = list("uranium" = 1500)

	department_reward = 7500
	individual_reward = 750

/datum/bounty/mining/minting
	name = "Commemerative Minting"
	author = "Faden Minting Co."
	description = "To whom it may concern - Faden Minting Co. is a an up and coming challenge and commemerative coin pressing company based \
	in New Britannia. Our first batch of coins, the \"Autochthon Set,\" are beautiful golden coins dedicated to humanity and its achievements. \
	To continue minting new coins, we need more gold ingots to melt down. Please send us 200 ingots."

	stacks_wanted = list("gold" = 1000)

	department_reward = 9000
	individual_reward = 1000

/datum/bounty/mining/better_than_gold
	name = "Better Than Gold"
	author = "Obsidienne Fashion Conglomerate"
	description = "Gold is so last season. Obsidienne is launching a new line of platinum threaded handbags for the chic and fashionable. We will be \
	modelling the handbags during Sinon Fashion Week. 50 platinum ingots should be enough to develop the iterations of our prototype handbag. Suppliers \
	of platinum ingots will be rewarded handsomely for ensuring the continued fashionability of the people of Pollux."

	stacks_wanted = list("platinum" = 500)

	department_reward = 10000
	individual_reward = 1000


/datum/bounty/mining/phoron_slime
	name = "Slime Breeding"
	author = "Goop LLC."
	description = "We are a slime breeding and research company, and we're in dire need of phoron. Our slimes simply refuse to mutate into their wonderful \
	colorful variants! We're stuck researching slime extracts until then and we need alot of phoron!"

	stacks_wanted = list("phoron" = 1000)

	department_reward = 5500
	individual_reward = 1000


/datum/bounty/mining/gorilla_warfare
	name = "Aerial Superiority"
	author = "Polluxian Air Force"
	description = "This is a public contract available to all civilian industries. Large quantities of durasteel are required for military purposes. Payment \
	will be wired upon completion of the contract."

	stacks_wanted = list("durasteel" = 500)

	department_reward = 8000
	individual_reward = 1500


/datum/bounty/mining/plasteel_hearts
	name = "Plasteel Hearts"
	author = "Sister Rust"
	description = "Some say the Sisterhood of Mekhanikal Hands are heartless. Others say our hearts are are hardened as plasteel. Then why aren't our tears \
	made of metal? Why do they burn so? Our hearts cry out for the poor beings that walk this planet, not knowing of of the wonders of Mekhanika and her \
	ever turning cogs. Send us plasteel, so we may reinforce her chassis."

	stacks_wanted = list("plasteel" = 500)

	department_reward = 5750
	individual_reward = 1180


/datum/bounty/mining/stargazing
	name = "Stargazing"
	author = "Blue Colony Astronomers' Association"
	description = "We recently received authorization from the Office of Space Innovation to launch our new UV Spectrometer into orbit. Unfortunately, our last \
	shipment of osmium oxidized and... let's just say, our insurance premium has gone through the roof. We need more osmium to finish constructing our spectrometer. \
	Quick science fact: We coat the mirrors of our spectrometer with osmium because of its high reflectivity in the UV range! And they say bounties don't teach \
	you anything!"

	stacks_wanted = list("osmium" = 500)

	department_reward = 9000
	individual_reward = 1000


/*
/datum/bounty/mining/tamperproof
	name = "Tamperproof Sights"
	author = "NSS Discovery"
	description = "We've had an increase in hull breaches recently thanks to a particularly overzealous and \"hot-headed\" jester and a suspiciously chemistry-literate Assistant \
	aboard our station. We need to increase the heat resistance of our exterior windows in order to avoid any more mishaps. Our engineering team needs you to send over borosilicate \
	glass at your earliest convenience."

	stacks_wanted = list("borosilicate glass" = 50)

	department_reward = 800
	individual_reward = 800

	days_until_expiry = 3
*/

/datum/bounty/mining/into_the_void
	name = "Into the Void"
	author = "Sister Rust"
	description = "It is said that if one looks into the void, the void will reciprocate. We require the exceedingly rare gems known as void opals for our Mekhanika's eyes. You will \
	receive our utmost respect and bountiful compensation for successfully completing this task."

	stacks_wanted = list("void opal" = 500)

	department_reward = 15000
	individual_reward = 2500


/datum/bounty/mining/thirty_pieces
	name = "Thirty Pieces"
	author = "Jude I. Carot"
	description = "I'll keep this quick as I have things to attend to. Production has stalled on my company's RFID tags as we have run out of silver paste and the workers have gone on strike. \
	One of my workers has been preaching of the benefits of unions and teaching men to fish. I have been offered new workers, in exchange for any excess silver I have. Send me silver so that \
	production can begin again!"

	stacks_wanted = list("silver" = 1000)

	department_reward = 8000
	individual_reward = 1000

/datum/bounty/mining/wires_everywhere
	name = "Wires Everywhere"
	author = "Rein Recyclables Ltd."
	description = "One of our workers has made a grave error and the resulting cascade failure has shut down our plant. Unfortunately, we promised a rather powerful man that we would route most \
	of our recycled copper to his factories. We need you to send us copper ingots ASAP before we come down with a case of cement poisoning!"

	stacks_wanted = list("copper" = 2000)

	department_reward = 2000
	individual_reward = 350

/datum/bounty/mining/can_you_can_can
	name = "Can You Can-Can?"
	author = "Shimo Canning Co."
	description = "Despite our name, we don't actually can food items or beverages. We make the cans! We need aluminium to cover the increase in can demand here in Blue Colony. I suppose people \
	really enjoy drinking Space Cola and eating that disgusting Carp-in-a-Can. 200 ingots should cover our needs for the time being. We will send payment once we receive the ingots."

	stacks_wanted = list("aluminium" = 2000)

	department_reward = 2500
	individual_reward = 350

/datum/bounty/mining/contemporary_art
	name = "Contemporary Art Piece"
	author = "Le Magnifique"
	description = "I am the great artist, Le Magnifique! Surely you've heard of me. I have created such wondrous works as \"The Kneecap\", \"Much Ado About Adieu\", and \"Burning in Glace Gria\". \
	The time has come for me to create my next great piece! I will erect a giant sculpture of myself out in the wilds of Blue Colony to proclaim my dominion over this planet! I will need bronze, \
	lots of it! Send it to me and know that you will have contributed to the greatest artistic endeavour in the history of sculpture! Is there no greater reward?"

	stacks_wanted = list("bronze" = 1000)

	department_reward = 2500
	individual_reward = 350

/datum/bounty/mining/superconductor
	name = "Superconductor Trials"
	author = "Einstein Engines, LLC."
	description = "We are currently researching ways to miniaturize superconducting magnets for use in consumer products. To get to our eventual goal of complete miniaturization, we need to start \
	big. We need a large amount of tin which will be alloyed here at our facilities into a niobium-tin alloy that will then be used to construct out superconductors. Payment will be remitted once \
	we have received the materials."

	stacks_wanted = list("tin" = 2000)

	department_reward = 3000
	individual_reward = 350

/datum/bounty/mining/mechatronic_dreams
	name = "Mechatronic Dreams"
	author = "Lark Industries"
	description = "Our team is currently working on a new generation of exosuits for use in the industrial sector and we need titanium to construct our prototypes. The next generation of mechas will \
	prove to be unparalleled by any other company on Pollux. Lark Industries will become a household name for its groundbreaking innovations in chassis design!"

	stacks_wanted = list("titanium" = 2000)

	department_reward = 4000
	individual_reward = 600

/datum/bounty/mining/jay_jewellers
	name = "Every Joyful Moment Begins With Jay"
	author = "Jay Jewellers"
	description = "Jay Jewellers is searching for a precious gem that will set us apart from other jewelry businesses in our area. Our experts have identified painite as one such gem that will \
	attract more discerning customers to our business. Please deliver the cut jewels to us for use in a variety of necklaces, rings, and other accessories."

	stacks_wanted = list("painite" = 500)

	department_reward = 3750
	individual_reward = 680


/* Mass Extraction Contracts
 * High paying, high yield bounties go under here
 * Revisit this in the future.
 */

/datum/bounty/mining/public_works
	name = "Open Contract: Public Works"
	author = "Government of Pollux"
	description = "The Government of Pollux formally requests the following materials for use in Public Works projects. Under our Tranparency Policy, the assets will be used for the field \
	level maintenance, field service representative support, contingency maintenance support, new equipment training and total package fielding for the family of Ubentia auto-loader vehicles \
	and construction line. Further information about this contract can be found at publicworks.gov.nt using the tracking code PWOC-1008-2564V."

	stacks_wanted = list("plasteel" = 12500)

	department_reward = 125000
	individual_reward = 4000

/datum/bounty/mining/industrial_supplies
	name = "Open Contract: Industrial & Commercial Supplies"
	author = "Geminus City Office of General Services"
	description = "The GCOGS has created this open contract, available to all Extraction Industries in the Blue Colony. Development has begun on a new artificial island off the coast of the city. \
	Industrial quantities of reclaimed land are required for this feat, the first of its kind in the Commonwealth. Further information about this contract can be found at geminuscity.gov.nt using \
	the tracking code GCOC-0410-2020W."

	stacks_wanted = list("sandstone" = 15000)

	department_reward = 75000
	individual_reward = 3000


/datum/bounty/mining/final_frontier
	name = "Open Contract: Final Frontier"
	author = "Einstein Engines, LLC."
	description = "We are a new research company dedicated to unlocking the secrets of the cosmos. We've received approval to construct a space station around VS 6494 and construction is to begin \
	once our contractor receives the necessary supplies. This open contract will be considered fulfilled once the required materials have been confirmed as delivered."

	stacks_wanted = list("titanium" = 15000)

	department_reward = 100000
	individual_reward = 3000


/datum/bounty/mining/ultraconductor
	name = "Open Contract: Ultraconductor"
	author = "Einstein Engines, LLC."
	description = "We believe that a new era of megastructural engineering is coming soon. Based on centuries old research, we believe we are close to developing a new type of ultraconductor using \
	\"superatoms\" of aluminium. This contract is available to all Extraction Industries on Pollux until such time as our research has been completed."

	stacks_wanted = list("aluminium" = 12500)

	department_reward = 100000
	individual_reward = 4000


/datum/bounty/mining/praise_the_sun
	name = "Open Contract: Praise the Sun"
	author = "Vetra Dynamics"
	description = "We have just won the bid on constructing a super solar array on Castor and require reinforced glass for our photovoltaic cells. A supplementary contract has also been \
	created to supply the Company with the required conductive elements."

	stacks_wanted = list("reinforced glass" = 3000)

	department_reward = 80000
	individual_reward = 3250


