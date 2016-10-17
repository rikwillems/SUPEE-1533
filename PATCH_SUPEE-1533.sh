#!/bin/bash


# What is the version number?
version=`php -r "require 'app/Mage.php'; echo Mage::getVersion();"`
echo "Magento version:" $version
naked_version="${version//\./}"


# Which patch file do we need?
if [ $naked_version -ge 1400 -a $naked_version -lt 1500 ]; then
	filename="1.9.x"
elif [ $naked_version -ge 1500 -a $naked_version -lt 1510 ]; then
	filename="1.10.0.x"
elif [ $naked_version -ge 1510 -a $naked_version -lt 1600 ]; then
	filename="1.10.1.x"
elif [ $naked_version -ge 1600 -a $naked_version -lt 1700 ]; then
	filename="1.11.x"
elif [ $naked_version -ge 1700 -a $naked_version -lt 1800 ]; then
	filename="1.12.x"
elif [ $naked_version -ge 1800 -a $naked_version -lt 1925 ]; then
	filename="1.13.x"
else
	filename="no-version"
fi;


# Download the right patch.
if [ $filename != "no-version" ]; then
	patch_file="PATCH_SUPEE-1533_EE_"$filename"_v1.sh"
	echo "Download patch: $patch_file"
	wget --no-check-certificate --quiet - https://raw.githubusercontent.com/rikwillems/SUPEE-1533/master/$patch_file
else 
	echo "Version not supported for patch."
	exit;
fi;


# Disable and clear compiler for ease of use.
echo "Disable compiler:"
php -f shell/compiler.php disable

echo "Clear compiler:"
php -f shell/compiler.php clear
