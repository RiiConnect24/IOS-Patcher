@ECHO OFF
echo This is a patcher that creates an IOS31 WAD.
echo This is only for the Wii, please don't install this on an actual Wii U.
echo If you want to patch IOS 31 for Wii U, please download the other version on the homepage.
echo Downloading IOS31 from NUS...
Sharpii.exe NUSD -ios 31 -v latest -o IOS31-old.wad -wad
echo Done.
echo Extracting.
Sharpii.exe WAD -u IOS31-old.wad IOS31/
echo Done.
echo Downloading APP file with new key...
wget -O 00000006.app http://riiconnect24.net/IOS/00000006.app -q
echo Done.
echo Moving to the folder. (press Y if needed)
xcopy 00000006.app IOS31\ /Y
echo Done.
echo Packing WAD to IOS31.wad
Sharpii.exe WAD -p IOS31\ IOS31.wad -f
echo Done.
echo Removing all the pointless stuff (type Y if needed):
del 00000006.app
del IOS31-old.wad 
del IOS31
echo Done.
echo We're done!
pause