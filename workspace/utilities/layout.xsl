<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="utf-8" indent="yes" />

	<xsl:template match="/data">
		<xsl:text disable-output-escaping='yes'>&lt;!doctype html>&#13;</xsl:text>
		<html lang="no">

			<head>
				<meta charset="utf-8" />
				<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

				<title>Norske Webapps</title>
				<meta name="description" content="" />
				<meta name="author" content="Eliksir AS" />

				<link rel="stylesheet" type="text/css" href="{$workspace}/css/site.css" />

				<script src="{$workspace}/js/libs/modernizr-2.0.6.min.js"></script>
			</head>

			<body>
				<header>
					<div class="content">
						<a href="/"><img src="{$workspace}/img/logo.png" alt="Norske Webapps" /></a>

						<nav>
							<ul>
								<li><a href="/">Hjem</a></li>
								<li><a href="/">Webapps</a></li>
								<li><a href="/send-tips/">Foreslå webapp</a></li>
							</ul>
						</nav>
					</div>
				</header>

				<div id="content" role="main">
					<xsl:call-template name="content" />
				</div>

				<footer>
					<div class="content">
						© <a href="http://e5r.no/">Eliksir AS</a>.
						<ul class="info">
							<li><a href="/hva-er-webapps/">Hva er webapps?</a></li>
							<li><a href="/om-webapps-no/">Om webapps.no</a></li>
						</ul>
					</div>
				</footer>
			</body>

			<script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
			<script><![CDATA[window.jQuery || document.write('<script src="/workspace/js/libs/jquery-1.6.2.min.js"><\/script>')]]></script>
			<script src="{$workspace}/js/app.js"></script>

			<!-- TODO: Activate Google Analytics
			<script>
				<![CDATA[
			    window._gaq = [['_setAccount','UAXXXXXXXX1'],['_trackPageview'],['_trackPageLoadTime']];
			    Modernizr.load({
					load: ('https:' == location.protocol ? '//ssl' : '//www') + '.google-analytics.com/ga.js'
				});
				]]>
			</script>
			-->

			<!-- Prompt IE 6 users to install Chrome Frame:
				 chromium.org/developers/how-tos/chrome-frame-getting-started -->
			<xsl:comment><![CDATA[[if lt IE 7]>
			<script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>
			<script>window.attachEvent('onload',function(){CFInstall.check({mode:'overlay'})})</script>
			<![endif]]]></xsl:comment>
		</html>
	</xsl:template>

	<!--
		En av de nyeste eller mest populære som vises i vanlig opplisting.
	-->
	<xsl:template match="entry[preceding-sibling::section[@handle = 'webapp']]" mode="app-grid">
		<xsl:variable name="bilde" select="skjermbilder/item[hoved]/bilde" />

		<article>
			<a href="{$root}/apps/{navn/@handle}">
				<xsl:if test="$bilde">
					<img src="/image/2/232/150/2{$bilde/@path}/{$bilde/filename}" width="232" height="150" />
				</xsl:if>
				<h1><xsl:value-of select="navn" /></h1>
				<ul>
					<xsl:for-each select="nokkelord/item">
						<xsl:sort select="." />
						<li>
							<a href="{$root}/apps/?type={@handle}"><xsl:value-of select="." /></a>
							<xsl:if test="position() != last()">, </xsl:if>
						</li>
					</xsl:for-each>
				</ul>
			</a>
		</article>

		<xsl:if test="position() != last() and position() mod 3 = 0">
			<hr />
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
