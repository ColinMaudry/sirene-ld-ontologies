#!/bin/bash

# I use Widodo: https://github.com/dgarijo/Widoco

# Download jar if not present

widocoJar="widoco-1.4.13-jar-with-dependencies.jar"

if [[ ! -f $widocoJar ]]
then
  curl -Lv "https://github.com/dgarijo/Widoco/releases/download/v1.4.13/widoco-1.4.13-jar-with-dependencies.jar" -o $widocoJar
fi

# Generate documentation
java -jar $widocoJar -ontFile sirene.ttl -outFolder sirene -htaccess -oops -rewriteAll -lang "fr-en" -webVowl

# Fix paths
sed -i 's/index\-en.html/index-fr.html/g' sirene/.htaccess

# Move to htdocs (hosting on Gandi simple server)
rm -r htdocs/sirene
mv sirene htdocs


