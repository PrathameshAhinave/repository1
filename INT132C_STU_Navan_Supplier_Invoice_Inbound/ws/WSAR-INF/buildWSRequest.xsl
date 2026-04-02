<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="todaysdate"/>
    <xsl:param name="base64.str"/>
    <xsl:template match="/root/Invoice">
        <env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <env:Body>
                <wd:Submit_Supplier_Invoice_Request xmlns:wd="urn:com.workday/bsvc"
                    wd:Add_Only="true" wd:version="v44.0">
                    <wd:Business_Process_Parameters>
                        <wd:Auto_Complete>true</wd:Auto_Complete>
                    </wd:Business_Process_Parameters>
                    <wd:Supplier_Invoice_Data>
                        <wd:Invoice_Number>
                            <xsl:text>NAV_</xsl:text>
                            <xsl:value-of select="LEGAL_ENTITY"/>
                            <xsl:text>_</xsl:text>
                            <xsl:value-of select="format-date($todaysdate, '[M01][D01][Y0001]')"/>
                        </wd:Invoice_Number>
                        <wd:Invoice_Document_Status_Reference>
                            <wd:ID wd:type="Document_Status_ID">
                                <xsl:value-of select="INVOICE_DOCUMENT_STATUS"/>
                            </wd:ID>
                        </wd:Invoice_Document_Status_Reference>
                        <wd:Company_Reference>
                            <wd:ID wd:type="Company_Reference_ID">
                                <xsl:choose>
                                    <xsl:when
                                        test="LEGAL_ENTITY = 'CO_24' or LEGAL_ENTITY = 'CO_35'">
                                        <xsl:text>CO_01</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="LEGAL_ENTITY"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </wd:ID>
                        </wd:Company_Reference>
                        <wd:Currency_Reference>
                            <wd:ID wd:type="Currency_ID">
                                <xsl:value-of select="POSTED_CURRENCY"/>
                            </wd:ID>
                        </wd:Currency_Reference>
                        <wd:Supplier_Reference>
                            <wd:ID wd:type="Supplier_ID">
                                <xsl:value-of select="SUPPLIER"/>
                            </wd:ID>
                        </wd:Supplier_Reference>
                        <wd:Default_Tax_Option_Reference>
                            <wd:ID wd:type="Tax_Option_ID">
                                <xsl:value-of select="TAX_OPTION"/>
                            </wd:ID>
                        </wd:Default_Tax_Option_Reference>
                        <wd:Invoice_Date>
                            <!--                             <xsl:value-of select="substring(POSTED_DATE,1,10)"/> -->
                            <xsl:value-of select="$todaysdate"/>
                        </wd:Invoice_Date>
                        <wd:Control_Amount_Total>
                            <xsl:value-of select="format-number(POSTED_AMOUNT,'#.000')"/>
                        </wd:Control_Amount_Total>
                        <wd:Suppliers_Invoice_Number>
                            <xsl:text>NAV_</xsl:text>
                            <xsl:value-of select="LEGAL_ENTITY"/>
                            <xsl:text>_</xsl:text>
                            <xsl:value-of select="format-date($todaysdate, '[M01][D01][Y0001]')"/>
                            
                        </wd:Suppliers_Invoice_Number>
                        <!--                         <wd:Memo> -->
                        <!--                             <xsl:value-of select="BILLABLE_ENTITY"/> -->
                        <!--                             <xsl:text>||</xsl:text> -->
                        <!--                             <xsl:value-of select="LEGAL_ENTITY"/> -->
                        <!--                             <xsl:text>||</xsl:text> -->
                        <!--                             <xsl:value-of select="CARDHOLDER"/> -->
                        <!--                             <xsl:text>||</xsl:text> -->
                        <!--                             <xsl:value-of select="MERCHANT_NAME"/> -->
                        <!--                             <xsl:text>||</xsl:text> -->
                        <!--                             <xsl:value-of select="POLICY"/> -->
                        <!--                             <xsl:text>||</xsl:text> -->
                        <!--                             <xsl:value-of select="ACTIVITY_DESCRIPTION"/> -->
                        <!--                             <xsl:text>||</xsl:text> -->
                        <!--                             <xsl:value-of select="TRIP_PURPOSE"/> -->
                        <!--                             <xsl:text>||</xsl:text> -->
                        <!--                             <xsl:value-of select="substring(POSTED_DATE, 1, 10)"/> -->
                        <!--                         </wd:Memo> -->
                        <wd:Payment_Terms_Reference>
                            <wd:ID wd:type="Payment_Terms_ID">
                                <xsl:value-of select="PAYMENT_TERMS"/>
                            </wd:ID>
                        </wd:Payment_Terms_Reference>
                        <xsl:variable name="filename">
                            <xsl:value-of select="LEGAL_ENTITY"/>
                            <xsl:text>_</xsl:text>
                            <xsl:value-of select="$todaysdate"/>
                            <xsl:text>.csv</xsl:text>
                        </xsl:variable>
                        <wd:Attachment_Data wd:Content_Type="text/csv" wd:Encoding="base64Binary"
                            wd:Compressed="false">
                            <xsl:attribute name="wd:Filename">
                                <xsl:value-of select="$filename"/>
                            </xsl:attribute>
                            <wd:File_Content>
                              <xsl:value-of select="$base64.str"/>
                            </wd:File_Content>
                            <wd:Comment>file attached</wd:Comment>
                        </wd:Attachment_Data>
                        <xsl:for-each select="Invoicelines">
                            <wd:Invoice_Line_Replacement_Data>
                                <wd:Intercompany_Affiliate_Reference>
                                    <wd:ID wd:type="Company_Reference_ID">
                                        <xsl:value-of select="LEGAL_ENTITY"/>
                                    </wd:ID>
                                </wd:Intercompany_Affiliate_Reference>
                                <wd:Spend_Category_Reference>
                                    <wd:ID wd:type="Spend_Category_ID">
                                        <xsl:value-of select="SPEND_CATEGORY"/>
                                    </wd:ID>
                                </wd:Spend_Category_Reference>
                                <wd:Extended_Amount>
                                    <xsl:value-of select="format-number(POSTED_AMOUNT,'#.000')"/>
                                </wd:Extended_Amount>
                                <wd:Payment_Amount>
                                    <xsl:value-of select="format-number(POSTED_AMOUNT,'#.000')"/>
                                </wd:Payment_Amount>
                                <wd:Memo>
                                    <xsl:value-of select="BILLABLE_ENTITY"/>
                                    <xsl:text>||</xsl:text>
                                    <xsl:value-of select="LEGAL_ENTITY"/>
                                    <xsl:text>||</xsl:text>
                                    <xsl:value-of select="CARDHOLDER"/>
                                    <xsl:text>||</xsl:text>
                                    <xsl:value-of select="MERCHANT_NAME"/>
                                    <xsl:text>||</xsl:text>
                                    <xsl:value-of select="POLICY"/>
                                    <xsl:text>||</xsl:text>
                                    <xsl:value-of select="ACTIVITY_DESCRIPTION"/>
                                    <xsl:text>||</xsl:text>
                                    <xsl:value-of select="TRIP_PURPOSE"/>
                                    <xsl:text>||</xsl:text>
                                    <xsl:value-of select="substring(POSTED_DATE, 1, 10)"/>
                                </wd:Memo>
                                <wd:Worktags_Reference>
                                    <wd:ID wd:type="Cost_Center_Reference_ID">
                                        <xsl:value-of select="TRAVELERS_COST_CENTER"/>
                                    </wd:ID>
                                </wd:Worktags_Reference>
                                <wd:Worktags_Reference>
                                    <wd:ID>
                                        <xsl:attribute name="wd:type">
                                            <xsl:value-of select="WORKER_TYPE"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="CARDHOLDER_EMPLOYEE_ID"/>
                                    </wd:ID>
                                </wd:Worktags_Reference>
                                <xsl:if test="PROJECT_PLAN_TASK_ID != 'Internal Project' and PROJECT_PLAN_TASK_ID != ''">
                                <wd:Worktags_Reference>
                                    <wd:ID wd:type="Project_Plan_ID">
                                        <xsl:value-of select="substring-before(substring-after(PROJECT_PLAN_TASK_ID,'|'),'|')"/>
                                        
                                    </wd:ID>
                                </wd:Worktags_Reference>
                                </xsl:if>
                            </wd:Invoice_Line_Replacement_Data>
                        </xsl:for-each>
                    </wd:Supplier_Invoice_Data>
                </wd:Submit_Supplier_Invoice_Request>
            </env:Body>
        </env:Envelope>
    </xsl:template>
</xsl:stylesheet>
