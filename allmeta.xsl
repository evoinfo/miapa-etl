<?xml version="1.1" encoding="UTF-8"?>
<!-- This file pulls all meta attribute names and then their values in rows below for an arbitrary NeXML file -->
<!-- Still needed:  
    deal systematically with attributes of main elements (e.g. otus and trees)
    -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0" xmlns:nex="http://www.nexml.org/2009" xpath-default-namespace="http://www.nexml.org/2009">
    
    <!-- Note:  I have put little thought into the ordering of these imports yet.  They may require a tweak for performance -->
    <xsl:import href="trees.xsl"/>
    <xsl:import href="otus.xsl"/>
    <xsl:import href="characters.xsl"/>
    <xsl:import href="meta.xsl"/>
    <!-- Note: meta.xsl has to have a match="/", so I've put the xsl:apply-templates in there. -->
</xsl:stylesheet>