#!/bin/sh

echo
echo 'hugo-build'

ls -lh ~/.ssh

cat ~/.ssh/config
cat ~/.ssh/id_rsa

set -e

SOURCE_REPO=$1
BUILD_REPO=$2

echo
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

echo
echo 'hugo-build successfully'
