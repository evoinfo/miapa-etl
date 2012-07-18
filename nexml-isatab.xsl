<?xml version="1.1" encoding="UTF-8"?>
 <!-- NeXML to ISAtab Converstion -->
<!-- Summer 2012 - Google Summer of Code - NESCent -->

<!-- This file imports a stylesheet corresponding to each of the 3 ISAtab files,
    Investigation, Study, and Assay.  It produces one of each when it encounters
    <<nexml>>, <<characters>>, and <<trees>> elements in the source NeXML file,
    respectively.  

    Output will be in a directory named after the input file, with ISAtab files named
    i_xxxx_n.txt, s_xxxx_n.txt, a_xxxx_n.txt.  
    
    Ex: S1040.xml, which has two <<characters>> and two <<trees>> elements:

    -Output files-
    ./S1040/i_S1040_1.txt
    ./S1040/s_S1040_1.txt
    ./S1040/s_S1040_2.txt
    ./S1040/a_S1040_1.txt
    ./S1040/a_S1040_2.txt

    
    The content of Investigation, Study, and Assay files are determined by templates
    within their respective .xsl files.-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0" xmlns:nex="http://www.nexml.org/2009" xpath-default-namespace="http://www.nexml.org/2009">
    
    <!-- This import will replace each import of template.xsl in the final version -->
    <xsl:import href="template.xsl"/>
    
    <!-- Note:  I have put little thought into the ordering of these imports yet.  They may require a tweak for performance -->
    <xsl:import href="investigation.xsl"/>
    <xsl:import href="study.xsl"/>
    <xsl:import href="assay.xsl"/>
    
    <!-- This template controls the output files.  It takes parameters that tell us whether
        it's an I, S, or A file, outputs a result-document with the correct name, and calls
        the corresponding template-->
    <xsl:template name="fileout">
        <xsl:param name="prefix"/>
        <xsl:param name="assaynum"/>
        <xsl:param name="element"/>
        <xsl:param name="tempname"/>
        <xsl:for-each select=".">
            
            <!-- Construct proper output filepath -->
            <xsl:variable name="filename" select="concat($filebase, '/', $prefix, '_', $filebase, '_', $assaynum, '.txt')" />
            
            <!-- DEBUG: print output file path -->
            <xsl:text>DEBUG: Print output file path -- </xsl:text>
            <xsl:value-of select="$filename" />
            <xsl:value-of select="$line"/>
            
            <!-- Create the document using output path above -->
            <xsl:result-document href="{$filename}">
                <xsl:text>This document was created from the &lt;&lt;</xsl:text>
                <xsl:value-of select="$element"/>
                <xsl:text>&gt;&gt; element in the source file </xsl:text>
                <xsl:value-of select="$filebase"/>
                <xsl:text>.xml</xsl:text>
                <xsl:value-of select="$line"/>
                <xsl:value-of select="$tab"/>
                <xsl:text>Begin ISAtab output:</xsl:text>
                <xsl:value-of select="$line"/>
                
                <!-- Choose template to call based on $tempname parameter -->
                <xsl:choose>                          
                    <xsl:when test="$tempname='assay'">
                        <xsl:call-template name="assay"/>
                    </xsl:when>
                    <xsl:when test="$tempname='study'">
                        <xsl:call-template name="study"/>
                    </xsl:when>
                    <xsl:when test="$tempname='investigation'">
                        <xsl:call-template name="investigation"/>
                    </xsl:when>
                </xsl:choose>              
            </xsl:result-document>         
        </xsl:for-each>      
    </xsl:template>
    
    <!-- This is the main template -->
    <xsl:template match="/">
        
        <!--output an Assay file for each trees element by calling fileout with params-->
        <xsl:for-each select="/nexml/trees">
            <xsl:call-template name="fileout">
                <xsl:with-param name="prefix">
                    <xsl:value-of>a</xsl:value-of>
                </xsl:with-param>
                <xsl:with-param name="assaynum">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
                <xsl:with-param name="element">
                    <xsl:value-of>trees</xsl:value-of>
                </xsl:with-param>
                <xsl:with-param name="tempname">
                    <xsl:value-of>assay</xsl:value-of>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each> 
        
        <!-- output a Study file for each characters element -->
        <xsl:for-each select="/nexml/characters">
            <xsl:call-template name="fileout">
                <xsl:with-param name="prefix">
                    <xsl:value-of>s</xsl:value-of>
                </xsl:with-param>
                <xsl:with-param name="assaynum">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
                <xsl:with-param name="element">
                    <xsl:value-of>characters</xsl:value-of>
                </xsl:with-param>
                <xsl:with-param name="tempname">
                    <xsl:value-of>study</xsl:value-of>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>  
        
        <!-- output an Investigation file for each nexml element -->
        <xsl:for-each select="//nexml">
            <xsl:call-template name="fileout">
                <xsl:with-param name="prefix">
                    <xsl:value-of>i</xsl:value-of>
                </xsl:with-param>
                <xsl:with-param name="assaynum">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
                <xsl:with-param name="element">
                    <xsl:value-of>nexml</xsl:value-of>
                </xsl:with-param>
                <xsl:with-param name="tempname">
                    <xsl:value-of>investigation</xsl:value-of>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>  
    </xsl:template>
</xsl:stylesheet>