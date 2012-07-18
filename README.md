This project is a conversion tool to Extract, Transform, and Load (ETL) MIAPA-compliant data from NeXML files into valid ISAtab format.  

You can find details on the logical mapping between the formats in the links section.


### Usage

From the project directory, run

	./miapaisatab.sh 

The script has inline instructions.  Requires a [SAXON jar] (http://sourceforge.net/projects/saxon/files/).  I use [SAXON 9.4 HE] (http://sourceforge.net/projects/saxon/files/Saxon-HE/9.4/)

Optionally, you can pass it arguments:

	./miapaisatab.sh path/to/NeXML.file ./nexml-isatab.xsl path/to/your.SAXON.jar

The tool will create an output directory named after the input file and place the ISAtab files in this directory.

### Examples

The examples directory contains NeXML files and corresponding ISAtab files, taken from Rutger Vos' [supertreebase](https://github.com/rvosa/supertreebase).  You should be able to duplicate them using the tool.  For instance, to transform the treebase file `S10410.xml` from the examples, type

	./miapaisatab.sh examples/S10410/S10410.xml ./nexml-isatab.xsl ~/git/working/SAXON9he.jar

Assuming `~/git/working/SAXON9he.jar` actually points to your SAXON jar, this should produce the following files in your project directory:
``` 
S10410/a_S10410_1.txt
S10410/a_S10410_2.txt
S10410/i_S10410_1.txt
S10410/s_S10410_1.txt
S10410/s_S10410_2.txt
S10410/s_S10410_3.txt
S10410/s_S10410_4.txt
```
These should be identical to their counterparts in `examples/S10410`.


### Latest Update
Currently (July 18 2012):
The XSLT converts TreeBASE NeXML files into ISAtab files correctly.  Work continues:

- On a finalized ISA config for Phylogenetics


#### Links 
* [NESCent Project Wiki Page:] (http://informatics.nescent.org/wiki/PhyloSoC:_NeXML_to_MIAPA_mapping)

* [Working Documentation (Google Docs)](bit.ly/ehmiapafolder)

* [NeXML](http://nexml.org)

* [National Evolutionary Synthesis Center](http://nescent.org)

* [ISA Tools](http://isatools.org)


To contribute, please fork and use pull requests.
