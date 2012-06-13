#!/bin/bash

#Draft script for transforming all of treebase

transformfolder()
{
    #Run through every xml file in supertreebase and transform it using nexml-isatab.xsl
    echo "Under Construction"
}

if [ "$#" != "1" ]
then
echo "Enter absolute path of supertreebase folder"
read $stb

transformfolder $stb

else

transformfolder $1

fi