#!/bin/sh

# http://macosxautomation.com/mavericks/notifications/01.html
# https://developer.apple.com/library/mac/documentation/applescript/conceptual/applescriptlangguide/reference/aslr_cmds.html#//apple_ref/doc/uid/TP40000983-CH216-SW224

# A simple bash script that uses Applescript to display alerts.
# 	alert "Title" "Subtitle" "Message"
# Sample usage:
#   personal/bin/mac_os_x/alert.sh -t "Drink Water"


function help_text () {
	echo "Uses AppleScript to display alerts."
    echo "Usage: $0 [-t title] [-s subtitle] [-m message]"
}

function alert() {

	title=$1
	subtitle=$2
	message=$3

	osascript -e "display alert \"${title}\""
}

function notify () {

	title=$1
	subtitle=$2
	message=$3

	osascript -e "display \
		notification \"${message}\" with \
		title \"${title}\" \
		subtitle \"${subtitle}\""
}

if [ -z "$*" ]; then
	help_text
 	exit
fi

while getopts "t:s:m:" opt; do
	case ${opt} in
		t )
			title=$OPTARG
			;;
		s )
			subtitle=$OPTARG
			;;
		m )
			message=$OPTARG
			;;
		\?)
			help_text
			exit 1
			;;
		: )
			help_text
			exit 1
	esac
done

notify "$title" "$subtitle" "$message"