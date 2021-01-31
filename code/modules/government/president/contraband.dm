/datum/persistent_option/select_list/contraband
	value_options = list(
	ILLEGAL,
	PROFESSIONAL_ONLY,
	PERMIT_SELLING,
	PERMIT_POSSESSION,
	PROFESSIONAL_SALE,
	LEGAL
	)

	value_select = LEGAL
	portal_category = "Contraband and Restricted Materials"
	portal_grouping = "Law and Order"

/datum/persistent_option/select_list/contraband/cannabis
	name = "Cannabis Contraband Status"
	description = "This relates to cannabis and cannabis derived products that contain THC. Does not include hemp."
	id = CONTRABAND_CANNABIS

/datum/persistent_option/select_list/contraband/alcohol
	name = "Alcohol Contraband Status"
	description = "This relates to alcoholic beverages that are consumeable."
	id = CONTRABAND_ALCOHOL

/datum/persistent_option/select_list/contraband/ecstasy
	name = "Ecstasy Contraband Status"
	description = "This relates to ecstasy that is in any form."
	id = CONTRABAND_ECSTASY

/datum/persistent_option/select_list/contraband/nicotine
	name = "Nicotine Contraband Status"
	description = "This relates to nicotine that is in any form."
	id = CONTRABAND_NICOTINE

/datum/persistent_option/select_list/contraband/psilocybin
	name = "Psilocybin Contraband Status"
	description = "This relates to psilocybin that is in any form."
	id = CONTRABAND_PSILOCYBIN

/datum/persistent_option/select_list/contraband/crack
	name = "Crack Contraband Status"
	description = "This relates to crack that is in any form."
	id = CONTRABAND_CRACK

/datum/persistent_option/select_list/contraband/cocaine
	name = "Cocaine Contraband Status"
	description = "This relates to cocaine that is in any form."
	id = CONTRABAND_COCAINE

/datum/persistent_option/select_list/contraband/heroin
	name = "Heroin Contraband Status"
	description = "This relates to heroin that is in any form."
	id = CONTRABAND_HEROIN

/datum/persistent_option/select_list/contraband/meth
	name = "Meth Contraband Status"
	description = "This relates to meth that is in any form."
	id = CONTRABAND_METH

/datum/persistent_option/select_list/contraband/stimm
	name = "Stimm Contraband Status"
	description = "This relates to stimm that is in any form."
	id = CONTRABAND_STIMM

/datum/persistent_option/select_list/contraband/ayahuasca
	name = "Ayahuasca Contraband Status"
	description = "This relates to ayahuasca that is in any form."
	id = CONTRABAND_AYAHUASCA

/datum/persistent_option/select_list/select_list/contraband/lsd
	name = "LSD Contraband Status"
	description = "This relates to LSD that is in any form."
	id = CONTRABAND_LSD

/datum/persistent_option/select_list/contraband/dmt
	name = "DMT Contraband Status"
	description = "This relates to DMT that is in any form."
	id = CONTRABAND_DMT

/datum/persistent_option/select_list/contraband/bath_salts
	name = "Bath Salts Contraband Status"
	description = "This relates to bath salts that is in any form."
	id = CONTRABAND_BATHSALTS

/datum/persistent_option/select_list/contraband/krokodil
	name = "Krokodil Contraband Status"
	description = "This relates to krokodil that is in any form."
	id = CONTRABAND_KROKODIL

/datum/persistent_option/select_list/contraband/caapi
	name = "Caapi Contraband Status"
	description = "This relates to caapi that is in any form."
	id = CONTRABAND_CAAPI

/datum/persistent_option/select_list/contraband/chacruna
	name = "Chacruna Contraband Status"
	description = "This relates to chacruna that is in any form."
	id = CONTRABAND_CHACRUNA

// Science Chems
/datum/persistent_option/select_list/contraband/cyanide
	name = "Cyanide Contraband Status"
	description = "This relates to cyanide that is in any form."
	id = CONTRABAND_CYANIDE

/datum/persistent_option/select_list/contraband/chloral_hydrate
	name = "Chloral Hydrate Contraband Status"
	description = "This relates to chloral hydrate that is in any form."
	id = CONTRABAND_CHLORAL

/datum/persistent_option/select_list/contraband/harmful_chems
	name = "Harmful Chemical Contraband Status"
	description = "This relates to harmful chemicals that are not used for medical purpose."
	id = CONTRABAND_HARMFUL_CHEMS

// Weapons

/datum/persistent_option/select_list/contraband/guns
	name = "Gun Contraband Status"
	description = "This relates to any type of gun."
	id = CONTRABAND_GUN

/datum/persistent_option/select_list/contraband/knives_small
	name = "Small Knives Contraband Status"
	description = "This relates to any knife that is small enough to fit into a pocket or be concealed into one. Excludes knives made for kitchens."
	id = CONTRABAND_KNIFESMALL

/datum/persistent_option/select_list/contraband/knives_large
	name = "Large Knives Contraband Status"
	description = "This relates to any knife that is too big to fit in a pocket or cannot be concealed. Excludes knives made for kitchens."
	id = CONTRABAND_KNIFELARGE

/datum/persistent_option/select_list/contraband/explosives
	name = "Explosives Contraband Status"
	description = "This relates to any type of device or utility that is used to make explosions of any size."
	id = CONTRABAND_EXPLOSIVES


// Research
/datum/persistent_option/select_list/contraband/bioweaponry
	name = "Bioweaponry Contraband Status"
	description = "This relates to the containment of viruses and biologically based material that can be used to infect human beings."
	id = CONTRABAND_BIOWEAPONRY

/datum/persistent_option/select_list/contraband/benign_artifacts
	name = "Benign Artifact Contraband Status"
	description = "This relates to the containment of artifacts that cannot be used as a weapon, and do not have the potential to cause harm to people. Note: This only applies for outside of official Nanotrasen Research facilities."
	id = CONTRABAND_ARTIFACTSBENIGN

/datum/persistent_option/select_list/contraband/harmful_artifacts
	name = "Harmful Artifact Contraband Status"
	description = "This relates to the containment of artifacts that can be used as a weapon, cause harm to people, alter the atmosphere or have devastating effects on the environment. Note: This only applies for outside of official Nanotrasen Research facilities."
	id = CONTRABAND_ARTIFACTSHARMFUL