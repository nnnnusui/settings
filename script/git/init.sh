git init
git commit --allow-empty -m "blank commit."

while true; do
    read -p 'Do you want to commit the file already in the current directory?[y/n]' yn
    case $yn in
        [Yy] ) git add .
               git commit -m ":tada: first commit."
               break;;
        [Nn] ) break;;
        * )   echo "[y/n]で入力してください";;
    esac
done

while true; do
    read -p 'Do you want to push for remote repository?[y/n]' yn
    case $yn in
        [Yy] ) echo 'plz remote repository URL.'
	       read url
               git remote add origin $url
               git push origin master
               break;;
        [Nn] ) break;;
        * )   echo "[y/n]で入力してください";;
    esac
done
