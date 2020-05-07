GLOBAL_LIST_EMPTY(all_money_accounts)
GLOBAL_LIST_EMPTY(transaction_devices)
GLOBAL_LIST_EMPTY(money_displays)

GLOBAL_LIST_EMPTY(department_cards)

// all departments
GLOBAL_LIST_EMPTY(departments)

GLOBAL_LIST_EMPTY(public_departments)
GLOBAL_LIST_EMPTY(private_departments)
GLOBAL_LIST_EMPTY(external_departments)
GLOBAL_LIST_EMPTY(hidden_departments)

// the department's bank accounts
GLOBAL_LIST_EMPTY(department_accounts)

GLOBAL_LIST_EMPTY(public_department_accounts)
GLOBAL_LIST_EMPTY(private_department_accounts)
GLOBAL_LIST_EMPTY(external_department_accounts)
GLOBAL_LIST_EMPTY(hidden_department_accounts)

GLOBAL_VAR_INIT(num_financial_terminals, 1)
GLOBAL_VAR_INIT(economy_init, 0)

GLOBAL_VAR(current_date_string)
// businesses

GLOBAL_LIST_EMPTY(all_businesses)
GLOBAL_LIST_INIT(business_categories, list( // list of categories businesses can list themselves as
	CAT_ADS,
	CAT_FARM,
	CAT_BANK,
	CAT_LIBRARY,
	CAT_BUILDING,
	CAT_EDU,
	CAT_EMPLOY,
	CAT_ENTERTAINMENT,
	CAT_FOOD,
	CAT_HOSPITALITY,
	CAT_LEGAL,
	CAT_LEISURE,
	CAT_MANUFACTURE,
	CAT_MOTOR,
	CAT_NEWS,
	CAT_HEALTH,
	CAT_RETAIL,
	CAT_JANITOR,
	CAT_SEC,
	CAT_TECH
))

