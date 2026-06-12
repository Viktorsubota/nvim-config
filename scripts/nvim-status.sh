#!/bin/bash
# Shows all running nvim instances with memory and project info.
# RSS = physical memory now. ALLOC = dirty + swapped (total privately allocated).
# Usage: ./nvim-status.sh

get_alloc_mb() {
	vmmap -summary "$1" 2>/dev/null | awk '/^TOTAL/ {
		dirty = $5; swap = $7
		# Parse value with K/M/G suffix to MB
		d = dirty + 0; s = swap + 0
		if (dirty ~ /K/) d = d / 1024
		else if (dirty ~ /G/) d = d * 1024
		if (swap ~ /K/) s = s / 1024
		else if (swap ~ /G/) s = s * 1024
		printf "%.1f", d + s
	}'
}

printf "%-7s %10s %10s %15s  %s\n" "PID" "RSS(MB)" "ALLOC(MB)" "UPTIME" "PROJECT"
printf "%-7s %10s %10s %15s  %s\n" "-------" "----------" "----------" "---------------" "-------"

for pid in $(pgrep -x nvim | sort -u); do
	ppid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
	parent_comm=$(ps -o comm= -p "$ppid" 2>/dev/null)
	echo "$parent_comm" | grep -q nvim && continue

	rss=$(ps -o rss= -p "$pid" 2>/dev/null | tr -d ' ')
	etime=$(ps -o etime= -p "$pid" 2>/dev/null | tr -d ' ')
	cwd=$(lsof -p "$pid" -Fn 2>/dev/null | grep "^n/" | head -1 | sed 's/^n//' | grep -v '\.dylib\|\.so\|/dev/\|/usr/' || echo "?")
	project=$(basename "$cwd")

	rss_mb=$(echo "scale=1; $rss / 1024" | bc)
	alloc_mb=$(get_alloc_mb "$pid")

	printf "%-7s %10s %10s %15s  %s\n" "$pid" "${rss_mb}M" "${alloc_mb:-?}M" "$etime" "$project"

	pgrep -P "$pid" | while read -r cpid; do
		crss=$(ps -o rss= -p "$cpid" 2>/dev/null | tr -d ' ')
		ccmd=$(ps -o comm= -p "$cpid" 2>/dev/null | xargs basename 2>/dev/null)
		[ -z "$crss" ] && continue
		crss_mb=$(echo "scale=1; $crss / 1024" | bc)
		calloc_mb=$(get_alloc_mb "$cpid")
		printf "  └─ %-7s %6s %10s %15s  %s\n" "$cpid" "${crss_mb}M" "${calloc_mb:-?}M" "" "$ccmd"
	done
done
