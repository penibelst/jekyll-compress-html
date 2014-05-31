# encoding: utf-8
require 'nokogiri'


module Jekyll
  module CompressHTMLFilter

    def compress_html(input)
      doc = Nokogiri::HTML(input)
      doc.inner_html
    end

  end
end

Liquid::Template.register_filter(Jekyll::CompressHTMLFilter)
