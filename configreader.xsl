<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="local.uri" xmlns:isa="http://www.ebi.ac.uk/bii/isatab_configuration#"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.nexml.org/2009" version="2.0">

    <xsl:import href="template.xsl"/>

    <xsl:function name="local:investigation-map">
        <!-- This function takes an ISA field header and returns appropriate NeXML values -->
        <!-- It should be modified to reflect updates to ISAconfig or NeXML-->

        <!-- TODO: explore alternatives to this God function -->
        <xsl:param name="header"/>
        <xsl:choose>
            <xsl:when test="$header='Study Identifier'">
                <xsl:value-of select="$pubid"/>
                <xsl:value-of select="$tab"/>
            </xsl:when>
            <xsl:when test="$header='Study Title'">
                <xsl:value-of select="$pubtitle"/>
                <xsl:value-of select="$tab"/>
            </xsl:when>
            <xsl:when test="$header='Study File Name'">
                <xsl:value-of select="$filefull"/>
                <xsl:value-of select="$tab"/>
            </xsl:when>
            <xsl:when test="$header='Study Publication DOI'">
                <xsl:value-of select="$pubdoi"/>
                <xsl:value-of select="$tab"/>
            </xsl:when>
            <xsl:when test="$header='Study Publication Author list'">
                <xsl:value-of select="$pubauthors"/>
                <xsl:value-of select="$tab"/>
            </xsl:when>
            <xsl:when test="$header='Study Publication Title'">
                <xsl:value-of select="$pubtitle"/>
                <xsl:value-of select="$tab"/>
            </xsl:when>
            <xsl:when test="$header='Study Assay Measurement Type'">
                <xsl:value-of select="$treetypekinds"/>
                <xsl:value-of select="$tab"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$tab"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="local:tree-map">
        <xsl:param name="header"/>
        <xsl:param name="treenum" as="xs:double"/>
        <xsl:param name="treeid"/>
        <xsl:param name="treesid"/>
        <xsl:variable name="current-tree" select="$trees[@id=$treesid]/tree[@id=$treeid]"/>
        <xsl:choose>
            <xsl:when test="$header='Sample Name'">
                <xsl:choose>
                    <xsl:when test="exists($characters[@otus=ancestor::trees/@otus]/@otus)">
                        <xsl:value-of select="local:enquote($characters[@otus=ancestor::trees/@otus]/@otus)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="local:empty-cell()"/>
                    </xsl:otherwise>
                </xsl:choose>              
            </xsl:when>
            <xsl:when test="$header='Assay Name'">
                <xsl:value-of select="local:enquote($current-tree/@id)"/>
            </xsl:when>
            <xsl:when test="$header='Characteristics[Tree Kind]'">
                <xsl:value-of select="local:enquote($current-tree/meta[@property='tb:kind.tree']/@content)"/>
            </xsl:when>
            <xsl:when test="$header='Characteristics[Tree Type]'">
                <xsl:value-of select="local:enquote($current-tree/meta[@property='tb:type.tree']/@content)"/>
            </xsl:when>
            <xsl:when test="$header='Characteristics[Tree Quality]'">
                <xsl:value-of select="local:enquote($current-tree/meta[@property='tb:rating.tree']/@content)"/>
            </xsl:when>
            <xsl:when test="$header='Raw Data File'">
                <xsl:value-of select="local:enquote($filefull)"/>
            </xsl:when>
            <xsl:when test="$header='Characteristics[XPath to Tree]'">
                <xsl:value-of select='local:enquote(concat("/nexml/trees[@id=&apos;",$treesid,"&apos;]/tree[@id=&apos;",$treeid,"&apos;]"))'/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="local:empty-cell()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="local:matrix-map">
        <xsl:param name="header"/>
        <xsl:param name="rowid"/>
        <xsl:param name="matrixnum"/>
        <xsl:param name="matrixid"/>
        
        <xsl:variable name="matrix-rows" select="$characters[@id=$matrixid]/matrix/row"/>
        
        <xsl:choose>
            <xsl:when test="$header='Source Name'">
                <xsl:value-of select="local:enquote($rowid)"/>
            </xsl:when>
            <xsl:when test="$header='Material Type'">
                <xsl:value-of select="local:enquote($characters[@id=$matrixid]/meta[@property='tb:type.matrix']/@content)"/>
            </xsl:when>
            <xsl:when test="$header='Characteristics[OTU Name]'">
                <xsl:value-of select="local:enquote($nexml/otus[@id=$characters[@id=$matrixid]/@otus]/otu[@id=$matrix-rows[@id=$rowid]/@otu]/@label)"/>
            </xsl:when>
            <xsl:when test="$header='Characteristics[Row OTU ID]'">
                <xsl:value-of select="local:enquote($matrix-rows[@id=$matrixid]/@otu)"/>
            </xsl:when>
            <xsl:when test="$header='Sample Name'">
                <xsl:value-of select="local:enquote($matrixid)"/>
            </xsl:when>
            <xsl:when test="$header='Characteristics[Characters OTUs Reference]'">
                <xsl:value-of select="local:enquote($characters[@id=$matrixid]/@otus)"/>
            </xsl:when>
            <xsl:when test="$header='Characteristics[Number of Taxa in Matrix]'">
                <xsl:value-of select="local:enquote($characters[@id=$matrixid]/meta[@property='tb:ntax.matrix']/@content)"/>
            </xsl:when>
            <xsl:when test="$header='Characteristics[Number of Characters in Matrix]'">
                <xsl:value-of select="local:enquote($characters[@id=$matrixid]/meta[@property='tb:nchar.matrix']/@content)"/>
            </xsl:when>
            <xsl:when test="$header='Characteristics[Character Matrix Type]'">
                <xsl:value-of select="local:enquote($characters[@id=$matrixid]/meta[@property='tb:type.matrix']/@content)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="local:empty-cell()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>


    <xsl:template name="config-print">
        <xsl:param name="table-name"/>
        <xsl:param name="prefix"/>
        <xsl:param name="position"/>
        <xsl:param name="id"/>
        <xsl:variable name="current-config">
            <xsl:copy-of select="collection('config')[/isa:isatab-config-file/isa:isatab-configuration/@table-name=$table-name]"/>
        </xsl:variable>
        <xsl:choose>
            <!-- Investigation -->
            <xsl:when test="$table-name='investigation'">
                <xsl:variable name="filename" select="concat($filebase, '/', $prefix, '_', $filebase, '_', $position, '.txt')"/>
                <xsl:result-document href="{$filename}">
                    <xsl:text>DEBUG: result-doc</xsl:text>
                    <xsl:for-each-group select="$current-config/isa:isatab-config-file/isa:isatab-configuration/isa:field" group-by="@section">
                        <xsl:text>DEBUG: for-each-group</xsl:text>
                        <xsl:value-of select="current-grouping-key()"/>
                        <xsl:value-of select="$line"/>
                        <xsl:for-each select="current-group()">
                            <xsl:value-of select="@header"/>
                            <xsl:value-of select="$tab"/>
    
                            <xsl:value-of select="local:investigation-map(@header)"/>
    
                            <xsl:value-of select="$line"/>
                        </xsl:for-each>
                    </xsl:for-each-group>
                </xsl:result-document>
            </xsl:when>

            <!-- Study - Matrices -->
            <xsl:when test="$table-name='matrix'">
                <xsl:variable name="filename" select="concat($filebase, '/', $prefix, '_', $filebase, '_', $position, '.txt')"/>
                <xsl:result-document href="{$filename}">
                    <xsl:for-each select="$current-config/isa:isatab-config-file/isa:isatab-configuration/isa:field/@header">
                        <xsl:value-of select="local:enquote(.)"/>
                    </xsl:for-each>
                    <xsl:value-of select="$line"/>

                    <xsl:for-each select="$characters[@id=$id]/matrix/row">
                       
                        <xsl:variable name="row-id" select="@id"/>
                        <xsl:for-each select="$current-config/isa:isatab-config-file/isa:isatab-configuration/isa:field/@header">
                            <xsl:value-of select="local:matrix-map(.,$row-id, $position, $id)"/>
                        </xsl:for-each>
                        <xsl:value-of select="$line"/>
                    </xsl:for-each>
                </xsl:result-document>
            </xsl:when>

            <!-- Assay - Trees -->
            <xsl:when test="$table-name='tree-inference'">
                
                <xsl:variable name="filename" select="concat($filebase, '/', $prefix, '_', $filebase, '_', $position, '.txt')"/>
                <xsl:result-document href="{$filename}">
                    <xsl:for-each select="$current-config/isa:isatab-config-file/isa:isatab-configuration/isa:field/@header">
                        <xsl:value-of select="local:enquote(.)"/>
                    </xsl:for-each>
                    <xsl:value-of select="$line"/>
                    
                    <xsl:for-each select="$trees[@id=$id]/tree">
                        <xsl:variable name="treeid" select="@id"/>
                        <xsl:for-each select="$current-config/isa:isatab-config-file/isa:isatab-configuration/isa:field/@header">
                            <xsl:value-of select="local:tree-map(.,$position,$treeid,$id)"/>
                        </xsl:for-each>
                    </xsl:for-each>

                </xsl:result-document>
            </xsl:when>

            <xsl:otherwise>
                <xsl:text>ERROR: Unrecognized table-name passed to local:config-print</xsl:text>
            </xsl:otherwise>

        </xsl:choose>


    </xsl:template>

    <xsl:template match="/">
        
        <xsl:for-each select="$nexml">
            <xsl:call-template name="config-print">
                <xsl:with-param name="table-name">
                    <xsl:value-of select="'investigation'"/>
                </xsl:with-param>
                <xsl:with-param name="prefix">
                    <xsl:value-of select="'i'"/>
                </xsl:with-param>
                <xsl:with-param name="position">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
                <xsl:with-param name="id">
                    <xsl:value-of select="@id"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
        
        <xsl:for-each select="$characters">
            <xsl:variable name="matrixid" select="@id"/>
            <xsl:call-template name="config-print">
                <xsl:with-param name="table-name">
                    <xsl:value-of select="'matrix'"/>
                </xsl:with-param>
                <xsl:with-param name="prefix">
                    <xsl:value-of select="'s'"/>
                </xsl:with-param>
                <xsl:with-param name="position">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
                <xsl:with-param name="id">
                    <xsl:value-of select="$matrixid"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
        
        <xsl:for-each select="$trees">
            <xsl:variable name="treeid" select="@id"/>
            <xsl:call-template name="config-print">
                <xsl:with-param name="table-name">
                    <xsl:value-of select="'tree-inference'"/>
                </xsl:with-param>
                <xsl:with-param name="prefix">
                    <xsl:value-of select="'a'"/>
                </xsl:with-param>
                <xsl:with-param name="position">
                    <xsl:value-of select="position()"/>
                </xsl:with-param>
                <xsl:with-param name="id">
                    <xsl:value-of select="$treeid"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
