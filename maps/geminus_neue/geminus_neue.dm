#if !defined(USING_MAP_DATUM)

	#include "geminus_neue-1.dmm"
	#include "geminus_neue-2.dmm"
	#include "geminus_neue-3.dmm"
	#include "geminus_neue-4.dmm"
	#include "geminus_neue_defines.dm"
	#include "geminus_neue_shuttles.dm"
	#include "geminus_neue_areas.dm"
	#include "geminus_neue_lot_areas.dm"
	#include "geminus_neue_lots.dm"
	#include "geminus_neue_elevator.dm"

	#define USING_MAP_DATUM /datum/map/geminus_neue

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Geminus Neue

#endif