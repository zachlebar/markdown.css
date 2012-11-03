#!/bin/bash

IN_EXT="md"
OUT_EXT="html"
BRANCH="gh-pages"

git stash save "Building Pages"
git checkout "$BRANCH"
git merge master --no-ff

for file in ./*.$IN_EXT
do
    name=`basename "$file" ".$IN_EXT"`
    echo "Exporting $name.$IN_EXT to $name.$OUT_EXT"
    markdown_py -o html5 -e utf8 -f "$TEMP/$name.$OUT_EXT" "$file"
done


git add --all
git commit -m "Automated page build by `whoami`"
git push origin "$BRANCH"
git push github "$BRANCH"
git checkout master
git stash pop
