<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:e5r="http://e5r.no/xml">

	<xsl:include href="../utilities/layout.xsl" />
	<xsl:include href="../utilities/urlencode.xsl" />
	<xsl:include href="../utilities/dates.xsl" />

	<xsl:param name="url-type" />

	<xsl:template name="content">
		<xsl:choose>
			<xsl:when test="$app">
				<xsl:apply-templates select="vis-app/entry" />
			</xsl:when>
			<xsl:otherwise>
				<aside>
					<section class="ordering">
						<h1>Sortering</h1>
						<ul>
							<li>
								<label>
									<input type="radio" name="sort" value="system:date">
										<xsl:if test="params/url-sort = 'system:date'">
											<xsl:attribute name="checked" />
										</xsl:if>
									</input>
									Dato
								</label>
							</li>
							<li>
								<label>
									<input type="radio" name="sort" value="visninger">
										<xsl:if test="params/url-sort = 'visninger'">
											<xsl:attribute name="checked" />
										</xsl:if>
									</input>
									Popularitet
								</label>
							</li>
							<li>
								<label>
									<input type="radio" name="sort" value="navn">
										<xsl:if test="not(params/url-sort) or params/url-sort = 'navn'">
											<xsl:attribute name="checked" />
										</xsl:if>
									</input>
									Navn
								</label>
							</li>
						</ul>
					</section>

					<section class="categories">
						<h1>Finn webapps</h1>
						<ul>
							<xsl:apply-templates select="merkelapper/entry" />
						</ul>
					</section>
				</aside>

				<div class="main">
					<section class="app-grid">
						<xsl:apply-templates select="apps/entry" mode="app-grid" />
					</section>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="vis-app/entry">
		<xsl:variable name="appUrl">
			<xsl:call-template name="url-encode">
				<xsl:with-param name="str" select="concat($root, '/apps/', navn/@handle, '/')" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="fbUrl">
			<xsl:if test="facebook-side">
				<xsl:call-template name="url-encode">
					<xsl:with-param name="str" select="facebook-side" />
				</xsl:call-template>
			</xsl:if>
		</xsl:variable>

		<div class="main">
			<article id="app">
				<header>
					<h1><xsl:value-of select="navn" />&#160;<span class="developer">fra <xsl:value-of select="utvikler/item[1]/navn" /></span></h1>

					<div id="sharing">
						<xsl:if test="facebook-side">
							<iframe src="http://www.facebook.com/plugins/like.php?href={$fbUrl}&amp;send=false&amp;layout=button_count&amp;width=100&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font=lucida+grande&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:100px; height:21px;" allowTransparency="true"></iframe>
						</xsl:if>
						<iframe allowtransparency="true" frameborder="0" scrolling="no" src="http://platform.twitter.com/widgets/tweet_button.html?url={$appUrl}" style="width:100px; height:21px;"></iframe>
					</div>
				</header>

				<div class="content">
					<div class="screenshots">
						<xsl:apply-templates select="skjermbilder/item" />
					</div>
					<div class="description">
						<p class="summary">
							<xsl:value-of select="undertittel" />
						</p>

						<xsl:copy-of select="beskrivelse/* | beskrivelse/text()" />
					</div>
				</div>

				<h2>Erfaringer og kommentarer</h2>
				<xsl:call-template name="disqus" />
			</article>
		</div>

		<aside>
			<section id="price-and-register">
				<p class="price">
					<xsl:choose>
						<xsl:when test="number(fra-manedspris)">
							Fra kr <xsl:value-of select="fra-manedspris" /> per måned.
							<xsl:if test="proveperiode">
								<br /><span class="has-free-trial">Gratis prøveperiode</span>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							Gratis!
						</xsl:otherwise>
					</xsl:choose>
				</p>
				<a href="{nettside}">Besøk nettsiden ▶</a>
				<a href="{registrering}">Registrer deg nå ▶</a>
			</section>

			<section id="facts">
				<h1>Informasjon</h1>
				<xsl:apply-templates select="." mode="facts" />
			</section>
		</aside>
	</xsl:template>

	<!--
		Kategori i navigasjonsopplisting.
	-->
	<xsl:template match="merkelapper/entry">
		<li>
			<label>
				<xsl:value-of select="navn" />
				<input type="checkbox" name="nokkelord" value="{navn/@handle}">
					<xsl:if test="contains($url-type, navn/@handle)">
						<xsl:attribute name="checked" />
					</xsl:if>
				</input>
			</label>
		</li>
	</xsl:template>
	
	<!--
		A thumb nail screenshot with a link to the full size image.
	-->
	<xsl:template match="skjermbilder/item">
		<a href="{$workspace}{bilde/@path}/{bilde/filename}">
			<img src="{$root}/image/1/232/0{bilde/@path}/{bilde/filename}" width="232" />
		</a>
	</xsl:template>

	<!--
		Facts about the webapp.
	-->
	<xsl:template match="vis-app/entry" mode="facts">
		<table id="facts">
			<tr>
				<th scope="row">Utvikler</th>
				<td><a href="{utvikler/item[1]/nettside}"><xsl:value-of select="utvikler/item[1]/navn" /></a></td>
			</tr>
			<tr>
				<th scope="row">Kategorier</th>
				<td>
					<xsl:for-each select="nokkelord/item">
						<a href="{$root}/apps/?type={@handle}"><xsl:value-of select="." /></a>
						<xsl:if test="position() != last()">, </xsl:if>
					</xsl:for-each>
				</td>
			</tr>
			<tr>
				<th scope="row">Lagt til</th>
				<td><xsl:value-of select="e5r:format-date('j. F Y', opprettet)" /></td>
			</tr>
			<tr>
				<th scope="row">Sist oppdatert</th>
				<td><xsl:value-of select="e5r:format-date('j. F Y', oppdatert)" /></td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="disqus">
		<div id="disqus_thread"></div>
		<script type="text/javascript">
			<xsl:text>
				var disqus_shortname = 'norskewebapps';
				var disqus_developer = 1;
				var	disqus_identifier = '</xsl:text><xsl:value-of select="navn/@handle" /><xsl:text>';
				var disqus_url = 'http://webapps.no/apps/</xsl:text><xsl:value-of select="navn/@handle" /><xsl:text>/';
				(function() {
					var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
					dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
					(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
				})();
			</xsl:text>
		</script>
		<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
		<a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
	</xsl:template>
</xsl:stylesheet>
