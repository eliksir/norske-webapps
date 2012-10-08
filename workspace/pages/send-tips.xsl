<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="../utilities/layout.xsl" />
	<xsl:variable name="event" select="/data/events/send-tips" />

	<xsl:template name="content">
		<h1><xsl:value-of select="$page-title"/></h1>

		<!--xsl:copy-of select="$event" /-->

		<form id="send-tips" method="post" action="" enctype="multipart/form-data">
			<xsl:if test="$event[@result = 'error']">
				<xsl:attribute name="class">error</xsl:attribute>

				<p class="message">
					<xsl:value-of select="$event/message" />
				</p>
			</xsl:if>

			<input name="MAX_FILE_SIZE" type="hidden" value="2097152" />
			<div class="field">
				<xsl:if test="$event/navn">
					<xsl:attribute name="class">field error</xsl:attribute>
				</xsl:if>

				<label for="app-navn">Navn</label>
				<input id="app-navn" name="fields[navn]" type="text"
					value="{$event/post-values/navn}" />

				<xsl:if test="$event/navn">
					<span class="error">
						<xsl:value-of select="$event/navn/@message" />
					</span>
				</xsl:if>
			</div>
			<div class="field">
				<xsl:if test="$event/nettside">
					<xsl:attribute name="class">field error</xsl:attribute>
				</xsl:if>

				<label for="app-nettside">Nettside</label>
				<input id="app-nettside" name="fields[nettside]" type="text"
					value="{$event/post-values/nettside}" />
				
				<xsl:if test="$event/nettside">
					<span class="error">
						<xsl:value-of select="$event/nettside/@message" />
					</span>
				</xsl:if>
			</div>
			<div class="field">
				<xsl:if test="$event/undertittel">
					<xsl:attribute name="class">field error</xsl:attribute>
				</xsl:if>

				<label for="app-undertittel">Undertittel</label>
				<input id="app-undertittel" name="fields[undertittel]" type="text"
					value="{$event/post-values/undertittel}" />

				<xsl:if test="$event/undertittel">
					<span class="error">
						<xsl:value-of select="$event/undertittel/@message" />
					</span>
				</xsl:if>
			</div>
			<div class="field">
				<xsl:if test="$event/beskrivelse">
					<xsl:attribute name="class">field error</xsl:attribute>
				</xsl:if>

				<label for="app-beskrivelse">Beskrivelse</label>
				<textarea id="app-beskrivelse" name="fields[beskrivelse]" rows="15" cols="50"><xsl:value-of select="$event/post-values/beskrivelse" /></textarea>

				<xsl:if test="$event/beskrivelse">
					<span class="error">
						<xsl:value-of select="$event/beskrivelse/@message" />
					</span>
				</xsl:if>
			</div>
			<div class="field">
				<xsl:if test="$event/registrering">
					<xsl:attribute name="class">field error</xsl:attribute>
				</xsl:if>

				<label for="app-registrering">Registrering</label>
				<input id="app-registrering" name="fields[registrering]" type="text"
					value="{$event/post-values/registrering}" />

				<xsl:if test="$event/registrering">
					<span class="error">
						<xsl:value-of select="$event/registrering/@message" />
					</span>
				</xsl:if>
			</div>
			<div class="field">
				<xsl:if test="$event/facebook-side">
					<xsl:attribute name="class">field error</xsl:attribute>
				</xsl:if>

				<label for="app-facebook-side">Facebook-side</label>
				<input id="app-facebook-side" name="fields[facebook-side]" type="text"
					value="{$event/post-values/facebook-side}" />

				<xsl:if test="$event/facebook-side">
					<span class="error">
						<xsl:value-of select="$event/facebook-side/@message" />
					</span>
				</xsl:if>
			</div>
			<div class="field">
				<xsl:if test="$event/fra-manedspris">
					<xsl:attribute name="class">field error</xsl:attribute>
				</xsl:if>

				<label for="app-fra-manedspris">Fra månedspris</label>
				<input id="app-fra-manedspris" name="fields[fra-manedspris]" type="text"
					value="{$event/post-values/fra-manedspris}" />

				<xsl:if test="$event/fra-manedspris">
					<span class="error">
						<xsl:value-of select="$event/fra-manedspris/@message" />
					</span>
				</xsl:if>
			</div>
			<div class="field">
				<xsl:if test="$event/proveperiode">
					<xsl:attribute name="class">field error</xsl:attribute>
				</xsl:if>

				<label for="app-proveperiode">Prøveperiode</label>
				<input id="app-proveperiode" name="fields[proveperiode]" type="checkbox"
					values="{$event/post-values/proveperiode}" />

				<xsl:if test="$event/proveperiode">
					<span class="error">
						<xsl:value-of select="$event/proveperiode/@message" />
					</span>
				</xsl:if>
			</div>

			<h2>Utvikler</h2>
			<div class="field">
				<xsl:if test="$event/utvikler">
					<xsl:attribute name="class">field error</xsl:attribute>
				</xsl:if>

				<select name="fields[utvikler]" size="1">
					<option value="">Velg utvikler...</option>
					<xsl:apply-templates select="/data/utviklere/entry" />
					<option value="+">Legg til...</option>
				</select>

				<xsl:if test="$event/utvikler">
					<span class="error">
						<xsl:value-of select="$event/utvikler/@message" />
					</span>
				</xsl:if>
			</div>

			<div class="field">
				<label for="utvikler-navn">Navn</label>
				<input id="utvikler-navn" name="fields[ny-utvikler][navn]" type="text" />
			</div>
			<div class="field">
				<label for="utvikler-nettside">Nettside</label>
				<input id="utvikler-nettside" name="fields[ny-utvikler][nettside]" type="text" />
			</div>

			<h2>Skjermklipp</h2>
			<div class="field">
				<label for="skjermklipp-bilde-1">Bilde</label>
				<input id="skjermklipp-bilde-1" name="fields[nytt-skjermklipp][0][bilde]" type="file" />
			</div>
			<div class="field">
				<label for="skjermklipp-tittel-1">Tittel</label>
				<input id="skjermklipp-tittel-1" name="fields[nytt-skjermklipp][0][tittel]" type="text" />
			</div>

			<div class="field">
				<label for="skjermklipp-bilde-2">Bilde</label>
				<input id="skjermklipp-bilde-2" name="fields[nytt-skjermklipp][1][bilde]" type="file" />
			</div>
			<div class="field">
				<label for="skjermklipp-tittel-2">Tittel</label>
				<input id="skjermklipp-tittel-2" name="fields[nytt-skjermklipp][1][tittel]" type="text" />
			</div>

			<input name="action[send-tips]" type="submit" value="Submit" />
		</form>
	</xsl:template>

	<xsl:template match="utviklere/entry">
		<option value="{@id}"><xsl:value-of select="navn" /></option>
	</xsl:template>

</xsl:stylesheet>
