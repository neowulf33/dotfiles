#!/usr/bin/osascript

-- http://www.macosxhints.com/article.php?story=2004070301135736
(*

Author: sivakom
Resources:
	http://oreilly.com/catalog/aplscptian/chapter/ch07.html
	http://developer.apple.com/mac/library/DOCUMENTATION/AppleScript/Conceptual/AppleScriptLangGuide/conceptual/ASLR_fundamentals.html
	http://forums.macosxhints.com/archive/index.php/t-34109.html
*)

set MAX_LENGTH to 30

--begin applescript
set theApp to "iTunes"
-- set isRunning to do shell script "ps ax | grep " & theApp & " | wc -l | sed 's/ //g'"
set isRunning to do shell script "pgrep iTunes | wc -l | sed 's/ //g'"

if isRunning > 1 then -- !!! need to have removed wc's spaces, or that ">" won't work
	tell application "iTunes"
		set tname to name of current track
		set art to artist of current track
		if art is equal to "" then
			set art to " - "
		else
			if length of art > MAX_LENGTH then
				copy characters 1 through MAX_LENGTH of art to art
				set art to art & "..."
			end if
			set art to " ( " & art & " ) "
		end if
		set pos to player position
		set dur to duration of current track as integer
		set foo4 to tname & art & pos & "/" & dur
	end tell
end if