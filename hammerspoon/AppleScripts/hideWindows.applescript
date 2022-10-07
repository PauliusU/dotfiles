-- Shows desktop by hiding all visible windows
activate application "Finder"
tell application "System Events"
	set visible of processes where name is not "Finder" to false
end tell
tell application "Finder" to set collapsed of windows to true