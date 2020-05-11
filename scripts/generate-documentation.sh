#!/bin/bash

# I use Widodo: https://github.com/dgarijo/Widoco

# Download jar if not present

widocoJar="widoco-1.4.13-jar-with-dependencies.jar"

if [[ ! -f $widocoJar ]]
then
  curl -Lv "https://github.com/dgarijo/Widoco/releases/download/v1.4.13/widoco-1.4.13-jar-with-dependencies.jar" -o $widocoJar
fi

# Generate documentation
for code in sirene compub
do
  echo ""
  echo "Generating documentation for $code:..."
  java -jar $widocoJar -ontFile $code.ttl -outFolder $code -htaccess -oops -rewriteAll -lang "fr-en" -webVowl &> /dev/null

  # Fix paths
  sed -i 's/index\-en.html/index-fr.html/g' $code/.htaccess

  # Change WebVOWL display configuration
  # Not working: https://github.com/dgarijo/Widoco/issues/390
  jq '
  .settings.filter.degreesSliderValue |= "2" |
  .settings.gravity.datatypeDistance |= 450 
  ' $code/webvowl/data/ontology.json > temp
  mv temp $code/webvowl/data/ontology.json

  # Move to htdocs (hosting on Gandi simple server)
  rm -rf htdocs/$code
  mv $code htdocs

done


