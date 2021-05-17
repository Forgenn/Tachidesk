#!/bin/bash

cp master/server/build/Tachidesk-*.jar preview
cd preview

new_jar_build=$(ls *.jar| tail -1)
echo "last jar build file name: $new_jar_build"

cp -f $new_jar_build Tachidesk-latest.jar

rm -rf latest_pointer/*
cp $new_jar_build latest_pointer
cp master/server/build/Tachidesk-*.zip latest_pointer

latest=$(ls *.jar | tail -n1 | sed -e's/Tachidesk-\|.jar//g')
echo "{ \"latest\": \"$latest\" }" > index.json

git config --global user.email "github-actions[bot]@users.noreply.github.com"
git config --global user.name "github-actions[bot]"
git status
if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "Update preview repository"
    git push
else
    echo "No changes to commit"
fi
