<#--
This software is in the public domain under CC0 1.0 Universal plus a Grant of Patent License.

To the extent possible under law, the author(s) have dedicated all
copyright and related and neighboring rights to this software to the
public domain worldwide. This software is distributed without any
warranty.

You should have received a copy of the CC0 Public Domain Dedication
along with this software (see the LICENSE.md file). If not, see
<http://creativecommons.org/publicdomain/zero/1.0/>.
-->

<#-- See the mantle.shipment.ShipmentServices.get#ShipmentPickPackInfo service for data preparation -->

<#assign cellPadding = "1pt">
<#assign dateFormat = dateFormat!"dd MMM yyyy">
<#assign dateTimeFormat = dateTimeFormat!"yyyy-MM-dd HH:mm">

<#macro encodeText textValue>${(Static["org.moqui.util.StringUtilities"].encodeForXmlAttribute(textValue!"", false))!""}</#macro>

<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="Helvetica, sans-serif" font-size="10pt">
    <fo:layout-master-set>
        <fo:simple-page-master master-name="letter-portrait" page-width="8.5in" page-height="11in"
                               margin-top="0.5in" margin-bottom="0.5in" margin-left="0.5in" margin-right="0.5in">
            <fo:region-body margin-top="0.5in" margin-bottom="0.6in"/>
            <fo:region-before extent="0.5in"/>
            <fo:region-after extent="0.5in"/>
        </fo:simple-page-master>
    </fo:layout-master-set>

    <fo:page-sequence master-reference="letter-portrait">
        <fo:static-content flow-name="xsl-region-before">
            <#if fromPartyDetail?has_content><fo:block font-size="14pt" text-align="center"><@encodeText fromPartyDetail.organizationName!""/><@encodeText fromPartyDetail.firstName!""/> <@encodeText fromPartyDetail.lastName!""/></fo:block></#if>
            <fo:block font-size="12pt" text-align="center" margin-bottom="0.1in">Product Barcodes</fo:block>
            <fo:block-container absolute-position="absolute" top="0in" right="0.5in" width="3in">
                <fo:block text-align="right">
                    <#--<fo:instream-foreign-object>
                        <barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="${shipmentId}">
                            <barcode:code128>
                                <barcode:height>0.4in</barcode:height>
                                <barcode:module-width>0.3mm</barcode:module-width>
                            </barcode:code128>
                            <barcode:human-readable>
                                <barcode:placement>bottom</barcode:placement>
                                <barcode:font-name>Helvetica</barcode:font-name>
                                <barcode:font-size>12pt</barcode:font-size>
                                <barcode:display-start-stop>false</barcode:display-start-stop>
                                <barcode:display-checksum>false</barcode:display-checksum>
                            </barcode:human-readable>
                        </barcode:barcode>
                    </fo:instream-foreign-object>-->
                </fo:block>
            </fo:block-container>
        </fo:static-content>
        <fo:static-content flow-name="xsl-region-after" font-size="8pt">
            <fo:block border-top="thin solid black">
                <#-- not displaying address, not needed in general:
                <fo:block text-align="center">
                <#if fromContactInfo.postalAddress?has_content>
                ${(fromContactInfo.postalAddress.address1)!""}<#if fromContactInfo.postalAddress.unitNumber?has_content> #${fromContactInfo.postalAddress.unitNumber}</#if><#if fromContactInfo.postalAddress.address2?has_content>, ${fromContactInfo.postalAddress.address2}</#if>, ${fromContactInfo.postalAddress.city!""}, ${(fromContactInfo.postalAddressStateGeo.geoCodeAlpha2)!""} ${fromContactInfo.postalAddress.postalCode!""}<#if fromContactInfo.postalAddress.postalCodeExt?has_content>-${fromContactInfo.postalAddress.postalCodeExt}</#if><#if fromContactInfo.postalAddress.countryGeoId?has_content>, ${fromContactInfo.postalAddress.countryGeoId}</#if>
                </#if>
                <#if fromContactInfo.telecomNumber?has_content>
                    -- <#if fromContactInfo.telecomNumber.countryCode?has_content>${fromContactInfo.telecomNumber.countryCode}-</#if><#if fromContactInfo.telecomNumber.areaCode?has_content>${fromContactInfo.telecomNumber.areaCode}-</#if>${fromContactInfo.telecomNumber.contactNumber!""}
                </#if>
                <#if fromContactInfo.emailAddress?has_content> -- ${fromContactInfo.emailAddress}</#if>
                </fo:block>
                -->
                <fo:block text-align="center"> Page <fo:page-number/></fo:block>
            </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">

            <#if productIdList?has_content>
                <#list productIdList as productId>
                   <fo:block text-align="center">
                        <fo:instream-foreign-object>
                            <barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="<@encodeText productId/>">
                                <barcode:code128>
                                    <barcode:height>0.4in</barcode:height>
                                    <barcode:module-width>0.25mm</barcode:module-width>
                                </barcode:code128>
                                <barcode:human-readable>
                                    <barcode:placement>bottom</barcode:placement>
                                    <barcode:font-name>Helvetica</barcode:font-name>
                                    <barcode:font-size>7pt</barcode:font-size>
                                    <barcode:display-start-stop>false</barcode:display-start-stop>
                                    <barcode:display-checksum>false</barcode:display-checksum>
                                </barcode:human-readable>
                            </barcode:barcode>
                        </fo:instream-foreign-object>
                    </fo:block>

                </#list>
            </#if>

        </fo:flow>
    </fo:page-sequence>
</fo:root>
