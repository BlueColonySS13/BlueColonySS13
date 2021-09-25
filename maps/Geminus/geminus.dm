#if !defined(USING_MAP_DATUM)

	#include "ophelia-1.dmm"
	#include "ophelia-2.dmm"
	#include "ophelia-3.dmm"
	#include "ophelia-redspace-1.dmm"
	#include "ophelia-VR.dmm"
	#include "ophelia-VR-psych.dmm"
	#include "ophelia_shuttles.dm"
	#include "ophelia_defines.dm"
	#include "ophelia_elevator.dm"
	#include "ophelia_areas.dm"
	#include "ophelia_lots.dm"
	#include "ophelia_lot_areas.dm"
	#include "ophelia_VR_games.dm"

	#define USING_MAP_DATUM /datum/map/ophelia

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Ophelia

#endif