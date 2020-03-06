
/decl/webhook/email_gov
	id = WEBHOOK_EMAIL_GOV

// Data expects a "text" field containing the new custom event text.
/decl/webhook/email_gov/get_message(var/list/data)
	. = ..()
	.["embeds"] = list(list(
		"title" = "Incoming Email",
		"sender" = "unknown@invalid.nt",
		"reciever" = "you@something.nt",
		"email_title" = "Email Title",
		"email_content" = (data && data["text"]) || "undefined",
		"color" = COLOR_WEBHOOK_DEFAULT
	))
