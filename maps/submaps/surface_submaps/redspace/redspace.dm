// This causes PoI maps to get 'checked' and compiled, when undergoing a unit test.
// This is so Travis can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new PoI, please add it to this list.
#if MAP_TEST
#include "attunement_field_generator.dmm"
#include "attunement_field_generator_broken.dmm"
#endif

/datum/map_template/surface/redspace
	name = "Surface Content - Redspace"
	desc = "Submaps for Redspace!"

// To be added: Templates for surface exploration when they are made.

/datum/map_template/surface/redspace/af_generator
	name = "Attunement Field Generator"
	desc = "A mysterious machine."
	mappath = 'maps/submaps/surface_submaps/redspace/attunement_field_generator.dmm'
	cost = 10

/datum/map_template/surface/redspace/af_generator_broken
	name = "Attunement Field Generator - Damaged"
	desc = "A mysterious machine. It looks damaged."
	mappath = 'maps/submaps/surface_submaps/redspace/attunement_field_generator_broken.dmm'
	cost = 10