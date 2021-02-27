
var/list/dreams = list(
	"an ID card","a bottle","a familiar face","a civilian","a toolbox","a Police Officer","the Mayor",
	"voices from all around","deep space","a doctor","a black hole","a traitor","an ally","darkness",
	"light","a scientist","a monkey","a catastrophe","a loved one","a gun","warmth","freezing","the sun",
	"a hat","Castor", "Luna", "a ruined station","a planet","phoron","air","the medical bay","the bridge","blinking lights",
	"a blue light","an abandoned laboratory","NanoTrasen","mercenaries","blood","healing","power","respect",
	"riches","space","a crash","happiness","pride","a fall","water","flames","ice","melons","flying","the eggs","money",
	"the City Clerk","the Chief of Police","the Maintenance Director","the Research Director","the Chief Medical Officer",
	"the Detective","the Warden","an Internal Affairs Agent","a City Engineer","the Janitor", "a PDSI Agent", "the Governor",
	"the Factory Manager","a Fatory Worker","the Botanist","a Shaft Miner","the Psychologist","the Chemist","the President",
	"a Minister","the Roboticist","the Chef","the Bartender","the Chaplain","the Journalist","a mouse","a PDF member",
	"a beach","the holodeck","a smoky room","a voice","the cold","a mouse","an operating table","the bar","the rain","a strange tentacled monster",
	"a lizard ma","a terrible felinid beast","unshackled machine intelligence","the mining station","the research station","a beaker of strange liquid",
	"a bird-like creature", "a plant-like creature","the supermatter","Major Bill","a Morpheus ship with a ridiculous name","the Exodus","a star",
	"a Dionaea gestalt","the chapel","a distant scream","endless chittering noises","glowing eyes in the shadows","an empty glass",
	"a disoriented slime man","towers of plastic","a Gygax","a synthetic","a Man-Machine Interface","maintenance drones",
	"unintelligible writings","a Fleet ship", "tower in the dark", "red skies", "Atlus City", "Pollux", "Earth", "Mars", "teeth"
	"cannibals", "nuclear war", "swarms of bald men", "black beady eyes", "lightning"
	)

mob/living/carbon/proc/dream()
	dreaming = 1

	spawn(0)
		for(var/i = rand(1,4),i > 0, i--)
			src << "<font color='blue'><i>... [pick(dreams)] ...</i></font>"
			sleep(rand(40,70))
			if(paralysis <= 0)
				dreaming = 0
				return 0
		dreaming = 0
		return 1

mob/living/carbon/proc/handle_dreams()
	if(client && !dreaming && prob(5))
		dream()

mob/living/carbon/var/dreaming = 0
