This project is developing tools to Extract, Transform, and Load (ETL) MIAPA-compliant data from NeXML files into valid ISAtab format.  

It is part of a Google Summer of Code project sponsored by the National Evolutionary Synthesis Center in Durham, North Carolina, USA

<<<<<<< HEAD
##Links
* [NESCent Project Wiki Page](http://bit.ly/ehmiapawiki)
=======
###	== Extract ==
To extract MIAPA-relevant information out of NeXML files I'll use XSL files and a Java-based XSLT processor.  This processor is currently Saxon 9 HE.

###	== Transform ==
I'll transform the extracted information above into ISAtab files.

###	  == Load ==
The ISAtab files should be able to be loaded into ISAtools for curation, etc, workflows.


##			Latest Update
_______________________________________________________________________________________
Currently (May 23 2012), allmeta.xsl can be run to transform NeXML files into labeled, tabular lists 
of values corresponding with the major NeXML elements.  Work continues on several fronts:

- Starting a shell script or other interface for arbitrary input & transformation
- Configuring an ISAtab format for NeXML
	- Note: Test files are able to name in correct ISAtab format based on the source file name
- Identifying the data that are MIAPA-relevant
_______________________________________________________________________________________


== Links ==
NESCent Project Wiki Page:
http://informatics.nescent.org/wiki/PhyloSoC:_NeXML_to_MIAPA_mapping
>>>>>>> XSL-testing

* [Working Documentation (Google Docs)](bit.ly/ehmiapafolder)

* [NeXML](http://nexml.org)

* [National Evolutionary Synthesis Center](http://nescent.org)

* [ISA Tools](http://isatools.org)


To contribute, please fork and use pull requests.
