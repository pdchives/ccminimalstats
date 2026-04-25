#!/bin/sh                                                                     
# ccminimalstats                    

abbrev() {
	n=$1
	if [ "$n" -ge 1000000 ] 2>/dev/null; then
		awk -v n="$n" 'BEGIN { printf "%.1fm", n/1000000 }'                       
	elif [ "$n" -ge 1000 ] 2>/dev/null; then
		awk -v n="$n" 'BEGIN { printf "%.1fk", n/1000 }'                          
	else                              
		echo "$n"                                                                 
	fi                                
}

pct_color() {
	pct=$1
	if awk "BEGIN { exit !($pct < 50) }"; then                                  
		printf '\033[32m'
	elif awk "BEGIN { exit !($pct < 75) }"; then                                
		printf '\033[33m'               
	else
		printf '\033[31m'
	fi                                                                          
}
																																							
input=$(cat)                        
used=$(echo "$input"      | /opt/homebrew/bin/jq -r
'.context_window.used_percentage // empty')
total_in=$(echo "$input"  | /opt/homebrew/bin/jq -r
'.context_window.total_input_tokens // 0')                                    
total_out=$(echo "$input" | /opt/homebrew/bin/jq -r
'.context_window.total_output_tokens // 0')                                   
cost=$(echo "$input"      | /opt/homebrew/bin/jq -r '.cost.total_cost_usd // 
empty')                                                                       
rl_5h=$(echo "$input"     | /opt/homebrew/bin/jq -r
'.rate_limits.five_hour.used_percentage // empty')                            
rl_7d=$(echo "$input"     | /opt/homebrew/bin/jq -r
'.rate_limits.seven_day.used_percentage // empty')                            
																		
total=$((total_in + total_out))
abbrev_total=$(abbrev "$total")
																																							
orange=$(printf '\033[38;2;212;101;36m')
grey=$(printf '\033[38;2;130;130;130m')                                       
reset=$(printf '\033[0m')           
dot="${grey} · ${reset}"

status="${orange}${abbrev_total}${reset}"                                     
plain="${abbrev_total}"
																																							
if [ -n "$cost" ]; then             
	cost_val=$(awk -v c="$cost" 'BEGIN { printf "%.2f", c }')
	status="${status} ${orange}\$${cost_val}${reset}"
	plain="${plain} \$${cost_val}"                                              
fi
																																							
if [ -n "$used" ]; then             
	c=$(pct_color "$used")
	status="${status}${dot}${grey}ctx ${reset}${c}$(printf '%.0f%%'
"$used")${reset}"                                                             
	plain="${plain} · ctx $(printf '%.0f%%' "$used")"
fi                                                                            
																		
if [ -n "$rl_5h" ]; then
	c=$(pct_color "$rl_5h")
	status="${status}${dot}${grey}5h ${reset}${c}$(printf '%.0f%%'              
"$rl_5h")${reset}"
	plain="${plain} · 5h $(printf '%.0f%%' "$rl_5h")"                           
fi                                                                            
 
if [ -n "$rl_7d" ]; then                                                      
	c=$(pct_color "$rl_7d")           
	status="${status}${dot}${grey}7d ${reset}${c}$(printf '%.0f%%'
"$rl_7d")${reset}"                                                            
	plain="${plain} · 7d $(printf '%.0f%%' "$rl_7d")"
fi                                                                            
																		
printf '\033]0;ccminimalstats · %s\007' "$plain" > /dev/tty 2>/dev/null       
printf '%s' "$status"
