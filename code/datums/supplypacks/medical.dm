/*
*	Here is where any supply packs
*	related to medical tasks live.
*/


/datum/supply_pack/med
	group = "Medical"
	spend_type = SPEND_MEDICAL

/datum/supply_pack/med/medical
	name = "Medical crate"
	contains = list(
			/obj/item/weapon/storage/firstaid/regular,
			/obj/item/weapon/storage/firstaid/fire,
			/obj/item/weapon/storage/firstaid/toxin,
			/obj/item/weapon/storage/firstaid/o2,
			/obj/item/weapon/storage/firstaid/adv,
			/obj/item/weapon/reagent_containers/glass/bottle/antitoxin,
			/obj/item/weapon/reagent_containers/glass/bottle/inaprovaline,
			/obj/item/weapon/reagent_containers/glass/bottle/stoxin,
			/obj/item/weapon/storage/box/syringes,
			/obj/item/weapon/storage/box/autoinjectors
			)
	cost = 200
	containertype = /obj/structure/closet/crate/medical
	containername = "Medical crate"

/datum/supply_pack/med/bloodpack
	name = "BloodPack crate"
	contains = list(/obj/item/weapon/storage/box/bloodpacks = 5)
	cost = 2000 // blood is expensive yo
	containertype = /obj/structure/closet/crate/medical
	containername = "BloodPack crate"

/datum/supply_pack/med/synthplas
	name = "Synthblood crate"
	contains = list(/obj/item/weapon/reagent_containers/blood/synthplas = 6)
	cost = 4500 // synthblood is expensiver yo
	containertype = /obj/structure/closet/crate/medical
	containername = "SynthPlas crate"

/datum/supply_pack/med/bodybag
	name = "Body bag crate"
	contains = list(/obj/item/weapon/storage/box/bodybags = 3)
	cost = 120
	containertype = /obj/structure/closet/crate/medical
	containername = "Body bag crate"

/datum/supply_pack/med/cryobag
	name = "Stasis bag crate"
	contains = list(/obj/item/bodybag/cryobag = 3)
	cost = 150
	containertype = /obj/structure/closet/crate/medical
	containername = "Stasis bag crate"

/datum/supply_pack/med/surgery
	name = "Surgery crate"
	contains = list(
			/obj/item/weapon/surgical/cautery,
			/obj/item/weapon/surgical/surgicaldrill,
			/obj/item/clothing/mask/breath/medical,
			/obj/item/weapon/tank/anesthetic,
			/obj/item/weapon/surgical/FixOVein,
			/obj/item/weapon/surgical/hemostat,
			/obj/item/weapon/surgical/scalpel,
			/obj/item/weapon/surgical/bonegel,
			/obj/item/weapon/surgical/retractor,
			/obj/item/weapon/surgical/bonesetter,
			/obj/item/weapon/surgical/circular_saw
			)
	cost = 250
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Surgery crate"

/datum/supply_pack/med/deathalarm
	name = "Death Alarm crate"
	contains = list(
			/obj/item/weapon/storage/box/cdeathalarm_kit,
			/obj/item/weapon/storage/box/cdeathalarm_kit
			)
	cost = 5000
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Death Alarm crate"

/datum/supply_pack/med/clotting
	name = "Clotting Medicine crate"
	contains = list(
			/obj/item/weapon/storage/firstaid/clotting
			)
	cost = 500
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Clotting Medicine crate"

/datum/supply_pack/med/sterile
	name = "Sterile equipment crate"
	contains = list(
			/obj/item/clothing/under/rank/medical/scrubs/green = 2,
			/obj/item/clothing/head/surgery/green = 2,
			/obj/item/weapon/storage/box/masks,
			/obj/item/weapon/storage/box/gloves,
			/obj/item/weapon/storage/belt/medical = 3
			)
	cost = 400
	containertype = "/obj/structure/closet/crate"
	containername = "Sterile equipment crate"

/datum/supply_pack/med/extragear
	name = "Medical surplus equipment"
	contains = list(
			/obj/item/weapon/storage/belt/medical = 3,
			/obj/item/clothing/glasses/hud/health = 3,
			/obj/item/device/radio/headset/headset_med/alt = 3,
			/obj/item/clothing/suit/storage/hooded/wintercoat/medical = 3
			)
	cost = 600
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Medical surplus equipment"

/datum/supply_pack/med/cmogear
	name = "Chief medical officer equipment"
	contains = list(
			/obj/item/weapon/storage/belt/medical,
			/obj/item/device/radio/headset/heads/cmo,
			/obj/item/clothing/under/rank/chief_medical_officer,
			/obj/item/weapon/reagent_containers/hypospray/vial,
			/obj/item/clothing/accessory/stethoscope,
			/obj/item/clothing/glasses/hud/health,
			/obj/item/clothing/suit/storage/toggle/labcoat/cmo,
			/obj/item/clothing/suit/storage/toggle/labcoat/cmoalt,
			/obj/item/clothing/mask/surgical,
			/obj/item/clothing/shoes/white,
			/obj/item/clothing/gloves/sterile/latex,
			/obj/item/device/healthanalyzer,
			/obj/item/device/flashlight/pen,
			/obj/item/weapon/reagent_containers/syringe
			)
	cost = 2500
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Chief medical officer equipment"

/datum/supply_pack/med/doctorgear
	name = "Medical Doctor equipment"
	contains = list(
			/obj/item/weapon/storage/belt/medical,
			/obj/item/device/radio/headset/headset_med,
			/obj/item/clothing/under/rank/medical,
			/obj/item/clothing/accessory/stethoscope,
			/obj/item/clothing/glasses/hud/health,
			/obj/item/clothing/suit/storage/toggle/labcoat,
			/obj/item/clothing/mask/surgical,
			/obj/item/weapon/storage/firstaid/adv,
			/obj/item/clothing/shoes/white,
			/obj/item/weapon/cartridge/medical,
			/obj/item/clothing/gloves/sterile/latex,
			/obj/item/device/healthanalyzer,
			/obj/item/device/flashlight/pen,
			/obj/item/weapon/reagent_containers/syringe
			)
	cost = 1200
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Medical Doctor equipment"

/datum/supply_pack/med/chemistgear
	name = "Chemist equipment"
	contains = list(
			/obj/item/weapon/storage/box/beakers,
			/obj/item/device/radio/headset/headset_med,
			/obj/item/weapon/storage/box/autoinjectors,
			/obj/item/clothing/under/rank/chemist,
			/obj/item/clothing/glasses/science,
			/obj/item/clothing/suit/storage/toggle/labcoat/chemist,
			/obj/item/clothing/mask/surgical,
			/obj/item/clothing/shoes/white,
			/obj/item/weapon/cartridge/chemistry,
			/obj/item/clothing/gloves/sterile/latex,
			/obj/item/weapon/reagent_containers/dropper,
			/obj/item/device/healthanalyzer,
			/obj/item/weapon/storage/box/pillbottles,
			/obj/item/weapon/reagent_containers/syringe
			)
	cost = 1200
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Chemist equipment"

/datum/supply_pack/med/paramedicgear
	name = "Paramedic equipment"
	contains = list(
			/obj/item/weapon/storage/belt/medical/emt,
			/obj/item/device/radio/headset/headset_med,
			/obj/item/clothing/under/rank/medical/scrubs/black,
			/obj/item/clothing/accessory/armband/medblue,
			/obj/item/clothing/glasses/hud/health,
			/obj/item/clothing/suit/storage/toggle/labcoat/emt,
			/obj/item/clothing/under/rank/medical/paramedic,
			/obj/item/clothing/suit/storage/toggle/fr_jacket,
			/obj/item/clothing/mask/gas,
			/obj/item/clothing/under/rank/medical/paramedic,
			/obj/item/clothing/accessory/stethoscope,
			/obj/item/weapon/storage/firstaid/adv,
			/obj/item/clothing/shoes/boots/jackboots,
			/obj/item/clothing/gloves/sterile/latex,
			/obj/item/device/healthanalyzer,
			/obj/item/weapon/cartridge/medical,
			/obj/item/device/flashlight/pen,
			/obj/item/weapon/reagent_containers/syringe,
			/obj/item/clothing/accessory/storage/white_vest
			)
	cost = 1200
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Paramedic equipment"

/datum/supply_pack/med/psychiatristgear
	name = "Psychiatrist equipment"
	contains = list(
			/obj/item/clothing/under/rank/psych,
			/obj/item/device/radio/headset/headset_med,
			/obj/item/clothing/under/rank/psych/turtleneck,
			/obj/item/clothing/shoes/laceup,
			/obj/item/clothing/suit/storage/toggle/labcoat,
			/obj/item/clothing/shoes/white,
			/obj/item/weapon/clipboard,
			/obj/item/weapon/folder/white,
			/obj/item/weapon/pen,
			/obj/item/weapon/cartridge/medical
			)
	cost = 800
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Psychiatrist equipment"

/datum/supply_pack/med/medicalscrubs
	name = "Medical scrubs"
	contains = list(
			/obj/item/clothing/shoes/white = 3,,
			/obj/item/clothing/under/rank/medical/scrubs = 3,
			/obj/item/clothing/under/rank/medical/scrubs/green = 3,
			/obj/item/clothing/under/rank/medical/scrubs/purple = 3,
			/obj/item/clothing/under/rank/medical/scrubs/black = 3,
			/obj/item/clothing/head/surgery = 3,
			/obj/item/clothing/head/surgery/purple = 3,
			/obj/item/clothing/head/surgery/blue = 3,
			/obj/item/clothing/head/surgery/green = 3,
			/obj/item/clothing/head/surgery/black = 3,
			/obj/item/weapon/storage/box/masks,
			/obj/item/weapon/storage/box/gloves
			)
	cost = 900
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Medical scrubs crate"

/datum/supply_pack/med/autopsy
	name = "Autopsy equipment"
	contains = list(
			/obj/item/weapon/folder/white,
			/obj/item/device/camera,
			/obj/item/device/camera_film = 2,
			/obj/item/weapon/autopsy_scanner,
			/obj/item/weapon/surgical/scalpel,
			/obj/item/weapon/storage/box/masks,
			/obj/item/weapon/storage/box/gloves,
			/obj/item/weapon/pen
			)
	cost = 230
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Autopsy equipment crate"

/datum/supply_pack/med/medicaluniforms
	name = "Medical uniforms"
	contains = list(
			/obj/item/clothing/shoes/white = 3,
			/obj/item/clothing/under/rank/chief_medical_officer,
			/obj/item/clothing/under/rank/geneticist,
			/obj/item/clothing/under/rank/virologist,
			/obj/item/clothing/under/rank/nursesuit,
			/obj/item/clothing/under/rank/nurse,
			/obj/item/clothing/under/rank/orderly,
			/obj/item/clothing/under/rank/medical = 3,
			/obj/item/clothing/under/rank/medical/paramedic = 3,
			/obj/item/clothing/suit/storage/toggle/labcoat = 3,
			/obj/item/clothing/suit/storage/toggle/labcoat/cmo,
			/obj/item/clothing/suit/storage/toggle/labcoat/emt,
			/obj/item/clothing/suit/storage/toggle/labcoat/cmoalt,
			/obj/item/clothing/suit/storage/toggle/labcoat/genetics,
			/obj/item/clothing/suit/storage/toggle/labcoat/virologist,
			/obj/item/clothing/suit/storage/toggle/labcoat/chemist,
			/obj/item/weapon/storage/box/masks,
			/obj/item/weapon/storage/box/gloves
			)
	cost = 800
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Medical uniform crate"

/datum/supply_pack/med/medicalbiosuits
	name = "Medical biohazard gear"
	contains = list(
			/obj/item/clothing/head/bio_hood = 3,
			/obj/item/clothing/suit/bio_suit = 3,
			/obj/item/clothing/head/bio_hood/virology = 2,
			/obj/item/clothing/suit/bio_suit/cmo,
			/obj/item/clothing/head/bio_hood/cmo,
			/obj/item/clothing/mask/gas = 5,
			/obj/item/weapon/tank/oxygen = 5,
			/obj/item/weapon/storage/box/masks,
			/obj/item/weapon/storage/box/gloves
			)
	cost = 1500
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Medical biohazard equipment"

/datum/supply_pack/med/portablefreezers
	name = "Portable freezers crate"
	contains = list(/obj/item/weapon/storage/box/freezer = 7)
	cost = 315
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Portable freezers"

/datum/supply_pack/med/virus
	name = "Virus sample crate"
	contains = list(/obj/item/weapon/virusdish/random = 4)
	cost = 2000
	containertype = "/obj/structure/closet/crate/secure"
	containername = "Virus sample crate"

/datum/supply_pack/med/defib
	name = "Defibrillator crate"
	contains = list(/obj/item/device/defib_kit = 2)
	cost = 500
	containertype = /obj/structure/closet/crate/medical
	containername = "Defibrillator crate"

/datum/supply_pack/med/biomass
	name = "Biomass Crate"	// limbs should be more scarce
	contains = list(/obj/item/weapon/reagent_containers/glass/bottle/biomass = 10)
	cost = 10000 //bruh
	containertype = /obj/structure/closet/crate/medical
	containername = "Biomass Crate"