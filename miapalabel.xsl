<!-- this file experements with labeling certain elements with MIAPA attributes-->
<!--<?xml version="1.0" ?>-->
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:template match="/">
  <xsl:for-each select="otus/otu">
    <xsl:variable name="label" select="@label"/>
    <xsl:element name="$label">
 <!--     <xsl:value-of select="artist" /> -->
    </xsl:element>
    <br />
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>