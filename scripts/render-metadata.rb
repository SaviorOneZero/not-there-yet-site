#!/usr/bin/env ruby

require "cgi"
require "json"
require "pathname"
require "uri"

root = Pathname.new(__dir__).parent
config = JSON.parse((root / "site-metadata.json").read)
site_url = config.fetch("siteUrl").sub(%r{/+\z}, "")
social_image_url = "#{site_url}#{config.fetch("socialImagePath")}"

config.fetch("pages").each do |file, page|
  title = page.fetch("title", config.fetch("defaultTitle"))
  description = page.fetch("description", config.fetch("defaultDescription"))
  canonical_url = page.fetch("path") == "/" ? "#{site_url}/" : "#{site_url}#{page.fetch("path")}"

  metadata = <<~HTML.chomp.lines.map { |line| "    #{line}" }.join
    <!-- site-metadata:start; generated from site-metadata.json -->
    <title>#{CGI.escapeHTML(title)}</title>
    <meta name="description" content="#{CGI.escapeHTML(description)}" />
    <link rel="canonical" href="#{CGI.escapeHTML(canonical_url)}" />
    <meta property="og:type" content="website" />
    <meta property="og:site_name" content="#{CGI.escapeHTML(config.fetch("siteName"))}" />
    <meta property="og:title" content="#{CGI.escapeHTML(title)}" />
    <meta property="og:description" content="#{CGI.escapeHTML(description)}" />
    <meta property="og:url" content="#{CGI.escapeHTML(canonical_url)}" />
    <meta property="og:image" content="#{CGI.escapeHTML(social_image_url)}" />
    <meta property="og:image:alt" content="#{CGI.escapeHTML(config.fetch("socialImageAlt"))}" />
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="#{CGI.escapeHTML(title)}" />
    <meta name="twitter:description" content="#{CGI.escapeHTML(description)}" />
    <meta name="twitter:image" content="#{CGI.escapeHTML(social_image_url)}" />
    <meta name="twitter:image:alt" content="#{CGI.escapeHTML(config.fetch("socialImageAlt"))}" />
    <!-- site-metadata:end -->
  HTML

  path = root / file
  html = path.read
  generated_block = /    <!-- site-metadata:start; generated from site-metadata\.json -->.*?    <!-- site-metadata:end -->/m

  if html.match?(generated_block)
    html.sub!(generated_block, metadata)
  else
    html.gsub!(/\s*<title>.*?<\/title>/mi, "")
    html.gsub!(/\s*<meta\s+name=["']description["'].*?\/?>/mi, "")
    html.gsub!(/\s*<link\s+rel=["']canonical["'].*?\/?>/mi, "")
    html.gsub!(/\s*<meta\s+(?:property=["']og:[^"']+["']|name=["']twitter:[^"']+["']).*?\/?>/mi, "")
    html.sub!(/(\s*<link rel="icon")/, "\n#{metadata}\n\\1")
  end

  path.write(html)
end
