#!/usr/bin/zsh
# commit dev
git checkout dev
stack exec site clean
stack exec site build
git push -f origin dev
# commit master
git fetch --all
git checkout -b master --track origin/master
cp -a _site/. .
git add --all & git commit -am "published on `date`"
git push -f origin master
# back to dev and delete master
git checkout -f dev
git branch -D master
# sync to andrew
rsync -r -a -vv --delete _site/ yeshengm@linux.andrew.cmu.edu:~/www/