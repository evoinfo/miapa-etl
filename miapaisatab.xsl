<!-- this file experements with generating ISAtab-like output-->
<!--<?xml version="1.0" ?>-->
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>
<!--	<xsl:template match="/">
		<xsl:comment>this is a sample file generated from miapaisatab.xsl</xsl:comment>
	</xsl:template> -->
	<xsl:template match="otus">
	<xsl:text>this is a sample file generated from miapaisatab.xsl
	</xsl:text>
	<xsl:text>this section of the file is pulling the 'label' attribute from each otu element
	</xsl:text>
	<xsl:text>It then inserts a tab in between each.
	</xsl:text>
		<xsl:for-each select="otu">
  		    <xsl:text/>"<xsl:value-of select="@label"/>"	<xsl:text/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
