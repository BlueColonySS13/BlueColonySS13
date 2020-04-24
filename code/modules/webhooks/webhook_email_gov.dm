
/decl/webhook/email_gov
	id = WEBHOOK_EMAIL_GOV

// Data expects a "text" field containing the new custom event text.
/decl/webhook/email_gov/get_message(var/list/data)
	. = ..()
	var/desc = "**Incoming Email**"
	if(data && data["reciever"])
		desc += " **To**: [data["reciever"]]\n"
	if(data && data["sender"])
		desc += " **Sender**: [data["sender"]]\n"
	if(data && data["email_title"])
		desc += " **Title**: [data["email_title"]]\n"
	if(data && data["email_content"])
		desc += " **Content**: \n [pencode2webhook(data["email_content"])]"
	desc += "."

	.["embeds"] = list(list(
		"title" = "Incoming Email",
		"description" = desc,
		"color" = COLOR_WEBHOOK_DEFAULT
	))
