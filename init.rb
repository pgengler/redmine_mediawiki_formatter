# Redmine Mediawiki formatter
require 'redmine'
 
RAILS_DEFAULT_LOGGER.info 'Starting Mediawiki formatter for RedMine'
 
Redmine::Plugin.register :redmine_mediawiki_formatter do
	name 'Mediawiki formatter'
	author 'Phil Gengler'
	description 'This provides Mediawiki syntax (like Wikipedia) as a wiki format'
	version '0.0.2'
 
	wiki_format_provider 'mediawiki', RedmineMediawikiFormatter::WikiFormatter, RedmineMediawikiFormatter::Helper
end
