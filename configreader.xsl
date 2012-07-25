<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="local.uri" xmlns:isa="http://www.ebi.ac.uk/bii/isatab_configuration#"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.nexml.org/2009" version="2.0">

    <xsl:import href="template.xsl"/>
    <xsl:import href="mappings.xsl"/>

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
                    <xsl:for-each-group select="$current-config/isa:isatab-config-file/isa:isatab-configuration/isa:field" group-by="@section">
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
