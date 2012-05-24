<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nex="http://www.nexml.org/2009"
    version="1.0">
    <xsl:import href="../template.xsl"/>
    <xsl:template match="/nex:nexml">
        <xsl:value-of select="@version"/>
    </xsl:template>
</xsl:stylesheet>