/*

	Hello and welcome to sprite_accessories: For sprite accessories, such as hair,
	facial hair, and possibly tattoos and stuff somewhere along the line. This file is
	intended to be friendly for people with little to no actual coding experience.
	The process of adding in new hairstyles has been made pain-free and easy to do.
	Enjoy! - Doohl


	Notice: This all gets automatically compiled in a list in dna2.dm, so you do not
	have to define any UI values for sprite accessories manually for hair and facial
	hair. Just add in new hair types and the game will naturally adapt.

	!!WARNING!!: changing existing hair information can be VERY hazardous to savefiles,
	to the point where you may completely corrupt a server's savefiles. Please refrain
	from doing this unless you absolutely know what you are doing, and have defined a
	conversion in savefile.dm
*/

/datum/sprite_accessory

	var/icon			// the icon file the accessory is located in
	var/icon_state		// the icon_state of the accessory
	var/preview_state	// a custom preview state for whatever reason

	var/name			// the preview name of the accessory

	// Determines if the accessory will be skipped or included in random hair generations
	var/gender = NEUTER

	// Restrict some styles to specific species
	var/list/species_allowed = list(SPECIES_HUMAN,SPECIES_HUMAN_CHILD,SPECIES_HUMAN_TEEN,SPECIES_PROMETHEAN,SPECIES_HUMAN_VATBORN)

	// Whether or not the accessory can be affected by colouration
	var/do_colouration = 1

	//To allow markings to show over hair layer, often used for IPC and Skrell markings.
	var/over_hair = 0

/*
////////////////////////////
/  =--------------------=  /
/  == Hair Definitions ==  /
/  =--------------------=  /
////////////////////////////
*/

#define HAIR_BALD 0 //*rubs head*
#define HAIR_SHORT 1
#define HAIR_MEDIUM 2
#define HAIR_LONG 3

/datum/sprite_accessory/hair

	icon = 'icons/mob/Human_face_m.dmi'	  // default icon for all hairs
	var/icon_add = 'icons/mob/human_face.dmi'
	var/hair_type = HAIR_SHORT // Default is short

	bald
		name = "Bald"
		icon_state = "bald"
		gender = MALE
		hair_type = HAIR_BALD
		species_allowed = list(SPECIES_HUMAN,SPECIES_HUMAN_CHILD,SPECIES_HUMAN_TEEN,SPECIES_UNATHI,SPECIES_PROMETHEAN,SPECIES_HUMAN_VATBORN,SPECIES_VOX)

	short
		name = "Short Hair"	  // try to capatilize the names please~
		hair_type = HAIR_SHORT
		icon_state = "hair_a" // you do not need to define _s or _l sub-states, game automatically does this for you

	short2
		name = "Short Hair 2"
		hair_type = HAIR_SHORT
		icon_state = "hair_shorthair3"

	short3
		name = "Short Hair 3"
		hair_type = HAIR_SHORT
		icon_state = "hair_shorthair4"

	twintail
		name = "Twintail"
		hair_type = HAIR_LONG
		icon_state = "hair_twintail"

	cut
		name = "Cut Hair"
		hair_type = HAIR_SHORT
		icon_state = "hair_c"

	flair
		name = "Flaired Hair"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_flair"

	long
		name = "Shoulder-length Hair"
		hair_type = HAIR_LONG
		icon_state = "hair_b"

	/*longish
		name = "Longer Hair"
		icon_state = "hair_b2"*/

	longer
		name = "Long Hair"
		hair_type = HAIR_LONG
		icon_state = "hair_vlong"

	longest
		name = "Very Long Hair"
		hair_type = HAIR_LONG
		icon_state = "hair_longest"

	longfringe
		name = "Long Fringe"
		hair_type = HAIR_LONG
		icon_state = "hair_longfringe"

	longestalt
		name = "Longer Fringe"
		hair_type = HAIR_LONG
		icon_state = "hair_vlongfringe"

	halfbang
		name = "Half-banged Hair"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_halfbang"

	halfbangalt
		name = "Half-banged Hair Alt"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_halfbang_alt"

	ponytail1
		name = "Ponytail 1"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_ponytail"

	ponytail2
		name = "Ponytail 2"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_pa"

	ponytail3
		name = "Ponytail 3"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_ponytail3"

	ponytail4
		name = "Ponytail 4"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_ponytail4"

	ponytail5
		name = "Ponytail 5"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_ponytail5"

	ponytail6
		name = "Ponytail 6"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_ponytail6"

	fringetail
		name = "Fringetail"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_fringetail"

	sideponytail
		name = "Side Ponytail"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_stail"

	sideponytail4 //Not happy about this... but it's for the save files.
		name = "Side Ponytail 2"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_ponytailf"

	sideponytail2
		name = "One Shoulder"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_oneshoulder"

	sideponytail3
		name = "Tress Shoulder"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_tressshoulder"

	spikyponytail
		name = "Spiky Ponytail"
		hair_type = HAIR_SHORT
		icon_state = "hair_spikyponytail"

	zieglertail
		name = "Zieglertail"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_ziegler"
	wisp
		name = "Wisp"
		hair_type = HAIR_SHORT
		icon_state = "hair_wisp"

	parted
		name = "Parted"
		hair_type = HAIR_SHORT
		icon_state = "hair_parted"

	partedalt
		name = "Parted Alt"
		icon_state = "hair_partedalt"

	pompadour
		name = "Pompadour"
		hair_type = HAIR_SHORT
		icon_state = "hair_pompadour"

	sleeze
		name = "Sleeze"
		hair_type = HAIR_SHORT
		icon_state = "hair_sleeze"

	quiff
		name = "Quiff"
		hair_type = HAIR_SHORT
		icon_state = "hair_quiff"

	bedhead
		name = "Bedhead"
		hair_type = HAIR_SHORT
		icon_state = "hair_bedhead"

	bedhead2
		name = "Bedhead 2"
		hair_type = HAIR_SHORT
		icon_state = "hair_bedheadv2"

	bedhead3
		name = "Bedhead 3"
		hair_type = HAIR_SHORT
		icon_state = "hair_bedheadv3"

	bedheadlong
		name = "Bedhead Long"
		hair_type = HAIR_LONG
		icon_state = "hair_long_bedhead"

	beehive
		name = "Beehive"
		hair_type = HAIR_SHORT
		icon_state = "hair_beehive"

	beehive2
		name = "Beehive 2"
		hair_type = HAIR_SHORT
		icon_state = "hair_beehive2"

	bobcurl
		name = "Bobcurl"
		icon_state = "hair_bobcurl"
		hair_type = HAIR_SHORT
		species_allowed = list(SPECIES_HUMAN,SPECIES_PROMETHEAN,SPECIES_HUMAN_VATBORN,SPECIES_UNATHI)

	bob
		name = "Bob"
		icon_state = "hair_bobcut"
		hair_type = HAIR_SHORT
		species_allowed = list(SPECIES_HUMAN,SPECIES_PROMETHEAN,SPECIES_HUMAN_VATBORN,SPECIES_UNATHI)

	bobcutalt
		name = "Chin Length Bob"
		hair_type = HAIR_SHORT
		icon_state = "hair_bobcutalt"

	bun
		name = "Bun"
		hair_type = HAIR_SHORT
		icon_state = "hair_bun"

	bun2
		name = "Bun 2"
		hair_type = HAIR_SHORT
		icon_state = "hair_bun2"

	bun3
		name = "Bun 3"
		hair_type = HAIR_SHORT
		icon_state = "hair_bun3"

	bowl
		name = "Bowl"
		hair_type = HAIR_SHORT
		icon_state = "hair_bowlcut"

	buzz
		name = "Buzzcut"
		hair_type = HAIR_BALD
		icon_state = "hair_buzzcut"
		species_allowed = list(SPECIES_HUMAN,SPECIES_PROMETHEAN,SPECIES_HUMAN_VATBORN,SPECIES_UNATHI)

	shavehair
		name = "Shaved Hair"
		hair_type = HAIR_BALD
		icon_state = "hair_shaved"

	crew
		name = "Crewcut"
		hair_type = HAIR_BALD
		icon_state = "hair_crewcut"

	combover
		name = "Combover"
		hair_type = HAIR_BALD
		icon_state = "hair_combover"

	father
		name = "Father"
		hair_type = HAIR_SHORT
		icon_state = "hair_father"

	reversemohawk
		name = "Reverse Mohawk"
		hair_type = HAIR_SHORT
		icon_state = "hair_reversemohawk"

	devillock
		name = "Devil Lock"
		hair_type = HAIR_SHORT
		icon_state = "hair_devilock"

	dreadlocks
		name = "Dreadlocks"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_dreads"

	curls
		name = "Curls"
		hair_type = HAIR_SHORT
		icon_state = "hair_curls"

	afro
		name = "Afro"
		hair_type = HAIR_SHORT
		icon_state = "hair_afro"

	afro2
		name = "Afro 2"
		hair_type = HAIR_SHORT
		icon_state = "hair_afro2"

	afro_large
		name = "Big Afro"
		hair_type = HAIR_LONG
		icon_state = "hair_bigafro"

	rows
		name = "Rows"
		hair_type = HAIR_SHORT
		icon_state = "hair_rows1"

	rows2
		name = "Rows 2"
		hair_type = HAIR_SHORT
		icon_state = "hair_rows2"

	sargeant
		name = "Flat Top"
		hair_type = HAIR_SHORT
		icon_state = "hair_sargeant"

	emo
		name = "Emo"
		hair_type = HAIR_SHORT
		icon_state = "hair_emo"

	emo2
		name = "Emo Alt"
		hair_type = HAIR_SHORT
		icon_state = "hair_emo2"

	longemo
		name = "Long Emo"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_emolong"

	fringeemo
		name = "Emo Fringe"
		hair_type = HAIR_SHORT
		icon_state = "hair_emofringe"

	veryshortovereyealternate
		name = "Overeye Very Short, Alternate"
		hair_type = HAIR_SHORT
		icon_state = "hair_veryshortovereyealternate"

	veryshortovereye
		name = "Overeye Very Short"
		hair_type = HAIR_SHORT
		icon_state = "hair_veryshortovereye"

	shortovereye
		name = "Overeye Short"
		hair_type = HAIR_SHORT
		icon_state = "hair_shortovereye"

	longovereye
		name = "Overeye Long"
		hair_type = HAIR_SHORT
		icon_state = "hair_longovereye"

	flowhair
		name = "Flow Hair"
		hair_type = HAIR_SHORT
		icon_state = "hair_f"

	feather
		name = "Feather"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_feather"

	glossy
		name = "Glossy"
		icon_state = "hair_glossy"

	hitop
		name = "Hitop"
		hair_type = HAIR_SHORT
		icon_state = "hair_hitop"

	mohawk
		name = "Mohawk"
		hair_type = HAIR_SHORT
		icon_state = "hair_d"
		species_allowed = list(SPECIES_HUMAN,SPECIES_PROMETHEAN,SPECIES_HUMAN_VATBORN,SPECIES_UNATHI)

	jensen
		name = "Adam Jensen Hair"
		hair_type = HAIR_SHORT
		icon_state = "hair_jensen"

	gelled
		name = "Gelled Back"
		hair_type = HAIR_SHORT
		icon_state = "hair_gelled"

	gentle
		name = "Gentle"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_gentle"

	gentlelong
		name = "Gentle Long"
		icon_state = "hair_gentle2long"

	spiky
		name = "Spiky"
		icon_state = "hair_spikey"
		hair_type = HAIR_SHORT
		species_allowed = list(SPECIES_HUMAN,SPECIES_PROMETHEAN,SPECIES_HUMAN_VATBORN,SPECIES_UNATHI)

	kusangi
		name = "Kusanagi Hair"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_kusanagi"

	kagami
		name = "Pigtails"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_kagami"

	himecut
		name = "Hime Cut"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_himecut"

	shorthime
		name = "Short Hime Cut"
		hair_type = HAIR_SHORT
		icon_state = "hair_shorthime"

	grandebraid
		name = "Grande Braid"
		hair_type = HAIR_LONG
		icon_state = "hair_grande"

	mbraid
		name = "Medium Braid"
		icon_state = "hair_shortbraid"
		hair_type = HAIR_MEDIUM

	braid2
		name = "Long Braid"
		icon_state = "hair_hbraid"
		hair_type = HAIR_LONG

	/*braid
		name = "Floorlength Braid"
		icon_state = "hair_braid"
		hair_type = HAIR_LONG*/

	odango
		name = "Odango"
		hair_type = HAIR_LONG
		icon_state = "hair_odango"

	ombre
		name = "Ombre"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_ombre"

	updo
		name = "Updo"
		hair_type = HAIR_SHORT
		icon_state = "hair_updo"

	skinhead
		name = "Skinhead"
		hair_type = HAIR_BALD
		icon_state = "hair_skinhead"

	balding
		name = "Balding Hair"
		icon_state = "hair_e"
		hair_type = HAIR_BALD
		gender = MALE

	familyman
		name = "The Family Man"
		hair_type = HAIR_MEDIUM
		icon_state = "hair_thefamilyman"

	mahdrills
		name = "Drillruru"
		hair_type = HAIR_SHORT
		icon_state = "hair_drillruru"

	fringetail
		name = "Fringetail"
		icon_state = "hair_fringetail"

	dandypomp
		name = "Dandy Pompadour"
		icon_state = "hair_dandypompadour"

	poofy
		name = "Poofy"
		icon_state = "hair_poofy"

	poofy2
		name = "Poofy2"
		icon_state = "hair_poofy2"
	crono
		name = "Chrono"
		icon_state = "hair_toriyama"

	vegeta
		name = "Vegeta"
		icon_state = "hair_toriyama2"

	cia
		name = "CIA"
		icon_state = "hair_cia"

	mulder
		name = "Mulder"
		icon_state = "hair_mulder"

	scully
		name = "Scully"
		icon_state = "hair_scully"

	nitori
		name = "Nitori"
		icon_state = "hair_nitori"

	joestar
		name = "Joestar"
		icon_state = "hair_joestar"

	volaju
		name = "Volaju"
		icon_state = "hair_volaju"

	eighties
		name = "80's"
		icon_state = "hair_80s"

	nia
		name = "Nia"
		icon_state = "hair_nia"

	unkept
		name = "Unkept"
		icon_state = "hair_unkept"

	modern
		name = "Modern"
		hair_type = HAIR_LONG
		icon_state = "hair_modern"

	bald
		name = "Bald"
		hair_type = HAIR_BALD
		icon_state = "bald"

	longeralt2
		name = "Long Hair Alt 2"
		icon_state = "hair_longeralt2"

	shortbangs
		name = "Short Bangs"
		icon_state = "hair_shortbangs"

	halfshaved
		name = "Half-Shaved Emo"
		icon_state = "hair_halfshaved"

	bun
		name = "Casual Bun"
		icon_state = "hair_bun"

	doublebun
		name = "Double-Bun"
		icon_state = "hair_doublebun"

	oxton
		name = "Oxton"
		icon_state = "hair_oxton"

	lowfade
		name = "Low Fade"
		icon_state = "hair_lowfade"
		gender = MALE

	medfade
		name = "Medium Fade"
		icon_state = "hair_medfade"

	highfade
		name = "High Fade"
		icon_state = "hair_highfade"
		gender = MALE

	baldfade
		name = "Balding Fade"
		icon_state = "hair_baldfade"
		gender = MALE

	nofade
		name = "Regulation Cut"
		icon_state = "hair_nofade"
		gender = MALE

	trimflat
		name = "Trimmed Flat Top"
		icon_state = "hair_trimflat"
		gender = MALE

	trimmed
		name = "Trimmed"
		icon_state = "hair_trimmed"
		gender = MALE

	tightbun
		name = "Tight Bun"
		icon_state = "hair_tightbun"
		gender = FEMALE

	coffeehouse
		name = "Coffee House Cut"
		icon_state = "hair_coffeehouse"
		gender = MALE

	undercut1
		name = "Undercut"
		icon_state = "hair_undercut1"
		gender = MALE

	undercut2
		name = "Undercut Swept Right"
		icon_state = "hair_undercut2"
		gender = MALE

	undercut3
		name = "Undercut Swept Left"
		icon_state = "hair_undercut3"
		gender = MALE

	partfade
		name = "Parted Fade"
		icon_state = "hair_shavedpart"
		gender = MALE

	hightight
		name = "High and Tight"
		icon_state = "hair_hightight"

	rowbun
		name = "Row Bun"
		icon_state = "hair_rowbun"

	rowdualbraid
		name = "Row Dual Braid"
		icon_state = "hair_rowdualtail"

	rowbraid
		name = "Row Braid"
		icon_state = "hair_rowbraid"

	regulationmohawk
		name = "Regulation Mohawk"
		icon_state = "hair_shavedmohawk"

	topknot
		name = "Topknot"
		icon_state = "hair_topknot"

	ronin
		name = "Ronin"
		icon_state = "hair_ronin"

	bowlcut2
		name = "Bowl2"
		icon_state = "hair_bowlcut2"

	thinning
		name = "Thinning"
		icon_state = "hair_thinning"

	thinningfront
		name = "Thinning Front"
		icon_state = "hair_thinningfront"

	thinningback
		name = "Thinning Back"
		icon_state = "hair_thinningrear"

	manbun
		name = "Manbun"
		icon_state = "hair_manbun"

	/*shy
		name = "Shy"
		hair_type = HAIR_LONG
		icon_state = "hair_shy"*/

	jade
		name = "Jade"
		hair_type = HAIR_LONG
		icon_state = "hair_jade"

	country
		name = "Country"
		hair_type = HAIR_LONG
		icon_state = "hair_country"

	rosa
		name = "Rosa"
		hair_type = HAIR_LONG
		icon_state = "hair_rosa"

	dave
		name = "Dave"
		icon_state = "hair_dave"

	mohawkunshaven
		name = "Unshaven Mohawk"
		icon_state = "hair_unshaven_mohawk"
/*
	undercut4
		name = "Regulation Undercut"
		icon_state = "hair_undercut4"
*/
/*
	slick
		name = "Slick"
		icon_state = "hair_slick"
*/
	messyhair
		name = "All Up"
		icon_state = "hair_messyhair"

	averagejoe
		name = "Average Joe"
		icon_state = "hair_averagejoe"

	amazon
		name = "Amazon"
		icon_state = "hair_amazon"

	straightlong
		name = "Straight Long"
		icon_state = "hair_straightlong"

	marysue
		name = "Mary Sue"
		icon_state = "hair_marysue"

	sideundercut
		name = "Side Undercut"
		icon_state = "hair_sideundercut"

	donutbun
		name = "Donut Bun"
		icon_state = "hair_donutbun"

	sweepshave
		name = "Sweep Shave"
		icon_state = "hair_sweepshave"

	beachwave
		name = "Beach Waves"
		icon_state = "hair_beachwave"

	celebcurls
		name = "Celeb Curls"
		icon_state = "hair_celebcurls"

	jessica
		name = "Jessica"
		icon_state = "hair_jessica"

	proper
		name = "Proper"
		icon_state = "hair_proper"

	newyou
		name = "New You"
		icon_state = "hair_newyou"

	himeup
		name = "Hime Updo"
		icon_state = "hair_himeup"

	antenna
		name = "Antenna"
		icon_state = "hair_antenna"

	sidetail
		name = "Side Pony"
		icon_state = "hair_sidetail"

	sidetail2
		name = "Side Pony 2"
		icon_state = "hair_sidetail2"

	front_braid
		name = "Braided front"
		icon_state = "hair_braidfront"

	protagonist
		name = "Slightly Long"
		icon_state = "hair_protagonist"

	lowbraid
		name = "Low Braid"
		icon_state = "hair_hbraid"

	braidtail
		name = "Braided Tail"
		icon_state = "hair_braidtail"

	keanu
		name = "Keanu Hair"
		icon_state = "hair_keanu"

	business
		name = "Business Hair"
		icon_state = "hair_business"

	business2
		name = "Business Hair 2"
		icon_state = "hair_business2"

	business3
		name = "Business Hair 3"
		icon_state = "hair_business3"

	business4
		name = "Business Hair 4"
		icon_state = "hair_business4"

	bunhead
		name = "Bun Head "
		icon_state = "hair_bunhead"

	pixie
		name = "Pixie Cut"
		icon_state = "hair_pixie"

	sidepartlongalt
		name = "Long Side Part"
		icon_state = "hair_longsidepart"

	miles
		name = "Miles Hair"
		icon_state = "hair_miles"

	vivi
		name = "Vivi"
		icon_state = "hair_vivi"

	judge
		name = "Judge"
		icon_state = "hair_judge"

	mia
		name = "Mia"
		icon_state = "hair_mia"

	mialong
		name = "Mia Long"
		icon_state = "hair_mialong"

	longbraid
		name = "Long Braid"
		icon_state = "hair_longbraid"

	longbraidalt
		name = "Long Braid Alt"
		icon_state = "hair_braidalt"

	longundercut
		name = "Long Undercut"
		icon_state = "hair_undercutlong"

	emoright
		name = "Medium Emo Cut"
		icon_state = "hair_emoright"

	aradia
		name = "Aradia"
		icon_state = "hair_aradia"

	dirk
		name = "Dirk"
		icon_state = "hair_dirk"

	equius
		name = "Equius"
		icon_state = "hair_equius"

	feferi
		name = "Feferi"
		icon_state = "hair_feferi"

	gamzee
		name = "Gamzee"
		icon_state = "hair_gamzee"

	kanaya
		name = "Kanaya"
		icon_state = "hair_kanaya"

	nepeta
		name = "Nepeta"
		icon_state = "hair_nepeta"

	rose
		name = "Rose"
		icon_state = "hair_rose"

	roxy
		name = "Roxy"
		icon_state = "hair_roxy"

	terezi
		name = "Terezi"
		icon_state = "hair_terezi"

	vriska
		name = "Vriska"
		icon_state = "hair_vriska"

	elize
		name = "Elize"
		icon_state = "hair_elize"

	flipped
		name = "Flipped"
		icon_state = "hair_flipped"

	angelique
		name = "Angelique"
		icon_state = "hair_angelique"

	darcy
		name = "Darcy"
		icon_state = "hair_darcy"

	antonio
		name = "Antonio"
		icon_state = "hair_antonio"

	bigcurls
		name = "Big Curls"
		icon_state = "hair_bigcurls"

	sweptfringe
		name = "Swept fringe"
		icon_state = "hair_sweptfringe"

	dreadslong
		name = "Dreads Long"
		icon_state = "hair_dreadslong"

	highponytail
		name = "High Ponytail"
		icon_state = "hair_highponytail"

	cornbun
		name = "Cornbun"
		icon_state = "hair_cornbun"

	jeanponytail
		name = "Jean Ponytail"
		icon_state = "hair_jeanponytail"

	shouldersweep
		name = "Shoulder Sweep"
		icon_state = "hair_shouldersweep"

	afropuffdouble
		name = "Afropuff Double"
		icon_state = "hair_afropuffdouble"

	afropuffleft
		name = "Afropuff Left"
		icon_state = "hair_afropuffleft"

	afropuffright
		name = "Afropuff Right"
		icon_state = "hair_afropuffright"

	suave
		name = "Suave"
		icon_state = "hair_suave"

	suavetwo
		name = "Suave 2"
		icon_state = "hair_suave2"

	jane
		name = "Jane"
		icon_state = "hair_jane"

	rockstarcurls
		name = "Rockstar Curls"
		icon_state = "hair_rockstarcurls"

	band
		name = "Band"
		icon_state = "hair_band"

	bieber
		name = "Bieber"
		icon_state = "hair_bieb"

	fabio
		name = "Fabio"
		icon_state = "hair_fabio"

	froofy_long
		name = "Froofy Long"
		icon_state = "hair_froofy_long"

	glammetal
		name = "Glam Metal Long"
		icon_state = "hair_glammetal"

	midb
		name = "Mid-length bob"
		icon_state = "hair_midb"

	halfshaved
		name = "Half shaved"
		icon_state = "hair_halfshavedL"

	longbraid
		name = "Long braid"
		icon_state = "hair_longbraid"

	rockandroll
		name = "Rock and roll"
		icon_state = "hair_rockandroll"

	shortflip
		name = "Short flip"
		icon_state = "hair_shortflip"

/*
///////////////////////////////////
/  =---------------------------=  /
/  == Facial Hair Definitions ==  /
/  =---------------------------=  /
///////////////////////////////////
*/

/datum/sprite_accessory/facial_hair
	species_allowed = list(SPECIES_HUMAN,SPECIES_PROMETHEAN,SPECIES_HUMAN_VATBORN)


	icon = 'icons/mob/Human_face.dmi'

	shaved
		name = "Shaved"
		icon_state = "bald"
		gender = NEUTER
		species_allowed = list(SPECIES_HUMAN,SPECIES_HUMAN_CHILD,SPECIES_HUMAN_TEEN,SPECIES_HUMAN_VATBORN,SPECIES_UNATHI,SPECIES_TAJ,SPECIES_SKRELL, "Machine", SPECIES_TESHARI, SPECIES_TESHARI,SPECIES_PROMETHEAN)

	watson
		name = "Watson Mustache"
		icon_state = "facial_watson"

	hogan
		name = "Hulk Hogan Mustache"
		icon_state = "facial_hogan" //-Neek

	vandyke
		name = "Van Dyke Mustache"
		icon_state = "facial_vandyke"

	chaplin
		name = "Square Mustache"
		icon_state = "facial_chaplin"

	selleck
		name = "Selleck Mustache"
		icon_state = "facial_selleck"

	neckbeard
		name = "Neckbeard"
		icon_state = "facial_neckbeard"

	fullbeard
		name = "Full Beard"
		icon_state = "facial_fullbeard"

	longbeard
		name = "Long Beard"
		icon_state = "facial_longbeard"

	vlongbeard
		name = "Very Long Beard"
		icon_state = "facial_wise"

	elvis
		name = "Elvis Sideburns"
		icon_state = "facial_elvis"

	abe
		name = "Abraham Lincoln Beard"
		icon_state = "facial_abe"

	chinstrap
		name = "Chinstrap"
		icon_state = "facial_chin"

	hip
		name = "Hipster Beard"
		icon_state = "facial_hip"

	gt
		name = "Goatee"
		icon_state = "facial_gt"

	jensen
		name = "Adam Jensen Beard"
		icon_state = "facial_jensen"

	volaju
		name = "Volaju"
		icon_state = "facial_volaju"

	dwarf
		name = "Dwarf Beard"
		icon_state = "facial_dwarf"

	threeOclock
		name = "3 O'clock Shadow"
		icon_state = "facial_3oclock"

	threeOclockstache
		name = "3 O'clock Shadow and Moustache"
		icon_state = "facial_3oclockmoustache"

	fiveOclock
		name = "5 O'clock Shadow"
		icon_state = "facial_5oclock"

	fiveOclockstache
		name = "5 O'clock Shadow and Moustache"
		icon_state = "facial_5oclockmoustache"

	sevenOclock
		name = "7 O'clock Shadow"
		icon_state = "facial_7oclock"

	sevenOclockstache
		name = "7 O'clock Shadow and Moustache"
		icon_state = "facial_7oclockmoustache"

	mutton
		name = "Mutton Chops"
		icon_state = "facial_mutton"

	muttonstache
		name = "Mutton Chops and Moustache"
		icon_state = "facial_muttonmus"

	walrus
		name = "Walrus Moustache"
		icon_state = "facial_walrus"

	croppedbeard
		name = "Full Cropped Beard"
		icon_state = "facial_croppedfullbeard"

	chinless
		name = "Chinless Beard"
		icon_state = "facial_chinlessbeard"

	tribeard
		name = "Tribeard"
		icon_state = "facial_tribeard"

	moonshiner
		name = "Moonshiner"
		icon_state = "facial_moonshiner"

	martial
		name = "Martial Artist"
		icon_state = "facial_martialartist"
/*
///////////////////////////////////
/  =---------------------------=  /
/  == Alien Style Definitions ==  /
/  =---------------------------=  /
///////////////////////////////////
*/

/datum/sprite_accessory/hair
	una_spines_long
		name = "Long Unathi Spines"
		icon_state = "soghun_longspines"
		species_allowed = list(SPECIES_UNATHI)

	una_spines_short
		name = "Short Unathi Spines"
		icon_state = "soghun_shortspines"
		species_allowed = list(SPECIES_UNATHI)

	una_frills_long
		name = "Long Unathi Frills"
		icon_state = "soghun_longfrills"
		species_allowed = list(SPECIES_UNATHI)

	una_frills_short
		name = "Short Unathi Frills"
		icon_state = "soghun_shortfrills"
		species_allowed = list(SPECIES_UNATHI)

	una_horns
		name = "Unathi Horns"
		icon_state = "soghun_horns"
		species_allowed = list(SPECIES_UNATHI)

	una_bighorns
		name = "Unathi Big Horns"
		icon_state = "unathi_bighorn"
		species_allowed = list(SPECIES_UNATHI)

	una_smallhorns
		name = "Unathi Small Horns"
		icon_state = "unathi_smallhorn"
		species_allowed = list(SPECIES_UNATHI)

	una_ramhorns
		name = "Unathi Ram Horns"
		icon_state = "unathi_ramhorn"
		species_allowed = list(SPECIES_UNATHI)

	una_sidefrills
		name = "Unathi Side Frills"
		icon_state = "unathi_sidefrills"
		species_allowed = list(SPECIES_UNATHI)

//Skrell 'hairstyles'
	skr_tentacle_veryshort
		name = "Skrell Very Short Tentacles"
		icon_state = "skrell_hair_veryshort"
		species_allowed = list(SPECIES_SKRELL)
		gender = MALE

	skr_tentacle_short
		name = "Skrell Short Tentacles"
		icon_state = "skrell_hair_short"
		species_allowed = list(SPECIES_SKRELL)

	skr_tentacle_average
		name = "Skrell Average Tentacles"
		icon_state = "skrell_hair_average"
		species_allowed = list(SPECIES_SKRELL)

	skr_tentacle_verylong
		name = "Skrell Long Tentacles"
		icon_state = "skrell_hair_verylong"
		species_allowed = list(SPECIES_SKRELL)
		gender = FEMALE

//Tajaran hairstyles
	taj_ears
		name = "Tajaran Ears"
		icon_state = "ears_plain"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_clean
		name = "Tajaran Clean"
		icon_state = "hair_clean"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_bangs
		name = "Tajaran Bangs"
		icon_state = "hair_bangs"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_braid
		name = "Tajaran Braid"
		icon_state = "hair_tbraid"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_shaggy
		name = "Tajaran Shaggy"
		icon_state = "hair_shaggy"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_mohawk
		name = "Tajaran Mohawk"
		icon_state = "hair_mohawk"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_plait
		name = "Tajaran Plait"
		icon_state = "hair_plait"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_straight
		name = "Tajaran Straight"
		icon_state = "hair_straight"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_long
		name = "Tajaran Long"
		icon_state = "hair_long"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_rattail
		name = "Tajaran Rat Tail"
		icon_state = "hair_rattail"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_spiky
		name = "Tajaran Spiky"
		icon_state = "hair_tajspiky"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_messy
		name = "Tajaran Messy"
		icon_state = "hair_messy"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_curls
		name = "Tajaran Curly"
		icon_state = "hair_curly"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_wife
		name = "Tajaran Housewife"
		icon_state = "hair_wife"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_victory
		name = "Tajaran Victory Curls"
		icon_state = "hair_victory"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_bob
		name = "Tajaran Bob"
		icon_state = "hair_tbob"
		species_allowed = list(SPECIES_TAJ)

	taj_ears_fingercurl
		name = "Tajaran Finger Curls"
		icon_state = "hair_fingerwave"
		species_allowed = list(SPECIES_TAJ)

//Teshari things
	teshari
		name = "Teshari Default"
		icon_state = "teshari_default"
		species_allowed = list(SPECIES_TESHARI)

	teshari_altdefault
		name = "Teshari Alt. Default"
		icon_state = "teshari_ears"
		species_allowed = list(SPECIES_TESHARI)

	teshari_tight
		name = "Teshari Tight"
		icon_state = "teshari_tight"
		species_allowed = list(SPECIES_TESHARI)

	teshari_excited
		name = "Teshari Spiky"
		icon_state = "teshari_spiky"
		species_allowed = list(SPECIES_TESHARI)

	teshari_spike
		name = "Teshari Spike"
		icon_state = "teshari_spike"
		species_allowed = list(SPECIES_TESHARI)

	teshari_long
		name = "Teshari Overgrown"
		icon_state = "teshari_long"
		species_allowed = list(SPECIES_TESHARI)

	teshari_burst
		name = "Teshari Starburst"
		icon_state = "teshari_burst"
		species_allowed = list(SPECIES_TESHARI)

	teshari_shortburst
		name = "Teshari Short Starburst"
		icon_state = "teshari_burst_short"
		species_allowed = list(SPECIES_TESHARI)

	teshari_mohawk
		name = "Teshari Mohawk"
		icon_state = "teshari_mohawk"
		species_allowed = list(SPECIES_TESHARI)

	teshari_pointy
		name = "Teshari Pointy"
		icon_state = "teshari_pointy"
		species_allowed = list(SPECIES_TESHARI)

	teshari_upright
		name = "Teshari Upright"
		icon_state = "teshari_upright"
		species_allowed = list(SPECIES_TESHARI)

	teshari_mane
		name = "Teshari Mane"
		icon_state = "teshari_mane"
		species_allowed = list(SPECIES_TESHARI)

	teshari_droopy
		name = "Teshari Droopy"
		icon_state = "teshari_droopy"
		species_allowed = list(SPECIES_TESHARI)

	teshari_mushroom
		name = "Teshari Mushroom"
		icon_state = "teshari_mushroom"
		species_allowed = list(SPECIES_TESHARI)

// Vox things
	vox_braid_long
		name = "Long Vox braid"
		icon_state = "vox_longbraid"
		species_allowed = list(SPECIES_VOX)

	vox_braid_short
		name = "Short Vox Braid"
		icon_state = "vox_shortbraid"
		species_allowed = list(SPECIES_VOX)

	vox_quills_short
		name = "Short Vox Quills"
		icon_state = "vox_shortquills"
		species_allowed = list(SPECIES_VOX)

	vox_quills_kingly
		name = "Kingly Vox Quills"
		icon_state = "vox_kingly"
		species_allowed = list(SPECIES_VOX)

	vox_quills_mohawk
		name = "Quill Mohawk"
		icon_state = "vox_mohawk"
		species_allowed = list(SPECIES_VOX)

/datum/sprite_accessory/facial_hair

	taj_sideburns
		name = "Tajaran Sideburns"
		icon_state = "facial_sideburns"
		species_allowed = list(SPECIES_TAJ)

	taj_mutton
		name = "Tajaran Mutton"
		icon_state = "facial_mutton"
		species_allowed = list(SPECIES_TAJ)

	taj_pencilstache
		name = "Tajaran Pencilstache"
		icon_state = "facial_pencilstache"
		species_allowed = list(SPECIES_TAJ)

	taj_moustache
		name = "Tajaran Moustache"
		icon_state = "facial_moustache"
		species_allowed = list(SPECIES_TAJ)

	taj_goatee
		name = "Tajaran Goatee"
		icon_state = "facial_goatee"
		species_allowed = list(SPECIES_TAJ)

	taj_smallstache
		name = "Tajaran Smallsatche"
		icon_state = "facial_smallstache"
		species_allowed = list(SPECIES_TAJ)

//unathi horn beards and the like

	una_chinhorn
		name = "Unathi Chin Horn"
		icon_state = "facial_chinhorns"
		species_allowed = list(SPECIES_UNATHI)

	una_hornadorns
		name = "Unathi Horn Adorns"
		icon_state = "facial_hornadorns"
		species_allowed = list(SPECIES_UNATHI)

	una_spinespikes
		name = "Unathi Spine Spikes"
		icon_state = "facial_spikes"
		species_allowed = list(SPECIES_UNATHI)

	una_dorsalfrill
		name = "Unathi Dorsal Frill"
		icon_state = "facial_dorsalfrill"
		species_allowed = list(SPECIES_UNATHI)


//Teshari things
	teshari_beard
		name = "Teshari Beard"
		icon_state = "teshari_chin"
		species_allowed = list(SPECIES_TESHARI)
		gender = NEUTER

	teshari_scraggly
		name = "Teshari Scraggly"
		icon_state = "teshari_scraggly"
		species_allowed = list(SPECIES_TESHARI)
		gender = NEUTER

	teshari_chops
		name = "Teshari Chops"
		icon_state = "teshari_gap"
		species_allowed = list(SPECIES_TESHARI)
		gender = NEUTER

/*
////////////////////////////
/  =--------------------=  /
/  ==  Body Markings   ==  /
/  =--------------------=  /
////////////////////////////
*/
/datum/sprite_accessory/marking
	icon = 'icons/mob/human_races/markings.dmi'
	do_colouration = 1 //Almost all of them have it, COLOR_ADD

	//Empty list is unrestricted. Should only restrict the ones that make NO SENSE on other species,
	//like Tajaran inner-ear coloring overlay stuff.
	species_allowed = list()

	var/body_parts = list() //A list of bodyparts this covers, in organ_tag defines
	//Reminder: BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_TORSO,BP_GROIN,BP_HEAD

	taj_paw_socks
		name = "Socks Coloration (Taj)"
		icon_state = "taj_pawsocks"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND)
		species_allowed = list(SPECIES_TAJ)

	una_paw_socks
		name = "Socks Coloration (Una)"
		icon_state = "una_pawsocks"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND)
		species_allowed = list(SPECIES_UNATHI)

	paw_socks
		name = "Socks Coloration (Generic)"
		icon_state = "pawsocks"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND)
		species_allowed = list(SPECIES_TAJ, SPECIES_UNATHI)

	paw_socks_belly
		name = "Socks,Belly Coloration (Generic)"
		icon_state = "pawsocksbelly"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_GROIN,BP_TORSO)
		species_allowed = list(SPECIES_TAJ, SPECIES_UNATHI)

	belly_hands_feet
		name = "Hands,Feet,Belly Color (Minor)"
		icon_state = "bellyhandsfeetsmall"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_GROIN,BP_TORSO)
		species_allowed = list(SPECIES_TAJ, SPECIES_UNATHI)

	hands_feet_belly_full
		name = "Hands,Feet,Belly Color (Major)"
		icon_state = "bellyhandsfeet"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_GROIN,BP_TORSO)
		species_allowed = list(SPECIES_TAJ, SPECIES_UNATHI)

	hands_feet_belly_full_female
		name = "Hands,Feet,Belly Color (Major, Female)"
		icon_state = "bellyhandsfeet_female"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_GROIN,BP_TORSO)
		species_allowed = list(SPECIES_TAJ)

	patches
		name = "Color Patches"
		icon_state = "patches"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_TORSO,BP_GROIN)
		species_allowed = list(SPECIES_TAJ)

	patchesface
		name = "Color Patches (Face)"
		icon_state = "patchesface"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_TAJ)

	tiger_stripes
		name = "Tiger Stripes"
		icon_state = "tiger"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_TORSO,BP_GROIN)
		species_allowed = list(SPECIES_TAJ) //There's a tattoo for non-cats

	//Taj specific stuff
	taj_belly
		name = "Belly Fur (Taj)"
		icon_state = "taj_belly"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_TAJ)

	taj_bellyfull
		name = "Belly Fur Wide (Taj)"
		icon_state = "taj_bellyfull"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_TAJ)

	taj_earsout
		name = "Outer Ear (Taj)"
		icon_state = "taj_earsout"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_TAJ)

	taj_earsin
		name = "Inner Ear (Taj)"
		icon_state = "taj_earsin"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_TAJ)

	taj_nose
		name = "Nose Color (Taj)"
		icon_state = "taj_nose"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_TAJ)

	taj_crest
		name = "Chest Fur Crest (Taj)"
		icon_state = "taj_crest"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_TAJ)

	taj_muzzle
		name = "Muzzle Color (Taj)"
		icon_state = "taj_muzzle"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_TAJ)

	taj_face
		name = "Cheeks Color (Taj)"
		icon_state = "taj_face"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_TAJ)

	taj_all
		name = "All Taj Head (Taj)"
		icon_state = "taj_all"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_TAJ)

	//Una specific stuff
	una_face
		name = "Face Color (Una)"
		icon_state = "una_face"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_UNATHI)

	una_facelow
		name = "Face Color Low (Una)"
		icon_state = "una_facelow"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_UNATHI)

	una_scutes
		name = "Scutes (Una)"
		icon_state = "una_scutes"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_UNATHI)

// Human Body Markings //

	aug_backports
		name = "Augment (Backports, Back)"
		icon_state = "aug_backports"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		diode
			name = "Augment (Backports Diode, Back)"
			icon_state = "aug_backportsdiode"

	aug_backportswide
		name = "Augment (Backports Wide, Back)"
		icon_state = "aug_backportswide"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		diode
			name = "Augment (Backports Wide Diode, Back)"
			icon_state = "aug_backportswidediode"

	aug_headcase
		name = "Augment (Headcase, Head)"
		icon_state = "aug_headcase"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	aug_headcase_light
		name = "Augment (Headcase Light, Head)"
		icon_state = "aug_headcaselight"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

/* This one simply refuses to appear in the list. I don't know why. I've just spent 5 hours trying EVERYTHING to fix this ONE marking. I give up.
If you're reading this and have any clue on how to fix this. Please. Be my guest. I can't do this anymore. I can't feel my hands. - Flag */
	aug_headport
		name = "Augment (Headport, Head)"
		icon_state = "aug_headport"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		diode //This one works though. I don't know why. I DON'T KNOW WHYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY. - Flag
		name = "Augment (Headport Diode, Head)"
		icon_state = "aug_headplugdiode"

	aug_lowerjaw
		name = "Augment (Lower Jaw, Head)"
		icon_state = "aug_lowerjaw"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	aug_scalpports
		name = "Augment (Scalp Ports)"
		icon_state = "aug_scalpports"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		vertex_left
			name = "Augment (Scalp Port, Vertex Left)"
			icon_state = "aug_vertexport_l"

		vertex_right
			name = "Augment (Scalp Port, Vertex Right)"
			icon_state = "aug_vertexport_r"

		occipital_left
			name = "Augment (Scalp Port, Occipital Left)"
			icon_state = "aug_occipitalport_l"

		occipital_right
			name = "Augment (Scalp Port, Occipital Right)"
			icon_state = "aug_occipitalport_r"

	aug_scalpportsdiode
		name = "Augment (Scalp Ports Diode)"
		icon_state = "aug_scalpportsdiode"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		vertex_left
			name = "Augment (Scalp Port Diode, Vertex Left)"
			icon_state = "aug_vertexportdiode_l"

		vertex_right
			name = "Augment (Scalp Port Diode, Vertex Right)"
			icon_state = "aug_vertexportdiode_r"

		occipital_left
			name = "Augment (Scalp Port Diode, Occipital Left)"
			icon_state = "aug_occipitalportdiode_l"

		occipital_right
			name = "Augment (Scalp Port Diode, Occipital Right)"
			icon_state = "aug_occipitalportdiode_r"

	aug_backside_left
		name = "Augment (Backside Left, Head)"
		icon_state = "aug_backside_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		side_diode
			name = "Augment (Backside Left Diode, Head)"
			icon_state = "aug_sidediode_l"

	aug_backside_right
		name = "Augment (Backside Right, Head)"
		icon_state = "aug_backside_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		side_diode
			name = "Augment (Backside Right Diode, Head)"
			icon_state = "aug_sidediode_r"

	aug_side_deunan_left
		name = "Augment (Deunan, Side Left)"
		icon_state = "aug_sidedeunan_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	aug_side_deunan_right
		name = "Augment (Deunan, Side Right)"
		icon_state = "aug_sidedeunan_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	aug_side_kuze_left
		name = "Augment (Kuze, Side Left)"
		icon_state = "aug_sidekuze_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		side_diode
			name = "Augment (Kuze Diode, Side Left)"
			icon_state = "aug_sidekuzediode_l"

	aug_side_kuze_right
		name = "Augment (Kuze, Side Right)"
		icon_state = "aug_sidekuze_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		side_diode
			name = "Augment (Kuze Diode, Side Right)"
			icon_state = "aug_sidekuzediode_r"

	aug_side_kinzie_left
		name = "Augment (Kinzie, Side Left)"
		icon_state = "aug_sidekinzie_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	aug_side_kinzie_right
		name = "Augment (Kinzie, Side Right)"
		icon_state = "aug_sidekinzie_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	aug_side_shelly_left
		name = "Augment (Shelly, Side Left)"
		icon_state = "aug_sideshelly_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	aug_side_shelly_right
		name = "Augment (Shelly, Side Right)"
		icon_state = "aug_sideshelly_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	aug_chestports
		name = "Augment (Chest Ports)"
		icon_state = "aug_chestports"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	aug_abdomenports
		name = "Augment (Abdomen Ports)"
		icon_state = "aug_abdomenports"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	backstripe
		name = "Back Stripe"
		icon_state = "backstripe"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		spinemarks
			name = "Back Stripe Marks"
			icon_state = "backstripemarks"

	bands
		name = "Color Bands (All)"
		icon_state = "bands"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_TORSO,BP_GROIN)

		chest
			name = "Color Bands (Torso)"
			body_parts = list(BP_TORSO)

		groin
			name = "Color Bands (Groin)"
			body_parts = list(BP_GROIN)

		left_arm
			name = "Color Bands (Left Arm)"
			body_parts = list(BP_L_ARM)

		right_arm
			name = "Color Bands (Right Arm)"
			body_parts = list(BP_R_ARM)

		left_hand
			name = "Color Bands (Left Hand)"
			body_parts = list(BP_L_HAND)

		right_hand
			name = "Color Bands (Right Hand)"
			body_parts = list(BP_R_HAND)

		left_leg
			name = "Color Bands (Left Leg)"
			body_parts = list(BP_L_LEG)

		right_leg
			name = "Color Bands (Right Leg)"
			body_parts = list(BP_R_LEG)

		left_foot
			name = "Color Bands (Left Foot)"
			body_parts = list(BP_L_FOOT)
			species_allowed = list("Tajara", "Zhan-Khazan Tajara", "M'sai Tajara", "Unathi")

		left_foot_human
			name = "Color Bands (Left Foot)"
			icon_state = "bandshuman"
			body_parts = list(BP_L_FOOT)
			species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		right_foot
			name = "Color Bands (Right Foot)"
			body_parts = list(BP_R_FOOT)
			species_allowed = list("Tajara", "Zhan-Khazan Tajara", "M'sai Tajara", "Unathi")

		right_foot_human
			name = "Color Bands (Right Foot)"
			icon_state = "bandshuman"
			body_parts = list(BP_R_FOOT)
			species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	bandsface_human
		name = "Color Bands (Face)"
		icon_state = "bandshumanface"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	bindi
		name = "Bindi"
		icon_state = "bindi"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	blush
		name = "Blush"
		icon_state= "blush"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	bridge
		name = "Bridge"
		icon_state = "bridge"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	brow_left
		name = "Brow Left"
		icon_state = "brow_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	brow_right
		name = "Brow Right"
		icon_state = "brow_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	cheekspot_left
		name = "Cheek Spot (Left Cheek)"
		icon_state = "cheekspot_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	cheekspot_right
		name = "Cheek Spot (Right Cheek)"
		icon_state = "cheekspot_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	cheshire_left
		name = "Cheshire (Left Cheek)"
		icon_state = "cheshire_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	cheshire_right
		name = "Cheshire (Right Cheek)"
		icon_state = "cheshire_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	crow_left
		name = "Crow Mark (Left Eye)"
		icon_state = "crow_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	crow_right
		name = "Crow Mark (Right Eye)"
		icon_state = "crow_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	ear_left
		name = "Ear Cover (Left)"
		icon_state = "ear_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	ear_right
		name = "Ear Cover (Right)"
		icon_state = "ear_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	eyestripe
		name = "Eye Stripe"
		icon_state = "eyestripe"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	eyecorner_left
		name = "Eye Corner Left"
		icon_state = "eyecorner_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	eyecorner_right
		name = "Eye Corner Right"
		icon_state = "eyecorner_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	eyelash_left
		name = "Eyelash Left"
		icon_state = "eyelash_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	eyelash_right
		name = "Eyelash Right"
		icon_state = "eyelash_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	fullfacepaint
		name = "Full Face Paint"
		icon_state = "fullface"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	lips
		name = "Lips"
		icon_state = "lips"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	lipcorner_left
		name = "Lip Corner Left"
		icon_state = "lipcorner_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	lipcorner_right
		name = "Lip Corner Right"
		icon_state = "lipcorner_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	lowercheek_left
		name = "Lower Cheek Left"
		icon_state = "lowercheek_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	lowercheek_left
		name = "Lower Cheek Right"
		icon_state = "lowercheek_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	neck
		name = "Neck Cover"
		icon_state = "neck"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	neckthick
		name = "Neck Cover (Thick)"
		icon_state = "neckthick"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	nosestripe
		name = "Nose Stripe"
		icon_state = "nosestripe"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	nosetape
		name = "Nose Tape"
		icon_state = "nosetape"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	scratch_abdomen_left
		name = "Scratch, Abdomen Left"
		icon_state = "scratch_abdomen_l"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	scratch_abdomen_right
		name = "Scratch, Abdomen Right"
		icon_state = "scratch_abdomen_r"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	scratch_abdomen_small_left
		name = "Scratch, Abdomen Small Left"
		icon_state = "scratch_abdomensmall_l"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	scratch_abdomen_small_right
		name = "Scratch, Abdomen Small Right"
		icon_state = "scratch_abdomensmall_r"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	scratch_back
		name = "Scratch, Back"
		icon_state = "scratch_back"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	scratch_chest_left
		name = "Scratch, Chest (Left)"
		icon_state = "scratch_chest_l"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	scratch_chest_right
		name = "Scratch, Chest (Right)"
		icon_state = "scratch_chest_r"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	skull_paint
		name = "Skull Paint"
		icon_state = "skull"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_belly
		name = "Tattoo (Belly)"
		icon_state = "tat_belly"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_campbell_leftarm
		name = "Tattoo (Campbell, Left Arm)"
		icon_state = "tat_campbell"
		body_parts = list(BP_L_ARM)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_campbell_rightarm
		name = "Tattoo (Campbell, Right Arm)"
		icon_state = "tat_campbell"
		body_parts= list(BP_R_ARM)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_campbell_leftleg
		name = "Tattoo (Campbell, Left Leg)"
		icon_state = "tat_campbell"
		body_parts= list(BP_L_LEG)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_campbell_rightleg
		name = "Tattoo (Campbell, Right Leg)"
		icon_state = "tat_campbell"
		body_parts= list(BP_R_LEG)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_forrest_left
		name = "Tattoo (Forrest, Left Eye)"
		icon_state = "tat_forrest_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_forrest_right
		name = "Tattoo (Forrest, Right Eye)"
		icon_state = "tat_forrest_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_hive
		name = "Tattoo (Hive, Back)"
		icon_state = "tat_hive"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_heart
		name = "Tattoo (Heart, Chest)"
		icon_state = "tat_heart"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_heart_back
		name = "Tattoo (Heart, Lower Back)"
		icon_state = "tat_heartback"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_hunter_left
		name = "Tattoo (Hunter, Left Eye)"
		icon_state = "tat_hunter_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_hunter_right
		name = "Tattoo (Hunter, Right Eye)"
		icon_state = "tat_hunter_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_jaeger_left
		name = "Tattoo (Jaeger, Left Eye)"
		icon_state = "tat_jaeger_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_jaeger_right
		name = "Tattoo (Jaeger, Right Eye)"
		icon_state = "tat_jaeger_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_kater_left
		name = "Tattoo (Kater, Left Eye)"
		icon_state = "tat_kater_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_kater_right
		name = "Tattoo (Kater, Right Eye)"
		icon_state = "tat_kater_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_lujan_left
		name = "Tattoo (Lujan, Left Eye)"
		icon_state = "tat_lujan_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_lujan_right
		name = "Tattoo (Lujan, Right Eye)"
		icon_state = "tat_lujan_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_montana_left
		name = "Tattoo (Montana, Left Face)"
		icon_state = "tat_montana_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_montana_right
		name = "Tattoo (Montana, Right Face)"
		icon_state = "tat_montana_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_natasha_left
		name = "Tattoo (Natasha, Left Eye)"
		icon_state = "tat_natasha_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_natasha_right
		name = "Tattoo (Natasha, Right Eye)"
		icon_state = "tat_natasha_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_nightling
		name = "Tattoo (Nightling, Back)"
		icon_state = "tat_nightling"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_pawsocks
		name = "Tattoo (Pawsocks, All)"
		icon_state = "pawsocks"
		body_parts = list(BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_GROIN,BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		chest
			name = "Tattoo (Pawsocks, Torso)"
			body_parts = list(BP_TORSO)

		groin
			name = "Tattoo (Pawsocks, Groin)"
			body_parts = list(BP_GROIN)

		left_arm
			name = "Tattoo (Pawsocks, Left Arm)"
			body_parts = list(BP_L_ARM)

		right_arm
			name = "Tattoo (Pawsocks, Right Arm)"
			body_parts = list(BP_R_ARM)

		left_hand
			name = "Tattoo (Pawsocks, Left Hand)"
			body_parts = list(BP_L_HAND)

		right_hand
			name = "Tattoo (Pawsocks, Right Hand)"
			body_parts = list(BP_R_HAND)

		left_leg
			name = "Tattoo (Pawsocks, Left Leg)"
			body_parts = list(BP_L_LEG)

		right_leg
			name = "Tattoo (Pawsocks, Right Leg)"
			body_parts = list(BP_R_LEG)

		left_foot
			name = "Tattoo (Pawsocks, Left Foot)"
			body_parts = list(BP_L_FOOT)

		right_foot
			name = "Tattoo (Pawsocks, Right Foot)"
			body_parts = list(BP_R_FOOT)

	tat_silverburgh_left
		name = "Tattoo (Silverburgh, Left Leg)"
		icon_state = "tat_silverburgh"
		body_parts = list(BP_L_LEG)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_silverburgh_right
		name = "Tattoo (Silverburgh, Right Leg)"
		icon_state = "tat_silverburgh"
		body_parts = list(BP_R_LEG)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_tamoko
		name = "Tattoo (Ta Moko, Face)"
		icon_state = "tat_tamoko"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_tiger
		name = "Tattoo (Tiger Stripes, All)"
		icon_state = "tat_tiger"
		body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BP_GROIN,BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

		chest
			name = "Tattoo (Tiger Stripes, Chest)"
			body_parts = list(BP_TORSO)

		groin
			name = "Tattoo (Tiger Stripes, Groin)"
			body_parts = list(BP_GROIN)

		left_arm
			name = "Tattoo (Tiger Stripes, Left Arm)"
			body_parts = list(BP_L_ARM)

		right_arm
			name = "Tattoo (Tiger Stripes, Right Arm)"
			body_parts = list(BP_R_ARM)

		left_hand
			name = "Tattoo (Tiger Stripes, Left Hand)"
			body_parts = list(BP_L_HAND)

		right_hand
			name = "Tattoo (Tiger Stripes, Right Hand)"
			body_parts = list(BP_R_HAND)

		left_leg
			name = "Tattoo (Tiger Stripes, Left Leg)"
			body_parts = list(BP_L_LEG)

		right_leg
			name = "Tattoo (Tiger Stripes, Right Leg)"
			body_parts = list(BP_R_LEG)

		left_foot
			name = "Tattoo (Tiger Stripes, Left Foot)"
			body_parts = list(BP_L_FOOT)

		right_foot
			name = "Tattoo (Tiger Stripes, Right Foot)"
			body_parts = list(BP_R_FOOT)

	tat_toshi_left
		name = "Tattoo (Toshi, Left Eye)"
		icon_state = "tat_toshi_l"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_toshi_right
		name = "Tattoo (Volgin, Right Eye)"
		icon_state = "tat_toshi_r"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tat_wings_back
		name = "Tattoo (Wings, Lower Back)"
		icon_state = "tat_wingsback"
		body_parts = list(BP_TORSO)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tigerhead
		name = "Tiger Stripes (Head, Minor)"
		icon_state = "tigerhead"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tilaka
		name = "Tilaka"
		icon_state = "tilaka"
		body_parts = list(BP_HEAD)
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

//skin styles - WIP
//going to have to re-integrate this with surgery
//let the icon_state hold an icon preview for now
/datum/sprite_accessory/skin
	icon = 'icons/mob/human_races/r_human.dmi'

	human
		name = "Default human skin"
		icon_state = "default"
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	human_tatt01
		name = "Tatt01 human skin"
		icon_state = "tatt1"
		species_allowed = list(SPECIES_HUMAN, SPECIES_HUMAN_VATBORN, SPECIES_HUMAN_VATBORN_MPL)

	tajaran
		name = "Default tajaran skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_tajaran.dmi'
		species_allowed = list(SPECIES_TAJ)

	unathi
		name = "Default Unathi skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_lizard.dmi'
		species_allowed = list(SPECIES_UNATHI)

	skrell
		name = "Default skrell skin"
		icon_state = "default"
		icon = 'icons/mob/human_races/r_skrell.dmi'
		species_allowed = list(SPECIES_SKRELL)
