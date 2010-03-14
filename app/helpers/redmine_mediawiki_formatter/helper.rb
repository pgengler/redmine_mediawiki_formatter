module RedmineMediawikiFormatter
	module Helper
		unloadable

		def wikitoolbar_for(field_id)
			file = Engines::RailsExtensions::AssetHelpers.plugin_asset_path('redmine_mediawiki_formatter', 'help', 'mediawiki_syntax.html')
			help_link = l(:setting_text_formatting) + ': ' +
				link_to(
					l(:label_help), file, :onclick => "window.open(\"#{file}\", \"\", \"resizable=yes, location=no, width=300, height=640, menubar=no, status=no, scrollbars=yes\"); return false;"
				)
 				javascript_include_tag('jstoolbar/jstoolbar') +
				javascript_include_tag('mediawiki', :plugin => 'redmine_mediawiki_formatter') +
				javascript_include_tag("lang/mediawiki-#{current_language}", :plugin => 'redmine_mediawiki_formatter') +
				javascript_include_tag("jstoolbar/lang/jstoolbar-#{current_language}") +
				javascript_tag("var toolbar = new jsToolBar($('#{field_id}')); toolbar.setHelpLink('#{help_link}'); toolbar.draw();"
			)
		end

		def initial_page_content(page)
			"= #{page.pretty_title} ="
		end

		def heads_for_wiki_formatter
			stylesheet_link_tag('jstoolbar')
		end
	end
end
