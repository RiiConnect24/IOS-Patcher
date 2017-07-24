#!/usr/bin/env bash
cd -P -- "$(dirname -- "$0")"
echo "This is a patcher that creates an IOS31 and IOS80 WAD."
echo "This is only for the Wii, please don't install this on a Wii U."
unamevar="$(uname -s)"
case "$OSTYPE" in
	linux*)   
		hash xdelta3 2>/dev/null || { echo >&2 "I'm missing xdelta3, please install with package manager, or compile and add it to your path."; exit 1; }
		hash mono 2>/dev/null || { echo >&2 "I'm missing mono, please install with package manager, or compile and add it to your path."; exit 1; };;
	darwin*)  
		hash mono 2>/dev/null || { echo >&2 "I'm missing mono, please install with the homebrew package manager at https://brew.sh/";exit 1;}
		hash xdelta3 2>/dev/null || { echo >&2 "I'm missing xdelta3, please install with homebrew at https://brew.sh/"; exit 1; };;
esac

if [ ! -f ./Sharpii.exe ]; then
	echo "Warning! Missing stuff from release folder. Please extract all files."
	echo "You can get them from https://github.com/RiiConnect24/IOS-Patcher/releases"
	exit 1
fi
printf '\e[0;31m%s\e[0m \n' '1. Downloading IOS from NUS...'
mono Sharpii.exe NUSD -ios 31 -v latest -o IOS31-old
mono Sharpii.exe NUSD -ios 80 -v latest -o IOS80-old
printf '\e[0;31m%s\e[0m \n' '2. Unpacking IOS...'
cp IOS31-old/000000010000001fv3608.wad IOS31-old.wad
cp IOS80-old/0000000100000050v6944.wad IOS80-old.wad
mono Sharpii.exe WAD -u IOS31-old.wad IOS31/
mono Sharpii.exe WAD -u IOS80-old.wad IOS80/
printf '\e[0;31m%s\e[0m \n' '3. Patching the APP file...'
xdelta3 -f -d -s ./IOS31/00000006.app ../Patches/00000006-31.delta ./IOS31/00000006.app
xdelta3 -f -d -s ./IOS80/00000006.app ../Patches/00000006-80.delta ./IOS80/00000006.app
printf '\e[0;31m%s\e[0m \n' '4. Packing the new IOS...'
mkdir WAD
# This verion of Sharpii has fakesigning enabled by default.
mono Sharpii.exe WAD -p IOS31/ ./WAD/IOS31.wad
mono Sharpii.exe WAD -p IOS80/ ./WAD/IOS80.wad
mono Sharpii.exe IOS ./WAD/IOS31.wad -fs -es -np -vp
mono Sharpii.exe IOS ./WAD/IOS80.wad -fs -es -np -vp
printf '\e[0;31m%s\e[0m \n' '5. Cleaning up files... (Type Y if needed).'
rm IOS31-old.wad
rm IOS80-old.wad
rm -rf IOS31-old
rm -rf IOS80-old
rm -rf IOS31
rm -rf IOS80
echo "We're done."
