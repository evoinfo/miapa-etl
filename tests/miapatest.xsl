<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>
<!--root element generation.  Need to figure out how to enclose the below in this 
<xsl:template match="/">
<nex:nexml xmlns:nex="http://www.nexml.org/2009"/>
</xsl:template>-->
<!-- OTU label extraction.-->
<xsl:template match="otus">
  <heading>OTUs contained within this NeXML file:</heading>
	<xsl:for-each select="otu">
		<MIAPA-OTU>
			<xsl:value-of select="@label"/>
		</MIAPA-OTU>
	</xsl:for-each>
</xsl:template>
<!--Character type extraction.  I'm having trouble extracting when the attribute uses the 
xsi namespace.-->
<xsl:template match="characters">
   <heading>Character types in this NeXML file:</heading>
	<xsl:for-each select=".">
		<MIAPA-CharType>	
			<xsl:value-of select="@type"/>
			<MIAPA-CharLabel>
				<xsl:value-of select="@label"/>
			</MIAPA-CharLabel>
		</MIAPA-CharType>
	</xsl:for-each>
</xsl:template>
<!-- Tree property extraction.  This example starts to dig down into the complexities 
of the fact that most of the MIAPA relevant information are represented attributes of 
nexml meta elements-->
<xsl:template match="trees">
   <heading>Tree properties in this NeXML file:</heading>
	<xsl:for-each select="tree/meta">
		<MIAPA-TreeProp>	
			<xsl:value-of select="@property"/>
		</MIAPA-TreeProp>
	</xsl:for-each>
</xsl:template>
<!-- THis was my attempt to close the nexml element from above but Saxon didn't like it, 
telling me the element wasn't closed.
<xsl:template match="/">
</nexml>
</xsl:template>-->
</xsl:stylesheet>
