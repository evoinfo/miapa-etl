<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="2.0">
<xsl:output method="text"/>
  
  <!-- This code generates a result document for each tree it finds, and labels the result document by the tree label name.-->
<xsl:template match="/">
  <xsl:for-each select="//tree">
    <xsl:variable name="filename" select="concat('outtest/a_',@label,'.txt')" />
    <xsl:value-of select="$filename" />  <!-- Creating  -->
    <xsl:result-document href="{$filename}">
      <xsl:text>This document was created from the tree element in the source file
      Begin ISAtab mockup of 'meta' element 'content' attributes:
      </xsl:text>
       <xsl:for-each select="meta">
        	    <xsl:text/>"<xsl:value-of select="@content"/>"	<xsl:text/>
      </xsl:for-each>
    </xsl:result-document>
  </xsl:for-each>
</xsl:template>
</xsl:stylesheet>