/datum/persistent_option/portal/contraband
	value_options = list(
	ILLEGAL,
	PROFESSIONAL_ONLY,
	PERMIT_SELLING,
	PERMIT_POSSESSION,
	PROFESSIONAL_SALE,
	LEGAL
	)

	var/list/associated_items = list()
	var/list/associated_reagents = list()

	value_text = LEGAL


/datum/persistent_option/portal/contraband/cannabis
	name = "Cannabis Contraband Status"
	description = "This relates to cannabis and cannabis derived products that contain THC. Does not include hemp."
	id = "contraband_cannabis"

/datum/persistent_option/portal/contraband/alcohol
	name = "Alcohol Contraband Status"
	description = "This relates to alcoholic beverages that are consumeable."
	id = "contraband_alcohol"

/datum/persistent_option/portal/contraband/nicotine
	name = "Nicotine Contraband Status"
	description = "This relates to nicotine that is in any form."
	id = "contraband_nicotine"

/datum/persistent_option/portal/contraband/ecstasy
	name = "Ecstasy Contraband Status"
	description = "This relates to ecstasy that is in any form."
	id = "contraband_ecstasyl"

/datum/persistent_option/portal/contraband/ecstasy
	name = "Ecstasy Contraband Status"
	description = "This relates to ecstasy that is in any form."
	id = "contraband_ecstasy"

/datum/persistent_option/portal/contraband/psilocybin
	name = "Psilocybin Contraband Status"
	description = "This relates to psilocybin that is in any form."
	id = "contraband_psilocybin"

/datum/persistent_option/portal/contraband/crack
	name = "Crack Contraband Status"
	description = "This relates to crack that is in any form."
	id = "contraband_crack"

/datum/persistent_option/portal/contraband/cocaine
	name = "Cocaine Contraband Status"
	description = "This relates to cocaine that is in any form."
	id = "contraband_cocaine"

/datum/persistent_option/portal/contraband/heroin
	name = "Heroin Contraband Status"
	description = "This relates to heroin that is in any form."
	id = "contraband_heroin"

/datum/persistent_option/portal/contraband/meth
	name = "Meth Contraband Status"
	description = "This relates to meth that is in any form."
	id = "contraband_meth"

/datum/persistent_option/portal/contraband/stimm
	name = "Stimm Contraband Status"
	description = "This relates to stimm that is in any form."
	id = "contraband_stimm"

/datum/persistent_option/portal/contraband/ayahuasca
	name = "Ayahuasca Contraband Status"
	description = "This relates to ayahuasca that is in any form."
	id = "contraband_ayahuasca"

/datum/persistent_option/portal/contraband/lsd
	name = "LSD Contraband Status"
	description = "This relates to LSD that is in any form."
	id = "contraband_lsd"

/datum/persistent_option/portal/contraband/dmt
	name = "DMT Contraband Status"
	description = "This relates to DMT that is in any form."
	id = "contraband_dmt"

/datum/persistent_option/portal/contraband/bath_salts
	name = "Bath Salts Contraband Status"
	description = "This relates to bath salts that is in any form."
	id = "contraband_bath_salts"

/datum/persistent_option/portal/contraband/krokodil
	name = "Krokodil Contraband Status"
	description = "This relates to krokodil that is in any form."
	id = "contraband_krokodil"

// Science Chems
/datum/persistent_option/portal/contraband/cyanide
	name = "Cyanide Contraband Status"
	description = "This relates to cyanide that is in any form."
	id = "contraband_cyanide"

/datum/persistent_option/portal/contraband/chloral_hydrate
	name = "Chloral Hydrate Contraband Status"
	description = "This relates to chloral hydrate that is in any form."
	id = "contraband_chloral_hydrate"

// Weapons

/datum/persistent_option/portal/contraband/guns
	name = "Gun Contraband Status"
	description = "This relates to any type of gun."
	id = "contraband_gun"

/datum/persistent_option/portal/contraband/knives_small
	name = "Small Knives Contraband Status"
	description = "This relates to any knife that is small enough to fit into a pocket or be concealed into one. Excludes knives made for kitchens."
	id = "contraband_knife_small"

/datum/persistent_option/portal/contraband/knives_large
	name = "Large Knives Contraband Status"
	description = "This relates to any knife that is too big to fit in a pocket or cannot be concealed. Excludes knives made for kitchens."
	id = "contraband_knife_large"

/datum/persistent_option/portal/contraband/explosives
	name = "Explosives Contraband Status"
	description = "This relates to any type of device or utility that is used to make explosions of any size."
	id = "contraband_explosives"

/datum/persistent_option/portal/contraband/bioweaponry
	name = "Bioweaponry Contraband Status"
	description = "This relates to the containment of viruses and biologically based material that can be used to infect human beings."
	id = "contraband_bioweaponry"