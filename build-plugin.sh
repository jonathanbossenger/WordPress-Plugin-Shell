#!/bin/bash

printf "Plugin name: "
read NAME

printf "Destination folder: "
read FOLDER

printf "Initialise new git repo (y/n): "
read NEWREPO

DEFAULT_NAME="WordPress Plugin Shell"
DEFAULT_CLASS=${DEFAULT_NAME// /_}
DEFAULT_TOKEN=$( tr '[A-Z]' '[a-z]' <<< $DEFAULT_CLASS)
DEFAULT_SLUG=${DEFAULT_TOKEN//_/-}

CLASS=${NAME// /_}
TOKEN=$( tr '[A-Z]' '[a-z]' <<< $CLASS)
SLUG=${TOKEN//_/-}

git clone https://github.com/jonathanbossenger/$DEFAULT_SLUG.git $FOLDER/$SLUG

echo "Removing git files..."

mkdir -p $FOLDER
cd $FOLDER/$SLUG

rm -rf .git
rm README.md
rm build-plugin.sh
rm changelog.txt

echo "Updating plugin files..."

mv $DEFAULT_SLUG.php $SLUG.php

cp $SLUG.php $SLUG.tmp
sed "s/$DEFAULT_NAME/$NAME/g" $SLUG.tmp > $SLUG.php
rm $SLUG.tmp

cp $SLUG.php $SLUG.tmp
sed "s/$DEFAULT_SLUG/$SLUG/g" $SLUG.tmp > $SLUG.php
rm $SLUG.tmp

cp $SLUG.php $SLUG.tmp
sed "s/$DEFAULT_TOKEN/$TOKEN/g" $SLUG.tmp > $SLUG.php
rm $SLUG.tmp

cp $SLUG.php $SLUG.tmp
sed "s/$DEFAULT_CLASS/$CLASS/g" $SLUG.tmp > $SLUG.php
rm $SLUG.tmp

cp readme.txt readme.tmp
sed "s/$DEFAULT_NAME/$NAME/g" readme.tmp > readme.txt
rm readme.tmp


cd lang
mv $DEFAULT_SLUG.pot $SLUG.pot

cp $SLUG.pot $SLUG.tmp
sed "s/$DEFAULT_NAME/$NAME/g" $SLUG.tmp > $SLUG.pot
rm $SLUG.tmp

cp $SLUG.pot $SLUG.tmp
sed "s/$DEFAULT_CLASS/$CLASS/g" $SLUG.tmp > $SLUG.pot
rm $SLUG.tmp

cp $SLUG.pot $SLUG.tmp
sed "s/$DEFAULT_TOKEN/$TOKEN/g" $SLUG.tmp > $SLUG.pot
rm $SLUG.tmp

cp $SLUG.pot $SLUG.tmp
sed "s/$DEFAULT_SLUG/$SLUG/g" $SLUG.tmp > $SLUG.pot
rm $SLUG.tmp


if [ "$NEWREPO" == "y" ]; then
	echo "Initialising new git repo..."
	cd ../..
	git init
fi

echo "Complete!"
