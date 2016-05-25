#!/usr/bin/osascript
# Usage: ./open-files-from-finder-in-app.applescript com.sublimetext.3

on quoted_path(pathlike)
	return (quoted form of POSIX path of (pathlike as alias))
end quoted_path

on main(args)
	if class of args is script then set args to {"com.sublimetext.3", "-g"}
	if length of args ³ 1 then
		set app_id to item 1 of args
	else
		error "argument 1 is required"
	end if
	if length of args ³ 2 then
		set flags to item 2 of args
	else
		set flags to ""
	end if
	
	tell application id "com.apple.Finder"
		-- Get either selection (preferred) or target of front window
		set the_targets to selection
		if length of the_targets is 0 then set the_targets to {target of front window}
		
		-- Build command for `open`
		set the_command to ("open -b" & space & quoted form of app_id & space & flags & space & "--" & space)
		repeat with the_target in the_targets
			set the_command to the_command & " " & "\"$(cd \"$(dirname " & my quoted_path(the_target) & ")\"; cd " & my quoted_path(the_target) & "; git rev-parse --show-toplevel)\""
		end repeat
		# display dialog "Command:" default answer the_command
		
		-- Execute command
		do shell script the_command
	end tell
end main

on run (args)
	main(args)
end run
