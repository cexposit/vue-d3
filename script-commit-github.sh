read -p "# Enter your message in the commit: " message

git add .
git commit -m "${message}"

#if [ -n "$(git status - porcelain)" ];
#then
#	echo "IT IS CLEAN"
#else
	git status
	echo "Pushing data to remote GitHub repository:"
	git push -u origin master
	echo "Done!"
#fi
