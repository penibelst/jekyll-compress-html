---
title: Compress HTML in Jekyll
layout: default
---

A [Jekyll][0] layout that compresses [HTML][html-spec]. At a glance:

* removes unnecessary whitespace;
* removes optional end tags;
* removes comments;
* preserves whitespace within `<pre>`;
* GitHub Pages compatible;
* ignores development environments;
* configurable affected elements;
* automatically tested.

The layout is written in pure [Liquid][2], no plugins are required.

The main reason for the compression is to [fight the space between inline block elements][3]. File size reduction is a welcome gain.

## Results

All options activated. File sizes in bytes. As of June 2014.

Site | Original | Compressed |
:--- | -------: | ---------: |
[Bootstrap CSS][11] | 249762 | 232085 |
[IIIF Image][14] | 61150 | 52732 |
[Jekyll News][jekyll-news] | 45358 | 40251 |
[Mother&shy;fucking][13] | 5200 | 4519 |
[Performance Culture][15] | 20715 | 19986 |

## Installation

1. Get the [latest release][4]. Extract `compress.html` and copy it to your `_layouts`.
1. Reference the `compress` layout in your highest-level layout. For example in `_layouts/default.html`:

~~~html
---
layout: compress
---

<html>
{% raw %}{{ content }}{% endraw %}
</html>
~~~

Now all your markup will be processed by the `compress` layout.

## Configuration

By default the layout replaces contiguous whitespace with a single whitespace character. Additional settings can be specified in the `compress_html` key inside the `_config.yml` file:

~~~yaml
compress_html:
  clippings: []
  comments: []
  endings: []
  ignore:
    envs: []
~~~

### clippings

An array of elements to clip whitespace around them. The following elements may be safe to clip:

* [Metadata content][html-semantics];
* [Sections][html-semantics];
* [Grouping content][html-semantics] except the `pre` element;
* [Tabular data][html-tabular].

Example:

~~~yaml
compress_html:
  clippings: [div, p, ul, td, h1, h2]
~~~

Use the shortcut `all` to clip all safe elements.

~~~yaml
compress_html:
  clippings: all
~~~

### comments

An array of exactly two comment tags to strip comments enclosed by them. The first string must be the start tag, the second must be the end tag. Example:

~~~yaml
compress_html:
  comments: ["<!-- ", " -->"]
~~~

Whitespaces around the tags prevent [conditional comments][cond] from being deleted.

### endings

An array of elements with [optional end tags][html-syntax]. These end tags will be removed.

Example:

~~~yaml
compress_html:
  endings: [p, li, td]
~~~

Use the shortcut `all` to remove all optional endings.

~~~yaml
compress_html:
  endings: all
~~~

### ignore.envs

An array of environments given by `ENV["JEKYLL_ENV"]` where the compress layout is ignored. This may be useful while developing a website.

### Full-blown sample

~~~yaml
compress_html:
  clippings: all
  comments: ["<!-- ", " -->"]
  endings: all
  ignore:
    envs: [development]
~~~

## Restrictions

* Whitespaces inside of the `textarea` element are squeezed. Please don’t use the layout on pages with non-empty `textarea`.
* Inline JS can become broken where `//` comments used. Please remove the comments or change to `/**/` style.
* Invalid markup can lead to unexpected results. Please make sure your markup is valid before.

## Examples

This page itself is compressed by the layout. It’s hosted by GitHub in the `gh-pages` [branch](https://github.com/penibelst/jekyll-compress-html/tree/gh-pages).

Look how [others use][10] the layout on GitHub too.

## Testing

[![Build Status](https://api.travis-ci.org/penibelst/jekyll-compress-html.svg?branch=master){: .status }](https://travis-ci.org/penibelst/jekyll-compress-html)

Take a look at project’s `test/source` and `test/expected` directories. They contain self-explanatory specifications. Run `rake` to test the layout.

## Development

Feel free to submit bugs, patches, and questions in the [repository](https://github.com/penibelst/jekyll-compress-html).

----

© 2014–2015 [Anatol Broder](http://penibelst.de/)

[0]: http://jekyllrb.com/
[html-spec]: https://html.spec.whatwg.org/
[2]: http://docs.shopify.com/themes/liquid-documentation/basics
[3]: http://css-tricks.com/fighting-the-space-between-inline-block-elements/
[4]: https://github.com/penibelst/jekyll-compress-html/releases/latest
[html-semantics]: https://html.spec.whatwg.org/multipage/semantics.html
[html-syntax]: https://html.spec.whatwg.org/multipage/syntax.html
[html-tabular]: https://html.spec.whatwg.org/multipage/tables.html
[10]: https://github.com/search?l=html&o=desc&q=jekyll-compress-html+path%3A_layouts&s=indexed&type=Code
[11]: http://getbootstrap.com/css/
[jekyll-news]: http://jekyllrb.com/news/
[13]: http://motherfuckingwebsite.com/
[14]: http://iiif.io/api/image/2.0/
[15]: http://calendar.perfplanet.com/2012/creating-a-performance-culture/
[cond]: http://msdn.microsoft.com/en-us/library/ms537512.aspx
