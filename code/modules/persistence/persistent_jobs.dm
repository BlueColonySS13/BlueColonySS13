/datum/controller/subsystem/jobs/proc/save_job_list_private()
	var/list/private_jobs = list()
	for(var/datum/job/J in occupations)
		private_jobs += J
		J.sanitize_job()

	var/full_path = "data/persistent/privatejobs.sav"
	if(!full_path) return 0
	var/savefile/S = new /savefile(full_path)
	if(!fexists(full_path)) return 0

	S << GLOB.business_ids

	return 1


/datum/controller/subsystem/jobs/proc/load_job_list_private()
	var/full_path = "data/persistent/privatejobs.sav"
	if(!full_path)			return 0
	if(!fexists(full_path)) return 0

	var/savefile/S = new /savefile(full_path)
	if(!S)					return 0

	S >> GLOB.business_ids

	return 1

