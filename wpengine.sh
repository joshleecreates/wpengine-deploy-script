endpoint=$1
echo "Starting the build process..."
#do build here, grunt, gulp, whatever
git checkout --orphan wpengine
git rm -rf --cached .
rm .gitignore
echo "/*" >> .gitignore
echo '!wp-content/' >> .gitignore
echo 'wp-content/uploads' >> .gitignore
cd wp-content/
find . | grep .git | xargs rm -rf
cd ../
git add .
git commit -am "WPEngine build"
git remote add wpengine $endpoint
echo "Pushing to WPEngine..."
git push wpengine wpengine:master --force
echo "Successfully deployed."