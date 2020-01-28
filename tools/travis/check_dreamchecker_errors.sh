#!/usr/bin/env bash

function check_dc_error_count {

	#Current number of DreamChecker problems. Reduce it as you fix them
	ERROR_COUNT=56
	
	tee build_log.log
	DIAGNOSTICS=$(grep -oP '(?<=Found )[0-9]+' build_log.log)
	

    if [[ DIAGNOSTICS -gt ERROR_COUNT ]]
	then
		echo "ERROR: DreamChecker problems increased from $ERROR_COUNT to $DIAGNOSTICS."
		exit 1
	elif [[ DIAGNOSTICS -lt ERROR_COUNT ]]
	then
		echo "ERROR: DreamChecker problems have decreased from $ERROR_COUNT to $DIAGNOSTICS. Update check_dreamchecker_errors.sh"
		exit 1
	else
		echo "SUCCESS: DreamChecker problems remain consistent at $DIAGNOSTICS."
	fi
}

check_dc_error_count