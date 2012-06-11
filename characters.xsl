<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:nex="http://www.nexml.org/2009" xpath-default-namespace="http://www.nexml.org/2009"
    version="1.0">
    <xsl:import href="template.xsl"/>
    <xsl:variable name="litcharmeta" select="/nex:nexml/characters/meta[@xsi:type='nex:LiteralMeta']"/>
    <xsl:variable name="rescharmeta" select="/nex:nexml/characters/meta[@xsi:type='nex:ResourceMeta']"/>
    <xsl:template match="characters">
        <xsl:value-of select="$line"/>
        <xsl:value-of select="$line"/>
        <xsl:value-of select="$line"/>
        <xsl:text>  ==  Output from characters.xsl: ==</xsl:text>
        <xsl:value-of select="$line"/>   
        <xsl:for-each select="$litcharmeta">
            
            <!-- Print headers the first time around -->
            <xsl:if test="position()=1">
                <xsl:text>LiteralMeta Character Headers: </xsl:text>
                <xsl:value-of select="$tab"/>
                <xsl:for-each select="attribute::*">
                    <xsl:value-of select='name()'/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>
                <xsl:value-of select="$line"/>
            </xsl:if>
            
            <!-- Print the attribute values separated by tabs -->
            <xsl:text>LiteralMeta Characters Row: </xsl:text>
            <xsl:value-of select="$tab"/>
            <xsl:for-each select="attribute::*">
                <xsl:value-of select='.'/>
                <xsl:value-of select="$tab"/>
            </xsl:for-each>
            <xsl:value-of select="$line"/>
        </xsl:for-each>
        
        <xsl:value-of select="$line"/>
        <xsl:value-of select="$line"/>
        
        <xsl:for-each select="$rescharmeta">
            
            <!-- Print headers the first time around -->
            <xsl:if test="position()=1">
                <xsl:text>ResourceMeta Character Headers: </xsl:text>
                <xsl:value-of select="$tab"/>
                <xsl:for-each select="attribute::*">
                    <xsl:value-of select='name()'/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>
                <xsl:value-of select="$line"/>
            </xsl:if>
            
            <!-- Print the attribute values separated by tabs -->
            <xsl:text>ResourceMeta Characters Row: </xsl:text>
            <xsl:value-of select="$tab"/>
            <xsl:for-each select="attribute::*">
                <xsl:value-of select='.'/>
                <xsl:value-of select="$tab"/>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>