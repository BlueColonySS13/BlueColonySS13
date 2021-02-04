/datum/bounty/black_market
	category = CAT_BLACKMARKET



/datum/bounty/black_market/vampire
	name = "The Most Dangerous Game"
	author = "Vladislav Vanburg"
	description = "Our organization is in search of the blood of the most dangerous game... Unfortunately, we can only procure \
	so much through proper channels. Please, send us 750u of blood. We will compensate you most generously. We only ask that you \
	ask no questions."

	reagents_wanted = list("blood" = 500)

	department_reward = 900	// blood isn't that hard to get - vatborn cubes and hospital break ins can usually prove this
	individual_reward = 250

	days_until_expiry = 3

/datum/bounty/black_market/detective_work
	name = "A Little Detective Work"
	author = "William Bjork"
	description = "We're cleaning up a little 'scene' over here, but we're not sure if we got everything. We just need one of those \
	universal detective scanners to check if the fingerprints and fibers are around. If you send us one we'll pass you our leftover sterilizine \
	and one of our UV lights."

	items_wanted = list(/obj/item/device/detective_scanner = 1)

	item_rewards = list(/obj/item/weapon/reagent_containers/spray/sterilizine = 1,
	/obj/item/device/uv_light = 1)

	department_reward = 200
	individual_reward = 90

	days_until_expiry = 3

/datum/bounty/black_market/organs_organist
	name = "Organs For An Organist"
	author = "Heinrich Gravae"
	description = "In the middle of an over-enthusiastic church session it would appear that our organist has suffered a... lively accident. It's not over yet, \
	we're willing to pay to help replace what he lost during that very emotionally church scene."

	random_items_wanted = list(
		/obj/item/organ/internal/heart,
		/obj/item/organ/internal/lungs,
		/obj/item/organ/internal/kidneys,
		/obj/item/organ/internal/eyes,
		/obj/item/organ/internal/liver,
		/obj/item/organ/internal/spleen,
		/obj/item/organ/external/arm,
		/obj/item/organ/external/arm/right,
		/obj/item/organ/external/leg,
		/obj/item/organ/external/leg/right,
		/obj/item/organ/external/foot,
		/obj/item/organ/external/foot/right,
		/obj/item/organ/external/hand,
		/obj/item/organ/external/hand/right
		)

	department_reward = 800
	individual_reward = 350

	days_until_expiry = 3