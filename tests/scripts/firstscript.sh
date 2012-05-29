#!/bin/bash
chmod +x firstscript.sh
echo
echo "This is a test script to run XSLT transformations using Saxon"
echo

printdir()
{
	#Note: This is is a hard-coded path to my instance of Saxon
	#      non-test versions should be bundled with an instance of the jar.
	expath="java -jar $HOME/git/working/saxon9he.jar $1 $2"
	echo "========Begin Saxon output========"
	$expath
}




#If two arguments weren't passed, collect & pass them.  Otherwise, pass them to printdir.
if [ "$#" != "2" ]

then

echo "If your setup is like mine, your XML is here:"
echo "$HOME/git/miapa-etl/nexmlex/treebase-record.xml"
echo
echo "Enter location of XML to be transformed"
read one

echo
echo "If your setup is like mine, your XSLT ile is here:"
echo "$HOME/git/miapa-etl/allmeta.xsl"
echo
echo "Enter location of XSLT file to transform with"
read two


printdir $one $two

else

echo "File Locations Received"
echo
printdir $1 $2


fi
