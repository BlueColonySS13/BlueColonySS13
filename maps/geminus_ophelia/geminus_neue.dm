#if !defined(USING_MAP_DATUM)

	#include "ophelia_neue-1.dmm"
	#include "ophelia_neue-2.dmm"
	#include "ophelia_neue-3.dmm"
	#include "ophelia_neue-4.dmm"
	#include "ophelia_neue_defines.dm"
	#include "ophelia_neue_shuttles.dm"
	#include "ophelia_neue_areas.dm"
	#include "ophelia_neue_lot_areas.dm"
	#include "ophelia_neue_lots.dm" // forces the lot datums to work - yeah, dirty fix
	#include "ophelia_neue_elevator.dm"

	#define USING_MAP_DATUM /datum/map/ophelia_neue

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Ophelia Neue

#endif