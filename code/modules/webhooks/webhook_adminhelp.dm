
/decl/webhook/adminhelp
	id = WEBHOOK_ADMINHELP

// Data expects a "text" field containing the new custom event text.
/decl/webhook/adminhelp/get_message(var/list/data)
	. = ..()
	.["embeds"] = list(list(
		"sender" = (data && data["sender_name"]) || "No Sender",
		"description" = (data && data["text"]) || "undefined",
		"color" = COLOR_RED
	))