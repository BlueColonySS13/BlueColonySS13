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
  
/obj/machinery/case_database/proc/check_for_access(mob/user)
  if(!req_access) return 1
	var/obj/item/weapon/card/id/I = user.GetIdCard()  
  if(req_access in I.access) return 1
  
  return 0


/obj/machinery/case_database/interact(mob/user)
        var/dat
        
        dat += "<h1>[name]</h1><hr>"
        
        if(!check_for_access())
                dat += "You do not have access to this confidential system. Please ask an administrator for assistance."
        
        else
                
        


  
