#!/usr/bin/osascript

set hostList to {"p.pelican001", "p.pelican002", "p.pelican003", "p.pelican004", "p.pelican005"} as list
tell application "iTerm"
    activate
    set myTerm to (make new terminal)
    tell myTerm
        repeat with hostItem in hostList
            set Lsession to (launch session "Default Session")
            tell Lsession
                write text "ssh " & hostItem
            end tell
        end repeat
    end tell
end tell

tell application "System Events"
    tell process "iTerm"
        keystroke "I" using {command down}
    end tell
end tell