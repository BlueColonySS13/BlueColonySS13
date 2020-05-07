/obj/machinery/artifact_analyser
	name = "Anomaly Analyser"
	desc = "Studies the emissions of anomalous materials to discover their uses."
	icon = 'icons/obj/virology.dmi'
	icon_state = "isolator"
	anchored = 1
	density = 1
	var/scan_in_progress = 0
	var/scan_num = 0
	var/obj/scanned_obj
	var/obj/machinery/artifact_scanpad/owned_scanner = null
	var/scan_completion_time = 0
	var/scan_duration = 50
	var/obj/scanned_object
	var/report_num = 0

/obj/machinery/artifact_analyser/initialize()
	. = ..()
	reconnect_scanner()

/obj/machinery/artifact_analyser/proc/reconnect_scanner()
	//connect to a nearby scanner pad
	owned_scanner = locate(/obj/machinery/artifact_scanpad) in get_step(src, dir)
	if(!owned_scanner)
		owned_scanner = locate(/obj/machinery/artifact_scanpad) in orange(1, src)

/obj/machinery/artifact_analyser/attack_hand(var/mob/user as mob)
	src.add_fingerprint(user)
	interact(user)

/obj/machinery/artifact_analyser/interact(mob/user)
	if(stat & (NOPOWER|BROKEN) || get_dist(src, user) > 1)
		user.unset_machine(src)
		return

	var/dat = "<B>Anomalous material analyser</B><BR>"
	dat += "<HR>"
	if(!owned_scanner)
		reconnect_scanner()

	if(!owned_scanner)
		dat += "<b><font color=red>Unable to locate analysis pad.</font></b><br>"
	else if(scan_in_progress)
		dat += "Please wait. Analysis in progress.<br>"
		dat += "<a href='?src=\ref[src];halt_scan=1'>Halt scanning.</a><br>"
	else
		dat += "Scanner is ready.<br>"
		dat += "<a href='?src=\ref[src];begin_scan=1'>Begin scanning.</a><br>"

	dat += "<br>"
	dat += "<hr>"
	dat += "<a href='?src=\ref[src]'>Refresh</a> <a href='?src=\ref[src];close=1'>Close</a>"
	user << browse(dat, "window=artanalyser;size=450x500")
	user.set_machine(src)
	onclose(user, "artanalyser")

/obj/machinery/artifact_analyser/process()
	if(scan_in_progress && world.time > scan_completion_time)
		scan_in_progress = 0
		updateDialog()

		var/results = ""
		if(!owned_scanner)
			reconnect_scanner()
		if(!owned_scanner)
			results = "Error communicating with scanner."
		else if(!scanned_object || scanned_object.loc != owned_scanner.loc)
			results = "Unable to locate scanned object. Ensure it was not moved in the process."
		else
			results = get_scan_info(scanned_object)

		src.visible_message("<b>[name]</b> states, \"Scanning complete.\"")
		var/obj/item/weapon/paper/P = new(src.loc)
		P.name = "[src] report #[++report_num]"
		P.info = "<b>[src] analysis report #[report_num]</b><br>"
		P.info += "<br>"
		P.info += "\icon[scanned_object] [results]"
		P.stamped = list(/obj/item/weapon/stamp)
		P.overlays = list("paper_stamped")

		if(scanned_object && istype(scanned_object, /obj/machinery/artifact))
			var/obj/machinery/artifact/A = scanned_object
			A.anchored = 0
			A.being_used = 0
			scanned_object = null

/obj/machinery/artifact_analyser/Topic(href, href_list)
	if(href_list["begin_scan"])
		if(!owned_scanner)
			reconnect_scanner()
		if(owned_scanner)
			var/artifact_in_use = 0
			for(var/obj/O in owned_scanner.loc)
				if(O == owned_scanner)
					continue
				if(O.invisibility)
					continue
				if(istype(O, /obj/machinery/artifact))
					var/obj/machinery/artifact/A = O
					if(A.being_used)
						artifact_in_use = 1
					else
						A.anchored = 1
						A.being_used = 1

				if(artifact_in_use)
					src.visible_message("<b>[name]</b> states, \"Cannot scan. Too much interference.\"")
				else
					scanned_object = O
					scan_in_progress = 1
					scan_completion_time = world.time + scan_duration
					src.visible_message("<b>[name]</b> states, \"Scanning begun.\"")
				break
			if(!scanned_object)
				src.visible_message("<b>[name]</b> states, \"Unable to isolate scan target.\"")
	if(href_list["halt_scan"])
		scan_in_progress = 0
		src.visible_message("<b>[name]</b> states, \"Scanning halted.\"")

	if(href_list["close"])
		usr.unset_machine(src)
		usr << browse(null, "window=artanalyser")

	..()
	updateDialog()

//hardcoded responses for predefined artifacts
/obj/machinery/artifact_analyser/proc/get_scan_info(var/obj/scanned_obj)
	switch(scanned_obj.type)
		if(/obj/machinery/auto_cloner)
			return "Automated cloning pod - appears to rely on an artificial ecosystem formed by semi-organic nanomachines and the contained liquid.<br>The liquid resembles protoplasmic residue supportive of unicellular organism developmental conditions.<br>The structure is composed of a titanium alloy."
		if(/obj/machinery/power/supermatter)
			return "Superdense phoron clump - appears to have been shaped or hewn, structure is composed of matter aproximately 20 times denser than ordinary refined phoron."
		if(/obj/structure/constructshell)
			return "Tribal idol - subject resembles statues/emblems built by superstitious pre-warp civilisations to honour their gods. Material appears to be a rock/plastcrete composite."
		if(/obj/machinery/giga_drill)
			return "Automated mining drill - structure composed of titanium-carbide alloy, with tip and drill lines edged in an alloy of diamond and phoron."
		if(/obj/structure/cult/pylon)
			return "Tribal pylon - subject resembles statues/emblems built by cargo cult civilisations to honour energy systems from post-warp civilisations."
		if(/obj/machinery/replicator)
			return "Automated construction unit - subject appears to be able to synthesize various objects given a material, some with simple internal circuitry. Method unknown."
		if(/obj/structure/crystal)
			return "Crystal formation - pseudo-organic crystalline matrix, unlikely to have formed naturally. No known technology exists to synthesize this exact composition."
		if(/obj/machinery/artifact/alien_codex)
			return "<b>Object:</b> Data Storage Device/Information Transfer Relay<br>\
					<b>Description:</b> Object utilizes technology similar to that of bluespace information relays, albeit connected to <b>\[REDACTED\]</b>.<br>\
					<b>Composition:</b> The object is composed of a highly energized composite alloy not listed in the database. Additional testing is required to \
					ascertain the material composition of the object.<br>\
					<b>Internal Scan:</b> Failure - The object generates an interference wave that prevents the analyzer from receiving proper imaging \
					of internal mechanisms.<br>\
					<b>Anomalous Activity:</b> Intermittent psionic wavefront detected from the object. Absolute Exclusion Harness recommended for handling \
					of the object.<br>\
					<b>Activation Measures:</b> Increase in psionic activity detected when interfacing with Xenoarch Sapience Emulator. Direct contact with \
					the object by a sapient being may trigger its anomalous effects. Contact with high-frequency energies initiates anomalous activity independent \
					of the primary effect.<br>\
					<b>Calculated Psi Level:</b> 0.377<br>\
					<b>Estimated Risk Level:</b> Medium<br>"
		if(/obj/item/weapon/melee/cursedblade)
			return "<b>Object:</b> Sword<br>\
					<b>Description:</b> Object is a bladed weapon used for combat.<br>\
					<b>Composition:</b> Object is composed of an unknown crystal.<br>\
					<b>Internal Scan:</b> Quantum scan of the object reveals a complex fourth-dimensional lattice capable of storing immense amounts of data. Traces \
					of mnemonic impressions within the lattice suggest the crystal is a codex containing one or more engrams.<br>\
					<b>Anomalous Activity:</b> Object emits low-level psionic energy. Additionally, the object has a complex fourth-dimensional lattice stored \
					within a relatively small mass.<br>\
					<b>Activation Measures:</b> Increase in psionic activity detected when interfacing with Xenoarch Sapience Emulator. Direct contact with \
					the object by a sapient being may trigger its anomalous effects.<br>\
					<b>Calculated Psi Level:</b> 0.4<br>\
					<b>Estimated Risk Level:</b> Low<br>"
		if(/mob/living/carbon/human/precursor)
			return "<b>Object:</b> Precursor<br>\
					<b>Description:</b> Object is a member of an unknown species, codenamed: Precursor.<br>\
					<b>Composition:</b> 18% Oxygen, 14% Carbon, 68% Hydrogen, 2.5% Nitrogen, 0.07% Calcium, 0.35% \
					Phosphorus, 0.06% Potassium, 0.58% Sulfur, 0.56% Sodium, 0.24% Chlorine, 0.07% Magnesium, <1.0% \
					Trace Elements<br>\
					<b>Internal Scan:</b> Object possesses numerous organs with no known human analogues.<br>\
					<b>Anomalous Activity:</b> Object is emitting low-level of psionic energy.<br>\
					<b>Activation Measures:</b> N/A<br>\
					<b>Calculated Psi Level:</b> 0.754<br>\
					<b>Estimated Risk Level:</b> Low<br>"
		if(/mob/living/carbon/human)
			return 	"<b>Object:</b> Homo Sapiens Sapiens<br>\
					<b>Description:</b> Object is a member of homo sapiens sapiens, also known as a human.<br>\
					<b>Composition:</b> 24% Oxygen, 12% Carbon, 62% Hydrogen, 1.1% Nitrogen, 0.22% Calcium, 0.22% \
					Phosphorus, 0.03% Potassium, 0.38% Sulfur, 0.37% Sodium, 0.24% Chlorine, 0.07% Magnesium, <1.0% \
					Trace Elements<br>\
					<b>Internal Scan:</b> Object contains human musculature, organs, and skeleton.<br>\
					<b>Anomalous Activity:</b> No anomalous activity detected.<br>\
					<b>Activation Measures:</b> N/A<br>\
					<b>Calculated Psi Level:</b> 0.998<br>\
					<b>Estimated Risk Level:</b> Low<br>"

		if(/obj/machinery/artifact)
			var/obj/machinery/artifact/A = scanned_obj

			var/out = "<b>Object:</b> [A.name]<br>\
						<b>Composition: </b> Object is composed primarily of [A.composition].<br>\
						<b>Internal Scan:</b> [A.my_effect.getInternalScan()]<br>\
						<b>Anomalous Activity:</b> [A.my_effect.getAnomaly()]<br>\
						<b>Activation Measures:</b> [A.my_effect.getActivation()]<br>\
						<b>Calculated Psi Level:</b> [A.getOmegaLevel()]<br>"

			if(A.secondary_effect && A.secondary_effect.activated)
				out += "<br>Internal scans indicate ongoing secondary activity operating independently from primary systems.<br>\
						<b>Secondary Anomalous Activity:</b> [A.secondary_effect.getAnomaly()]<br>\
						<b>Secondary Activation Measures:</b> [A.secondary_effect.getActivation()]"
			return out
		else
			return "[scanned_obj.name] - mundane application."
