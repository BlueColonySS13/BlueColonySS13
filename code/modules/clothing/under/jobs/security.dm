/*
 * Contains:
 *		Security
 *		Detective
 *		Head of Security
 */

/*
 * Security
 */
/obj/item/clothing/under/rank/warden
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for more robust protection. It has the word \"Warden\" written on the shoulders."
	name = "warden's jumpsuit"
	icon_state = "warden"
	item_state_slots = list(slot_r_hand_str = "darkblue", slot_l_hand_str = "darkblue")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/security
	name = "police officer's tactical uniform"
	desc = "It's made of a slightly sturdier material than standard suits, to allow for robust protection."
	icon_state = "police"
	item_state_slots = list(slot_r_hand_str = "darkblue", slot_l_hand_str = "darkblue")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/security/turtleneck
	name = "police officer's turtleneck"
	desc = "It's a stylish turtleneck made of a robust nanoweave. Nobody said the Law couldn't be fashionable."
	icon_state = "turtle_sec"
	rolled_down = -1
	rolled_sleeves = -1
	index = 1


/obj/item/clothing/under/rank/dispatch
	name = "dispatcher's uniform"
	desc = "A dress shirt and khakis with a security patch sewn on."
	icon_state = "dispatch"
	item_state_slots = list(slot_r_hand_str = "detective", slot_l_hand_str = "detective")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
	siemens_coefficient = 0.9

/obj/item/clothing/under/rank/security2
	name = "police officer's uniform"
	desc = "It's made of a slightly sturdier material, to allow for robust protection."
	icon_state = "redshirt2"
	item_state_slots = list(slot_r_hand_str = "darkblue", slot_l_hand_str = "darkblue")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/security/traffic
	name = "traffic warden's uniform"
	desc = "Stitched together by those bankrupted by parking tickets."
	icon_state = "traffic"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	rolled_sleeves = 0

/obj/item/clothing/under/rank/security/corp
	icon_state = "sec_corporate"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	rolled_sleeves = 0

/obj/item/clothing/under/rank/warden/corp
	icon_state = "warden_corporate"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	rolled_sleeves = 0

/obj/item/clothing/under/tactical
	name = "tactical jumpsuit"
	desc = "It's made of a slightly sturdier material than standard jumpsuits, to allow for robust protection."
	icon_state = "swatunder"
	item_state_slots = list(slot_r_hand_str = "green", slot_l_hand_str = "green")
	armor = list(melee = 10, bullet = 5, laser = 5,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = -1

/*
 * Detective
 */
/obj/item/clothing/under/det
	name = "detective's suit"
	desc = "A rumpled white dress shirt paired with well-worn grey slacks."
	icon_state = "detective"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0
	starting_accessories = list(/obj/item/clothing/accessory/tie/blue_clip)

/*
/obj/item/clothing/under/det/verb/rollup()
	set name = "Roll Suit Sleeves"
	set category = "Object"
	set src in usr
	var/unrolled = item_state_slots[slot_w_uniform_str] == initial(worn_state)
	item_state_slots[slot_w_uniform_str] = unrolled ? "[worn_state]_r" : initial(worn_state)
	var/mob/living/carbon/human/H = loc
	H.update_inv_w_uniform(1)
	H << "<span class='notice'>You roll the sleeves of your shirt [unrolled ? "up" : "down"]</span>"
*/
/obj/item/clothing/under/det/grey
	icon_state = "detective2"
	desc = "A serious-looking tan dress shirt paired with freshly-pressed black slacks."
	starting_accessories = list(/obj/item/clothing/accessory/tie/red_long)

/obj/item/clothing/under/det/black
	icon_state = "detective3"
	item_state_slots = list(slot_r_hand_str = "sl_suit", slot_l_hand_str = "sl_suit")
	desc = "An immaculate white dress shirt, paired with a pair of dark grey dress pants, a red tie, and a charcoal vest."
	starting_accessories = list(/obj/item/clothing/accessory/tie/red_long, /obj/item/clothing/accessory/vest)

/obj/item/clothing/under/det/corporate
	name = "detective's jumpsuit"
	icon_state = "det_corporate"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	desc = "A more modern uniform for corporate investigators."

/obj/item/clothing/under/det/waistcoat
	icon_state = "detective"
	desc = "A rumpled white dress shirt paired with well-worn grey slacks, complete with a blue striped tie, faux-gold tie clip, and waistcoat."
	starting_accessories = list(/obj/item/clothing/accessory/tie/blue_clip, /obj/item/clothing/accessory/wcoat)

/obj/item/clothing/under/det/grey/waistcoat
	icon_state = "detective2"
	desc = "A serious-looking tan dress shirt paired with freshly-pressed black slacks, complete with a red striped tie and waistcoat."
	starting_accessories = list(/obj/item/clothing/accessory/tie/red_long, /obj/item/clothing/accessory/wcoat)

/obj/item/clothing/under/det/skirt
	name = "detective's skirt"
	icon_state = "detective_skirt"
	desc = "A serious-looking white blouse paired with a formal black pencil skirt."
	item_state_slots = list(slot_r_hand_str = "sl_suit", slot_l_hand_str = "sl_suit")

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/head_of_security
	desc = "It's a jumpsuit worn by those few with the dedication to achieve the position of \"Chief of Police\". It has additional armor to protect the wearer."
	name = "chief of police's uniform"
	icon_state = "chiefofpolice"
	item_state_slots = list(slot_r_hand_str = "darkblue", slot_l_hand_str = "darkblue")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/head_of_security/corp
	icon_state = "hos_corporate"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	rolled_sleeves = 0

//Jensen cosplay gear
/obj/item/clothing/under/rank/head_of_security/jensen
	desc = "You never asked for anything that stylish."
	name = "head of security's jumpsuit"
	icon_state = "jensen"
	rolled_sleeves = -1

/*
 * Navy uniforms
 */
/obj/item/clothing/under/rank/security/navyblue
	name = "police officer's uniform"
	desc = "The latest in fashionable security outfits."
	icon_state = "officerblueclothes"
	item_state_slots = list(slot_r_hand_str = "ba_suit", slot_l_hand_str = "ba_suit")
	rolled_sleeves = 0

/obj/item/clothing/under/rank/head_of_security/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Head of Security."
	name = "chief of police's uniform"
	icon_state = "hosblueclothes"
	item_state_slots = list(slot_r_hand_str = "ba_suit", slot_l_hand_str = "ba_suit")
	rolled_sleeves = 0

/obj/item/clothing/under/rank/warden/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Warden."
	name = "warden's uniform"
	icon_state = "wardenblueclothes"
	item_state_slots = list(slot_r_hand_str = "ba_suit", slot_l_hand_str = "ba_suit")
	rolled_sleeves = 0

//Blue Police Uniforms

/obj/item/clothing/under/rank/wardenalt
	desc = "a Police Sergeant's uniform, its gold ranks indicate seniroity."
	name = "police sergeant's uniform"
	icon_state = "policewardenalt"
	item_state_slots = list(slot_r_hand_str = "darkblue", slot_l_hand_str = "darkblue")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/policeofficeralt
	desc = "a police officers uniform, donut not included"
	name = "police officer's uniform"
	icon_state = "policealt"
	item_state_slots = list(slot_r_hand_str = "darkblue", slot_l_hand_str = "darkblue")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/policecadetalt
	desc = "a police cadets uniform, donut not included"
	name = "police cadets's uniform"
	icon_state = "policecadetalt"
	item_state_slots = list(slot_r_hand_str = "darkblue", slot_l_hand_str = "darkblue")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/policedetectivealt
	desc = "a police investigator's uniform, zippo not included"
	name = "police investigator's uniform"
	icon_state = "policedetectivealt"
	item_state_slots = list(slot_r_hand_str = "darkblue", slot_l_hand_str = "darkblue")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/policetrafficalt
	desc = "a traffic officer's uniform, orange cone not included"
	name = "traffic officer's uniform"
	icon_state = "policetrafficalt"
	item_state_slots = list(slot_r_hand_str = "darkblue", slot_l_hand_str = "darkblue")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/policechiefalt
	desc = "a police chief's uniform, alcoholism not included"
	name = "police chief's uniform"
	icon_state = "policechiefalt"
	item_state_slots = list(slot_r_hand_str = "darkblue", slot_l_hand_str = "darkblue")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

// Game Warden Uniforms

/obj/item/clothing/under/rank/gamewardenlt
	desc = "a Game Warden Lieutenant's uniform, its gold ranks indicate seniroity."
	name = "game warden lieutenant's uniform"
	icon_state = "gwardenltalt"
	item_state_slots = list(slot_r_hand_str = "pale", slot_l_hand_str = "pale")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/gamewarden
	desc = "a Game Warden's uniform, its gold ranks indicate mild seniroity."
	name = "game warden's uniform"
	icon_state = "gwardenalt"
	item_state_slots = list(slot_r_hand_str = "pale", slot_l_hand_str = "pale")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/gamewardencadet
	desc = "a Game Cadet's uniform, its lack of ranks indicates a rookie."
	name = "game warden cadet's uniform"
	icon_state = "gwardencadetalt"
	item_state_slots = list(slot_r_hand_str = "pale", slot_l_hand_str = "pale")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/gamewardenltalt
	desc = "a Game Warden Lieutenant's black uniform, its gold ranks indicate seniroity."
	name = "game warden lieutenant's black uniform"
	icon_state = "gwardenltbalt"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/gamewardenalt
	desc = "a Game Warden's black uniform, its gold ranks indicate seniroity."
	name = "game warden's black uniform"
	icon_state = "gwardenbalt"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0

/obj/item/clothing/under/rank/gamewardencadetalt
	desc = "a Game Warden Cadet's black uniform, its gold ranks indicate seniroity."
	name = "game warden cadet's black uniform"
	icon_state = "gwardencadetbalt"
	item_state_slots = list(slot_r_hand_str = "black", slot_l_hand_str = "black")
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	rolled_sleeves = 0