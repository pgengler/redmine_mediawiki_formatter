require 'mediacloth'


module RedmineMediawikiFormatter
	# This class overrides the normal interal link parser. Since Redmine
	# provides its own way of handling internal links (coincidentally in
	# the same format as for Mediawiki), the 'parse_internal_link'
	# method simply returns a Mediawiki-style link instead of a parsed
	# HTML one.
	class RedmineMediaWikiHTMLGenerator < MediaWikiHTMLGenerator
		def parse_internal_link(ast)
			text = parse_wiki_ast(ast)
			text = ast.locator if text.length == 0
			href = link_handler.url_for(ast.locator)
			return '[[' + href + '|' + text + ']]'
		end
	end

	# This class overrides the 'link_for' method of the
	# MediaWikiHTMLGenerator's MediaWikiLinkHandler class. This method
	# is used for parsing double-bracketed links that include a prefix.
	# For example, [[Image:image_url]]. For now, this only handles
	# Image: links (including 'alt' text), returning an HTML string
	# with the <img> tag.
	# The 'url_for' method is also overridden to simply return the link
	# target.
	class RedmineMediaWikiLinkHandler < MediaWikiHTMLGenerator::MediaWikiLinkHandler
		def url_for(resource)
			return resource
		end

		def link_for(prefix, resource, options=[])
			if prefix == 'Image':
				alt = '';
				if options.length > 0:
					alt = options[0];
				end
				return "<img src='#{resource}' alt='#{alt}' title='#{alt}' />"
			end
		end
	end

	class WikiFormatter
		def initialize(text)
			@text = text
		end

		def to_html(&block)
			parser = MediaWikiParser.new
			parser.lexer = MediaWikiLexer.new
			ast = parser.parse(@text)
			generator = RedmineMediaWikiHTMLGenerator.new
			generator.link_handler = RedmineMediaWikiLinkHandler.new
			generator.parse(ast)
			return generator.html
			rescue => e
			      return("<pre>problem parsing wiki text: #{e.message}\n" + "original text: \n" + @text + "</pre>")

		end
	end
end
