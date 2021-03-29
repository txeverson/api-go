git config --global user.email "tx.everson@gmail.com"
git config --global user.name "Everson Teixeira"
git init
git remote add origin https://github.com/txeverson/api-go.git
git fetch origin +refs/heads/master
git fetch origin 'refs/tags/*:refs/tags/*'
git checkout master

VERS_OLD=$(git tag -l --sort=-v:refname "*-stable" | head -1)
MAJOR=$(echo $VERS_OLD | cut -d. -f1)
MINOR=$(echo $VERS_OLD | cut -d. -f2)
PATCH=$(echo $VERS_OLD | cut -d. -f3 | cut -d- -f1)

if [ -z "$MAJOR" ]; then
  MAJOR=1
fi

if [ -z "$MINOR" ]; then
  MINOR=0
else
  MINOR=$(($MINOR+1))
fi

VERS_NEW=$MAJOR.$MINOR."0-stable"

git tag -a $VERS_NEW -m $VERS_NEW
git push origin --tags

echo $VERS_NEW

