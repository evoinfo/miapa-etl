#!/bin/bash
chmod +x firstscript.sh
echo
echo "This is a test script to run XSLT transformations using Saxon"
echo

printdir()
{
	#Note:  this is a hard-coded path to Saxon
	expath="java -jar $HOME/git/working/saxon9he.jar $1 $2"
	echo "========Begin Saxon output========"
	$expath
}




#If two arguments weren't passed, collect them
if [ "$#" != "2" ]

then

echo "If your setup is like mine, your XML is here:"
echo "/Users/elliott/git/miapa-etl/nexmlex/treebase-record.xml"
echo
echo "Enter location of XML to be transformed"
read one

echo
echo "If your setup is like mine, your XSLT ile is here:"
echo "/Users/elliottgit/miapa-etl/allmeta.xsl"
echo
echo "Enter location of XSLT file to transform with"
read two


printdir $one $two

else

echo "File Locations Received"
echo
printdir $1 $2


fi
