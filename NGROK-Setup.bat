  
@echo off

setlocal
if not "%1%"=="if" (
    goto csmpw
)
goto rdmpw
:csmpw
set "_Password=%1"
goto crtacc
:rdmpw
set "set[1]=ABCDEFGHIJKLMNOPQRSTUVWXYZ"  &  set "len[1]=26"  &  set "num[1]=0"
set "set[2]=abcdefghijklmnopqrstuvwxyz"  &  set "len[2]=26"  &  set "num[2]=0"
set "set[3]=0123456789"                  &  set "len[3]=10"  &  set "num[3]=0"
set "set[4]=~!@#$%%"                     &  set "len[4]=6"   &  set "num[4]=0"
setlocal EnableDelayedExpansion
set "list="
for /L %%i in (1,1,10) do (
    set /A rnd=!random! %% 4 + 1
    set "list=!list!!rnd! "
    set /A num[!rnd!]+=1
)

:checkList
set /A mul=num[1]*num[2]*num[3]*num[4]
if %mul% neq 0 goto genpw
    set /A num[%list:~0,1%]-=1
    set "list=%list:~2%"
    set /A rnd=%random% %% 4 + 1
    set "list=%list%%rnd% "
    set /A num[%rnd%]+=1
goto checkList

:genpw
set "_Password="
for %%a in (%list%) do (
    set /A rnd=!random! %% len[%%a]
    for %%r in (!rnd!) do set "_Password=!_Password!!set[%%a]:~%%r,1!"
)

:crtacc
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
net config server /srvcomment:"Windows Azure VM" > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F > out.txt 2>&1
net user runneradmin %_Password%
echo All done! Connect your VM using RDP. When RDP expired and VM shutdown, Re-run jobs to get a new RDP.
sh ip.sh
echo User: runneradmin
echo Pass: %_Password%
curl -O https://raw.githubusercontent.com/CZ4B/RDP/main/Files/DisablePasswordComplexity.ps1 > out.txt 2>&1
curl -o "C:\Users\Public\Desktop\Fast Config VPS.exe" https://raw.githubusercontent.com/powu01/kirkubarta/blob/main/Files/FastConfigVPS_v5.1.exe > out.txt 2>&1
curl -o "C:\Users\Public\Desktop\Everything.exe" https://raw.githubusercontent.com/powu01/kirkubarta/blob/main/Files/Everything.exe > out.txt 2>&1
curl -o "C:\Users\Public\Desktop\Windows-User.bat" https://raw.githubusercontent.com/powu01/kirkubarta/blob/main/Files/Windows-User.bat > out.txt 2>&1
curl -o "C:\Users\Public\Desktop\winrar_SETUP.exe" "https://raw.githubusercontent.com/ans20049/FREE-RDP-2021-after-delete-/main/FILES/winrar-x64-602ar.exe" > out.txt 2>&1
curl -o "C:\Users\Public\Desktop\HTTP.txt" "https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=all" > out.txt 2>&1
curl -o "C:\Users\Public\Desktop\SOCKS4.txt" "https://api.proxyscrape.com/v2/?request=getproxies&protocol=socks4&timeout=10000&country=all&simplified=true" > out.txt 2>&1
curl -o "C:\Users\Public\Desktop\SOCKS5.txt" "https://api.proxyscrape.com/v2/?request=getproxies&protocol=socks5&timeout=10000&country=all" > out.txt 2>&1
curl -o "C:\Users\Public\Desktop\yt1.zip" "https://raw.githubusercontent.com/powu01/kirkubarta/blob/main/yt1.zip" > out.txt 2>&1
curl -o "C:\Users\Public\Desktop\yt2.zip" "https://raw.githubusercontent.com/powu01/kirkubarta/blob/main/yt2.zip" > out.txt 2>&1

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './DisablePasswordComplexity.ps1'" > out.txt 2>&1
diskperf -Y >nul
sc start audiosrv >nul
sc config Audiosrv start= auto >nul
ICACLS C:\Windows\Temp /grant runneradmin:F >nul
ICACLS C:\Windows\installer /grant runneradmin:F >nul
ping -n 10 127.0.0.1 >nul
