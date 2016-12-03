echo "This is a patcher that creates an IOS31 and IOS80 WAD."
echo "This is only for the Wii, please don't install this on a Wii U."
echo "If you want to patch the IOS for Wii U, please download the other version."
echo "Please install Mono or else this won't work."
printf '\e[0;31m%s\e[0m \n' '1. Downloading IOS from NUS...'
mono Sharpii.exe NUSD -ios 31 -v latest -o IOS31
mono Sharpii.exe NUSD -ios 80 -v latest -o IOS80
printf '\e[0;31m%s\e[0m \n' '2. Unpacking IOS...'
cp IOS31/000000010000001fv3608.wad IOS31-old.wad
cp IOS80/0000000100000050v6944.wad IOS80-old.wad
mono Sharpii.exe WAD -u IOS31-old.wad IOS31/
mono Sharpii.exe WAD -u IOS80-old.wad IOS80/
printf '\e[0;31m%s\e[0m \n' '3. Patching the APP file...'
./xdelta3 -f -d -s ./IOS31/00000006.app 00000006-31.delta 00000006.app
mv 00000006.app IOS31
./xdelta3 -f -d -s ./IOS80/00000006.app 00000006-80.delta 00000006.app
mv 00000006.app IOS80
printf '\e[0;31m%s\e[0m \n' '4. Packing the new IOS...'
mkdir WAD
mono Sharpii.exe WAD -p IOS31/ WAD/IOS31.wad -f
mono Sharpii.exe WAD -p IOS80/ WAD/IOS80.wad -f
printf '\e[0;31m%s\e[0m \n' '5. Cleaning up files... (Type Y if needed).'
rm IOS31-old.wad
rm IOS80-old.wad
rm -rf IOS31/
rm -rf IOS80/
echo "We're done."