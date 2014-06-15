Compress HTML in Jekyll
====================

[![Build Status](https://travis-ci.org/penibelst/jekyll-compress-html.svg?branch=master)](https://travis-ci.org/penibelst/jekyll-compress-html)

A [Jekyll][0] layout that compresses [HTML][1]. At a glance:

* removes unnecessary whitespace;
* removes optional end tags;
* preserves whitespace within `<pre>`;
* Github Pages compatible;
* configurable affected elements;
* automatically tested.

The layout is written in pure [Liquid][2], no plugins are required.

The main reason for the compression is to [fight the space between inline block elements][3]. File size reduction is a welcome gain.

## Installation

1. Get the [latest release][4]. Extract `compress.html` and copy it to your `_layouts`.
1. Reference the `compress` layout in your highest-level layout. For example in `_layouts/default.html`:

   ```html
---
layout: compress
---
<html>
{{ content }}
</html>
```

Now all your markup will be processed by the `compress` layout.

## Configuration

By default the layout replaces contiguous whitespace with a single whitespace character. Additional settings can be specified in the `compress_html` key inside the `_config.yml` file:

```yaml
compress_html:
  clippings: []
  endings: []
```

### `clippings`

An array of elements to clip whitespace around them. The following elements may be safe to clip:

* [Metadata content][8];
* [Sections][5];
* [Grouping content][6] except the `pre` element;
* [Tabular data][7].

### `endings`

An array of elements with [optional end tags][9].

### Full-blown sample

```yaml
compress_html:
  clippings: [html, head, title, base, link, meta, style, body, article, section, nav, aside, h1, h2, h3, h4, h5, h6, hgroup, header, footer, address, p, hr, blockquote, ol, ul, li, dl, dt, dd, figure, figcaption, main, div, table, caption, colgroup, col, tbody, thead, tfoot, tr, td, th]
  endings: [html, head, body, li, dt, dd, p, rt, rp, optgroup, option, colgroup, caption, thead, tbody, tfoot, tr, td, th]
```

## Testing

Compatible Jekyll versions are:

* 1.x.x
* 2.x.x

Take a look at project’s `test/source` and `test/expected` directories. They contain self-explanatory specifications. Run `rake` to test the layout.

## Restrictions :warning:

* Whitespaces inside of the `textarea` element are squeezed. Please don’t use the layout on pages with non-empty `textarea`.
* Inline JS can become broken where `//` comments used. Please remove the comments or change to `/**/` style.
* Invalid markup can lead to unexpected results. Please make sure your markup is valid before.

## Examples

Look how people [use the layout on Github][10].

[0]: http://jekyllrb.com/
[1]: http://www.w3.org/TR/html5/
[2]: http://docs.shopify.com/themes/liquid-basics
[3]: http://css-tricks.com/fighting-the-space-between-inline-block-elements/
[4]: https://github.com/penibelst/jekyll-compress-html/releases/latest
[5]: http://www.whatwg.org/specs/web-apps/current-work/multipage/sections.html
[6]: http://www.whatwg.org/specs/web-apps/current-work/multipage/grouping-content.html
[7]: http://www.whatwg.org/specs/web-apps/current-work/multipage/tabular-data.html
[8]: http://www.whatwg.org/specs/web-apps/current-work/multipage/semantics.html
[9]: http://www.whatwg.org/specs/web-apps/current-work/multipage/syntax.html
[10]: https://github.com/search?l=html&q=%27jekyll-compress-html%27+path%3A_layouts
