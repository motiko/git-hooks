#!/bin/bash\
# .git/hooks/pre-commit
path_with_pattern=$(git diff --cached --find-copies --find-renames --name-only --diff-filter=ACR | grep "\.bak-mo$")
if [[ -n $path_with_pattern  ]];
then
  for path in $path_with_pattern; do
    folder=$(echo $path | sed 's/\/[^\/]*\.bak-mo$//')
    echo "Found OpenModelica backup folder: $folder"
    git reset HEAD $folder
    echo "Unstaged: $folder"
    rm -rf $folder  # Consider adding some confirmation here (use at your own risk)
    echo "Removed: $folder"
    # or safer option add to .gitignore instead of removing
    # echo $folder >> .gitignore
  done
fi

exit 0
if [[ -n $path_with_pattern  ]];
then
	for path in $path_with_pattern; do
    folder=$(echo $path | sed 's/\/[^\/]*\.bak-mo$//')
    git reset HEAD $folder
    echo $folder
  done
fi
