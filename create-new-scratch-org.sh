#!/bin/sh -e

HEDA_PACKAGE_ID=$1

if [ -z "$HEDA_PACKAGE_ID" ]; then 
    echo "getting heda package id"
    HEDA_PACKAGE_ID=`sfdx force:package:installed:list | awk '$4 ~ /hed/ { print $5 }'`
fi

if [ -z "$HEDA_PACKAGE_ID" ]; then 
    DEAULT_ORG=`sfdx force:config:list | awk '$1 ~ /defaultusername/ {print $2}'`
    echo "HEDA not installed in ${DEFAULT_ORG}. Please provide the HEDA Package ID."
    exit 1;
fi

echo "using package id $HEDA_PACKAGE_ID"

echo "creating scratch org"
sfdx force:org:create -f config/project-scratch-def.json -a hedaScratch -s

echo "deploying pre-setup metadata"
sfdx force:mdapi:deploy -u hedaScratch -d setup/pre -w 5

echo "installing HEDA package in scratch org"
sfdx force:package:install -u hedaScratch -i $HEDA_PACKAGE_ID -w 5

echo "deploying post-setup metadata"
sfdx force:mdapi:deploy -u hedaScratch -d setup/post -w 5

sfdx force:user:permset:assign -n HEDA_Record_Types