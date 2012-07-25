<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="local.uri" xmlns:isa="http://www.ebi.ac.uk/bii/isatab_configuration#"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.nexml.org/2009" version="2.0">
      
    <!-- == Mappings.xsl -->
    <!--This file contains mappings from ISAconfig headings, etc to NeXML XPath 
        expressions.  It should be updated when either the ISA config for 
        phylogenetics or TreeBase NeXML are updated.  For instance, TreeBase 
        NeXML doesn't currently contain information about the software used in
        an analysis.  If it is updated to include this informaiton, the XPath
        expression representing this information should be placed in the 
        appropriate places below. 
    
        Headings with no mapping (i.e. not listed below) get either blanks or
        enquoted blanks, depending on the file type.-->

    
    <!-- === INVESTIGATION MAPPINGS -->
    <xsl:function name="local:investigation-map">
        <!--This function checks headers passed to it for matches.  If a match is found,
            it returns the value-of an appropriate NeXML element.  Otherwise, blanks are
            returned.-->
        <!--To modify mappings, make sure the test is exactly the content @header 
            attribute of the field element in question.  Then, insert a variable or 
            variable ply XPath modifier followed by a tab. XPath expressions without
            variables at the head will not work because functions do not have access
            to context.-->
        <!-- Common variables that are declared for you already (in template.xsl) are
                * $root - the root node of the NeXML file ( '/' )
                * $nexml - the nexml element ( '/nexml' )
                * $characters - all characters elements ( '/nexml/characters' )
                * $trees - all trees elements ( '/nexml/trees' )-->
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
    
    <!-- === TREE MAPPINGS -->
    <xsl:function name="local:tree-map">
        <!--This function takes in a header, a specific tree element and returns
            enquoted NeXML data associated with the header type.-->
        <!--To modify it, make sure the <xsl:when> test exactly matches the header
            of interest.  Then insert the variable or variable modified by XPath 
            that corresponds to the correct data.  For example, 'Assay Name' should
            be the @id attribute of the current tree element, so this code:
        
            <xsl:when test="$header='Assay Name'">
                <xsl:value-of select="local:enquote($current-tree/@id)"/>
            </xsl:when>
        
            gets it done.-->
        <!-- Common variables that are declared for you already (in template.xsl) are
                * $root - the root node of the NeXML file ( '/' )
                * $nexml - the nexml element ( '/nexml' )
                * $characters - all characters elements ( '/nexml/characters' )
                * $trees - all trees elements ( '/nexml/trees' )-->
        
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
    
    
    <!-- === MATRIX MAPPINGS -->
    <xsl:function name="local:matrix-map">
        <!--This function takes in a header, a specific character matrix element and 
            returns enquoted NeXML data associated with the header.-->
        <!--To modify it, make sure the <xsl:when> test exactly matches the header
            of interest.  Then insert the variable or variable modified by XPath 
            that corresponds to the correct data.  For example, 'Source Name' should
            be the @id attribute of the current row, which is a parameter of the
            function:
            
            <xsl:param name="rowid"/>            
            
            so this code:
        
            <xsl:when test="$header='Source Name'">
                <xsl:value-of select="local:enquote($rowid)"/>
            </xsl:when>
        
            gets it done.-->
        <!-- Common variables that are declared for you already (in template.xsl) are
                * $root - the root node of the NeXML file ( '/' )
                * $nexml - the nexml element ( '/nexml' )
                * $characters - all characters elements ( '/nexml/characters' )
                * $trees - all trees elements ( '/nexml/trees' )-->
        
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
    
</xsl:stylesheet>