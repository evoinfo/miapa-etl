<!-- This XSLT file selects the filename sans extennsion of the xml file  
    it is evaluating and outputs it in valid ISAtab Assayfile naming format.
    With modification it could generate valid I, S, and A files, though an 
    interation scheme is needed. -->
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="2.0">
<xsl:output method="text"/>
  
  <!-- Store the filename sans extension as variable 'filebase'-->
<xsl:variable name="filebase">
  <xsl:analyze-string select='base-uri()' regex="([/]?)([^/]+)([.])([xml]{{1,}}$)"> 
    <xsl:matching-substring>
      <xsl:value-of select="regex-group(2)"/>
    </xsl:matching-substring>
  </xsl:analyze-string>
</xsl:variable>

<xsl:template match="/">
<!-- Build ISAtab Assay filename from filebase variable-->
  <xsl:value-of select='concat("a_",$filebase,".txt")'/>
</xsl:template>
</xsl:stylesheet>