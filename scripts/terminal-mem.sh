#!/usr/bin/env zsh
# Shows total memory usage grouped by terminal tool.
# Usage: ./terminal-mem.sh

typeset -A tool_rss tool_count

tools=(nvim lazygit zsh tmux fzf node ruff gopls terraform-ls lua-language-server pyright bash-language-server stylua claude gemini genini)

for tool in $tools; do
	total_rss=0
	count=0
	# Try exact match first, then full command line match for node scripts
	pids=$(pgrep -x "$tool" 2>/dev/null)
	if [ -z "$pids" ]; then
		pids=$(pgrep -f "$tool" 2>/dev/null)
	fi
	for pid in ${=pids}; do
		rss=$(ps -o rss= -p "$pid" 2>/dev/null | tr -d ' ')
		[ -z "$rss" ] && continue
		total_rss=$((total_rss + rss))
		count=$((count + 1))
	done
	if [ "$count" -gt 0 ]; then
		tool_rss[$tool]=$total_rss
		tool_count[$tool]=$count
	fi
done

printf "%-25s %8s %10s %7s\n" "TOOL" "COUNT" "TOTAL(MB)" "AVG(MB)"
printf "%-25s %8s %10s %7s\n" "-------------------------" "--------" "----------" "-------"

grand_total=0
# Sort by total RSS descending
for tool in $(for k in ${(k)tool_rss}; do echo "${tool_rss[$k]} $k"; done | sort -rn | awk '{print $2}'); do
	rss=${tool_rss[$tool]}
	cnt=${tool_count[$tool]}
	mb=$(echo "scale=1; $rss / 1024" | bc)
	avg=$(echo "scale=1; $rss / $cnt / 1024" | bc)
	grand_total=$((grand_total + rss))
	printf "%-25s %8s %10s %7s\n" "$tool" "$cnt" "${mb}M" "${avg}M"
done

grand_mb=$(echo "scale=1; $grand_total / 1024" | bc)
printf "%-25s %8s %10s\n" "-------------------------" "--------" "----------"
printf "%-25s %8s %10s\n" "TOTAL" "" "${grand_mb}M"
