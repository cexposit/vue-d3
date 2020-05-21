commitMessage=$1

git rm --cached -r .
git remote rm origin
git init
git add *
git config --global user.email "cexposit@ull.edu.es"
git config --global user.name "cexposit"
git commit -m "${commitMessage}"
git remote add origin https://github.com/cexposit/vue-d3
git push -u origin master
