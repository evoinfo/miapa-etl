<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0" xmlns:nex="http://www.nexml.org/2009" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xpath-default-namespace="http://www.nexml.org/2009">
    <xsl:import href="template.xsl"/>
    <xsl:variable name="seq"/>
    
    <!-- I split the meta elements that are children of the document element or descendents of one of these
            into two groups, based on the xsi:type attribute vaule.  This attribute is required in the NeXML schema,
            and these are the only two possible values as far as I understand.-->
    <xsl:variable name="litnodes" select="//meta[parent::nex:nexml | parent::meta][@xsi:type='nex:LiteralMeta']"/>
    <xsl:variable name="resnodes" select="//meta[parent::nex:nexml | parent::meta][@xsi:type='nex:ResourceMeta']"/>
    
    <xsl:template match="nexml" name="nexml">    
        <xsl:text>  ==  Output from meta.xsl: ==</xsl:text>
        <xsl:text>  ==  [Investigation] ==</xsl:text>
        
        <!-- LiteralMeta nodes -->
        <xsl:for-each select="$litnodes">
            <xsl:sort select="@property" order="ascending"/>
            <xsl:value-of select="$line"/>
            
            <!-- Print headers the first time around -->
            <xsl:if test="position()=1">
                <xsl:text>LiteralMeta Headers: </xsl:text>
                <xsl:value-of select="$tab"/>
                <xsl:for-each select="attribute::*">
                    <xsl:value-of select='name()'/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>
                <xsl:value-of select="$line"/>
            </xsl:if>
            
            <!-- Print the attribute values separated by tabs -->
            <!-- **Next step: Customize row labels via a choose -->
            <xsl:text>LiteralMeta Row: </xsl:text>
            <xsl:value-of select="$tab"/>
            <!-- **Next step: Customize which attributes are printed based on what they are -->
            <xsl:for-each select="attribute::*">
                <xsl:value-of select='.'/>
                <xsl:value-of select="$tab"/>
            </xsl:for-each>
        </xsl:for-each>
        
        
        <!-- Now, the ResourceMeta nodes-->
        <xsl:value-of select="$line"/>
        <xsl:for-each select="$resnodes"> 
            
            <!-- Print headers the first time around -->
            <xsl:if test="position()=1">
                <xsl:value-of select="$line"/>
                <xsl:text>ResourceMeta Headers: </xsl:text>
                <xsl:value-of select="$tab"/>
                <xsl:for-each select="attribute::*">
                    <xsl:value-of select='name()'/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>
                <xsl:value-of select="$line"/>
            </xsl:if>
            
            <!-- Print the attribute values separated by tabs -->
            <!-- **Next step: Customize row labels via a choose -->
            <xsl:text>ResourceMeta Row: </xsl:text>
            <xsl:value-of select="$tab"/>
            <xsl:if test="position()=last()">
                <xsl:text> last one</xsl:text>
            </xsl:if>
            <!-- **Next step: Customize which attributes are printed based on what they are -->
            <xsl:for-each select="attribute::*">
                <xsl:value-of select='.'/>
                <xsl:value-of select="$tab"/>
            </xsl:for-each>
            <xsl:value-of select="$line"/>
        </xsl:for-each>
        
        <!-- Otherwise.  Might delete this if I can confirm the Schema prevents an otherwise -->
        <xsl:if test="@xsl:type!='[nex:ResourceMeta | nex:LiteralMeta]'">
            <xsl:text>Warning: A meta element in the source file contains an xsi:type other than LiteralMeta or ResourceMeta</xsl:text>
        </xsl:if>
        
        <!-- Now, apply the other templates.  This is so it will work from allmeta.xsl
            When run on its own, meta.xsl will have a bunch of gene sequences spit out the bottom.-->
        
    </xsl:template>
</xsl:stylesheet>