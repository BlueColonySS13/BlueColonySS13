
/mob/new_player/proc/JoinAsAntag()
	if(!SSjobs)
		return

	var/dat = JoinAntagData()


	var/datum/browser/popup = new(usr, "joinasantag", "Join As Antag", 350, 430, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(usr, "joinasantag")


/mob/new_player/proc/JoinAntagData()

	var/dat = ""

	if(!config.allow_lobby_antagonists)
		dat += "<center><font color='red'>Joining as an antagonist is currently disabled.</font></center><br>"
		return dat


	var/list/lobby_antagonists = get_lobbyjoin_antagonism()


	if(!LAZYLEN(lobby_antagonists))
		dat += "There are no antagonist types available for joining at the moment, please visit later."
	else
		for(var/datum/antagonist/antag in lobby_antagonists)
			dat += "<a href=''>[antag.role_text]</a><br>"


	return dat