#!/usr/bin/env ruby

require "json"
require "pathname"

root = Pathname.new(__dir__).parent
config = JSON.parse((root / "site-metadata.json").read)
site_url = config.fetch("siteUrl").sub(%r{/+\z}, "")
errors = []

config.fetch("pages").each do |file, page|
  html = (root / file).read
  expected_title = page.fetch("title", config.fetch("defaultTitle"))
  expected_description = page.fetch("description", config.fetch("defaultDescription"))
  expected_canonical = page.fetch("path") == "/" ? "#{site_url}/" : "#{site_url}#{page.fetch("path")}"

  {
    "title" => /<title>#{Regexp.escape(expected_title)}<\/title>/,
    "description" => /<meta name="description" content="#{Regexp.escape(expected_description)}" \/>/,
    "canonical" => /<link rel="canonical" href="#{Regexp.escape(expected_canonical)}" \/>/,
    "og:url" => /<meta property="og:url" content="#{Regexp.escape(expected_canonical)}" \/>/,
    "og:title" => /<meta property="og:title" content="#{Regexp.escape(expected_title)}" \/>/,
    "twitter:title" => /<meta name="twitter:title" content="#{Regexp.escape(expected_title)}" \/>/
  }.each do |label, pattern|
    errors << "#{file}: incorrect or missing #{label}" unless html.match?(pattern)
  end

  {
    "title" => /<title>/,
    "canonical" => /<link rel="canonical"/,
    "Open Graph title" => /<meta property="og:title"/,
    "Twitter card" => /<meta name="twitter:card"/
  }.each do |label, pattern|
    count = html.scan(pattern).length
    errors << "#{file}: expected one #{label}, found #{count}" unless count == 1
  end
end

abort(errors.join("\n")) unless errors.empty?
puts "Validated metadata for #{config.fetch("pages").length} pages."
