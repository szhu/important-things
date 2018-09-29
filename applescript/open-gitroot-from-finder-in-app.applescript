#!/usr/bin/osascript
# Usage: ./open-files-from-finder-in-app.applescript com.sublimetext.3

on |path|(pathlike)
	return POSIX path of (pathlike as alias)
end |path|

on join(|list|, delimiter)
	set |items| to {}
	repeat with |item| in |list|
		set |items| to |items| & |item|
	end repeat
	set |old text item delimiters| to text item delimiters
	set text item delimiters to delimiter
	set |result| to |items| as text
	set text item delimiters to |old text item delimiters|
	return |result|
end join

on |subcommand from args|(args)
	set |original text| to |join args|(args)

	set |old text item delimiters| to text item delimiters
	set text item delimiters to "\""
	set the |text items| to every text item of the |original text|
	set text item delimiters to "\\\""
	set |replaced text| to the |text items| as text
	set text item delimiters to "$"
	set the |text items| to every text item of the |original text|
	set text item delimiters to "\\$"
	set |replaced text| to the |text items| as text
	set AppleScript's text item delimiters to |old text item delimiters|

	return "\"$(" & |replaced text| & ")\""
end |subcommand from args|

on |quoted form if necessary|(arg)
	if ("'" is in arg) or (return is in arg) then
		return quoted form of arg
	else
		return arg
	end if
end |quoted form if necessary|

on |join args|(args)
	set |formatted args| to {}
	repeat with arg in args
		set |formatted args| to |formatted args| & {|quoted form if necessary|(arg)}
	end repeat
	return join(|formatted args|, " ")
end |join args|

on |join statements|(statements)
	set |formatted statements| to {}
	repeat with statement in statements
		set |formatted statements| to |formatted statements| & {|join args|(statement)}
	end repeat
	return join(|formatted statements|, "; ")
end |join statements|

on |as alias|(aliaslikes)
	set |aliases| to {}
	repeat with aliaslike in aliaslikes
		set |aliases| to |aliases| & {aliaslike as alias}
	end repeat
	return |aliases|
end |as alias|

on main(args)
	-- For demo purposes
	if class of args is script then set args to {"com.sublimetext.3", "-g"}

	-- Get arg 1
	if length of args ³ 1 then
		set |app id| to item 1 of args
	else
		error "Argument 1 is required."
	end if

	-- Get arg 2
	if length of args ³ 2 then
		set flags to {item 2 of args}
	else
		set flags to ""
	end if

	global targets
	set targets to missing value
	tell application id "com.apple.Finder"
		-- Get either selection (preferred) or target of front window
		set |selection| to selection as list
		if |selection| = {} then
			set my targets to my |as alias|({target of front window})
		else
			set my targets to |selection|
		end if
	end tell

	repeat with target in targets
		-- Build command
		set |open command| to {"open", "-b", |app id|} & flags & {"--", "."}
		set |1st cd command| to {"cd", |subcommand from args|({"dirname", |path|(target)})}
		set |2nd cd command| to {"cd", |path|(target)}
		set |3rd cd command| to {"cd", |subcommand from args|({"git", "rev-parse", "--show-toplevel", "||", "."})}
		set |entire command| to |join statements|({|1st cd command|, |2nd cd command|, |3rd cd command|, |open command|})

		# display dialog "Command:" default answer |entire command|

		-- Execute command
		do shell script |entire command|
	end repeat
end main

on run (args)
	main(args)
end run
