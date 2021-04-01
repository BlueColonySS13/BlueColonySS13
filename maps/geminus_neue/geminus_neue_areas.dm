// Elevator areas.
/area/turbolift/geminus_subway_top
	name = "lift (geminus city)"
	lift_floor_label = "Floor 2"
	lift_floor_name = "Geminus City Metro"
	lift_announce_str = "Lift arriving at Geminus City Metro Station, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_subway_ground
	name = "lift (sewers)"
	lift_floor_label = "Floor 1"
	lift_floor_name = "Geminus Underground Sewers"
	lift_announce_str = "Lift arriving at Geminus underground sewers, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_top_mining
	name = "lift (geminus city)"
	lift_floor_label = "Floor 2"
	lift_floor_name = "Geminus City - East End"
	lift_announce_str = "Lift arriving at Geminus City East End, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_ground_mining
	name = "lift (mines)"
	lift_floor_label = "Floor 1"
	lift_floor_name = "Geminus City - Mines"
	lift_announce_str = "Lift arriving at Geminus Mines, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_top_science
	name = "lift (city science)"
	lift_floor_label = "Floor 2"
	lift_floor_name = "Geminus City - Upper Science Lab"
	lift_announce_str = "Lift arriving at Geminus City - Science Upper, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_ground_science
	name = "lift (science underground)"
	lift_floor_label = "Floor 1"
	lift_floor_name = "Geminus City - Underground Science Lab"
	lift_announce_str = "Lift arriving at Geminus City - Science Lab Underground, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_overground_hospital
	name = "lift (city hospital)"
	lift_floor_label = "Ground Floor"
	lift_floor_name = "Geminus City Hospital - Hospital"
	lift_announce_str = "Lift arriving at Geminus City - Hospital, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_ground_hospital
	name = "lift (hospital overground - asylum)"
	lift_floor_label = "Floor 1"
	lift_floor_name = "Geminus City Hospital - Asylum"
	lift_announce_str = "Lift arriving at Geminus City - Asylum, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_court_top
	name = "lift (court offices)"
	lift_floor_label = "Floor 2"
	lift_floor_name = "Geminus City Court Offices"
	lift_announce_str = "Lift arriving at Geminus City Court Offices, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_court_ground
	name = "lift (courtroom)"
	lift_floor_label = "Floor 1"
	lift_floor_name = "Geminus City Courtroom"
	lift_announce_str = "Lift arriving at Geminus City Courtroom, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_mall_top
	name = "lift (upper shopping mall)"
	lift_floor_label = "Floor 1"
	lift_floor_name = "Upper Shopping Mall"
	lift_announce_str = "Lift arriving at the upper shopping mall, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/geminus_mall_ground
	name = "lift (ground shopping mall)"
	lift_floor_label = "Ground Floor"
	lift_floor_name = "Shopping Mall"
	lift_announce_str = "Lift arriving at the shopping mall, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/police_top
	name = "lift (upper police station)"
	lift_floor_label = "Floor 1"
	lift_floor_name = "Upper Police Station"
	lift_announce_str = "Lift arriving at the upper police station, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/police_ground
	name = "lift (police station main)"
	lift_floor_label = "Ground"
	lift_floor_name = "Ground Police Station"
	lift_announce_str = "Lift arriving at the lower police station, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

/area/turbolift/police_lower_ground
	name = "lift (prison mines)"
	lift_floor_label = "Lower Ground"
	lift_floor_name = "Prison Mines"
	lift_announce_str = "Lift arriving at the prison mines, please stand clear of the doors."
	base_turf = /turf/simulated/floor/tiled/steel_ridged

//shuttle areas
/area/shuttle
	dynamic_lighting = 1 //OH BOY

/area/shuttle/trade/station
	dynamic_lighting = 1 //OH BOY

/area/shuttle/arrival/pre_game
	icon_state = "shuttle2"
	base_turf = /turf/simulated/sky

/area/syndicate_station/
	dynamic_lighting = 1

//city areas

/area
	name = "\improper Planet"
	icon_state = "planet"
	has_gravity = 1
	power_equip = 1
	power_light = 1
	power_environ = 1
	requires_power = 0
	flags = RAD_SHIELDED
	base_turf = /turf/simulated/floor/outdoors/dirt

/area/planets
	name = "\improper Planet"
	icon_state = "planet"
//	has_gravity = 1
//	power_equip = 1
//	power_light = 1
//	power_environ = 1
//	requires_power = 0


/area/planets/Geminus
	name = "\improper Geminus City"
	icon_state = "Holodeck"

/area/planets/Geminus/outdoor
	name = "\improper Geminus City Area"
	dynamic_lighting = 1
	sound_env = CITY
	flags = null

/area/planets/Geminus/indoor
	name = "\improper Geminus Interior"
	icon_state = "yellow"
	dynamic_lighting = 1
	flags = RAD_SHIELDED


/area/planets/Geminus/outdoor/north
	name = "\improper Geminus City - North"
	icon_state = "yellow"
	sound_env = PARKING_LOT


/area/planets/Geminus/outdoor/south
	name = "\improper Geminus City - South"
	icon_state = "blue"
	sound_env = PARKING_LOT

/area/planets/Geminus/outdoor/east
	name = "\improper Geminus City - East"
	icon_state = "green"
	sound_env = PARKING_LOT

/area/planets/Geminus/outdoor/west
	name = "\improper Geminus City - West"
	icon_state = "yellow"
	sound_env = PARKING_LOT


/area/planets/Geminus/outdoor/central
	name = "\improper Geminus City - Central"
	icon_state = "blue"
	sound_env = CITY


/area/planets/Geminus/outdoor/mines
	name = "\improper Mines"
	icon_state = "yellow"

/area/planets/Geminus/outdoor/metro/abandoned
	name = "\improper Abandoned Metro"
	icon_state = "green"



/area/planets/Geminus/indoor/arrivalbus
	name = "\improper Arrival Bus"
	icon_state = "yellow"

/area/planets/Geminus/indoor/disco
	name = "\improper Disco"
	icon_state = "red"
	sound_env = CONCERT_HALL

/area/planets/Geminus/indoor/shoppingarea
	name = "\improper Shopping Area"
	icon_state = "green"

/area/planets/Geminus/indoor/shoppingarea/upper
	name = "\improper Upper Shopping Area"
	icon_state = "yellow"

/area/planets/Geminus/indoor/hotel
	name = "\improper Hotel"
	icon_state = "yellow"

/area/planets/Geminus/indoor/courtroom
	name = "\improper Courtroom"
	icon_state = "courtroom"

/area/planets/Geminus/indoor/chapel
	name = "\improper Chapel"
	icon_state = "chapel"

/area/planets/Geminus/indoor/virology
	name = "\improper Virology"
	icon_state = "virology"

/area/planets/Geminus/indoor/virologyaccess
	name = "\improper Virology Access"
	icon_state = "virology"

/area/planets/Geminus/indoor/police_station
	name = "\improper Police Station"
	icon_state = "brig"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/planets/Geminus/indoor/prison
	name = "\improper Security - Prison Wing"
	icon_state = "sec_prison"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/planets/Geminus/indoor/xenoflora
	name = "\improper Xenoflora Lab"
	icon_state = "xeno_f_lab"

/area/planets/Geminus/indoor/city_hall
	name = "\improper City Hall"
	icon_state = "dk_yellow"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/planets/Geminus/indoor/mayor
	name = "\improper Mayor Office"
	icon_state = "captain"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/planets/Geminus/indoor/mayor_car_park
	name = "\improper Mayor Car Park"
	icon_state = "captain"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/planets/Geminus/indoor/headmeetingroom
	name = "\improper City Hall Meeting Room"
	icon_state = "conference"

/area/planets/Geminus/indoor/cargo
	name = "\improper Cargo"
	icon_state = "quart"

/area/planets/Geminus/indoor/disposal_bay
	name = "\improper Disposal Bay"
	icon_state = "blue"

/area/planets/Geminus/indoor/museum
	name = "\improper Geminus Museum"
	icon_state = "blue"
	sound_env = AUDITORIUM

/area/planets/Geminus/indoor/sewer
	name = "\improper Underground Sewers"
	icon_state = "blue"
	requires_power = 0
	dynamic_lighting = 1
	base_turf = /turf/simulated/floor/tiled/steel_ridged
	sound_env = TUNNEL_ENCLOSED
	turf_initializer = new /datum/turf_initializer/mines()

	flags = AREA_FLAG_IS_NOT_PERSISTENT | RAD_SHIELDED

/area/planets/Geminus/indoor/sewer/north
	name = "\improper Underground Sewers - North"
	icon_state = "blue"

/area/planets/Geminus/indoor/sewer/central
	name = "\improper Underground Sewers - Central"
	icon_state = "red"

/area/planets/Geminus/indoor/sewer/east
	name = "\improper Underground Sewers - East"
	icon_state = "green"

/area/planets/Geminus/indoor/sewer/west
	name = "\improper Underground Sewers - West"
	icon_state = "blue"

/area/planets/Geminus/indoor/sewer/south
	name = "\improper Underground Sewers - South"
	icon_state = "yellow"

/area/planets/Geminus/indoor/sewer/rooms
	name = "\improper Underground Sewers - Rooms"
	icon_state = "purple"
	turf_initializer = new /datum/turf_initializer/maintenance/sewer()

/area/planets/Geminus/indoor/science
	name = "\improper Research and Development Labs"
	icon_state = "purple"

/area/planets/Geminus/indoor/morgue
	name = "\improper Morgue"
	icon_state = "morgue"

/area/planets/Geminus/outdoor/nuclear
	name = "\improper Nuclear Storage"
	icon_state = "nuke_storage"

/area/planets/Geminus/outdoor/aiupload
	name = "\improper City AI Upload"
	icon_state = "ai_upload"

/area/planets/Geminus/indoor/tech_storage
	name = "\improper Tech Shop"
	icon_state = "green"

/area/planets/Geminus/indoor/mining
	name = "\improper Mine"
	icon_state = "mining"

/area/planets/Geminus/indoor/cop_office
	name = "\improper Chief Of Police Office"
	icon_state = "green"

/area/planets/Geminus/indoor/warden_office
	name = "\improper Warden Office"
	icon_state = "green"

/area/planets/Geminus/indoor/armory
	name = "\improper City Police Armory"
	icon_state = "yellow"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/planets/Geminus/indoor/panicbunker
	name = "\improper Unknown Area"
	icon_state = "yellow"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND
//This is the head of city staff's safe room. Panic bunker, etc.

/area/planets/Geminus/indoor/hospital
	name = "\improper City Hospital"
	icon_state = "medbay"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/planets/Geminus/indoor/cmo
	name = "\improper Chief Medical Officer Office"
	icon_state = "cmo"

/area/planets/Geminus/outdoor/park
	name = "\improper Geminus City - Park"
	icon_state = "yellow"

/area/planets/Geminus/outdoor/sky
	name = "\improper Geminus City - The Sky"
	icon_state = "blue"

//Residential Area

/area/centcom/residential_area
	name = "\improper Residential Area"
	icon_state = "yellow"
	requires_power = 0
	dynamic_lighting = 1

/area/centcom/residential_area/bar
	name = "\improper Residential Area - Bar"

/area/centcom/residential_area/coffee_shop
	name = "\improper Residential Area - Coffee Shop"

/area/centcom/residential_area/mansions
	name = "\improper Residential Area - Mansion Area"
	icon_state = "green"

/area/centcom/residential_area/mansions/mansion_one
	name = "\improper Residential Area - Mansion One"

/area/centcom/residential_area/mansions/mansion_two
	name = "\improper Residential Area - Mansion Two"

/area/centcom/residential_area/mansions/mansion_three
	name = "\improper Residential Area - Mansion Three"

/area/centcom/residential_area/houses
	name = "\improper Residential Area - House Area"

/area/centcom/residential_area/houses/house_one
	name = "\improper Residential Area - House One"

/area/centcom/residential_area/houses/house_two
	name = "\improper Residential Area - House Two"

/area/centcom/residential_area/flats
	name = "\improper Residential Area - Flats"

/area/centcom/residential_area/flats/flat_one
	name = "\improper Residential Area - Flat One"

/area/centcom/residential_area/flats/flat_two
	name = "\improper Residential Area - Flat Two"

/area/centcom/residential_area/flats/flat_three
	name = "\improper Residential Area - Flat Three"

/area/centcom/residential_area/flats/flat_four
	name = "\improper Residential Area - Flat Four"

/area/centcom/residential_area/flats/flat_five
	name = "\improper Residential Area - Flat Five"

/area/centcom/residential_area/flats/flat_fox
	name = "\improper Residential Area - Flat Six"

/area/centcom/residential_area/house_masonette
	name = "\improper Residential Area - Masonette"

/area/centcom/residential_area/house_masonette/mason_one
	name = "\improper Residential Area - Masonette One"

/area/centcom/residential_area/house_masonette/mason_two
	name = "\improper Residential Area - Masonette Two"

/area/centcom/president_office_geminus
	name = "\improper Government HQ - Geminus City" //Central Command Command totally isn't RAS Syndrome in action.
	icon_state = "centcom_command"

/area/centcom/president_office_geminus/office
	name = "\improper Government HQ - President's Office" //Central Command Command totally isn't RAS Syndrome in action.
	icon_state = "centcom_command"

/area/centcom/president_office_geminus/governor
	name = "\improper Government HQ - Governor's Office" //Central Command Command totally isn't RAS Syndrome in action.
	icon_state = "yellow"

/area/centcom/president_office_geminus/ceo
	name = "\improper Government HQ - CEO's Office" //Central Command Command totally isn't RAS Syndrome in action.
	icon_state = "blue"

/area/centcom/president_office_geminus/advisor/defense
	name = "\improper Advisor of Defense's Offices"
	icon_state = "red"

/area/centcom/president_office_geminus/advisor/finance
	name = "\improper Advisor of Finance's Offices"
	icon_state = "green"

/area/centcom/president_office_geminus/advisor/health
	name = "\improper Advisor of Health's Offices"
	icon_state = "blue"

/area/centcom/president_office_geminus/advisor/innovation
	name = "\improper Advisor of Innovation's Offices"
	icon_state = "yellow"

/area/centcom/president_office_geminus/advisor/justice
	name = "\improper Advisor of Justice's Offices"
	icon_state = "darkred"

/area/centcom/president_office_geminus/meeting
	name = "\improper Government HQ - Meeting Room"
	icon_state = "yellow"

/area/abandoned_lab
	name = "\improper NSS Abendrot"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "blue"
	requires_power = 0
	dynamic_lighting = 1
	base_turf = /turf/simulated/floor/plating

/area/abandoned_lab/laboratory
	name = "\improper NSS Abendrot - Laboratory"
	icon_state = "yellow"

/area/abandoned_lab/gateway
	name = "\improper NSS Abendrot - Gateway"
	icon_state = "green"

/area/abandoned_lab/bridge
	name = "\improper NSS Abendrot - Bridge"
	icon_state = "bridge"