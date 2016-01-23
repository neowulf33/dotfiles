#!/usr/bin/osascript

##
# http://netzwerg.ch/blog/2012/02/08/intellij-idea-reveal-in-terminal/
##

on run dir
  tell application "iTerm"
    activate
    tell last terminal
      set mysession to (make new session at the beginning of sessions)
      tell mysession
        set name to "Default"
        exec command "/bin/bash -l"
      end tell
      tell mysession
        write text "cd " & dir
      end tell
    end tell
  end tell
end run

