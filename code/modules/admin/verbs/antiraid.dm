/client/proc/ip_reputation()
	set category = "Server"
	set name = "Toggle IP Rep Checks"

	if(!check_rights(R_ADMIN))
		return

	config.ip_reputation = (!config.ip_reputation)

	log_and_message_admins("[key_name(usr)] has toggled IP reputation checks, it is now [(config.ip_reputation?"on":"off")].")
