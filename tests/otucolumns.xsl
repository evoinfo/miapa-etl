<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:nex="http://www.nexml.org/2009"
    version="1.0">
    <xsl:import href="../template.xsl"/>
    <!-- This file attempts to construct tables out of NeXML with the meta attributes conceived as columns, 
        the values as values and the elements themselves concieved as rows 
        As of May 25 2012 it is working with arbitrary NeXML files from supertreebase, but is 
        dependent on the <<otu>> elements having a standard number of <<meta>> elements.
        For instance, run it on S103.xml and the second otu, Kunstleria, only produces 4 columns
        of data instead of five.-->
    
    <!-- First, extract information about the OTUs element (which I assume is about the taxa in aggregate) -->
   
    <xsl:template match='/nex:nexml/otus'>
        <xsl:for-each select=".">
            
            <!-- Store headers for OTU Group-level information in a variable-->
            <xsl:variable name="otugroupheaders">
                <!-- This code pulls out the attribute names from the otus element.
                    It's commented out because this information doesnt seem relevant to ISAtab
                <xsl:for-each select="@*">
                    <xsl:value-of select="name(.)"/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>-->
                <xsl:for-each select="/nex:nexml/otus/meta">
                    <xsl:for-each select="@*">
                        <xsl:value-of select="name(.)"/>
                        <xsl:value-of select="$tab"/>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:variable>
            
            <!-- Store values of OTU Group-level information in a variable-->
            <xsl:variable name="otugroupinfo">
                <!-- This code pulls out the attribute values from the otus element.
                    It's commented out because this information doesnt seem relevant to ISAtab
                <xsl:for-each select="@*">
                    <xsl:value-of select="."/>
                    <xsl:value-of select="$tab"/>
                </xsl:for-each>-->
                <!-- Right now this just pulls all meta attributes, dumbly. In the future it should pick -->
                <xsl:for-each select="/nex:nexml/otus/meta">
                    <xsl:for-each select="@*">
                        <xsl:value-of select="."/>
                        <xsl:value-of select="$tab"/>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:variable>
            <xsl:value-of select="$line"/>

             
             <!-- Make a table of OTUs information-->
             <xsl:for-each select="otu">
                 <!-- distinguish between literal and resource meta elements (defined by NeXML) -->
                 <xsl:variable name="otu-literal-metas" select='meta[@xsi:type="nex:LiteralMeta"]'/>
                 <xsl:variable name="otu-resource-metas" select='meta[@xsi:type="nex:ResourceMeta"]'/>
                 
                 
                 
                 <!-- Print column headers, titled the @property and @rel attribute values for literal and resource metas, respectively -->
                 <xsl:if test="position()=1">
                     <xsl:variable name="metaheaders">
                         <xsl:for-each select="$otu-literal-metas">
                             <xsl:value-of select="@property"/>
                             <xsl:value-of select="$tab"/>
                         </xsl:for-each>
                         <xsl:for-each select="$otu-resource-metas">
                             <xsl:value-of select="@rel"/>
                             <xsl:value-of select="$tab"/>
                         </xsl:for-each>
                     </xsl:variable>
                     
                     <xsl:value-of select="$line"/>
                     <xsl:text>Taxon Name</xsl:text>
                     <xsl:value-of select="$tab"/>      
                     <xsl:value-of select="$metaheaders"/>
                     <xsl:value-of select="$otugroupheaders"/>
                     <xsl:value-of select="$line"/>
                 </xsl:if>
                 
                 <!-- Rows: Print the name of the OTU, then the @content and @href attribtue contents, respectively-->
                 <xsl:value-of select="@label"/>
                 <xsl:value-of select="$tab"/>
                 <xsl:for-each select="$otu-literal-metas">
                     <xsl:value-of select="@content"/>
                     <xsl:value-of select="$tab"/>
                 </xsl:for-each>
                 <xsl:for-each select="$otu-resource-metas">
                     <xsl:value-of select="@href"/>
                     <xsl:value-of select="$tab"/>
                 </xsl:for-each>
                 
                 <!-- Append the info extracted above from the OTUs element to the taxon row -->
                 <xsl:value-of select="$otugroupinfo"/>
                 <xsl:value-of select="$line"/>
             </xsl:for-each>
        </xsl:for-each>    
    </xsl:template>
</xsl:stylesheet>