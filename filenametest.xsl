

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="2.0">
  
<xsl:output method="text"/>
<xsl:template match="/">
<!--<xsl:variable name="filename"
  select="concat('3outtest/a_', base-uri(),'.txt')" />
  <out>
  <xsl:value-of select='$filename' /></out>-->
<xsl:value-of select='base-uri()' />
</xsl:template>
</xsl:stylesheet>