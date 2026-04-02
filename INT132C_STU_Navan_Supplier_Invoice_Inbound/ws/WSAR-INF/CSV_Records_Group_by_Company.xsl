<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:jmap="java:java.util.Map"
    xmlns:jt="http://saxon.sf.net/java-type"
    xmlns:ctx="java:com.capeclear.mediation.MediationContext"
    xmlns:tube="java:com.capeclear.mediation.impl.cc.MediationTube"
    exclude-result-prefixes="xs math"
    version="3.0">
 
    <xsl:param name="p.hashmap" />
    <xsl:param name="pInvoice-Date"/>
    <xsl:param name="pPayment_Terms_ID"/>
    <xsl:param name="pInvoice_Status_ID"/>
    <xsl:param name="pSpend_Category_Reference_ID"/>
    <xsl:param name="pSupplier_ID"/>
    <xsl:param name="pTax_Option_ID"/>
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <root>
            <xsl:for-each-group select="group/row" group-by="LEGAL_ENTITY">
                <Invoice>
                    <LEGAL_ENTITY>
                        <xsl:value-of select="current-group()[position() = 1]/LEGAL_ENTITY"/>
                    </LEGAL_ENTITY>
                    
                    <SUPPLIER>
                        <xsl:value-of select="$pSupplier_ID"/>
                    </SUPPLIER>
                    
                    <INVOICE_DOCUMENT_STATUS>
                        <xsl:value-of select="$pInvoice_Status_ID"/>
                    </INVOICE_DOCUMENT_STATUS>
                    
                    <POSTED_CURRENCY>
                        <xsl:value-of select="current-group()[position() = 1]/POSTED_CURRENCY"/>
                    </POSTED_CURRENCY>
                    
                    <POSTED_AMOUNT>
                        <xsl:value-of select="sum(current-group()/POSTED_AMOUNT)"/>
                    </POSTED_AMOUNT>
                    
                    <BILLABLE_ENTITY>
                        <xsl:value-of select="current-group()[position() = 1]/BILLABLE_ENTITY"/>
                    </BILLABLE_ENTITY>
                    
                    <CARDHOLDER>
                        <xsl:value-of select="current-group()[position() = 1]/CARDHOLDER"/>
                    </CARDHOLDER>
                    
                    <MERCHANT_NAME>
                        <xsl:value-of select="current-group()[position() = 1]/MERCHANT_NAME"/>
                    </MERCHANT_NAME>
                    
                    <ACTIVITY_DESCRIPTION>
                        <xsl:value-of select="current-group()[position() = 1]/ACTIVITY_DESCRIPTION"
                        />
                    </ACTIVITY_DESCRIPTION>
                    
                    <TRIP_PURPOSE>
                        <xsl:value-of select="current-group()[position() = 1]/TRIP_PURPOSE"/>
                    </TRIP_PURPOSE>
                    
                    <POSTED_DATE>
                        <!--   <xsl:value-of select="current-group()[position()=1]/format-date(xs:date(concat(substring(POSTED_DATE_TIME, 1, 4), '-', substring(POSTED_DATE_TIME, 6, 2), '-', substring(POSTED_DATE_TIME, 9, 2))), '[Y0001]-[M01]-[D01]') "/>
                   -->
                        <xsl:value-of select="POSTED_DATE"/>
                    </POSTED_DATE>
                    
                    <POLICY>
                        <xsl:value-of select="current-group()[position() = 1]/POLICY"/>
                    </POLICY>
                    
                    <PAYMENT_TERMS>
                        <xsl:value-of select="$pPayment_Terms_ID"/>
                    </PAYMENT_TERMS>
                    
                    <TAX_OPTION>
                        <xsl:value-of select="$pTax_Option_ID"/>
                    </TAX_OPTION>
                    
                    <xsl:for-each select="current-group()">
                        <Invoicelines>
                            <ID>
                                <xsl:value-of select="ID"/>
                            </ID>
                            <LEGAL_ENTITY>
                                <xsl:value-of select="LEGAL_ENTITY"/>
                            </LEGAL_ENTITY>
                            
                            <SPEND_CATEGORY>
                                <xsl:value-of select="$pSpend_Category_Reference_ID"/>
                            </SPEND_CATEGORY>
                            
                            <POSTED_AMOUNT>
                                <xsl:value-of select="POSTED_AMOUNT"/>
                            </POSTED_AMOUNT>
                            
                            <BILLABLE_ENTITY>
                                <xsl:value-of select="BILLABLE_ENTITY"/>
                            </BILLABLE_ENTITY>
                            <CARDHOLDER>
                                <xsl:value-of select="CARDHOLDER"/>
                            </CARDHOLDER>
                            <MERCHANT_NAME>
                                <xsl:value-of select="MERCHANT_NAME"/>
                            </MERCHANT_NAME>
                            <POLICY>
                                <xsl:value-of select="POLICY"/>
                            </POLICY>
                            <ACTIVITY_DESCRIPTION>
                                <xsl:value-of select="ACTIVITY_DESCRIPTION"/>
                            </ACTIVITY_DESCRIPTION>
                            <TRIP_PURPOSE>
                                <xsl:value-of select="TRIP_PURPOSE"/>
                            </TRIP_PURPOSE>
                            <POSTED_DATE>
                                <xsl:value-of select="POSTED_DATE"/>
                            </POSTED_DATE>
                            <TRAVELERS_COST_CENTER>
                                <xsl:value-of select="TRAVELERS_COST_CENTER"/>
                            </TRAVELERS_COST_CENTER>
                            <CARDHOLDER_EMPLOYEE_ID>
                                <xsl:value-of select="CARDHOLDER_EMPLOYEE_ID"/>
                            </CARDHOLDER_EMPLOYEE_ID>
                            <WORKER_TYPE>				
                				<xsl:value-of select="WORKER_TYPE"/>
                            </WORKER_TYPE>
                            <PROJECT_PLAN_TASK_ID>
                                <xsl:value-of select="CUSTOM_FIELD_VALUE---customField1---Vertex-Project_Task-Code"/>
                            </PROJECT_PLAN_TASK_ID>
                        </Invoicelines>
                    </xsl:for-each>
                </Invoice>
            </xsl:for-each-group>
        </root>
    </xsl:template>
    
</xsl:stylesheet>
