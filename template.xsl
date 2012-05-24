<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nex="http://www.nexml.org/2009" 
    version="1.0">
    <xsl:strip-space elements="*"/>
    <xsl:output method="text"/>
    
    <!-- These variables should not be defined elsewhere
         Instead, import this file.-->
    <!-- NOTE:  $tab may have multiple &#09;s in it for temporary text readability.  Final should have only one-->
    <xsl:variable name='tab' select="'&#09;'"/>
    <xsl:variable name='line' select="'&#10;'"/>
</xsl:stylesheet>