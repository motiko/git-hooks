#!/bin/bash
# .git/hooks/post-checkout
branch=$(git status --short -b | cut -d' ' -f2-)
previous=$(git config user.name)
case $branch in
  personal*)
    git config user.name "Personal Name"
    echo "changed user.name from $previous to Personal Name"
    ;;
  master*)
    git config user.name "Company Name"
    echo "changed user.name from $previous to Company Name"
    ;;
  *)
    echo "Some other branch"
    ;;
esac
