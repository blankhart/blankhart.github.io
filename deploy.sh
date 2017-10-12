#!/bin/bash

#https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
Y='\033[1;33m'
NC='\033[0m'

status () {
  echo -e "${Y}" $1
}

status "Stashing..."
git stash

status "Verifying correct branch..."
git checkout develop

status "Stack clean of old site..."
stack exec site clean

status "Stack build of new site..."
stack exec site build

status "Git fetching previous files..."
git fetch --all

status "Creating tracked master..."
git checkout -b master --track origin/master

# Overwrite existing files with new files
status "Copying site..."
cp -a _site/. .

# Commit
status "Adding & committing..."
git add -A
git commit -m "hakyll publish"

# Push
status "Pushing to github..."
git push origin master:master

# Restoration
status "Returning to develop..."
git checkout develop

status "Deleting branch master..."
git branch -D master

status "Popping stash..."
git stash pop
