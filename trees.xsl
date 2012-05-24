<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    <xsl:import href="template.xsl"/>
    <!-- Trees template -->
    <!-- Extracts all attribute names from tree elements and their meta children -->
    <xsl:template match='trees'>
        <xsl:value-of select="$line"/>
        <xsl:value-of select="$line"/>
        <xsl:value-of select="$line"/>
        <xsl:text>  ==  Output from trees.xsl: ==</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:for-each select="tree">
            
            <!-- Generate headers the first time around, skiping <<trees>> meta elements -->
            <!-- Problem!  The test below may not evaluate precisely if the meta elements are in a strange order -->
            <!-- I need to re-rewite this stroing nodes in variables -->
            <xsl:if test="position() = 1">
                <xsl:text>Trees Header Row: </xsl:text>  
                <xsl:value-of select="$tab"/>
                <xsl:for-each select="attribute::*">
                    <xsl:value-of select='name()'/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>
                <xsl:for-each select="meta/attribute::*">
                    <xsl:value-of select="name()"/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>
            </xsl:if>
            
            <!--End headers.  Start a new row and print each field then a tab-->
            <xsl:value-of select="$line"/>
            <xsl:text>Tree Row: </xsl:text>  
            <xsl:value-of select="$tab"/>
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
    <!-- This is so the Characters don't get printed-->
    <xsl:template match="characters"/>
</xsl:stylesheet>