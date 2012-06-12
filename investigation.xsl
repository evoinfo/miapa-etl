<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.nexml.org/2009"
    version="2.0">
    
    <!-- First draft Investigation ISAtab file, following the 'isaconfig-phylogenetics-prs' config file -->
    <xsl:import href="template.xsl"/>


    <xsl:variable name="ontology-source-reference">
        <xsl:text>ONTOLOGY SOURCE REFERENCE</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Term Source Name</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Term Source File</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Term Source Version</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Term Source Description</xsl:text>
        <xsl:value-of select="$line"/>
    </xsl:variable>

    <xsl:variable name="investigation">
        <xsl:text>INVESTIGATION</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Investigation Identifier</xsl:text>
        <xsl:value-of select="$tab"/>
        <xsl:value-of select="/nexml/meta[@property='tb:identifier.study']/@content"></xsl:value-of>
        <xsl:value-of select="$line"/>
        <xsl:text>Investigation Title</xsl:text>
        <xsl:value-of select="$tab"/>
        <xsl:value-of select="/nexml/meta[@property='dc:title']/@content"></xsl:value-of>
        <xsl:value-of select="$line"/>
        <xsl:text>Investigation Description</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Investigation Submission Date</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Investigation Public Release Date</xsl:text>
        <xsl:value-of select="$tab"/>
        <xsl:value-of select="/nexml/meta[@property='dc:date']/@content"></xsl:value-of>
        <xsl:value-of select="$line"/>
        <xsl:text>Comment [Created with configuration]</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Comment [Last Opened With Configuration]</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Comment [Created With Configuration]</xsl:text>
        <xsl:value-of select="$line"/>
    </xsl:variable>
    
    <xsl:variable name="investigation-publications">
        <xsl:text>INVESTIGATION PUBLICATIONS</xsl:text>
    </xsl:variable>
    <xsl:variable name="investigation-contacts">
        <xsl:text>INVESTIGATION CONTACTS</xsl:text>
    </xsl:variable>
    <xsl:variable name="study">
        <xsl:text>STUDY</xsl:text>
    </xsl:variable>
    <xsl:variable name="study-design-descriptors">
        <xsl:text>STUDY DESIGN DESCRIPTORS</xsl:text>
    </xsl:variable>
    <xsl:variable name="study-publications">
        <xsl:text>STUDY PUBLICATIONS</xsl:text>
    </xsl:variable>
    <xsl:variable name="study-factors">
        <xsl:text>STUDY FACTORS</xsl:text>
    </xsl:variable>
    <xsl:variable name="study-assays">
        <xsl:text>STUDY ASSAYS</xsl:text>
    </xsl:variable>
    <xsl:variable name="study-protocols">
        <xsl:text>STUDY PROTOCOLS</xsl:text>
    </xsl:variable>   
    <xsl:variable name="study-contacts">
        <xsl:text>STUDY CONTACTS</xsl:text>
    </xsl:variable>
   
    <xsl:template match="/" name="investigation">
        <xsl:text>  ==  Output of investigation.xsl:  ==</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:value-of select="$ontology-source-reference"/>
        <xsl:value-of select="$investigation"/>
        <xsl:value-of select="$investigation-publications"/>
        <xsl:value-of select="$investigation-contacts"/>
        <xsl:value-of select="$study"/>
        <xsl:value-of select="$study-design-descriptors"/>
        <xsl:value-of select="$study-publications"/>
        <xsl:value-of select="$study-factors"/>
        <xsl:value-of select="$study-assays"/>
        <xsl:value-of select="$study-protocols"/>
        <xsl:value-of select="$study-contacts"/>
    </xsl:template>
    
</xsl:stylesheet>