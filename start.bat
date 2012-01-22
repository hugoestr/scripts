set originalPath= %CD%

cd "C:\Program Files\Mozilla Firefox"
start firefox.exe

cd "C:\Program Files\Internet Explorer\"
start iexplore.exe

cd"C:\Program Files\Pidgin"
start pidgin.exe

cd "C:\Program Files\Skype\Phone"
start skype.exe

cd %originalPath%
echo End of Script
