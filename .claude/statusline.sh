#!/usr/bin/env bash

# Claude Code Status Line Script
# Displays model name, 5-hour and 7-day subscription usage with color coding

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
RESET='\033[0m'

# Read JSON from stdin
input=$(cat)

# Extract model display name
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Extract rate limit data
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Helper: colorize a percentage value
colorize_pct() {
  local pct="$1"
  local pct_int
  pct_int=$(printf '%.0f' "$pct")
  if [ "$pct_int" -ge 80 ]; then
    printf "${RED}%s%%${RESET}" "$pct_int"
  elif [ "$pct_int" -ge 50 ]; then
    printf "${YELLOW}%s%%${RESET}" "$pct_int"
  else
    printf "${GREEN}%s%%${RESET}" "$pct_int"
  fi
}


# Extract context window data
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Extract cost and duration data
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')

# Helper: format duration from milliseconds
format_duration() {
  local ms="$1"
  local total_secs=$(( ms / 1000 ))
  local hours=$(( total_secs / 3600 ))
  local mins=$(( (total_secs % 3600) / 60 ))
  local secs=$(( total_secs % 60 ))
  if [ "$hours" -gt 0 ]; then
    printf "%dh%02dm%02ds" "$hours" "$mins" "$secs"
  elif [ "$mins" -gt 0 ]; then
    printf "%dm%02ds" "$mins" "$secs"
  else
    printf "%ds" "$secs"
  fi
}

# Build output parts
parts=()

# Model name
if [ -n "$model" ]; then
  parts+=("$model")
fi

# Context window usage
if [ -n "$ctx_pct" ]; then
  colored=$(colorize_pct "$ctx_pct")
  parts+=("ctx: $colored")
fi

# Session cost
if [ -n "$cost" ]; then
  cost_fmt=$(printf '$%.2f' "$cost")
  parts+=("$cost_fmt")
fi

# Session duration
if [ -n "$duration_ms" ]; then
  dur=$(format_duration "$duration_ms")
  parts+=("$dur")
fi

# 5-hour limit
if [ -n "$five_pct" ]; then
  colored=$(colorize_pct "$five_pct")
  parts+=("5h: $colored")
fi

# 7-day limit
if [ -n "$week_pct" ]; then
  colored=$(colorize_pct "$week_pct")
  parts+=("7d: $colored")
fi

# If no data at all, exit silently
if [ ${#parts[@]} -eq 0 ]; then
  exit 0
fi

# Join parts with " | " separator
output=""
for part in "${parts[@]}"; do
  if [ -z "$output" ]; then
    output="$part"
  else
    output="$output | $part"
  fi
done

printf "%b\n" "$output"

