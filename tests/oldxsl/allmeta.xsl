<?xml version="1.1" encoding="UTF-8"?>
<!-- This file pulls all meta attribute names and then their values in rows below for an arbitrary NeXML file -->
<!-- Still needed:  
    deal systematically with attributes of main elements (e.g. otus and trees)
    -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0" xmlns:nex="http://www.nexml.org/2009" xpath-default-namespace="http://www.nexml.org/2009">
    
    <!-- This import will replace each import of template.xsl in the final version -->
    <xsl:import href="template.xsl"/>
    
    <!-- Note:  I have put little thought into the ordering of these imports yet.  They may require a tweak for performance -->
    <xsl:import href="investigation.xsl"/>
    <xsl:import href="trees.xsl"/>
    <xsl:import href="otus.xsl"/>
    <xsl:import href="characters.xsl"/>
    <xsl:import href="meta.xsl"/>
    
    <!-- Variable that selects the file name sans extension of the input XML file -->  
    <xsl:variable name="filebase">
        <xsl:analyze-string select='base-uri()' regex="([/]?)([^/]+)([.])([xml]{{1,}}$)"> 
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(2)"/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:variable>
    
    <xsl:template match="/">
        <!--output a assay file for each trees element-->
        <xsl:for-each select="//trees">
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
                    <xsl:value-of>trees</xsl:value-of>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each> 
        
        <!-- output a study file for each characters element -->
        <xsl:for-each select="//characters">
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
                    <xsl:value-of>characters</xsl:value-of>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>  
        
        <!-- output an investigation file for each nexml element -->
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
    
    <xsl:template name="fileout">
        <xsl:param name="prefix"/>
        <xsl:param name="assaynum"/>
        <xsl:param name="element"/>
        <xsl:param name="tempname"/>
        <xsl:for-each select=".">
            <xsl:variable name="filename" select="concat($filebase, '/', $prefix, '_', $filebase, '_', $assaynum, '.txt')" />
            <xsl:value-of select="$filename" />  <!-- Creating  -->
            <xsl:result-document href="{$filename}">
                <xsl:text>This document was created from the &lt;&lt;</xsl:text>
                <xsl:value-of select="$element"/>
                <xsl:text>&gt;&gt; element in the source file </xsl:text>
                <xsl:value-of select="$filebase"/>
                <xsl:text>.xml</xsl:text>
                <xsl:value-of select="$line"/>
                <xsl:value-of select="$tab"/>
                <xsl:text>Begin ISAtab mockup:</xsl:text>
                <xsl:choose>
                    <xsl:when test="$tempname='nexml'">
                        <xsl:call-template name="nexml"/>
                    </xsl:when>
                    <xsl:when test="$tempname='trees'">
                        <xsl:call-template name="trees"/>
                    </xsl:when>
                    <xsl:when test="$tempname='characters'">
                        <xsl:call-template name="characters"/>
                    </xsl:when>
                    <xsl:when test="$tempname='investigation'">
                        <xsl:call-template name="investigation"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:result-document>         
        </xsl:for-each>      
    </xsl:template>
</xsl:stylesheet>