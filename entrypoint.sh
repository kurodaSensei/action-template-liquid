#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ] ; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
  git config --global --add safe.directory "${GITHUB_WORKSPACE}" || exit 1
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

run theme-check -o json \
  | reviewdog -efm="%f:%l: %m,%-G%.%#" -diff="git diff FETCH_HEAD" -name="theme-check" -reporter=github-pr-check
