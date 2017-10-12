#!/bin/bash

# Verify correct branch
git stash

# Verify correct branch
git checkout develop

# Build new files
stack exec site clean
stack exec site build

# Get previous files
git fetch --all
git checkout -b master --track origin/master

# Overwrite existing files with new files
cp -a _site/. .

# Commit
git add -A
git commit -m "hakyll publish"

# Push
git push origin master:master

# Restoration
git checkout develop
git branch -D master
git stash pop
