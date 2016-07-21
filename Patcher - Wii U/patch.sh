echo "This is a patcher that creates an IOS31 WAD."
echo "This is only for the Wii U, please don't install this on an actual Wii."
echo "If you want to patch IOS 31 for Wii, please download the other version on the homepage."
echo "Please install Mono or else this won't work."
printf '\e[0;31m%s\e[0m \n' '1. Downloading IOS31 from NUS...'
mono Sharpii.exe NUSD -ios 31 -v latest -o IOS31-old
printf '\e[0;31m%s\e[0m \n' '2. Unpacking IOS31...'
cp IOS31-old/000000010000001fv3608.wad IOS31-old.wad
mono Sharpii.exe WAD -u IOS31-old.wad IOS31/
printf '\e[0;31m%s\e[0m \n' '3. Patching the APP file with the new key...'
./xdelta3 -f -d -s ./IOS31/00000006.app 00000006.delta ./IOS31/00000006.app
printf '\e[0;31m%s\e[0m \n' '4. Packing the new IOS31...'
mono Sharpii.exe WAD -p IOS31/ IOS31.wad -f
printf '\e[0;31m%s\e[0m \n' '5. Changing the IOS Slot...'
mkdir WAD
mono Sharpii.exe IOS IOS31.wad -o WAD/IOS221.wad -s 221
printf '\e[0;31m%s\e[0m \n' '6. Cleaning up files... (Type Y if needed).'
rm IOS31-old.wad
rm IOS31.wad
rm -rf IOS31-old/
rm -rf IOS31/
echo "We're done."