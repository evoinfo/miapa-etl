<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:local="local.uri"
    xpath-default-namespace="http://www.nexml.org/2009" version="2.0">
    
 
 
    <xsl:template match="/" name="assay">

        <!-- Print headers -->
        <xsl:value-of select="local:empty-cell('Sample Name')"/>
        <xsl:value-of select="local:empty-cell('Material Type')"/>
        <xsl:value-of select="local:empty-cell('Term Source REF')"/>
        <xsl:value-of select="local:empty-cell('Term Accession Number')"/>
        <xsl:value-of select="local:empty-cell('Protocol REF')"/>
        <xsl:value-of select="local:empty-cell('Tree ID')"/>
        <xsl:value-of select="local:empty-cell('Tree Kind')"/>
        <xsl:value-of select="local:empty-cell('Tree Type')"/>
        <xsl:value-of select="local:empty-cell('Tree Quality')"/>
        <xsl:value-of select="local:empty-cell('Derived Data File')"/>
        <xsl:value-of select="$line"/>
        
        <!--Now Content for each trees/tree-->
        <xsl:for-each select="/nexml/trees/tree">
            <xsl:variable name="ct-otus" select="parent::node()/@otus"/>
            <xsl:choose>
                <!-- If there's an OTUs match, populate Sample fields; otherwise empties -->
                <xsl:when test="exists($characters[@otus=$ct-otus])">
                    <xsl:value-of select="local:matrices-as-rows($ct-otus,$characters)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="local:empty-cell()"/>
                    <xsl:value-of select="local:empty-cell()"/>
                    <xsl:value-of select="local:empty-cell()"/>
                    <xsl:value-of select="local:empty-cell()"/>
                    <xsl:value-of select="local:empty-cell()"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="local:empty-cell(@id)"/>
            <xsl:value-of select="local:empty-cell(meta[@property=&quot;tb:kind.tree&quot;]/@content)"/>
            <xsl:value-of select="local:empty-cell(meta[@property=&quot;tb:type.tree&quot;]/@content)"/>
            <xsl:value-of select="local:empty-cell(meta[@property=&quot;tb:quality.tree&quot;]/@content)"/>
            <xsl:value-of select="local:empty-cell(concat($filefull, '/nexml/trees/tree[@id=', @id, ']'))"/>
            <xsl:value-of select="$line"/>
        </xsl:for-each>         
    </xsl:template>
</xsl:stylesheet>
