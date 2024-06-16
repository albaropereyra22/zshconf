#! /bin/sh -

git add .


if [ "X$1" = "X-h" ];
then
  tee<<EOF
usage: $0 -h:"comment".
EOF
  exit 0;

elif [ -z $1 ];
then
  printf "Enter comment:";
  read comment;
else
  comment="$@";
fi

git commit -m "$comment";
git push
