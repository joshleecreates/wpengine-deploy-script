endpoint=$1

echo "Starting the build process..."
grunt build &> /dev/null

if [[ -n $(git status -s) ]]
then
  echo "Please review and commit your changes before continuing..."
  exit
fi

exists=`git show-ref refs/heads/wpengine`
if [ -n "$exists" ]
then
  git branch -D wpengine &> /dev/null
fi

git checkout --orphan wpengine &> /dev/null
git rm -rf --cached .

rm .gitignore
echo "/*\n!wp-content/\nwp-content/uploads" >> .gitignore

cd wp-content/
find . | grep .git | xargs rm -rf
cd ../

git add .
git commit -am "WPEngine build from: $(git log -1 HEAD --pretty=format:%s)$(git rev-parse --short HEAD 2> /dev/null | sed "s/\(.*\)/@\1/")"

git remote add wpengine $endpoint &> /dev/null

echo "Pushing to WPEngine..."
git push wpengine wpengine:master --force

git checkout master
git branch -D wpengine
echo "Successfully deployed."