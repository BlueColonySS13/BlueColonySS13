// This causes PoI maps to get 'checked' and compiled, when undergoing a unit test.
// This is so Travis can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new PoI, please add it to this list.
#if MAP_TEST
#include "abandoned_lab.dmm"
#include "dna_vault.dmm"
#include "nt_ceo_office.dmm"
#endif

/datum/map_template/surface/corporate
	name = "Surface Content - Corporate"
	desc = "Submaps for NT shenanigans outside of Geminus and maybe even Pollux!"

// To be added: Templates for surface exploration when they are made.

/datum/map_template/surface/corporate/abandoned_lab
	name = "Illegal Human Testing Lab"
	desc = "An black site filled with human test subjects. Seems abandoned."
	mappath = 'maps/submaps/surface_submaps/corporate/abandoned_lab.dmm'
	cost = 10

/datum/map_template/surface/corporate/dna_vault
	name = "DNA Vault"
	desc = "A vault filled with genetic samples harvested from millions of humans."
	mappath = 'maps/submaps/surface_submaps/corporate/dna_vault.dmm'
	cost = 10

/datum/map_template/surface/corporate/ceo_office
	name = "NanoTrasen CEO's Office"
	desc = "The office of the most powerful person in the galaxy."
	mappath = 'maps/submaps/surface_submaps/corporate/nt_ceo_office.dmm'
	cost = 10