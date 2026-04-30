#!/bin/bash
# Monitors memory usage of all nvim processes and their LSP children.
# Usage: ./nvim-mem-monitor.sh [interval_seconds] [duration_minutes]
#   Default: every 60s for 480min (8 hours)
#
# Output: tab-separated log to stdout. Redirect to a file:
#   ./nvim-mem-monitor.sh 60 480 > ~/nvim-mem.log

INTERVAL=${1:-60}
DURATION_MIN=${2:-480}
TOTAL_SECS=$((DURATION_MIN * 60))
ELAPSED=0

echo -e "timestamp\ttype\tpid\trss_kb\tuptime\tcommand"

while [ $ELAPSED -lt $TOTAL_SECS ]; do
	NOW=$(date '+%Y-%m-%d %H:%M:%S')

	# Find all nvim processes (not embedded/child nvim)
	pgrep -x nvim | while read -r NPID; do
		RSS=$(ps -o rss= -p "$NPID" 2>/dev/null | tr -d ' ')
		ETIME=$(ps -o etime= -p "$NPID" 2>/dev/null | tr -d ' ')
		[ -z "$RSS" ] && continue
		echo -e "${NOW}\tnvim\t${NPID}\t${RSS}\t${ETIME}\tnvim"

		# Find LSP/child processes of this nvim
		pgrep -P "$NPID" | while read -r CPID; do
			CRSS=$(ps -o rss= -p "$CPID" 2>/dev/null | tr -d ' ')
			CETIME=$(ps -o etime= -p "$CPID" 2>/dev/null | tr -d ' ')
			CCMD=$(ps -o comm= -p "$CPID" 2>/dev/null)
			[ -z "$CRSS" ] && continue
			echo -e "${NOW}\tchild\t${CPID}\t${CRSS}\t${CETIME}\t${CCMD}"
		done
	done

	sleep "$INTERVAL"
	ELAPSED=$((ELAPSED + INTERVAL))
done
