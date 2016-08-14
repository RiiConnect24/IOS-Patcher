@ECHO OFF
echo This is a patcher that creates an IOS31 WAD.
echo This is only for the Wii U, please don't install this on an actual Wii.
echo If you want to patch IOS 31 for Wii, please download the other version on the homepage.
echo 1. Unpacking IOS31...
Sharpii.exe WAD -u IOS31-old.wad IOS31/
echo 2. Patching the APP file with the new key...
move IOS31\00000006.app 00000006.app
xdelta3.exe -f -d -s 00000006.app 00000006.delta IOS31\00000006.app
echo 3. Packing the new IOS31...
mkdir WAD
Sharpii.exe WAD -p IOS31\ WAD\IOS31.wad -f
echo 4. Cleaning up files... (Type Y if needed).
del 00000006.app
del IOS31-old.wad 
rmdir /s /q IOS31
echo We're done.
pause