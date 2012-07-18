<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:nex="http://www.nexml.org/2009"
    exclude-result-prefixes="xs" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:local="local.uri" xpath-default-namespace="http://www.nexml.org/2009" version="2.0">

    <xsl:template match="/" name="study">
        <xsl:text> == Output of Study.xsl: ==</xsl:text>
        <xsl:value-of select="$line"/>

        <!-- Print headers -->
        <xsl:value-of select="local:cell(&quot;Source Name&quot;)"/>
        <xsl:value-of select="local:cell(&quot;Characteristics[OTU name]&quot;)"/>
        <xsl:value-of select="local:cell(&quot;Row OTU id&quot;)"/>
        <xsl:value-of select="local:cell(&quot;Term Source REF&quot;)"/>
        <xsl:value-of select="local:cell(&quot;Term Access Number&quot;)"/>
        <xsl:value-of select="local:cell(&quot;Sample Name&quot;)"/>
        <xsl:value-of select="local:cell(&quot;Characters OTUs Group id&quot;)"/>
        <xsl:value-of select="local:cell(&quot;Number of Taxa in Sample Matrix&quot;)"/>
        <xsl:value-of select="local:cell(&quot;Number of Characters in Sample Matrix&quot;)"/>
        <xsl:value-of select="local:cell(&quot;Character Matrix Type&quot;)"/>
        <xsl:value-of select="$line"/>

        <!--Now Content for each Matrix row (= species | sequence) -->
        <xsl:for-each select="$characters/matrix/row">

            <xsl:variable name="otu" select="@otu"/>
            <xsl:variable name="current-chars" select="ancestor::node()[2]"/>
            

            <!-- Martix Rows = Source -->
            <xsl:value-of select="local:cell(@id)"/>
            <xsl:value-of select="local:cell((//otu[@id=$otu]/@label)[1])"/>
            <xsl:value-of select="local:cell((@otu)[1])"/>
            <xsl:value-of select="local:cell('')"/>
            <xsl:value-of select="local:cell('')"/>

            <!-- Character Matrix = Sample -->
            <xsl:value-of select="local:cell($current-chars/@id)"/>
            <xsl:value-of select="local:cell($current-chars/@otus)"/>
            <xsl:value-of
                select="local:cell($current-chars/meta[@property='tb:ntax.matrix']/@content)"/>
            <xsl:value-of
                select="local:cell($current-chars/meta[@property='tb:nchar.matrix']/@content)"/>
            <xsl:value-of
                select="local:cell($current-chars/meta[@property='tb:type.matrix']/@content)"/>
            <xsl:value-of select="$line"/>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
