/datum/design/circuit
	build_type = IMPRINTER
	req_tech = list(TECH_DATA = 2)
	materials = list("glass" = 2000, "copper" = 1000, "aluminium" = 1000)
	chemicals = list("sacid" = 20)
	time = 5

/datum/design/circuit/AssembleDesignName()
	..()
	if(build_path)
		var/obj/item/weapon/circuitboard/C = build_path
		if(initial(C.board_type) == "machine")
			name = "Machine circuit design ([item_name])"
		else if(initial(C.board_type) == "computer")
			name = "Computer circuit design ([item_name])"
		else
			name = "Circuit design ([item_name])"

/datum/design/circuit/AssembleDesignDesc()
	if(!desc)
		desc = "Allows for the construction of \a [item_name] circuit board."

/datum/design/circuit/arcademachine
	name = "battle arcade machine"
	id = "arcademachine"
	req_tech = list(TECH_DATA = 1)
	build_path = /obj/item/weapon/circuitboard/arcade/battle
	sort_string = "MAAAA"
	protected = TRUE

/datum/design/circuit/oriontrail
	name = "orion trail arcade machine"
	id = "oriontrail"
	req_tech = list(TECH_DATA = 1)
	build_path = /obj/item/weapon/circuitboard/arcade/orion_trail
	sort_string = "MAAAA"
	protected = TRUE

/datum/design/circuit/jukebox
	name = "jukebox"
	id = "jukebox"
	req_tech = list(TECH_MAGNET = 2, TECH_DATA = 1)
	build_path = /obj/item/weapon/circuitboard/jukebox
	sort_string = "MAAAB" //used to be MAAAZ
	protected = TRUE

/datum/design/circuit/seccamera
	name = "security camera monitor"
	id = "seccamera"
	build_path = /obj/item/weapon/circuitboard/security
	sort_string = "DAAAA" // used to be DAAAZ
	protected = TRUE

/datum/design/circuit/secdata
	name = "security records console"
	id = "sec_data"
	build_path = /obj/item/weapon/circuitboard/secure_data
	sort_string = "DABAA"
	protected = TRUE

/datum/design/circuit/prisonmanage
	name = "prisoner management console"
	id = "prisonmanage"
	build_path = /obj/item/weapon/circuitboard/prisoner
	sort_string = "DACAA"
	protected = TRUE

/datum/design/circuit/med_data
	name = "medical records console"
	id = "med_data"
	build_path = /obj/item/weapon/circuitboard/med_data
	sort_string = "FAAAA"
	protected = TRUE

/datum/design/circuit/operating
	name = "patient monitoring console"
	id = "operating"
	build_path = /obj/item/weapon/circuitboard/operating
	sort_string = "FACAA"
	protected = TRUE

/*
/datum/design/circuit/scan_console
	name = "DNA machine"
	id = "scan_console"
	build_path = /obj/item/weapon/circuitboard/scan_consolenew
	sort_string = "FAGAA"
	protected = TRUE

/datum/design/circuit/clonecontrol
	name = "cloning control console"
	id = "clonecontrol"
	req_tech = list(TECH_DATA = 3, TECH_BIO = 3)
	build_path = /obj/item/weapon/circuitboard/cloning
	sort_string = "FAGAC"
	protected = TRUE

/datum/design/circuit/clonepod
	name = "clone pod"
	id = "clonepod"
	req_tech = list(TECH_DATA = 3, TECH_BIO = 3)
	build_path = /obj/item/weapon/circuitboard/clonepod
	sort_string = "FAGAE"
	protected = TRUE

/datum/design/circuit/clonescanner
	name = "cloning scanner"
	id = "clonescanner"
	req_tech = list(TECH_DATA = 3, TECH_BIO = 3)
	build_path = /obj/item/weapon/circuitboard/clonescanner
	sort_string = "FAGAG"
	protected = TRUE
*/

/datum/design/circuit/crewconsole
	name = "crew monitoring console"
	id = "crewconsole"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 2, TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/crew
	sort_string = "FAGAI"

/datum/design/circuit/teleconsole
	name = "teleporter control console"
	id = "teleconsole"
	req_tech = list(TECH_DATA = 3, TECH_BLUESPACE = 2)
	build_path = /obj/item/weapon/circuitboard/teleporter
	sort_string = "HAAAA"
	protected = TRUE

/datum/design/circuit/robocontrol
	name = "robotics control console"
	id = "robocontrol"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/robotics
	sort_string = "HAAAB"
	protected = TRUE

/datum/design/circuit/mechacontrol
	name = "exosuit control console"
	id = "mechacontrol"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/mecha_control
	sort_string = "HAAAC"
	protected = TRUE

/datum/design/circuit/rdconsole
	name = "R&D control console"
	id = "rdconsole"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/rdconsole
	sort_string = "HAAAE"
	protected = TRUE

/datum/design/circuit/aifixer
	name = "AI integrity restorer"
	id = "aifixer"
	req_tech = list(TECH_DATA = 3, TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/aifixer
	sort_string = "HAAAF"

/datum/design/circuit/comm_monitor
	name = "telecommunications monitoring console"
	id = "comm_monitor"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/comm_monitor
	sort_string = "HAACA"
	protected = TRUE

/datum/design/circuit/comm_server
	name = "telecommunications server monitoring console"
	id = "comm_server"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/comm_server
	sort_string = "HAACB"
	protected = TRUE

/datum/design/circuit/message_monitor
	name = "messaging monitor console"
	id = "message_monitor"
	req_tech = list(TECH_DATA = 5)
	build_path = /obj/item/weapon/circuitboard/message_monitor
	sort_string = "HAACC"
	protected = TRUE

/datum/design/circuit/aiupload
	name = "AI upload console"
	id = "aiupload"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/aiupload
	sort_string = "HAABA"

/datum/design/circuit/borgupload
	name = "cyborg upload console"
	id = "borgupload"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/borgupload
	sort_string = "HAABB"
	protected = TRUE

/datum/design/circuit/destructive_analyzer
	name = "destructive analyzer"
	id = "destructive_analyzer"
	req_tech = list(TECH_DATA = 2, TECH_MAGNET = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/destructive_analyzer
	sort_string = "HABAA"
	protected = TRUE

/datum/design/circuit/protolathe
	name = "protolathe"
	id = "protolathe"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/protolathe
	sort_string = "HABAB"
	protected = TRUE

/datum/design/circuit/circuit_imprinter
	name = "circuit imprinter"
	id = "circuit_imprinter"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/circuit_imprinter
	sort_string = "HABAC"
	protected = TRUE

/datum/design/circuit/autolathe
	name = "autolathe board"
	id = "autolathe"
	req_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/autolathe
	sort_string = "HABAD"
	protected = TRUE

/datum/design/circuit/rdservercontrol
	name = "R&D server control console"
	id = "rdservercontrol"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/rdservercontrol
	sort_string = "HABBA"
	protected = TRUE

/datum/design/circuit/rdserver
	name = "R&D server"
	id = "rdserver"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/rdserver
	sort_string = "HABBB"
	protected = TRUE

/datum/design/circuit/mechfab
	name = "exosuit fabricator"
	id = "mechfab"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 3)
	build_path = /obj/item/weapon/circuitboard/mechfab
	sort_string = "HABAE"
	protected = TRUE

/datum/design/circuit/prosfab
	name = "prosthetics fabricator"
	id = "prosfab"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 3)
	build_path = /obj/item/weapon/circuitboard/prosthetics
	sort_string = "HABAF"
	protected = TRUE

/datum/design/circuit/mech_recharger
	name = "mech recharger"
	id = "mech_recharger"
	req_tech = list(TECH_DATA = 2, TECH_POWER = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/mech_recharger
	sort_string = "HACAA"
	protected = TRUE

/datum/design/circuit/recharge_station
	name = "cyborg recharge station"
	id = "recharge_station"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/recharge_station
	sort_string = "HACAC"
	protected = TRUE

/datum/design/circuit/atmosalerts
	name = "atmosphere alert console"
	id = "atmosalerts"
	build_path = /obj/item/weapon/circuitboard/atmos_alert
	sort_string = "JAAAA"

/datum/design/circuit/air_management
	name = "atmosphere monitoring console"
	id = "air_management"
	build_path = /obj/item/weapon/circuitboard/air_management
	sort_string = "JAAAB"

/datum/design/circuit/rcon_console
	name = "RCON remote control console"
	id = "rcon_console"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 3, TECH_POWER = 5)
	build_path = /obj/item/weapon/circuitboard/rcon_console
	sort_string = "JAAAC"

/datum/design/circuit/dronecontrol
	name = "drone control console"
	id = "dronecontrol"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/drone_control
	sort_string = "JAAAD"
	protected = TRUE

/datum/design/circuit/powermonitor
	name = "power monitoring console"
	id = "powermonitor"
	build_path = /obj/item/weapon/circuitboard/powermonitor
	sort_string = "JAAAE"

/datum/design/circuit/solarcontrol
	name = "solar control console"
	id = "solarcontrol"
	build_path = /obj/item/weapon/circuitboard/solar_control
	sort_string = "JAAAF"

/datum/design/circuit/pacman
	name = "PACMAN-type generator"
	id = "pacman"
	req_tech = list(TECH_DATA = 3, TECH_PHORON = 3, TECH_POWER = 3, TECH_ENGINEERING = 3)
	build_path = /obj/item/weapon/circuitboard/pacman
	sort_string = "JBAAA"
	protected = TRUE

/datum/design/circuit/superpacman
	name = "SUPERPACMAN-type generator"
	id = "superpacman"
	req_tech = list(TECH_DATA = 3, TECH_POWER = 4, TECH_ENGINEERING = 4)
	build_path = /obj/item/weapon/circuitboard/pacman/super
	sort_string = "JBAAB"
	protected = TRUE

/datum/design/circuit/mrspacman
	name = "MRSPACMAN-type generator"
	id = "mrspacman"
	req_tech = list(TECH_DATA = 3, TECH_POWER = 5, TECH_ENGINEERING = 5)
	build_path = /obj/item/weapon/circuitboard/pacman/mrs
	sort_string = "JBAAC"
	protected = TRUE

/datum/design/circuit/batteryrack
	name = "cell rack PSU"
	id = "batteryrack"
	req_tech = list(TECH_POWER = 3, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/batteryrack
	sort_string = "JBABA"
	protected = TRUE

/datum/design/circuit/smes_cell
	name = "'SMES' superconductive magnetic energy storage"
	desc = "Allows for the construction of circuit boards used to build a SMES."
	id = "smes_cell"
	req_tech = list(TECH_POWER = 7, TECH_ENGINEERING = 5)
	build_path = /obj/item/weapon/circuitboard/smes
	sort_string = "JBABB"

/datum/design/circuit/grid_checker
	name = "power grid checker"
	desc = "Allows for the construction of circuit boards used to build a grid checker."
	id = "grid_checker"
	req_tech = list(TECH_POWER = 4, TECH_ENGINEERING = 3)
	build_path = /obj/item/weapon/circuitboard/grid_checker
	sort_string = "JBABC"

/datum/design/circuit/breakerbox
	name = "breaker box"
	desc = "Allows for the construction of circuit boards used to build a breaker box."
	id = "breakerbox"
	req_tech = list(TECH_POWER = 3, TECH_ENGINEERING = 3)
	build_path = /obj/item/weapon/circuitboard/breakerbox
	sort_string = "JBABD"

/datum/design/circuit/gas_heater
	name = "gas heating system"
	id = "gasheater"
	req_tech = list(TECH_POWER = 2, TECH_ENGINEERING = 1)
	build_path = /obj/item/weapon/circuitboard/unary_atmos/heater
	sort_string = "JCAAA"

/datum/design/circuit/gas_cooler
	name = "gas cooling system"
	id = "gascooler"
	req_tech = list(TECH_MAGNET = 2, TECH_ENGINEERING = 2)
	build_path = /obj/item/weapon/circuitboard/unary_atmos/cooler
	sort_string = "JCAAB"

/datum/design/circuit/secure_airlock
	name = "secure airlock electronics"
	desc =  "Allows for the construction of a tamper-resistant airlock electronics."
	id = "securedoor"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/airlock_electronics/secure
	sort_string = "JDAAA"
	protected = TRUE

/*
/datum/design/circuit/ordercomp
	name = "supply ordering console"
	id = "ordercomp"
	build_path = /obj/item/weapon/circuitboard/ordercomp
	sort_string = "KAAAA"
*/
/datum/design/circuit/supplycomp
	name = "supply control console"
	id = "supplycomp"
	req_tech = list(TECH_DATA = 3)
	build_path = /obj/item/weapon/circuitboard/supplycomp // used to be /obj/item/weapon/circuitboard/supplycomp/control
	sort_string = "KAAAB" // used to be KAAAZ
	protected = TRUE

/datum/design/circuit/biogenerator
	name = "biogenerator"
	id = "biogenerator"
	req_tech = list(TECH_DATA = 2)
	build_path = /obj/item/weapon/circuitboard/biogenerator
	sort_string = "KBAAA"
	protected = TRUE

/datum/design/circuit/botany_extractor
	name = "lysis-isolation centrifuge"
	id = "lysis"
	req_tech = list (TECH_DATA = 2, TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/botany_extractor
	sort_string = "KBAAB"
	protected = TRUE

/datum/design/circuit/botany_editor
	name = "bioballistic delivery system"
	id = "bioball"
	req_tech = list (TECH_DATA = 2, TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/botany_editor
	sort_string = "KBAAC"
	protected = TRUE

/datum/design/circuit/slimeprocessor
	name = "slime processor"
	id = "slimeprocessor"
	req_tech = list (TECH_DATA = 2, TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/processor
	sort_string = "KBAAD"
	protected = TRUE

/datum/design/circuit/miningdrill
	name = "mining drill head"
	id = "mining drill head"
	req_tech = list(TECH_DATA = 1, TECH_ENGINEERING = 1)
	build_path = /obj/item/weapon/circuitboard/miningdrill
	sort_string = "KCAAA"
	protected = TRUE

/*
/datum/design/circuit/miningdrillbrace
	name = "mining drill brace"
	id = "mining drill brace"
	req_tech = list(TECH_DATA = 1, TECH_ENGINEERING = 1)
	build_path = /obj/item/weapon/circuitboard/miningdrillbrace
	sort_string = "KCAAB"
	protected = TRUE
*/

/datum/design/circuit/comconsole
	name = "communications console"
	id = "comconsole"
	build_path = /obj/item/weapon/circuitboard/communications
	sort_string = "LAAAA"
	protected = TRUE

/*
/datum/design/circuit/idcardconsole
	name = "ID card modification console"
	id = "idcardconsole"
	build_path = /obj/item/weapon/circuitboard/card
	sort_string = "LAAAB"
*/
/datum/design/circuit/emp_data
	name = "employment records console"
	id = "emp_data"
	build_path = /obj/item/weapon/circuitboard/skills
	sort_string = "LAAAC"
	protected = TRUE

/datum/design/circuit/mecha
	req_tech = list(TECH_DATA = 3)
	protected = TRUE

/datum/design/circuit/mecha/AssembleDesignName()
	name = "Exosuit module circuit design ([name])"
/datum/design/circuit/mecha/AssembleDesignDesc()
	desc = "Allows for the construction of \a [name] module."

/datum/design/circuit/mecha/ripley_main
	name = "APLU 'Ripley' central control"
	id = "ripley_main"
	build_path = /obj/item/weapon/circuitboard/mecha/ripley/main
	sort_string = "NAAAA"
	price = 750

/datum/design/circuit/mecha/ripley_peri
	name = "APLU 'Ripley' peripherals control"
	id = "ripley_peri"
	build_path = /obj/item/weapon/circuitboard/mecha/ripley/peripherals
	sort_string = "NAAAB"
	price = 750

/datum/design/circuit/mecha/odysseus_main
	name = "'Odysseus' central control"
	id = "odysseus_main"
	req_tech = list(TECH_DATA = 3,TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/odysseus/main
	sort_string = "NAABA"
	price = 900

/datum/design/circuit/mecha/odysseus_peri
	name = "'Odysseus' peripherals control"
	id = "odysseus_peri"
	req_tech = list(TECH_DATA = 3,TECH_BIO = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/odysseus/peripherals
	sort_string = "NAABB"
	price = 900

/datum/design/circuit/mecha/gygax_main
	name = "'Gygax' central control"
	id = "gygax_main"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/gygax/main
	sort_string = "NAACA"
	price = 1500

/datum/design/circuit/mecha/gygax_peri
	name = "'Gygax' peripherals control"
	id = "gygax_peri"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/gygax/peripherals
	sort_string = "NAACB"
	price = 1500

/datum/design/circuit/mecha/gygax_targ
	name = "'Gygax' weapon control and targeting"
	id = "gygax_targ"
	req_tech = list(TECH_DATA = 4, TECH_COMBAT = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/gygax/targeting
	sort_string = "NAACC"
	price = 1500

/datum/design/circuit/mecha/durand_main
	name = "'Durand' central control"
	id = "durand_main"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/durand/main
	sort_string = "NAADA"
	price = 5000

/datum/design/circuit/mecha/durand_peri
	name = "'Durand' peripherals control"
	id = "durand_peri"
	req_tech = list(TECH_DATA = 4)
	build_path = /obj/item/weapon/circuitboard/mecha/durand/peripherals
	sort_string = "NAADB"
	price = 5000

/datum/design/circuit/mecha/durand_targ
	name = "'Durand' weapon control and targeting"
	id = "durand_targ"
	req_tech = list(TECH_DATA = 4, TECH_COMBAT = 2)
	build_path = /obj/item/weapon/circuitboard/mecha/durand/targeting
	sort_string = "NAADC"
	price = 5000

/datum/design/circuit/tcom
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 4)
	protected = TRUE

/datum/design/circuit/tcom/AssembleDesignName()
	name = "Telecommunications machinery circuit design ([name])"
/datum/design/circuit/tcom/AssembleDesignDesc()
	desc = "Allows for the construction of a telecommunications [name] circuit board."

/datum/design/circuit/tcom/server
	name = "server mainframe"
	id = "tcom-server"
	build_path = /obj/item/weapon/circuitboard/telecomms/server
	sort_string = "PAAAA"

/datum/design/circuit/tcom/processor
	name = "processor unit"
	id = "tcom-processor"
	build_path = /obj/item/weapon/circuitboard/telecomms/processor
	sort_string = "PAAAB"

/datum/design/circuit/tcom/bus
	name = "bus mainframe"
	id = "tcom-bus"
	build_path = /obj/item/weapon/circuitboard/telecomms/bus
	sort_string = "PAAAC"

/datum/design/circuit/tcom/hub
	name = "hub mainframe"
	id = "tcom-hub"
	build_path = /obj/item/weapon/circuitboard/telecomms/hub
	sort_string = "PAAAD"

/datum/design/circuit/tcom/relay
	name = "relay mainframe"
	id = "tcom-relay"
	req_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 4, TECH_BLUESPACE = 3)
	build_path = /obj/item/weapon/circuitboard/telecomms/relay
	sort_string = "PAAAE"

/datum/design/circuit/tcom/broadcaster
	name = "subspace broadcaster"
	id = "tcom-broadcaster"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 4, TECH_BLUESPACE = 2)
	build_path = /obj/item/weapon/circuitboard/telecomms/broadcaster
	sort_string = "PAAAF"

/datum/design/circuit/tcom/receiver
	name = "subspace receiver"
	id = "tcom-receiver"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 3, TECH_BLUESPACE = 2)
	build_path = /obj/item/weapon/circuitboard/telecomms/receiver
	sort_string = "PAAAG"

/datum/design/circuit/tcom/exonet_node
	name = "exonet node"
	id = "tcom-exonet_node"
	req_tech = list(TECH_DATA = 5, TECH_ENGINEERING = 5, TECH_BLUESPACE = 4)
	build_path = /obj/item/weapon/circuitboard/telecomms/exonet_node
	sort_string = "PAAAH"

/datum/design/circuit/shield
	req_tech = list(TECH_BLUESPACE = 4, TECH_PHORON = 3)
	materials = list("glass" = 2000, "gold" = 1000, "copper" = 1000) // previosuly 2k glass, 2k copper, 1k aluminium, 1k gold
	protected = TRUE

/datum/design/circuit/shield/AssembleDesignName()
	name = "Shield generator circuit design ([name])"
/datum/design/circuit/shield/AssembleDesignDesc()
	if(!desc)
		desc = "Allows for the construction of \a [name] shield generator."

/datum/design/circuit/shield/bubble
	name = "bubble"
	id = "shield_gen"
	build_path = /obj/item/weapon/circuitboard/shield_gen
	sort_string = "VAAAA" // previously VAAAZ

/datum/design/circuit/shield/hull
	name = "hull"
	id = "shield_gen_ex"
	build_path = /obj/item/weapon/circuitboard/shield_gen_ex
	sort_string = "VAAAB"

/datum/design/circuit/shield/capacitor
	name = "capacitor"
	desc = "Allows for the construction of a shield capacitor circuit board."
	id = "shield_cap"
	req_tech = list(TECH_MAGNET = 3, TECH_POWER = 4)
	build_path = /obj/item/weapon/circuitboard/shield_cap
	sort_string = "VAAAC"

/datum/design/circuit/aicore
	name = "AI core"
	id = "aicore"
	req_tech = list(TECH_DATA = 4, TECH_BIO = 3)
	build_path = /obj/item/weapon/circuitboard/aicore
	sort_string = "XAAAA"
	protected = TRUE
	price = 10000

/datum/design/circuit/chem_master
	name = "ChemMaster 3000"
	id = "chemmaster"
	req_tech = list(TECH_DATA = 3, TECH_MAGNET = 2)
	build_path = /obj/item/weapon/circuitboard/chem_master
	sort_string = "FAGAH"
	protected = TRUE

/* I have no idea how this was even running before, but it doesn't seem to be necessary.
///////////////////////////////////
/////////Shield Generators/////////
///////////////////////////////////
/datum/design/circuit/shield
	req_tech = list(TECH_BLUESPACE = 4, TECH_PHORON = 3)
	materials = list("$glass" = 2000, "sacid" = 20, "$phoron" = 10000, "$diamond" = 5000, "$gold" = 10000)
*/
