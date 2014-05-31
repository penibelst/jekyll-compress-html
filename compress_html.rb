# encoding: utf-8
require 'nokogiri'


module Jekyll
  module CompressHTMLFilter

    def compress_html(input)
      doc = Nokogiri::HTML::DocumentFragment.parse(input)
      doc.search(BLOCK_TAGS).each { |node|
        next_node = node.next_sibling
        next_node.remove if next_node && next_node.text.strip == ''
      }
      doc.to_html(:save_with =>
        Nokogiri::XML::Node::SaveOptions::AS_HTML
      ).strip
    end

  private

    BLOCK_TAGS = 'div, h1, h2, h3, h4, h5, h6, li, meta, ol, p, ul'

  end
end

Liquid::Template.register_filter(Jekyll::CompressHTMLFilter)
