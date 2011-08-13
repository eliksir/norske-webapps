<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="../utilities/layout.xsl" />

	<xsl:template name="content">
		<aside>
			<h1>Om webapps.no</h1>
			<p>
				Lorem ipsum dolor sit amet, maiores ornare ac fermentum, imperdiet
				ut vivamus a, nam lectus at nunc. Quam euismod sem, semper ut
				potenti pellentesque quisque. In eget sapien sed, sit duis
				vestibulum ultricies, placerat morbi amet vel, nullam in in
				lorem vel. In molestie elit dui dictum, praesent nascetur
				pulvinar sed, in dolor pede in aliquam, risus nec error quis pharetra.
			</p>
			<p>
				<a href="">Hva er webapps?</a>&#160;<a href="">Hvem står bak?</a>
			</p>

			<section class="categories">
				<h1>Finn webapps</h1>
				<ul>
					<xsl:apply-templates select="merkelapper/entry" />
				</ul>
			</section>
		</aside>

		<div class="main">
			<div id="featured-apps">
				<ul>
					<xsl:apply-templates select="fremhevede/entry" mode="nav" />
				</ul>
				<xsl:apply-templates select="fremhevede/entry" />
			</div>

			<section id="new-apps" class="app-grid">
				<h1>Nye webapps <a href="/apps/?sort=system:date">vis alle ▶</a></h1>
				<xsl:apply-templates select="nyeste/entry" mode="app-grid" />
			</section>

			<section id="popular-apps" class="app-grid">
				<h1>Populære webapps <a href="/apps/?sort=visninger">vis alle ▶</a></h1>
				<xsl:apply-templates select="mest-vist/entry" mode="app-grid" />
			</section>
		</div>
	</xsl:template>

	<!--
		Kategori i navigasjonsopplisting.
	-->
	<xsl:template match="merkelapper/entry">
		<li>
			<a href="{$root}/apps/?type={navn/@handle}">
				<xsl:value-of select="navn" />
				<span class="count"><xsl:value-of select="@webapp" /></span>
			</a>
		</li>
	</xsl:template>

	<!--
		En utvalgt applikasjon i navigasjon over slideshow med utvalgte.
	-->
	<xsl:template match="fremhevede/entry" mode="nav">
		<xsl:variable name="bilde" select="skjermbilder/item[hoved]/bilde" />
		<li data-app="{navn/@handle}">
			<!--img src="/image/2/150/85/2{$bilde/@path}/{$bilde/filename}" alt="{navn}" width="150" height="85" /-->
			<img src="/image/2/102/78/5{$bilde/@path}/{$bilde/filename}" alt="{navn}" width="102" height="78" />
		</li>
	</xsl:template>

	<!--
		En utvalgt applikasjon som vises i slideshow.
	-->
	<xsl:template match="fremhevede/entry">
		<xsl:variable name="bilde" select="skjermbilder/item[hoved]/bilde" />
		<article>
			<a href="{$root}/apps/{navn/@handle}">
				<xsl:if test="$bilde">
					<!--img src="/image/2/574/340/2{$bilde/@path}/{$bilde/filename}" width="574" height="340" /-->
					<img src="/image/2/608/342/2{$bilde/@path}/{$bilde/filename}" width="608" height="342" />
				</xsl:if>
				<div class="info">
					<h1><xsl:value-of select="navn" /></h1>
					<p>fra <xsl:value-of select="utvikler/item[1]/navn" /></p>
					<p class="short-description">
						<xsl:value-of select="undertittel" />
					</p>
				</div>
			</a>
		</article>
	</xsl:template>

</xsl:stylesheet>
