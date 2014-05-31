# encoding: utf-8
require 'nokogiri'


module Jekyll
  module CompressHTMLFilter

    def compress_html(input)
      doc = Nokogiri::HTML::DocumentFragment.parse(input)
      doc.to_html.strip
    end

  end
end

Liquid::Template.register_filter(Jekyll::CompressHTMLFilter)
