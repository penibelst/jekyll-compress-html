Compress HTML in Jekyll
====================

[![Build Status](https://travis-ci.org/penibelst/jekyll-compress-html.svg?branch=master)](https://travis-ci.org/penibelst/jekyll-compress-html)

A [Jekyll][0] layout that compresses [HTML][1]. At a glance:

* stripes whitespace between block-level elements;
* squeezes whitespace;
* removes empty elements;
* preserves `<pre>`.

Works on Github Pages, because no plugins required. The layout is written in pure [Liquid][2].

The main reason for the compression is to [fight the space between inline block elements][3]. Size reduction is a welcome gain.

## Installation

### 1. Download

Get the [latest release][4]. Extract `compress.html` and copy it to your `_layouts`.

### 2. Declaration

Reference the `compress` layout inside your highest-level layout. For example in `_layouts/default.html`:

```html
---
layout: compress
---
<html>
{{ content }}
</html>
```

Now all your markup will be processed by the `compress` layout.

### 3. Configuration

The layout setting go in the `compress_html` variable inside the `_config.yml` file:

```yaml
compress_html:
  collapses: []
  omissions: []
```

#### `collapses`

An array of elements to strip whitespace between them. The following elements are a good choice to collapse:

* [Metadata content][8]
* [Comments][9]
* [Sections][5]
* [Grouping content][6] except the `pre` element
* [Tabular data][7]

#### `omissions`

An array of elements with [optional end tags][9].

#### Sample

```yaml
compress_html:
  collapses: [div]
  omissions: [p, li]
```

## Testing

Jekyll versions:

* 1.x.x
* 2.x.x

Take a look at project’s `test/source` and `test/expected` directories. They contain self-explanatory specifications. Run `rake` to test the layout.

## Restrictions :warning:

* Whitespaces inside of the `textarea` element are squeezed. Please don’t use the layout on pages with non-empty `textarea`.
* Inline JS can become broken where `//` comments used. Please remove the comments or change to `/**/` style.

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
[10]: https://github.com/search?q=%27jekyll-compress-html%27+path%3A_layouts&type=Code
