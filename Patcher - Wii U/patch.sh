echo "This is a patcher that creates an IOS31 WAD."
echo "This is only for the Wii U, please don't install this on an actual Wii."
echo "If you want to patch IOS 31 for Wii, please download the other version on the homepage."
echo "As this is the Linux/Mac version, I require Mono"
echo "Downloading IOS31 from NUS..."
mono Sharpii.exe NUSD -ios 31 -v latest -o IOS31-old
echo "Done."
echo "Extracting."
cp IOS31-old/000000010000001fv3608.wad IOS31-old.wad
mono Sharpii.exe WAD -u IOS31-old.wad IOS31/
echo "Done."
echo "Downloading APP file with new key..."
wget -O 00000006.app http://riiconnect24.net/IOS/00000006.app -q
echo "Done."
echo "Moving to the folder."
cp 00000006.app IOS31/
echo "Done."
echo "Packing WAD to IOS31-new.wad"
mono Sharpii.exe WAD -p IOS31/ IOS31.wad -f
echo "Done."
echo "Changing IOS Slot."
mono Sharpii.exe IOS IOS31.wad -o IOS221.wad -s 221
echo "Done."
echo "Removing all the pointless stuff (type Y if needed):"
rm 00000006.app
rm IOS31-old.wad
rm IOS31.wad
rm -rf IOS31-old/
rm -rf IOS31/
echo "Done."
echo "We're done!"