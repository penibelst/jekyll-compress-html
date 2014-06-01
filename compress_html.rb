# encoding: utf-8
require 'nokogiri'


module Jekyll
  module CompressHTMLFilter

    def compress_html(input)
      compress(input)
    end

  private

    BLOCK_TAGS = 'div, h1, h2, h3, h4, h5, h6, li, meta, ol, p, ul'

    def compress(input)
      doc = Nokogiri::HTML::DocumentFragment.parse(input) { |config|
        # http://nokogiri.org/Nokogiri/XML/ParseOptions.html
        config.noerror.strict.noent
      }

      doc.search(BLOCK_TAGS).each { |node|
        remove_empty_siblings(node)
      }

      doc.to_html(:save_with => Nokogiri::XML::Node::SaveOptions::AS_HTML).strip
    end

    def remove_empty_siblings(node)
      [node.previous_sibling, node.next_sibling, node].each { |n|
        n.unlink if !n.nil? && n.text.strip.empty?
      }
    end

  end
end

Liquid::Template.register_filter(Jekyll::CompressHTMLFilter)
