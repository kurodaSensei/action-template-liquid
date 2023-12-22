#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ] ; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
  git config --global --add safe.directory "${GITHUB_WORKSPACE}" || exit 1
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

#MODIFIED_FILES=$(git diff --name-only ${{ github.event.before }} ${{ github.sha }} | grep -E "\.(liquid|json)$")

echo xargs theme-check \
  | reviewdog -f=theme-check -name="theme-check" -reporter=github-pr-check

