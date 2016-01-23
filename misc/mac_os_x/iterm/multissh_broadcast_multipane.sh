#!/usr/bin/osascript

# https://coderwall.com/p/3uq7gw

set hostnames to {"foo", "bar"}

launch "iTerm"

tell application "iTerm"
    activate
    
    -- ssh in split panes to my queue processor hosts
    set myterm to (make new terminal)
    tell myterm
        launch session "Default Session"
        -- make the window fullscreen
        tell i term application "System Events" to key code 36 using command down
        -- split horizontally
        tell i term application "System Events" to keystroke "E" using command down
        -- move to upper split
        --tell i term application "System Events" to keystroke "[" using command down
        set num_hosts to count of hostnames
        repeat with n from 1 to num_hosts
            if n - 1 is num_hosts / 2 then
                -- move to lower split
                tell i term application "System Events" to keystroke "]" using command down
            else if n > 1 then
                -- split vertically
                tell i term application "System Events" to keystroke "d" using command down
            end if
            delay 1
            tell the current session to write text "ssh " & (item n of hostnames)
        end repeat
    end tell
end tell