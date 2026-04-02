<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:param name="r.WorkerType"/>
       
    <!-- standard copy template -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
        <xsl:if test="name() = 'CARDHOLDER_EMPLOYEE_ID'">
            <WORKER_TYPE>
                <xsl:value-of select = "$r.WorkerType"/>
            </WORKER_TYPE>
        </xsl:if>
    </xsl:template>	
</xsl:stylesheet>