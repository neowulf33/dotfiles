#!/usr/bin/osascript

# http://www.ithug.com/2008/12/applescript-arranging-multiple-windows/
# http://macmembrane.com/resize-any-window-quickly-and-exactly-with-applescript-and-fastscripts/

tell application "Google Chrome"
	activate
	set _theWindows to every window
	repeat with i from 1 to number of items in _theWindows
		set this_item to item i of _theWindows
		# {160, 80, 980, 700} {x, y, width, height}
		# set the bounds of this_item to {(20 + (20 * i)), (5 + (10 * i)), (1164 + (20 * i)), (786 + (10 * i))}
		set the bounds of this_item to {(240 + (20 * i)), (10 + (20 * i)), (1150 + (20 * i)), (500 + (20 * i))}
	end repeat
end tell


