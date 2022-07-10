#!/bin/sh

echo 'hugo-build'

echo "dirname ~ $(dirname ~)"
echo "basename ~ $(basename ~)"

echo "~/.ssh"
ls -lh ~/.ssh

echo "ls /root/.ssh"
ls -lh /root/.ssh

cat ~/.ssh/config
cat ~/.ssh/id_rsa

ssh -vT git@github.com

set -e

SOURCE_REPO=$1
BUILD_REPO=$2

echo "SOURCE=$SOURCE_REPO"
echo "BUILD=$BUILD_REPO"

git clone --recursive "${SOURCE_REPO}" source && cd source

git clone --depth=1 "${BUILD_REPO}" public-pages

mkdir public
mv public-pages/.git public/

hugo && cd public

git add -A
git commit -m "auto build by cc332030/hugo-asciidoctor-action" || exit 0
git push

echo 'hugo-build successfully'
