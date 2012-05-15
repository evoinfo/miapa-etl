<!-- Note: The following code was adapted from code posted to http://stackoverflow.com/questions/4912900/modifying-a-xslt-for-converting-xml-to-tab-delimited-text-file, Accessed on 5/14/2012.  - Elliott Hauser -->
<!--<?xml version="1.0" encoding="UTF-8"?>-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ns="http://www.canto.com/ns/Export/1.0"
    xmlns:fn="http://www.w3.org/2005/xpath-functions">
  <xsl:output method="text" indent="yes" encoding="utf-8" standalone="yes"/>
  <xsl:strip-space elements="*"/>

  <!-- Parameterized separator/end of line characters for flexibility -->
  <xsl:param name="sep" select="'&#09;'" />
  <xsl:param name="eol" select="'&#10;'" />
  <xsl:param name="listsep" select="'|'" />

  <!-- On matching the root node, output a list of field names, followed by the items -->
  <xsl:template match="/ns:Export">
    <xsl:apply-templates select="ns:Layout/ns:Fields/ns:Field" />
    <xsl:apply-templates select="ns:Items/ns:Item"/>
  </xsl:template>

  <!-- On matching all but the last field name, output the name followed by separator -->
  <xsl:template match="ns:Field[position()!=last()]">
    <xsl:value-of select="concat(normalize-space(ns:Name),$sep)" />
  </xsl:template>

  <!-- On matching the last field name, output the name followed by a newline -->
  <xsl:template match="ns:Field[position()=last()]">
    <xsl:value-of select="concat(normalize-space(ns:Name),$eol)" />
  </xsl:template>

  <!-- On matching an item, iterate through each field, applying templates to any 'ns:FieldValue' nodes that share the same value of @uid -->
  <xsl:template match="ns:Item">
    <xsl:variable name="item" select="." />
    <xsl:for-each select="/ns:Export/ns:Layout/ns:Fields/ns:Field/@uid">
      <xsl:apply-templates select="$item/ns:FieldValue[@uid=current()]" />
      <xsl:if test="position()!=last()">
        <xsl:value-of select="$sep" />
      </xsl:if>
    </xsl:for-each>
    <xsl:value-of select="$eol" />
  </xsl:template>

  <!-- On matching a field value, output the content. -->
  <xsl:template match="ns:FieldValue">
    <xsl:value-of select="normalize-space(.)" />
  </xsl:template>

  <!-- on matching a field value with a @displayValue attribute, output the value of that attribute -->
  <xsl:template match="ns:FieldValue[@displayValue]">
    <xsl:value-of select="normalize-space(@displayValue)" />
  </xsl:template>

  <!-- On matching a field value with ns:CategoryValue children, apply templates on those children. -->
  <xsl:template match="ns:FieldValue[ns:CategoryValue]">
    <xsl:apply-templates select="ns:CategoryValue" />
  </xsl:template>

  <!-- On matching a category value, output it's content, plus a separator. -->
  <xsl:template match="ns:CategoryValue">
    <xsl:value-of select="concat(normalize-space(.),$listsep)" />
  </xsl:template>

  <!-- On matching the last category value, output it's content without a separator. -->
  <xsl:template match="ns:CategoryValue[position()=last()]">
    <xsl:value-of select="normalize-space(.)" />
  </xsl:template>
</xsl:stylesheet>