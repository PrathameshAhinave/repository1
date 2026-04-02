<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:strip-space elements="*"/>
    <xsl:param name="company"/>
    
    
    <xsl:output method="xml" indent="yes"/>

    <!-- Root template -->
    <xsl:template match="/group">
<group>
        <!-- ONLY output <group> if matching rows exist -->
        <xsl:if test="row[LEGAL_ENTITY = $company]">
            
                <xsl:for-each select="row[LEGAL_ENTITY = $company]">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
          
        </xsl:if>
  </group>
    </xsl:template>

</xsl:stylesheet>