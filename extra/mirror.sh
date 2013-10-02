#!/bin/bash

#put your redmine URL here, without a trailing slash!
host=http://localhost:3000
#the API token of the user that will perform the download
token=13d57affff4adfc03aa815af9ec6b7d608fd7045
#the directory you can to backup to, without trailing slash!
dir=/tmp/wiki_backup

#cleanup the directory
rm -rf $dir

#mirror the website
wget --mirror --timestamping --no-verbose --page-requisites --base=./ --adjust-extension \
     --directory-prefix $dir --no-host-directories --cut-dirs=1 --convert-links --no-parent \
     --reject "*?parent=*" --header="X-Redmine-Api-Key: $token" \
     $host/wiki_backup/

# wget's --convert-link is not very reliable so...
fgrep -rl "$host/wiki_backup/" $dir | while read f; do
  # in: /tmp/wiki_backup/csac/index.html
  # $host/wiki_backup/salamandre/Wiki.html should be ../salamandre/Wiki.html
  points=$(echo $f|sed "s#$dir/##"|perl -pe 's#[^/]+#..#g; s#..$##;')
  sed -i "s#$host/wiki_backup/#$points#g" $f
done
