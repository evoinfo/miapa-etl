<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:nex="http://www.nexml.org/2009" exclude-result-prefixes="xs"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xpath-default-namespace="http://www.nexml.org/2009" version="2.0">
   
    <xsl:import href="template.xsl"/>
    <xsl:variable name="litcharmeta"
        select="/nex:nexml/characters/meta[@xsi:type='nex:LiteralMeta']"/>
    <xsl:variable name="rescharmeta"
        select="/nex:nexml/characters/meta[@xsi:type='nex:ResourceMeta']"/>
    <xsl:template match="/" name="study">
        <xsl:text> == Output of Study.xsl: ==</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:for-each select="$litcharmeta">

            <!-- Print headers the first time around -->
            <xsl:if test="position()=1">
                <xsl:text>Literal Metadata: </xsl:text>
                <!-- Headers should be taken from ISAconfig
                <xsl:value-of select="$tab"/>
                <xsl:for-each select="attribute::*">
                    <xsl:value-of select="name()"/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>-->
                <xsl:value-of select="$line"/>
            </xsl:if>

            <!-- Print the attribute values separated by tabs -->
            <xsl:value-of select="@property"/>
            <xsl:value-of select="$tab"/>
            <xsl:value-of select="@content"/>
            <xsl:value-of select="$tab"/>
            <xsl:value-of select="@datatype"/>
            <xsl:value-of select="$tab"/>
            <xsl:value-of select="@id"/>
            <xsl:value-of select="$line"/>
        </xsl:for-each>

        <xsl:value-of select="$line"/>
        <xsl:value-of select="$line"/>

        <xsl:for-each select="$rescharmeta">

            <!-- Print headers the first time around -->
            <xsl:if test="position()=1">
                <xsl:text>Resource Metadata: </xsl:text>
                <!-- These should come from the ISA config
                <xsl:value-of select="$tab"/>
                <xsl:for-each select="attribute::*">
                    <xsl:value-of select="name()"/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>-->
                <xsl:value-of select="$line"/>
            </xsl:if>

            <!-- Print the attribute values separated by tabs -->
            <xsl:value-of select="@rel"/>
            <xsl:value-of select="$tab"/>
            <xsl:value-of select="@href"/>
            <xsl:value-of select="$tab"/>
            <xsl:value-of select="@id"/>
            <xsl:value-of select="$tab"/>
            <xsl:value-of select="$line"/>
        </xsl:for-each>
        
        <!-- Now, process character state matrices -->
        <xsl:for-each select="/nexml/characters">
            <xsl:text>TBD: Characters element processing</xsl:text>
            <xsl:value-of select="$line"/>
        </xsl:for-each>
        
    </xsl:template>
</xsl:stylesheet>
