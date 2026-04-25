# ccminimalstats                                                                                        
 
A minimal terminal statusline for [Claude Code](https://claude.ai/code) CLI showing token usage, session
 cost, and rate limits — color-coded and live.

  <img width="399" height="111" alt="Screenshot 2026-04-25 at 00 26 33" src="https://github.com/user-attachments/assets/1b6d007a-0759-4066-95ca-a3aefb39f8da" />

<br>
                                                                                                 
```                                 
34.0k $1.35 · ctx 52% · 5h 8% · 7d 3%
```                                                                                                     

| Element | Description |                                                                               
|---|---|                           
| `34.0k` | Total session tokens (input + output) |
| `$1.35` | Session cost in USD |                                                                       
| `ctx 52%` | Context window usage |
| `5h 8%` | 5-hour rate limit usage |                                                                   
| `7d 3%` | 7-day rate limit usage |                                                                    

> The 5h and 7d limits reset on a rolling schedule. Run `/status` in Claude Code → Usage to see when    
  yours resets.
 
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
