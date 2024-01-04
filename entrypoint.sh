#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ] ; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
  git config --global --add safe.directory "${GITHUB_WORKSPACE}" || exit 1
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

MODIFIED_FILES=$(git diff --name-only ${ INPUT_EVENT } ${ INPUT_SHA } | grep -E "\.(liquid|json)$")

echo "$MODIFIED_FILES" | xargs theme-check -o json \
  | reviewdog -efm="%f:%l: %m,%-G%.%#" -name="theme-check" -reporter=github-pr-check

