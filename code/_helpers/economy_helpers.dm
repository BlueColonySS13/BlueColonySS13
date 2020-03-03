/proc/cash2text(num, use_symbol = TRUE, use_suffix = TRUE, use_desc = TRUE)	//returns $800USD mil for example.
	var/symbol
	var/suffix
	var/text_desc
	var/multiplier = 1
	var/negative = FALSE

	var/final_num

	if(using_map.currency_symbol && use_symbol)
		symbol = using_map.currency_symbol

	if(using_map.currency_suffix && use_suffix)
		suffix = using_map.currency_suffix

	if(0 > num)
		negative = TRUE
		num = (-1 * (num))

	var/quin = 1000000000000000000

	var/quad = 1000000000000000
	var/quad_end = 999999999999999999

	var/tril = 1000000000000
	var/tril_end = 999999999999999

	var/bil = 1000000000000
	var/bil_end = 999999999999999

	var/mil = 1000000
	var/mil_end = 999999999

	if(use_desc)
		switch(num)

			if(quin to INFINITY)
				text_desc = "quin"
				multiplier = quin

			if(quad to quad_end)
				text_desc = "quad"
				multiplier = quad

			if(tril to tril_end)
				text_desc = "tril"
				multiplier = tril

			if(bil to bil_end)
				text_desc = "bil"
				multiplier = bil

			if(mil to mil_end)
				text_desc = "mil"
				multiplier = mil

	final_num = round(num / multiplier)

	if(negative)
		final_num = "-[final_num]"


	return "[symbol][final_num][suffix][text_desc ? " [text_desc]" : ""]"
	


