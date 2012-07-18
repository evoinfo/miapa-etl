<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:local="local.uri" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nex="http://www.nexml.org/2009" xpath-default-namespace="http://www.nexml.org/2009"
    version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:output method="text"/>
    
    <!-- These variables should not be defined elsewhere
         Instead, import this file.-->
    <!-- NOTE:  $tab may have multiple &#09;s in it for temporary text readability.  Final should have only one-->
    <xsl:variable name='tab' select="'&#09;'"/>
    <xsl:variable name='line' select="'&#10;'"/>
    <xsl:variable name='empty' select="'&quot;&quot;'"/>
    
    <!-- TODO: replace all refs to this var with local:cell('') -->
    <xsl:variable name="empty-tab" select="concat($empty, $tab)"/>
    
    <!-- Location Variables - used in functions without context -->
    <xsl:variable name="characters" select="/nexml/characters"/>
    <xsl:variable name="trees" select="/nexml/trees"/>
    <xsl:variable name="nexml" select="/nexml"/>
    <xsl:variable name="root" select="/"/>
    <xsl:variable name="otus" select="/nexml/otus"></xsl:variable>
    
    <!-- Variable that selects the file name sans extension of the input XML file -->  
    <xsl:variable name="filebase">
        <xsl:analyze-string select='base-uri()' regex="([/]?)([^/]+)([.])([xml]{{1,}}$)"> 
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(2)"/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:variable>
    
    <!-- Variable that selects the file name sans extension of the input XML file -->  
    <xsl:variable name="filefull">
        <xsl:analyze-string select='base-uri()' regex="([/]?)([^/]+)([.])([xml]{{1,}}$)"> 
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(2)"/>
                <xsl:value-of select="regex-group(3)"/>
                <xsl:value-of select="regex-group(4)"/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:variable>

    
    <!-- Publication variables - Used in Study and Investigation-->
    <xsl:variable name="pubid" select="/nexml/meta[@property='tb:identifier.study']/@content"/>
    <xsl:variable name="pubtitle" select="/nexml/meta[@property='dc:title']/@content"/>
    <xsl:variable name="pubdate" select="/nexml/meta[@property='dc:date']/@content"/>
    <xsl:variable name="pubauthors" select="/nexml/meta[@property='dc:creator']/@content"/>
    <xsl:variable name="pubdoi" select="/nexml/meta[@property='prism:doi']"/>
    
    
    <!-- Tree variables - used in I S and A files -->
    <xsl:variable name="treetypekinds">
        <xsl:for-each select="/nexml/trees/tree">
            <xsl:value-of select="./meta[@property='tb:type.tree']/@content"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="./meta[@property='tb:kind.tree']/@content"/>
            <xsl:value-of select="$tab"/>
        </xsl:for-each>
    </xsl:variable>
    
    <!-- Functions -->

    <!--Todo: make this work when there are no matches & more than one match-->
    <xsl:function name="local:matrices-as-rows">
    <!-- Takes a matrix and a characters row and returns metadata-->
        <!-- note: This must be manually aligned to the column headers -->
        <xsl:param name="otus-param"/>
        <xsl:param name="characters-param"/>
        <xsl:value-of select="local:enquote($characters-param[@otus=$otus-param]/@id)"/>
        <xsl:value-of select="local:enquote($characters-param[@otus=$otus-param]/meta[@property='tb:type.matrix']/@content)"/>
        <xsl:value-of select="$empty-tab"/>
        <xsl:value-of select="$empty-tab"/>
        <xsl:value-of select="$empty-tab"/>
    </xsl:function>
    
    <xsl:function name="local:enquote">
    <!-- Takes input and surrounds each node in quotes and tabs -->
        <xsl:param name="node"/>
        <xsl:for-each select="$node">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>"</xsl:text>
            <xsl:if test="position()=last()"></xsl:if>
            <xsl:value-of select="$tab"/>
        </xsl:for-each>
    </xsl:function>
    
    <xsl:function name="local:cell">
        <!-- Takes text input and quotes and tabs it.  Eqivalent to a tab delimited cell -->
        <xsl:param name="text"/>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="string($text)"/>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="$tab"/>
    </xsl:function>

    <xsl:function name="local:cell">
        <!-- Zero arity version  Eqivalent to a tab delimited cell -->
        <xsl:text>""</xsl:text>
        <xsl:value-of select="$tab"/>
    </xsl:function>
    
</xsl:stylesheet>