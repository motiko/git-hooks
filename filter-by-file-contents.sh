#!/bin/sh
# .git/hooks/pre-commit
# Go through all the changed files (except for deleted and unmerged)
# Check for changed lines
# Set exit code to 0, will be set to 1 on error.
exit_code=0
# Grep git diff of files to commit
all_files=$(
	git diff --cached --find-copies --find-renames --name-only --diff-filter=ACMRTXBU
)

if [[ -n $all_files ]];
then
	for file in $all_files; do

    stop_pattern=$(
      git diff --cached $file | grep -E "STOP_COMMIT"
    )

		if [[ -n $stop_pattern ]];
		then
			echo
			echo -e "Found illegal commands in \033[1m$file:\033[0m"
			echo -e "\033[1m$stop_pattern\033[0m"
			echo
			# Abort commit
			exit_code=1
		fi

	done
fi



if [ $exit_code==1 ]; then
	echo
	echo -e '\033[1m'"Commit Aborted!"'\033[0m'
	echo
fi
exit $exit_code
