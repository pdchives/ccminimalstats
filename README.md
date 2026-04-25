# ccminimalstats                                                                                        
 
A minimal terminal statusline for [Claude Code](https://claude.ai/code) CLI showing token usage, session
 cost, and rate limits — color-coded and live.
                                                                                                        
```                                 
16.3k $0.59 · ctx 20% · 5h 4% · 7d 2%
```                                                                                                     
 
| Element | Description |                                                                               
|---|---|                           
| `16.3k` | Total session tokens (input + output) |
| `$0.59` | Session cost in USD |                                                                       
| `ctx 20%` | Context window usage |
| `5h 4%` | 5-hour rate limit usage |                                                                   
| `7d 2%` | 7-day rate limit usage |                                                                    
 
Colors: token count and cost in orange · percentages go green → yellow → red at <50 / <75 / ≥75.        
                                    
## Requirements                                                                                         
                                    
- macOS (Apple Silicon)                                                                                 
- [Homebrew](https://brew.sh) + jq: `brew install jq`
                                                                                                        
> **Linux users:** replace `/opt/homebrew/bin/jq` with `/usr/bin/jq` in `statusline-command.sh`.        
>
> **Windows:** not supported.                                                                           
                                    
## Install                                                                                              
                                    
```sh
curl -o ~/.claude/statusline-command.sh
https://raw.githubusercontent.com/pdchives/ccminimalstats/main/statusline-command.sh && chmod +x        
~/.claude/statusline-command.sh
```                                                                                                     
                                    
Then add this to `~/.claude/settings.json`:

```json
"statusLine": {
  "type": "command",
  "command": "~/.claude/statusline-command.sh"                                                          
}
```                                                                                                     
                                    
Restart Claude Code and the statusline will appear at the bottom of your terminal.

## Want to build your own?                                                                              
 
The statusline feature is fully documented in the [Claude Code                                          
docs](https://code.claude.com/docs/en/statusline) — including all available data fields and more
advanced examples. 
