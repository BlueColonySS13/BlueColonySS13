/obj/machinery/case_database
	name = "\improper Case Database Computer"
  desc = "A large database of legal cases can be accessed through this computer."
	unacidable = 1
	light_range = 4
	light_power = 2
	light_color = "#ebf7fe"  //white blue
	density = 1
	anchored = 1  
	bounds = "64,32"
  
	icon = 'icons/obj/buysell.dmi' // placeholder
	icon_state = "sell" // placeholder
  
	var/req_access = list()
	var/page
	
	var/datum/case/current_case
	var/
  
/obj/machinery/case_database/proc/check_for_access(mob/user)
  if(!req_access) return 1
	var/obj/item/weapon/card/id/I = user.GetIdCard()  
  if(req_access in I.access) return 1
  
  return 0


/obj/machinery/case_database/interact(mob/user)
        var/dat
	
        dat += "<h1>[name]</h1><hr>"
        dat += "Welcome to the [name], this computer database stores cases"
	
        if(!check_for_access())
                dat += "You do not have access to this system. Please ask an administrator for assistance.<br>"
	
	switch(page)
		if(1)
			dat += "Select an option:<br><br>"			 
			dat += "<a href=''>View Ongoing Public Cases</a><br>"
			dat += "<a href=''>Find Case By ID</a><br>"
			dat += "<a href=''>View Case Archive</a><br>"

		if(2)
			dat += "Current Case:"
		 

/datum/case_evidence
	var/name								// name of the item scanned
	var/description								// description copied from the actual item
	var/img									// actual photo taken of the evidence.
	var/list/fingerprints							// fingerprints of the evidence
	var/list/fingerprints_hidden						// same thing, but admin side

/datum/case
	name = "Unnamed Case"
	var/desc = "This is a case which is managed via the evidence computer."
	var/list/recordings = list()						// takes tape recorders for recordings.
	var/list/datum/case_evidence/case_ev = list()

  
