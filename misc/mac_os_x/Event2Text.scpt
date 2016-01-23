#!/usr/bin/osascript

-- this script runs automatically at about 7.00 every morning, and can be run manually during the day for cleanup if necessary
-- I'm going to write to a unix text file, because I use geektool and cat
set line_feed to (ASCII character 10)
set this_date to current date
set the start_day to (this_date - (time of this_date))
-- go out 7 days to the last second before midnight
set the end_day to (the start_day + (7 * days) - 1)
set all_events to {}
set what_cal to {}
-- I only use some of my calendars for this
set ok_cals to {"SKHome"}
-- this is the text file (the directory syncs to my iPod as well)
set events_file to alias "/Users/sivakom/Documents/todo/ical/events.txt"
try
	tell application "Calendar"
		repeat with i from 1 to count of ok_cals
			set this_calendar to (the first calendar whose title is item i of ok_cals)
			set returned_events to {}
			set the returned_events to (every event of this_calendar whose start date is greater than or equal to start_day and start date is less than or equal to the end_day and end date is greater than or equal to (current date))
			repeat with i from 1 to the count of returned_events
				set this_item to item i of returned_events
				set all_events to all_events & {this_item}
				-- I use what_cal to preserve the calendar each event is in
				set what_cal to what_cal & {name of this_calendar}
			end repeat
		end repeat
		-- Craig Smith's bubblesort follows; I'm lazy, so I just put it inline
		-- the goal here is to to sort all of the events by date
		repeat with i from length of all_events to 2 by -1 --> go backwards
			repeat with j from 1 to i - 1 --> go forwards
				-- there might be an easier way to set the sort items
				set j_props to the properties of item j of all_events
				set j_date to start date of j_props
				set j1_props to the properties of item (j + 1) of all_events
				set j1_date to the start date of j1_props
				if j_date > j1_date then
					set {all_events's item j, all_events's item (j + 1)} to {all_events's item (j + 1), all_events's item j} -- swap
					set {what_cal's item j, what_cal's item (j + 1)} to {what_cal's item (j + 1), what_cal's item j} -- swap in lockstep
				end if
			end repeat
		end repeat
		-- the reload isn't technically necessary, but I use Missing Sync, and iCal sometimes doesn't sync with the iSync database; this seems to help
		reload calendars
	end tell
	
	if all_events is equal to {} then
		set the master_data to ""
	else
		set the master_data to "Events for Next 7 Days" & line_feed & "======================" & line_feed & events_2_text(all_events, what_cal)
	end if
	
	write_to_file(master_data, events_file)
	
	-- I found this useful for troubleshooting before the write-to-file stage
	(*tell application "TextEdit"
		activate
		open events_file
	end tell*)
	
on error error_message number error_number
	if the error_number is not -128 then
		display dialog error_message buttons {"OK"} default button 1
	end if
end try

--- stripped down version of apple's write subroutine
on write_to_file(this_data, target_file)
	tell application "Finder"
		try
			set the target_file to the target_file as text
			set the open_target_file to open for access file target_file with write permission
			set eof of the open_target_file to 0
			write this_data to the open_target_file starting at eof
			close access the open_target_file
			return true
		on error
			try
				close access file target_file
			end try
			return false
		end try
	end tell
end write_to_file

on events_2_text(the_events, the_cal)
	set line_feed to (ASCII character 10)
	
	tell application "Calendar"
		set the event_count to the count of the_events
		set event_summary to ""
		if the event_count is 0 then
			return the event_summary
		end if
		repeat with i from 1 to the event_count
			set this_event to item i of the_events
			set the event_properties to the properties of this_event
			set summary_text to the summary of the event_properties
			--set this_location to the location of the event_properties
			--if this_location is missing value then set this_location to "N/A"
			--set the location_text to "Location:" & tab & this_location
			set all_day to allday event of the event_properties
			set take_off to start date of the event_properties
			set wheels_down to end date of the event_properties
			set start_date to date string of (get start date of the event_properties)
			set end_date to date string of (get end date of the event_properties)
			set starting_time to time string of (get start date of the event_properties)
			set ending_time to time string of (get end date of the event_properties)
			set event_description to the description of the event_properties
			-- I use the @@ to test whether to convert an event to a to-do using a different script, so it's not "notes"
			if (event_description is missing value or event_description is equal to "@@") then set event_description to ""
			set the date_text to start_date
			-- the if statement below eliminates times for all-day events and does a couple other cleanup tasks 
			if not all_day then
				if start_date is not equal to end_date then
					set the date_text to date_text & ", " & starting_time & " to " & end_date & ", " & ending_time
				else
					set the date_text to date_text & ", " & starting_time
					if (take_off + (10 * minutes)) is less than wheels_down then
						set the date_text to date_text & " to " & ending_time
					end if
				end if
			else
				if wheels_down is greater than (take_off + (1 * days) + 1) then
					set wheels_down to wheels_down - 1
					set end_date to date string of wheels_down
					set the date_text to date_text & " to " & end_date
				end if
			end if
			set the event_text to summary_text & " " & "(" & item i of the_cal & ")" & line_feed & the date_text & line_feed
			if event_description is not "" then set event_text to event_text & "Notes:" & "  " & event_description & line_feed
			set the event_summary to the event_summary & the event_text & line_feed
		end repeat
		return the event_summary
	end tell
end events_2_text

