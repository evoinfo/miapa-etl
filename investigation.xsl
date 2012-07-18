<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="local.uri"
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
        <xsl:value-of select="$line"/>
        <xsl:text>Investigation Title</xsl:text>
        <xsl:value-of select="$tab"/>
        <xsl:value-of select="$line"/>
        <xsl:text>Investigation Description</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Investigation Submission Date</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Investigation Public Release Date</xsl:text>
        <xsl:value-of select="$tab"/>
        <xsl:value-of select="$line"/>
        <xsl:text>Comment [Created with configuration]</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Comment [Last Opened With Configuration]</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:text>Comment [Created With Configuration]</xsl:text>
        <xsl:value-of select="$line"/>
    </xsl:variable>    
    <xsl:variable name="investigation-publications">
        <xsl:text>INVESTIGATION PUBLICATIONS</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Investigation PubMed ID</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Investigation Publication DOI</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Investigation Publication Author list</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Investigation Publication Title</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Investigation Publication Status</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Investigation Publication Status Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Investigation Publication Status Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
    </xsl:variable>
    <xsl:variable name="investigation-contacts">
        <!-- TODO: Should this be regexed out of the dc:contributor data? -->
        <xsl:text>INVESTIGATION CONTACTS</xsl:text><xsl:value-of select="$line"/>
        <xsl:text>Investigation Person Last Name</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>	
        <xsl:text>Investigation Person First Name</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Investigation Person Mid Initials</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>			
        <xsl:text>Investigation Person Email</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Investigation Person Phone</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>					
        <xsl:text>Investigation Person Fax</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>			
        <xsl:text>Investigation Person Address</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>	
        <xsl:text>Investigation Person Affiliation</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>	
        <xsl:text>Investigation Person Roles</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>	
        <xsl:text>Investigation Person Roles Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>				
        <xsl:text>Investigation Person Roles Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
    </xsl:variable>
    
    <!-- TODO: this section should repeat once per study -->
    <xsl:variable name="study">
        <xsl:value-of select="$line"/>
        <xsl:text>STUDY</xsl:text><xsl:value-of select="$line"/>
        <xsl:text>Study Identifier</xsl:text><xsl:value-of select="$tab"/>
        <xsl:value-of select="$pubid"/><xsl:value-of select="$line"/>
        <xsl:text>Study Title</xsl:text><xsl:value-of select="$tab"/>
        <xsl:value-of select="$pubtitle"></xsl:value-of><xsl:value-of select="$line"/>	
        <xsl:text>Study Submission Date</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Public Release Date</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>	
        <xsl:text>Study Description</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>				
        <xsl:text>Study File Name</xsl:text><xsl:value-of select="$tab"/>
        <xsl:value-of select="$filefull"/><xsl:value-of select="$line"/>
    </xsl:variable>
    <xsl:variable name="study-design-descriptors"><xsl:value-of select="$line"/>
        <xsl:text>STUDY DESIGN DESCRIPTORS</xsl:text><xsl:value-of select="$line"/>
        <xsl:text>Study Design Type</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>	
        <xsl:text>Study Design Type Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>					
        <xsl:text>Study Design Type Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>	
    </xsl:variable>
    <xsl:variable name="study-publications"><xsl:value-of select="$line"/>
        <xsl:text>STUDY PUBLICATIONS</xsl:text><xsl:value-of select="$line"/>
        <xsl:text>Study PubMed ID</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Publication DOI</xsl:text><xsl:value-of select="$tab"/>
        <xsl:value-of select="$pubdoi"/><xsl:value-of select="$line"/>
        <xsl:text>Study Publication Author list</xsl:text><xsl:value-of select="$tab"/>
        <xsl:value-of select="$pubauthors"/><xsl:value-of select="$line"/>
        <xsl:text>Study Publication Title</xsl:text><xsl:value-of select="$tab"/>
        <xsl:value-of select="$pubtitle"/><xsl:value-of select="$line"/>				
        <xsl:text>Study Publication Status</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Publication Status Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>							
        <xsl:text>Study Publication Status Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
    </xsl:variable>
    <xsl:variable name="study-factors">
        <xsl:text>STUDY FACTORS</xsl:text><xsl:value-of select="$line"/>
        <xsl:text>Study Factor Name</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Factor Type</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Factor Type Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Factor Type Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
    </xsl:variable>
    <!-- Todo: this section should have one column of results per //tree -->
    <xsl:variable name="study-assays">
        <xsl:text>STUDY ASSAYS</xsl:text><xsl:value-of select="$line"/>
        <xsl:text>Study Assay Measurement Type</xsl:text><xsl:value-of select="$tab"/>
        <xsl:value-of select="$treetypekinds"/><xsl:value-of select="$line"/>
        <xsl:text>Study Assay Measurement Type Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Assay Measurement Type Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Assay Technology Type</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Assay Technology Type Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Assay Technology Type Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Assay Technology Platform</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Assay File Name</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
    </xsl:variable>
    <xsl:variable name="study-protocols">
        <xsl:text>STUDY PROTOCOLS</xsl:text><xsl:value-of select="$line"/>
        <xsl:text>Study Protocol Name</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Protocol Type</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Protocol Type Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Protocol Type Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Protocol Description</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Protocol URI</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>					
        <xsl:text>Study Protocol Version</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>					
        <xsl:text>Study Protocol Parameters Name</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Protocol Parameters Name Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>						
        <xsl:text>Study Protocol Parameters Name Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>					
        <xsl:text>Study Protocol Components Name</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>		
        <xsl:text>Study Protocol Components Type</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>							
        <xsl:text>Study Protocol Components Type Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>							
        <xsl:text>Study Protocol Components Type Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
    </xsl:variable>   
    <xsl:variable name="study-contacts">
        <xsl:text>STUDY CONTACTS</xsl:text><xsl:value-of select="$line"/>
        <xsl:text>Study Person Last Name</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Person First Name</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Person Mid Initials</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
        <xsl:text>Study Person Email</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>					
        <xsl:text>Study Person Phone</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>							
        <xsl:text>Study Person Fax</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>						
        <xsl:text>Study Person Address</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>				
        <xsl:text>Study Person Affiliation</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>				
        <xsl:text>Study Person Roles</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>			
        <xsl:text>Study Person Roles Term Accession Number</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>							
        <xsl:text>Study Person Roles Term Source REF</xsl:text><xsl:value-of select="$tab"/><xsl:value-of select="$line"/>
    </xsl:variable>
   
    <xsl:template match="/" name="investigation">
        <xsl:text>  ==  Output of investigation.xsl:  ==</xsl:text>
        <xsl:value-of select="$line"/>
        <xsl:value-of select="$ontology-source-reference"/><xsl:value-of select="$line"/>
        <xsl:value-of select="$investigation"/><xsl:value-of select="$line"/>
        <xsl:value-of select="$investigation-publications"/><xsl:value-of select="$line"/>
        <xsl:value-of select="$investigation-contacts"/><xsl:value-of select="$line"/>
        <xsl:value-of select="$study"/><xsl:value-of select="$line"/>
        <xsl:value-of select="$study-design-descriptors"/><xsl:value-of select="$line"/>
        <xsl:value-of select="$study-publications"/><xsl:value-of select="$line"/>
        <xsl:value-of select="$study-factors"/><xsl:value-of select="$line"/>
        <xsl:value-of select="$study-assays"/><xsl:value-of select="$line"/>
        <xsl:value-of select="$study-protocols"/><xsl:value-of select="$line"/>
        <xsl:value-of select="$study-contacts"/><xsl:value-of select="$line"/>
    </xsl:template>
    
</xsl:stylesheet>