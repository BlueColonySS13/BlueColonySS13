/datum/computer_file/program/govportal/ntportal
	filename = "ntportal"
	filedesc = "NTPortal"
	extended_desc = "Allows you to view the current laws and regulations."
	nanomodule_path = /datum/nano_module/program/govportal/ntportal
	available_on_ntnet = 0

/datum/nano_module/program/govportal/ntportal
	name = "NTPortal"
	portal_type = PORTAL_HEAD_OFFICE
	admin_edit = TRUE

	available_groupings = list("Government" = list("Assign Cabinet"), \
	"Law and Order" = list("Emergency Procedures", "Contraband and Restricted Materials", "Contraband Control Measures", "Standard Operating Procedures"), \
	"Social Law" = list("Discrimination Policies", "Voting Rights", "Minimum Wages", "Leasehold and Tenancy"), \
	"Economy and Taxes" = list("Spending And Budget", "Public Healthcare Pricing", "Public Legal Pricing", "Permit Pricing", "Social Costs", "Economic Bracket Taxes"), \
	"Communications" = list("Broadcast and Communications"), \
	)