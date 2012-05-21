<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:variable name='tab' select="'&#09;'"/>
    <xsl:variable name='line' select="'&#10;'"/>
<!--    this code works- commented out for test
        <xsl:template match='.'>
        <xsl:value-of select="$line"/> 
        <xsl:apply-templates select="meta"/>
        <xsl:apply-templates select="characters"/>
        <xsl:apply-templates select="otus"/>
    </xsl:template>-->
    <xsl:template match='characters'><xsl:text>characters template</xsl:text></xsl:template>
    <!-- OTUs template -->
<!--    This code works- commented out for test
        <xsl:template match='otus/otu'>
        <!-\- Generate headers the first time around -\->
        <xsl:if test="position() = 1">
            <xsl:value-of select="$line"/>        
            <xsl:text>otus tempate</xsl:text>
            <xsl:value-of select="$line"/>
            <xsl:for-each select="attribute::*">
              <xsl:value-of select='name()'/>
              <xsl:value-of select="$tab"/>
            </xsl:for-each>
            <xsl:for-each select="meta/attribute::*">
                <!-\-<xsl:text>Meta for-each</xsl:text>-\->
                <xsl:value-of select="name()"/>
                <xsl:value-of select="$tab"/>
            </xsl:for-each>
        </xsl:if>
        <!-\-End headers.  Start a new row and print each field then a tab-\->
        <xsl:value-of select="$line"/>
        <!-\- OTU attributes -\->
        <xsl:for-each select="attribute::*">
            <xsl:value-of select='.'/>
            <xsl:value-of select="$tab"/>
        </xsl:for-each>
        <!-\- Meta attributes -\->
        <xsl:for-each select="meta/attribute::*">
            <xsl:value-of select="."/>
            <xsl:value-of select="$tab"/>
        </xsl:for-each>
        <xsl:value-of select="$line"/>
    </xsl:template>-->
    <!--This code doesn't work.  Goal is to pull meta attributes and values from only top level attributes-->
    <xsl:template name="filemeta" match="//meta where not(is(child::meta))">
        <xsl:text>file meta template</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:for-each select="attribute::*">
            <xsl:value-of select='name()'/>
            <xsl:value-of select="$tab"/>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>