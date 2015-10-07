#!/bin/bash

EXEC=$0

function usage {
  echo "Usage:"
  echo "  $EXEC [--host=HOSTNAME] --path=PATH"
  echo
  echo "Uploads the net-snmp Debian packages to the given repository server"
}

for arg in "$@"
do
  case $arg in
    -h=*|--host=*)
      REPOHOST="${arg#*=}"
      ;;
    -p=*|--path=*)
      REPOPATH="${arg#*=}"
      ;;
    *)
      echo "Unrecognised argument ($arg)"
      echo
      usage
      exit 2
      ;;
  esac
done

if [[ $REPOPATH == "" ]]
then
  echo "--path must be provided"
  echo
  usage
  exit 2
fi


DEBS=`make print_debs`

for deb in $DEBS
do
  if [[ ! -f $deb ]]
  then
    echo "$deb does not exist, have you build the debian packages?"
    exit 3
  fi
done

if [[ $REPOHOST == "" ]]
then
  echo Publishing debian packages to $REPOPATH.
  cp $DEBS $REPOPATH/binary
  cd $REPOPATH
  dpkg-scanpackages binary /dev/null > binary/Packages
  gzip -9c binary/Packages >binary/Packages.gz
  rm -f binary/Release binary/Release.gpg
  apt-ftparchive -o APT::FTPArchive::Release::Codename=binary release binary > binary/Release
else
  echo Publishing debian packages to $REPOHOST:$REPOPATH.
  scp $DEBS $REPOHOST:$REPOPATH/binary
  ssh $REPOHOST "cd $REPOPATH;
    dpkg-scanpackages binary /dev/null > binary/Packages;
    gzip -9c binary/Packages >binary/Packages.gz;
    rm -f binary/Release binary/Release.gpg;
    apt-ftparchive -o APT::FTPArchive::Release::Codename=binary release binary > binary/Release"
fi
