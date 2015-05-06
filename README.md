# Codeship / Vagrant for WPEngine
WPEngine doesn't support Composer, Gulp, Grunt, Bower or other modern development tools. This bash script will will update the root .gitignore (and clear the cache) so all files are ignored, except those in the `wp-content/` folder. It will then remove any .git related files in the wp-content/ folder so submodules and compiled assets are included. Finally, it will push up the branch to WPEngine (replacing capistrano). This is all completed on a separate WPEngine branch which is created initially and deleted after completion.

# Usage
1. Edit the `$1` variable on the first line to your actual endpoint (A WP Engine git URL).
2. Ensure you upload Codeship's public key to your WP Engine account.
3. Ensure you have a git name and email configured during your "setup" configuration in Codeship.
4. Copy and paste the script into the Codeship deploy script. Push to deploy.
