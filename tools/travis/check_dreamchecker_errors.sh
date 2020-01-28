#!/usr/bin/env bash

function check_dc_error_count {

	#Current number of DreamChecker problems. Reduce it as you fix them
	ERROR_COUNT=56
	
	DIAGNOSTICS=$(grep -oP '(?<=Found )[0-9]+' build_log.txt)
	

    if [[ DIAGNOSTICS -gt ERROR_COUNT ]]; then
		echo "ERROR: DreamChecked problems increased from $ERROR_COUNT to $DIAGNOSTICS"
		exit 1
	fi
}

check_dc_error_count