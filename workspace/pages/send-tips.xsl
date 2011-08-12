<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="../utilities/layout.xsl" />

	<xsl:template name="content">
		<h1><xsl:value-of select="$page-title"/></h1>

		<form method="post" action="" enctype="multipart/form-data">
			<input name="MAX_FILE_SIZE" type="hidden" value="2097152" />
			<div class="field">
				<label>Navn <input name="fields[navn]" type="text" /></label>
			</div>
			<div class="field">
				<label>Nettside <input name="fields[nettside]" type="text" /></label>
			</div>
			<div class="field">
				<label>Undertittel <input name="fields[undertittel]" type="text" /></label>
			</div>
			<div class="field">
				<label>Beskrivelse <textarea name="fields[beskrivelse]" rows="15" cols="50"></textarea></label>
			</div>
			<div class="field">
				<label>Registrering <input name="fields[registrering]" type="text" /></label>
			</div>
			<div class="field">
				<label>Facebook-side <input name="fields[facebook-side]" type="text" /></label>
			</div>
			<div class="field">
				<label>Fra månedspris <input name="fields[fra-manedspris]" type="text" /></label>
			</div>
			<div class="field">
				<label>Prøveperiode <input name="fields[proveperiode]" type="checkbox" /></label>
			</div>

			<h2>Utvikler</h2>
			<div class="field">
				<select name="fields[utvikler]" size="1">
					<xsl:apply-templates select="data/utviklere/entry" />
					<option value="+">Legg til...</option>
				</select>
			</div>

			<div class="field">
				<label>Navn <input name="fields[ny-utvikler][navn]" type="text" /></label>
			</div>
			<div class="field">
				<label>Nettside <input name="fields[ny-utvikler][nettside]" type="text" /></label>
			</div>

			<h2>Skjermklipp</h2>
			<div class="field">
				<label>Bilde <input name="fields[nytt-skjermklipp][0][bilde]" type="file" /></label>
			</div>
			<div class="field">
				<label>Tittel <input name="fields[nytt-skjermklipp][0][tittel]" type="text" /></label>
			</div>

			<div class="field">
				<label>Bilde <input name="fields[nytt-skjermklipp][1][bilde]" type="file" /></label>
			</div>
			<div class="field">
				<label>Tittel <input name="fields[nytt-skjermklipp][1][tittel]" type="text" /></label>
			</div>

			<input name="action[send-tips]" type="submit" value="Submit" />
		</form>
	</xsl:template>

	<xsl:template match="utviklere/entry">
		<option value="{@id}"><xsl:value-of select="navn" /></option>
	</xsl:template>

</xsl:stylesheet>
