# encoding: utf-8
require 'nokogiri'


module Jekyll
  module CompressHTMLFilter

    def compress_html(input)
      compress(input)
    end

  private

    # https://developer.mozilla.org/en-US/docs/Web/HTML/Block-level_elements
    BLOCK_ELEMENTS = %w(
      address
      article
      aside
      audio
      blockquote
      dd
      div
      dl
      dt
      figcaption
      figure
      form
      footer
      h1 h2 h3 h4 h5 h6
      hr
      li
      ol
      p
      pre
      section
      table
      ul)

    def compress(input)
      doc = Nokogiri::HTML::DocumentFragment.parse(input) { |config|
        # http://nokogiri.org/Nokogiri/XML/ParseOptions.html
        config.noerror.strict.noent
      }

      remove_comments(doc)
      remove_empty_block_elements(doc)

      doc.to_html(:save_with => Nokogiri::XML::Node::SaveOptions::AS_HTML).strip
    end

    def remove_empty_siblings(node)
      [node.previous_sibling, node.next_sibling, node].each { |n|
        n.remove if !n.nil? && n.content.strip.empty?
      }
    end

    def remove_comments(doc)
      doc.traverse { |node|
        node.remove if node.comment? && node.content !~ /\A(\[if|\<\!\[endif)/
      }
    end

    def remove_empty_block_elements(doc)
      doc.search(BLOCK_ELEMENTS.join(',')).each { |node|
        remove_empty_siblings(node)
      }
    end

  end
end

Liquid::Template.register_filter(Jekyll::CompressHTMLFilter)
