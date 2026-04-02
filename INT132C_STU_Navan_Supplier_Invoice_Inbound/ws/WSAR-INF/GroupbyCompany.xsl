<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="2.0">
    
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        
        <root>
            
            <xsl:for-each-group select="root/row" group-by="LEGAL_ENTITY">
                <group>
                    <xsl:for-each select="current-group()">
                       <!-- FNHVS 1391 Change Start -->
                      <xsl:if test="ACTIVITY_TYPE != 'FX_FEE'">
                         <!-- FNHVS 1391 Change End -->  
                        
                        
                        <xsl:copy-of select="."/>
                      </xsl:if>  
                    </xsl:for-each>
                </group>
            </xsl:for-each-group>
            
            
        </root>
        
        
    </xsl:template>
    
</xsl:stylesheet>