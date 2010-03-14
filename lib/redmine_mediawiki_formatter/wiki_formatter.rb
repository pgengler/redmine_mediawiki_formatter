require 'mediacloth'
 
module RedmineMediawikiFormatter
	class RedmineMediaWikiHTMLGenerator < MediaWikiHTMLGenerator
		def parse_internal_link(ast)
			text = parse_wiki_ast(ast)
			text = ast.locator if text.length == 0
			href = link_handler.url_for(ast.locator)
			return '[[' + href + '|' + text + ']]'
		end
	end


	class RedmineMediaWikiLinkHandler < MediaWikiHTMLGenerator::MediaWikiLinkHandler
		def url_for(resource)
			Rails.logger.info "YOU ARE HERE"
			Rails.logger.info resource.to_s
			return resource
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
