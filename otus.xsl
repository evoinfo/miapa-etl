<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.nexml.org/2009"
    version="1.0">
    <xsl:import href="template.xsl"/>
    <!-- OTUs template -->
    <!-- Extracts all attribute names from otu elements and their meta children -->
    <!-- I need to re-rewite this stroing nodes in variables -->
    <xsl:template match='otus'>
        <xsl:value-of select="$line"/>
        <xsl:value-of select="$line"/>
        <xsl:text>  ==  Output from otus.xsl: ==</xsl:text>
        <xsl:for-each select="otu">
            <!-- Generate headers the first time around, skipping OTUs meta elements -->
            <!-- Problem!  The test below may not evaluate precisely if the meta elements are in a strange order -->
            <xsl:if test="position() = 1  + count(../meta)">
                <xsl:value-of select="$line"/>        
                <xsl:text>OTU Header Row: </xsl:text>
                <xsl:value-of select="$tab"/>
                <xsl:for-each select="attribute::*">
                    <xsl:value-of select='name()'/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>
                
                <!-- This code prints subsidiary Meta attribtue names.  
                     Not sure I need this but should use node variables anyways -->
                <xsl:for-each select="meta/attribute::*">
                    <xsl:value-of select="name()"/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>
            </xsl:if>
            
            <!--End headers.  Start a new row and print each field then a tab-->
            <xsl:value-of select="$line"/>
            <xsl:text>OTU Row: </xsl:text>           
            <!-- OTU attributes -->
            <xsl:for-each select="attribute::*">
                <xsl:value-of select='.'/>
                <xsl:value-of select="$tab"/>
            </xsl:for-each>
            <!-- Meta attributes -->
            <xsl:for-each select="meta/attribute::*">
                <xsl:value-of select="."/>
                <xsl:value-of select="$tab"/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>