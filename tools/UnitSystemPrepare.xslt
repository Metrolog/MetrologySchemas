<?xml version="1.0" encoding="utf-8" standalone="no"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:v="http://csm.nov.ru/schemas/Value.xsd"
	xmlns:u="http://csm.nov.ru/schemas/MeasurementUnit.xsd"
	xmlns:us="http://csm.nov.ru/schemas/UnitsSystem.xsd"
	xmlns="http://csm.nov.ru/schemas/UnitsSystem.xsd"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="
		http://csm.nov.ru/schemas/Value.xsd                   ../Value.xsd
		http://csm.nov.ru/schemas/MeasurementUnit.xsd         ../MeasurementUnit.xsd
		http://csm.nov.ru/schemas/UnitsSystem.xsd             ../UnitsSystem.xsd
	"

	exclude-result-prefixes="msxsl us"
>
	<xsl:output
		method="xml"
		version="1.0"
		omit-xml-declaration="no"
		standalone="yes"
		encoding="utf-8"
		indent="yes"
	/>

	<xsl:template match="/us:СистемаЕдиницВеличин/us:ЕдиницыВеличин/us:ЕдиницаВеличины/us:КратныеЕдиницыВеличин"/>

	<xsl:template match="/us:СистемаЕдиницВеличин/us:ЕдиницыВеличин/us:ЕдиницаВеличины">
		<xsl:copy>
			<xsl:apply-templates select="@* | node() | text() | processing-instruction() | comment()"/>
			<xsl:variable name="ОбозначенияИНаименованияЕВ" select="./us:ОбозначенияИНаименования/us:ОбозначениеИНаименование"/>
			<КратныеЕдиницыВеличин>
				<xsl:for-each select="/us:СистемаЕдиницВеличин/us:ДесятичныеМножители/us:ДесятичныйМножитель">
					<xsl:variable name="ОбозначенияИНаименованияДМ" select="./us:ОбозначенияИНаименования/us:ОбозначениеИНаименование"/>
					<ЕдиницаВеличины>
						<xsl:copy-of select="@Порядок"/>
						<ОбозначенияИНаименования>
							<xsl:for-each select="$ОбозначенияИНаименованияЕВ">
								<ОбозначениеИНаименование>
									<xsl:copy-of select="@lang"/>
									<xsl:variable name="lang" select="@lang"/>
									<xsl:attribute name="Обозначение">
										<xsl:value-of select="concat($ОбозначенияИНаименованияДМ[@lang=$lang]/@Обозначение,@Обозначение)"/>
									</xsl:attribute>
									<xsl:if test="@Наименование">
										<xsl:attribute name="Наименование">
											<xsl:value-of select="concat($ОбозначенияИНаименованияДМ[@lang=$lang]/@Наименование,@Наименование)"/>
										</xsl:attribute>
									</xsl:if>
								</ОбозначениеИНаименование>
							</xsl:for-each>
						</ОбозначенияИНаименования>
					</ЕдиницаВеличины>
				</xsl:for-each>
			</КратныеЕдиницыВеличин>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@* | node() | processing-instruction() | comment()" priority="-1">
		<xsl:copy>
			<xsl:apply-templates select="@* | node() | text() | processing-instruction() | comment()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
