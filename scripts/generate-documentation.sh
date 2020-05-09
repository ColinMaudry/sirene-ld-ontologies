#!/bin/bash

# I use Widodo: https://github.com/dgarijo/Widoco

# Download jar if not present

widocoJar="./ontologies/widoco-1.4.13-jar-with-dependencies.jar"

if [[ ! -f $widocoJar ]]
then
  curl -Lv "https://github.com/dgarijo/Widoco/releases/download/v1.4.13/widoco-1.4.13-jar-with-dependencies.jar" -o $widocoJar
fi

# Generate documentation
java -jar $widocoJar -ontFile ontologies/sirene.ttl -outFolder ontologies/html -oops -rewriteAll -lang "fr" -htaccess -webVowl
