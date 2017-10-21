#!/usr/bin/env bash
cd -P -- "$(dirname -- "$0")"
TYPE="none"
echo "This is a patcher that creates an IOS31 and IOS80 WAD."
case "$OSTYPE" in
  linux*)
    hash xdelta3 2>/dev/null || { echo >&2 "I'm missing xdelta3, please install with package manager, or compile and add it to your path."; exit 1; }
    hash mono 2>/dev/null || { echo >&2 "I'm missing mono, please install with package manager, or compile and add it to your path."; exit 1; } ;;
  darwin*)
    hash mono 2>/dev/null || { echo >&2 "I'm missing mono, please install with the homebrew package manager at https://brew.sh/";exit 1;}
    hash xdelta3 2>/dev/null || { echo >&2 "I'm missing xdelta, please install with homebrew at https://brew.sh/"; exit 1; } ;;
esac

if [ ! -f ./Sharpii.exe ]; then
  echo "Warning! Missing stuff from release folder. Please extract all files."
  echo "You can get them from https://github.com/RiiConnect24/IOS-Patcher/releases"
  exit 1
fi

printColor () {
  if [ -z "$@" ]; then
    echo "Oi, please pass something for me to color."
  else
    printf '\e[0;31m%s\e[0m \n' "$@"
  fi
  return 0
}

while true; do
  read -p "What console are you patching for? v = vWii, w = normal Wii: " vw
  case $vw in
    [Vv]* ) TYPE="v"; break ;;
    [Ww]* ) TYPE="w"; break ;;
    * ) echo "Please answer with either v or w for console." ;;
  esac
done

if [ "$TYPE" = "v" ]; then
	printColor '1. Looking for WAD...'
  # Users of vWii must provide their own wad.
  if [ ! -f ./IOS31_v3864.wad ]; then
    echo "Warning! I'm missing the actual IOS, named IOS31_v3864.wad."
    echo "I can't tell you how to obtain this, but please place it in the current directory under that name."
    exit 1
  fi
else
  # For Wii
  printColor '1. Downloading IOS from NUS...'
  mono Sharpii.exe NUSD -ios 31 -v latest -o IOS31-old
  mono Sharpii.exe NUSD -ios 80 -v latest -o IOS80-old
fi

printColor '2. Unpacking IOS...'
if [ "$TYPE" = "w" ]; then
  cp IOS31-old/000000010000001fv3608.wad IOS31-old.wad
  cp IOS80-old/0000000100000050v6944.wad IOS80-old.wad
  mono Sharpii.exe WAD -u IOS31-old.wad IOS31/
  mono Sharpii.exe WAD -u IOS80-old.wad IOS80/
else
  mono Sharpii.exe WAD -u IOS31_v3864.wad IOS31/
fi
printColor  '3. Patching the APP file...'
xdelta3 -f -d -s ./IOS31/00000006.app ../Patches/"$TYPE"00000006-31.delta ./IOS31/00000006.app
# We only do IOS80 for actual Wiis.
if [ "$TYPE" = "w" ]; then
  xdelta3 -f -d -s ./IOS80/00000006.app ../Patches/"$TYPE"00000006-80.delta ./IOS80/00000006.app
fi
printColor '4. Packing the new IOS...'
mkdir WAD
# This verion of Sharpii has fakesigning enabled by default.
mono Sharpii.exe WAD -p IOS31/ ./WAD/IOS31.wad
mono Sharpii.exe IOS ./WAD/IOS31.wad -fs -es -np -vp

if [ "$TYPE" = "w" ]; then
  mono Sharpii.exe WAD -p IOS80/ ./WAD/IOS80.wad
  mono Sharpii.exe IOS ./WAD/IOS80.wad -fs -es -np -vp
fi
printColor '5. Cleaning up files... (Type Y if needed).'
rm IOS31-old.wad
rm IOS80-old.wad
rm -rf IOS31-old
rm -rf IOS80-old
rm -rf IOS31
rm -rf IOS80
echo "We're done."
