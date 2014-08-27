set app1 to application id "com.google.Chrome"
set app2 to application id "org.chromium.Chromium"
if (running of app2) and not (running of app1) then
	activate app2
	reopen app2
else
	activate app1
	reopen app1
end if
