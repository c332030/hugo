#!/bin/sh

echo 'hugo-build'

set -e

SOURCE=$1
BUILD=$2

echo "SOURCE=$SOURCE"
echo "BUILD=$BUILD"

git clone --recursive "${SOURCE}" source && cd source

git clone --depth=1 "${BUILD}" public-pages

mkdir public
mv public-pages/.git public/

hugo && cd public

git add -A
git commit -m "auto build by cc332030/hugo-asciidoctor-action" || exit 0
git push

echo 'hugo-build successfully'
