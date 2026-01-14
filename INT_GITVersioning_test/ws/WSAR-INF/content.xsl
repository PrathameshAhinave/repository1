<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <head>
                <style type="text/css">
                    body {
                        font-family: Arial, sans-serif;
                        font-size: 14px;
                        color: #333333;
                        line-height: 1.6;
                        margin: 20px;
                    }
                    .signature {
                        margin-top: 25px;
                    }
                    .company {
                        font-weight: bold;
                        color: #004080;
                    }
                    a {
                        color: #004080;
                        text-decoration: none;
                    }
                </style>
            </head>
            <body>
                <p>Attached is a copy of your invoice to be processed for payment. Should you have any 
                questions or issues regarding the attached invoice, please contact Accounts Receivable at
                <a href="mailto:invoiceinquiry@vertexinc.com">invoiceinquiry@vertexinc.com</a> or 
                (800) 355-3500 (Choose option 6, then option 2).</p>

                <p>Thank you, we truly appreciate your time and business.</p>

                <div class="signature">
                    <p class="company">Vertex, Inc.</p>
                    <p>Where Taxation Meets Innovation</p>
                    <p>2301 Renaissance Boulevard<br/>
                    King Of Prussia, PA</p>
                    <p><a href="http://www.vertexinc.com" target="_blank">www.vertexinc.com</a></p>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>