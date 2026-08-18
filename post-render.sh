#!/usr/bin/env bash
#
# Post-render hook for the default (web) profile.
#
# Goal: don't rebuild every reveal.js slide deck on every incremental
# `quarto preview` re-render. Quarto sets these env vars for post-render:
#   QUARTO_PROJECT_RENDER_ALL   - non-empty on a full-project render
#                                 (a plain `quarto render` and preview's
#                                 initial build), empty on incremental
#                                 single-file preview re-renders.
#   QUARTO_PROJECT_INPUT_FILES  - newline-separated files just rendered.
#
# Behavior:
#   - full render        -> rebuild all slide decks
#   - edited a *-slides  -> rebuild only that deck
#   - edited anything else -> do nothing (skip the slides render entirely)

set -euo pipefail

# Full project render: build every deck.
if [ -n "${QUARTO_PROJECT_RENDER_ALL:-}" ]; then
  quarto render --profile slides
  exit 0
fi

# Incremental render: only rebuild slide files that were actually touched.
slides=()
while IFS= read -r f; do
  case "$f" in
    *-slides.qmd) slides+=("$f") ;;
  esac
done <<< "${QUARTO_PROJECT_INPUT_FILES:-}"

if [ ${#slides[@]} -gt 0 ]; then
  quarto render "${slides[@]}" --profile slides
fi
