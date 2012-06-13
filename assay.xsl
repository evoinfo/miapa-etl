<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.nexml.org/2009" version="2.0">
    <xsl:import href="template.xsl"/>
    <!-- Trees template -->
    <!-- Extracts all attribute names from tree elements and their meta children -->
    <xsl:template match="/" name="assay">

        <xsl:value-of select="$line"/>
        <xsl:text>  ==  Output from assay.xsl: ==</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:for-each select="/nexml/trees">

            <!-- Generate headers the first time around, skiping <<trees>> meta elements -->
            <!-- Problem!  The test below may not evaluate precisely if the meta elements are in a strange order -->
            <!-- I need to re-rewite this stroing nodes in variables -->
            
            <xsl:text>Trees Element #</xsl:text>
            <xsl:value-of select="position()"/>
            <xsl:value-of select="$line"/>
            <xsl:for-each select="attribute::*">
                <xsl:value-of select="name()"/>
                <xsl:value-of select="$tab"/>
            </xsl:for-each>
            <xsl:value-of select="$line"/>
            <xsl:for-each select="attribute::*">
                <xsl:value-of select="."/>
                <xsl:value-of select="$tab"/>
            </xsl:for-each>
            <xsl:value-of select="$line"/>
            <xsl:value-of select="$line"/>
            <xsl:text>Meta Elements: </xsl:text>
            <xsl:value-of select="$tab"/>
            <xsl:value-of select="$line"/>

            <!-- THis should be written ala study.xsl, and conforming to ISA standard -->
            <xsl:for-each select="meta">
                <xsl:text>Meta element #</xsl:text>
                <xsl:value-of select="position()"/>
                <xsl:value-of select="$line"/>
            </xsl:for-each>

            <xsl:value-of select="$line"/>

            <xsl:text>Tree elements:</xsl:text>
            <xsl:value-of select="$line"/>
            
            <xsl:for-each select="tree">            
                <xsl:text>Tree element #</xsl:text>
                <xsl:value-of select="position()"/>
                <xsl:value-of select="$line"/>
            </xsl:for-each>
            <xsl:value-of select="$line"/>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
