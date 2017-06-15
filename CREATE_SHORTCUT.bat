@echo off
set currentpath=%cd%
cd /d %currentpath%

echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%userprofile%\Desktop\Lamp stack MENU.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "bash" >> CreateShortcut.vbs
echo oLink.Arguments = "-l ""%currentpath%\lampmenu.sh""" >> CreateShortcut.vbs
echo oLink.WorkingDirectory = "%currentpath%" >> CreateShortcut.vbs
echo oLink.Description = "Lamp stack MENU" >> CreateShortcut.vbs
echo oLink.IconLocation = "%currentpath%\icons\start.ico" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs

del CreateShortcut.vbs