<!-- this file experements with generating ISAtab-like output-->
<!--<?xml version="1.0" ?>-->
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:strip-space elements="*"/>
	<xsl:output method="text"/>
	<xsl:variable name='tab' select="'&#09;'"/>
	<xsl:variable name='line' select="'&#10;'"/>
<!--OK, base-uri give the whole path.  I now need to regex out the filename.	-->
	<xsl:variable name="filebase">
		<xsl:analyze-string select='base-uri()' regex="([/]?)([^/]+)([.])([xml]{{1,}}$)"> 
			<xsl:matching-substring>
				<xsl:value-of select="regex-group(2)"/>
			</xsl:matching-substring>
		</xsl:analyze-string>
	</xsl:variable>
<!-- Template to exclude characters because they're large -->
	<xsl:template match='characters'/>
<!--	<xsl:variable name="filename2" select='base-uri(document-uri())'/>-->
	<xsl:template match="otus">
		<xsl:text>this is a sample file generated from miapaisatab.xsl</xsl:text>
		<xsl:value-of select='$line'/>
		<xsl:value-of select='$line'/>
		<xsl:text>this section of the file is pulling the 'label' attribute from each otu element</xsl:text>
		<xsl:value-of select='$line'/>
		<xsl:text>It then inserts a tab in between each.</xsl:text>
		<xsl:value-of select='$line'/>
	<!--OTU names as column headers-->
		<!--OTU Names string is row label-->
		<xsl:text>OTU Names</xsl:text>
		<xsl:value-of select="$tab"/>
		<!-- now data -->
		<xsl:for-each select="otu">
			<xsl:value-of select="$tab"/>
			<xsl:value-of select="@label"/>
			<xsl:value-of select="$tab"/>
		</xsl:for-each>
		<xsl:value-of select='$line'/>
	<!-- Now, their 'about' attributes -->
		<!--About string is row label-->
		<xsl:text>About</xsl:text>
		<xsl:value-of select="$tab"/>
		<!-- now data -->
		<xsl:for-each select="otu">
			<xsl:value-of select="$tab"/>
			<xsl:value-of select="@about"/>
			<xsl:value-of select="$tab"/>
		</xsl:for-each>
	<!--Next steps: get sophisticated about pulling meta attributes-->
		<xsl:value-of select='$line'/>
	<!-- the below shows I can name the output files correctly -->
	<!-- combined with xsl:result-document, I can now generate correctly named ISAtab files -->
		<xsl:text>
			Now, filename tests: First the $filebase variable
		</xsl:text>
		<xsl:value-of select="$filebase"/>
		<xsl:value-of select='$line'/>
		<xsl:text>
			Now, concatenate: concat("a_",$filebase,".txt")
		</xsl:text>	
			<!-- Build ISAtab Assay filename from filebase variable-->
			<xsl:value-of select='concat("a_",$filebase,".txt")'/>
	</xsl:template>
</xsl:stylesheet>
