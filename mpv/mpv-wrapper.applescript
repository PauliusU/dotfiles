-- Wraps the Homebrew mpv CLI binary so it can be launched via LaunchServices (Finder, duti).
-- Must be a real app, not a shell script, to receive Finder's 'odoc' file-open Apple Event.
-- Compiled at setup time by setup-macos/install-soft.sh, not committed as a binary.

on findMpvBinary()
	repeat with candidate in {"/opt/homebrew/bin/mpv", "/usr/local/bin/mpv"}
		if (do shell script "test -x " & quoted form of candidate & " && echo yes || echo no") is "yes" then
			return candidate
		end if
	end repeat
	error "mpv wrapper: no Homebrew mpv binary found (checked /opt/homebrew/bin and /usr/local/bin)"
end findMpvBinary

on quotedArgList(argList)
	set out to ""
	repeat with anArg in argList
		set out to out & " " & quoted form of (anArg as text)
	end repeat
	return out
end quotedArgList

on open theFiles
	set posixPaths to {}
	repeat with aFile in theFiles
		set end of posixPaths to POSIX path of aFile
	end repeat
	set mpvBin to my findMpvBinary()
	do shell script quoted form of mpvBin & " --force-window=immediate --hwdec=videotoolbox" & my quotedArgList(posixPaths) & " > /dev/null 2>&1 &"
end open

on run argv
	-- Defensive fallback only: argv is not reliably a real list here.
	set argsText to ""
	try
		if (class of argv) is list then
			set argsText to my quotedArgList(argv)
		end if
	end try
	set mpvBin to my findMpvBinary()
	-- pseudo-gui idles in an empty window; plain mpv exits at once when given no file
	do shell script quoted form of mpvBin & " --player-operation-mode=pseudo-gui --hwdec=videotoolbox" & argsText & " > /dev/null 2>&1 &"
end run
