/datum/bounty/bank
	category = CAT_BANK

/datum/bounty/bank/quick_transfer
	name = "International Transfer from Castor"
	author = "Howard Hows"

	description = "Good day! I'd like to transfer %CASHWANTED to my business account, I don't like using the online interfaces for \
	these things. Do not worry, I am paying tax! Thank you for providing this service."

	cash_min = 300
	cash_max = 400

	days_until_expiry = 2

	department_reward = 400
	individual_reward = 10


/datum/bounty/bank/minorloan
	name = "A Minor Business Loan"
	author = "Yates Harrington"

	description = "My enterprise needs an investment loan of %CASHWANTED - this is needed to assist with our stock market value, \
	once we recieve the sum we'll send back you - this is guaranteed."

	cash_wanted = 5000

	days_until_expiry = 2

	department_reward = 5050
	individual_reward = 20
