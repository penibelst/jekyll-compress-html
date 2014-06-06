Compress HTML in Jekyll
====================

[![Build Status](https://travis-ci.org/penibelst/jekyll-compress-html.svg?branch=master)](https://travis-ci.org/penibelst/jekyll-compress-html)

A [Jekyll][0] layout that compresses [HTML][1]. At a glance:

* stripes whitespace between block-level elements;
* squeezes whitespace;
* removes empty elements;
* preserves `<pre>`.

Works on Github Pages, because no plugins required. The layout is written in pure [Liquid][2].

## Installation

Download the [latest release][4]. Extract `compress.html` and copy it to your `_layouts`.

## Usage

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

## Coverage

Jekyll versions:

* 1.x.x
* 2.x.x

Whitespaces are stripped around elements:

* [Metadata content][8]
* [Comments][9]
* [Sections][5]
* [Grouping content][6] except the `pre` element
* [Tabular data][7]

[Optional end tags][9] are removed.

Take a look at *[test/source](test/source)* and *[test/expected](test/expected)* directories. They contain self-explanatory specifications. Run `rake` to test the layout.

## Reasons

The main reason for that layout is to get rid of whitespaces. Check out *[Fighting the Space Between Inline Block Elements][3]* for better understanding of the topic. Size reduction is a welcome gain.

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
