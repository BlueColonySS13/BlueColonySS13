/datum/computer_file/program/loc_browser
	filename = "loc_browser"					// File name, as shown in the file browser program.
	filedesc = "LOC Browser"				// User-Friendly name. In this case, we will generate a random name in constructor.
	extended_desc = "A privacy orientated browser that is required to access .leek sites."		// A nice description.
	available_on_ntnet = FALSE					// ... but we want it to be available for download.
	nanomodule_path = /datum/nano_module/nt_explorer/loc	// Path of relevant nano module. The nano module is defined further in the file.

/datum/nano_module/nt_explorer/loc
	name = "LOC Browser"
	access_deepweb = TRUE
