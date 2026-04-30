#!/bin/bash
# Shows all running nvim instances with memory and project info.
# Usage: ./nvim-status.sh

printf "%-7s %10s %10s %15s  %s\n" "PID" "RSS(MB)" "VSZ(GB)" "UPTIME" "PROJECT"
printf "%-7s %10s %10s %15s  %s\n" "-------" "----------" "----------" "---------------" "-------"

for pid in $(pgrep -x nvim | sort -u); do
	ppid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
	parent_comm=$(ps -o comm= -p "$ppid" 2>/dev/null)
	echo "$parent_comm" | grep -q nvim && continue

	rss=$(ps -o rss= -p "$pid" 2>/dev/null | tr -d ' ')
	vsz=$(ps -o vsz= -p "$pid" 2>/dev/null | tr -d ' ')
	etime=$(ps -o etime= -p "$pid" 2>/dev/null | tr -d ' ')
	cwd=$(lsof -p "$pid" -Fn 2>/dev/null | grep "^n/" | head -1 | sed 's/^n//' | grep -v '\.dylib\|\.so\|/dev/\|/usr/' || echo "?")
	project=$(basename "$cwd")

	rss_mb=$(echo "scale=1; $rss / 1024" | bc)
	vsz_gb=$(echo "scale=2; $vsz / 1048576" | bc)

	printf "%-7s %10s %10s %15s  %s\n" "$pid" "${rss_mb}M" "${vsz_gb}G" "$etime" "$project"

	# Show LSP/child processes
	pgrep -P "$pid" | while read -r cpid; do
		crss=$(ps -o rss= -p "$cpid" 2>/dev/null | tr -d ' ')
		cvsz=$(ps -o vsz= -p "$cpid" 2>/dev/null | tr -d ' ')
		ccmd=$(ps -o comm= -p "$cpid" 2>/dev/null | xargs basename 2>/dev/null)
		[ -z "$crss" ] && continue
		crss_mb=$(echo "scale=1; $crss / 1024" | bc)
		cvsz_gb=$(echo "scale=2; $cvsz / 1048576" | bc)
		printf "  └─ %-7s %6s %10s %15s  %s\n" "$cpid" "${crss_mb}M" "${cvsz_gb}G" "" "$ccmd"
	done
done
