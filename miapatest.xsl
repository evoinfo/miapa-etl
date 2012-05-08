<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>
<xsl:template match="otus">
  <heading>OTUs contained within this NeXML file:</heading>
	<xsl:for-each select="otu">
		<MIAPA-OTU>
			<xsl:value-of select="@label"/>
		</MIAPA-OTU>
	</xsl:for-each>
</xsl:template>
<xsl:template match="characters">
   <heading>Character types in this NeXML file:</heading>
	<MIAPA-CharType>	
		<xsl:value-of select="@type"/>
	</MIAPA-CharType>
</xsl:template>
</xsl:stylesheet>
