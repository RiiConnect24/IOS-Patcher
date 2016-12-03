@ECHO OFF
echo This is a patcher that creates an IOS31 and IOS80 WAD.
echo This is only for the Wii, please don't install this on an actual Wii U.
echo If you want to patch IOS 31 for Wii U, please download the other version on the homepage.
echo 1. Downloading IOS from NUS...
Sharpii.exe NUSD -ios 31 -v latest -o IOS31-old.wad -wad
Sharpii.exe NUSD -ios 80 -v latest -o IOS80-old.wad -wad
echo 2. Unpacking IOS...
Sharpii.exe WAD -u IOS31-old.wad IOS31/
Sharpii.exe WAD -u IOS80-old.wad IOS80/
echo 3. Patching the APP file with the new key...
xdelta3.exe -f -d -s IOS31\00000006.app 00000006-31.delta IOS31\00000006.app
xdelta3.exe -f -d -s IOS80\00000006.app 00000006-80.delta IOS80\00000006.app
echo 4. Packing the new IOS...
mkdir WAD
Sharpii.exe WAD -p IOS31\ WAD\IOS31.wad -f
Sharpii.exe WAD -p IOS80\ WAD\IOS80.wad -f
echo 5. Cleaning up files... (Type Y if needed).
del 00000006.app
del IOS31-old.wad
del IOS80-old.wad 
rmdir /s /q IOS31
rmdir /s /q IOS80
echo We're done.
pause