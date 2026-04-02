<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Root match -->
    <xsl:template match="/group">
        <group>
            <!-- Process each row -->
            <xsl:for-each select="row">
                <!-- Copy original row -->
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
                
                <!-- If ACCRUED_REBATE_AMOUNT > 0, create duplicate -->
              <!-- FNHVS1420 Processing Negative ACCURED_REBATE_AMOUNT for Refund Transaction-->
              <!--    <xsl:if test="number(ACCRUED_REBATE_AMOUNT) &gt; 0"> -->
              <xsl:if test="number(ACCRUED_REBATE_AMOUNT) &gt; 0 or (number(ACCRUED_REBATE_AMOUNT) &lt; 0 and ACTIVITY_TYPE ='Refund')">
              <!-- FNHVS1420 Change End -->
                    <xsl:copy>
                        <xsl:apply-templates select="@* | node()">
                            <xsl:with-param name="isDuplicate" select="true()"/>
                        </xsl:apply-templates>
                    </xsl:copy>
                </xsl:if>
            </xsl:for-each>
        </group>
    </xsl:template>
    
    <!-- Copy everything by default -->
    <xsl:template match="@* | node()">
        <xsl:param name="isDuplicate" select="false()"/>
        <xsl:copy>
            <xsl:apply-templates select="@* | node()">
                <xsl:with-param name="isDuplicate" select="$isDuplicate"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
   
    
    <!-- Customize POSTED_AMOUNT if this is a duplicate row -->
    <xsl:template match="POSTED_AMOUNT">
        <xsl:param name="isDuplicate" select="false()"/>
        <xsl:copy>
            <xsl:choose>
                <xsl:when test="$isDuplicate">
              
                
              <xsl:value-of select="format-number((-1 * (../ACCRUED_REBATE_AMOUNT)),'#.00')"/>
               
              </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="format-number(.,'#.00')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>