#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract basic info
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
dir=$(echo "$cwd" | sed "s|^$HOME|~|")

# Start building the status line
parts="$dir"

# Add git branch if in a git repo
if cd "$cwd" 2>/dev/null && git rev-parse --git-dir >/dev/null 2>&1; then
    branch=$(git -c core.useBuiltinFSMonitor=false -c core.fsmonitor=false branch --show-current 2>/dev/null)
    [ -n "$branch" ] && parts="$parts $(printf '\033[2m')$branch$(printf '\033[0m')"
fi

# Add Python environment if active
[ -n "$PYENV_VERSION" ] && parts="$parts $(printf '\033[2m')🐍 $PYENV_VERSION$(printf '\033[0m')"
[ -n "$VIRTUAL_ENV" ] && parts="$parts $(printf '\033[2m')🐍 $(basename "$VIRTUAL_ENV")$(printf '\033[0m')"

# Context window progress bar
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

if [ -n "$used_pct" ]; then
    # Round to integer
    used_int=$(printf "%.0f" "$used_pct")
    
    # Determine color and emoji based on usage
    if [ "$used_int" -ge 80 ]; then
        color=$'\033[31m'  # Red
        emoji="🔴"
    elif [ "$used_int" -ge 60 ]; then
        color=$'\033[33m'  # Yellow
        emoji="🟡"
    else
        color=$'\033[32m'  # Green
        emoji="🟢"
    fi
    reset=$'\033[0m'
    dim=$'\033[2m'

    # Create progress bar (20 characters wide)
    bar_width=20
    filled=$((used_int * bar_width / 100))
    empty=$((bar_width - filled))

    bar=""
    for ((i=0; i<filled; i++)); do
        bar="${bar}█"
    done
    for ((i=0; i<empty; i++)); do
        bar="${bar}░"
    done

    # Add context info to status line
    parts="$parts ${dim}${emoji} ${color}${bar}${reset}${dim} ${used_int}%${reset}"
fi

echo "$parts"
