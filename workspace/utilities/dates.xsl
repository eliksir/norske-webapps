<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:func="http://exslt.org/functions"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:str="http://exslt.org/strings"
                xmlns:e5r="http://e5r.no/xml"
                extension-element-prefixes="exsl date func str">

	<!--
		Localized month names. English is the default locale for which this variable
		should be empty. Otherwise it should contain an XML structure with <month>
		elements with 'name' and 'abbr' attributes with the english month name and
		abbreviated month name. The content of each <month> element is a <localized>
		element with corresponding 'name' and 'abbr' attributes with the localized
		month name and abbreviated month name.

		TODO: Support 'lang' attribute on the <localized> elements for defining
		several different locales.
	-->
	<xsl:variable name="monthnames">
		<month name="January" abbr="Jan">
			<localized name="januar" abbr="jan" />
		</month>
		<month name="February" abbr="Feb">
			<localized name="februar" abbr="feb" />
		</month>
		<month name="March" abbr="Mar">
			<localized name="mars" abbr="mar" />
		</month>
		<month name="April" abbr="Apr">
			<localized name="april" abbr="apr" />
		</month>
		<month name="May" abbr="May">
			<localized name="mai" abbr="mai" />
		</month>
		<month name="June" abbr="Jun">
			<localized name="juni" abbr="jun" />
		</month>
		<month name="July" abbr="Jul">
			<localized name="juli" abbr="jul" />
		</month>
		<month name="August" abbr="Aug">
			<localized name="august" abbr="aug" />
		</month>
		<month name="September" abbr="Sep">
			<localized name="september" abbr="sep" />
		</month>
		<month name="October" abbr="Oct">
			<localized name="oktober" abbr="okt" />
		</month>
		<month name="November" abbr="Nov">
			<localized name="november" abbr="nov" />
		</month>
		<month name="December" abbr="Dec">
			<localized name="desember" abbr="des" />
		</month>
	</xsl:variable>

	<!--
		Localized day names. As with month names, english is the default locale for which
		this variable should be empty. Otherwise see the comment on month names for the
		structure of localized day names. The only difference is using <day> instead of
		<month> elements.
	-->
	<xsl:variable name="daynames">
		<day name="Monday" abbr="Mon">
			<localized name="mandag" abbr="man" />
		</day>
		<day name="Tuesday" abbr="Tue">
			<localized name="tirsdag" abbr="tir" />
		</day>
		<day name="Wednesday" abbr="Wed">
			<localized name="onsdag" abbr="ons" />
		</day>
		<day name="Thursday" abbr="Thu">
			<localized name="torsdag" abbr="tor" />
		</day>
		<day name="Friday" abbr="Fri">
			<localized name="fredag" abbr="fre" />
		</day>
		<day name="Saturday" abbr="Sat">
			<localized name="lørdag" abbr="lør" />
		</day>
		<day name="Sunday" abbr="Sun">
			<localized name="søndag" abbr="søn" />
		</day>
	</xsl:variable>

	<!--
		Outputs a formatted date, implementing the basics of PHP's date() function.
		The characters supported in the format string are:
			Year: y, Y
			Month: m, n, F, M
			Date: d, j, l, D
			Hours: h, H
			Minutes/seconds: i, s
			Misc: z, W, U
		Other characters will simply be output directly. The datetime string must be in a
		ISO 8601 compatible format, which means the result from date:date-time() can be used.

		@param String format The characters defining the date format.
		@param String date-time Optional datetime to format, by default the current date and
                                time will be used. Format needs to be similar to:
                                CCYY-MM-DD HH:MM:SS
	-->
	<func:function name="e5r:format-date">
		<xsl:param name="format" />
		<xsl:param name="date-time" select="date:date-time()" />
		<xsl:variable name="iso8601" select="translate($date-time, ' ', 'T')" />
		
		<func:result>
			<xsl:apply-templates select="str:tokenize($format, '')" mode="date">
				<xsl:with-param name="iso8601" select="$iso8601" />
			</xsl:apply-templates>
		</func:result>
	</func:function>

	<!--
		Template outputting date/time values for a subset of the format characters
		supported by PHPs date() function. Needs the values from a parsed datetime string
		as a parameter to use in substition of format characters.
	-->
	<xsl:template match="token" mode="date">
		<xsl:param name="iso8601" />

		<xsl:choose>
			<!-- Year formats -->
			<xsl:when test=". = 'Y'">
				<xsl:value-of select="date:year($iso8601)" />
			</xsl:when>
			<xsl:when test=". = 'y'">
				<xsl:value-of select="substring(date:year($iso8601), 3)" />
			</xsl:when>

			<!-- Month formats -->
			<xsl:when test=". = 'm'">
				<xsl:value-of select="format-number(date:month-in-year($iso8601), '00')" />
			</xsl:when>
			<xsl:when test=". = 'n'">
				<xsl:value-of select="date:month-in-year($iso8601)" />
			</xsl:when>
			<xsl:when test=". = 'F'">
				<xsl:variable name="months" select="exsl:node-set($monthnames)" />
				<xsl:variable name="monthname" select="date:month-name($iso8601)" />
				<xsl:value-of select="$months/*[@name = $monthname]/*/@name | exsl:node-set($monthname)" />
			</xsl:when>
			<xsl:when test=". = 'M'">
				<xsl:variable name="months" select="exsl:node-set($monthnames)" />
				<xsl:variable name="monthabbr" select="date:month-abbreviation($iso8601)" />
				<xsl:value-of select="$months/*[@abbr = $monthabbr]/*/@abbr | exsl:node-set($monthabbr)" />
			</xsl:when>

			<!-- Day of month formats -->
			<xsl:when test=". = 'd'">
				<xsl:value-of select="format-number(date:day-in-month($iso8601), '00')" />
			</xsl:when>
			<xsl:when test=". = 'j'">
				<xsl:value-of select="date:day-in-month($iso8601)" />
			</xsl:when>
			<xsl:when test=". = 'l'">
				<xsl:variable name="days" select="exsl:node-set($daynames)" />
				<xsl:variable name="dayname" select="date:day-name($iso8601)" />
				<xsl:value-of select="$days/*[@name = $dayname]/*/@name | exsl:node-set($dayname)" />
			</xsl:when>
			<xsl:when test=". = 'D'">
				<xsl:variable name="days" select="exsl:node-set($daynames)" />
				<xsl:variable name="dayabbr" select="date:day-abbreviation($iso8601)" />
				<xsl:value-of select="$days/*[@abbr = $dayabbr]/*/@abbr | exsl:node-set($dayabbr)" />
			</xsl:when>

			<!-- Hour formats -->
			<xsl:when test=". = 'h'">
				<xsl:value-of select="date:hour-in-day($iso8601)" />
			</xsl:when>
			<xsl:when test=". = 'H'">
				<xsl:value-of select="format-number(date:hour-in-day($iso8601), '00')" />
			</xsl:when>

			<!-- Minutes/seconds formats -->
			<xsl:when test=". = 'i'">
				<xsl:value-of select="format-number(date:minute-in-hour($iso8601), '00')" />
			</xsl:when>
			<xsl:when test=". = 's'">
				<xsl:value-of select="format-number(date:second-in-minute($iso8601), '00')" />
			</xsl:when>

			<!-- Miscellanous formats -->
			<xsl:when test=". = 'z'">
				<xsl:value-of select="date:day-in-year($iso8601)" />
			</xsl:when>
			<xsl:when test=". = 'W'">
				<xsl:value-of select="date:week-in-year($iso8601)" />
			</xsl:when>
			<xsl:when test=". = 'U'">
				<xsl:value-of select="date:seconds($iso8601)" />
			</xsl:when>

			<!-- Fallback outputs token character directly -->
			<xsl:otherwise><xsl:value-of select="." /></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
