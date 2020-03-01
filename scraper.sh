#!/bin/sh

while IFS=, read -r col1 col2
do
  let i=0
  while :; do
    let i++
    echo {$col1}?page={$i}
    resp=$(curl {$col1}?page={$i})
    echo Size: ${#resp}
    if [ ${#resp} -ge 5 ]; then
      echo $resp \
      | jq -r '.[] | [
              .id,
              .link,
              .metadata."@context",
              .metadata."@type",
              .metadata.name,
              .metadata.inLanguage,
              .metadata.image,
              .metadata.author[0]."@type",
              .metadata.author[0].name,
              .metadata.license."@type",
              .metadata.license.url,
              .metadata.license.name
      ] | @csv' >> result.csv
    else
      break
    fi
  done
done < sites.csv
