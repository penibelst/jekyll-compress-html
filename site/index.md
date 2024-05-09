---
title: Compress HTML in Jekyll
layout: default
prefetch: "https://github.com/penibelst/jekyll-compress-html"
---

A [Jekyll][jekyll] layout that compresses [HTML][html-spec]. At a glance:

* removes unnecessary whitespace;
* removes optional end tags;
* removes optional start tags;
* removes comments;
* preserves whitespace within `<pre>`;
* GitHub Pages compatible;
* ignores development environments;
* configurable affected elements;
* profile mode;
* automatically tested.

The layout is written in pure [Liquid][liquid], no plugins are required.

## Installation

1. Get the [latest release][github-repo-latest]. Extract `compress.html` and copy it to your `_layouts`.
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

By default the layout replaces contiguous whitespace with a single whitespace character. Additional settings can be specified in the `compress_html` key inside the `_config.yml` file. The default configuration is:

~~~yaml
compress_html:
  clippings: []
  comments: []
  endings: []
  ignore:
    envs: []
  blanklines: false
  profile: false
  startings: []
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

Use the shortcut `all` to remove all comments.

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

### startings

An array of elements with [optional start tags][html-syntax]. These start tags will be removed.

Example:

~~~yaml
compress_html:
  startings: [html, head, body]
~~~

## profile

A boolean value to turn on the profile mode. If true, the layout creates a HTML table after the compressed content. The table contains the file size in bytes during the compressing steps.

~~~yaml
compress_html:
  profile: true
~~~

The profile table provides attributes for styling and reading. The `id` ends with build’s timestamp to be unique enough.

~~~html
<table
  id="compress_html_profile_YYYYMMDD"
  class="compress_html_profile"
>
~~~

This page itself is compressed in profile mode for educational purposes only. The [table](#compress_html_profile_{{ site.time | date: "%Y%m%d" }}) is below. Please don’t profile in public.

### ignore.envs

An array of environments given by `ENV["JEKYLL_ENV"]` where the compress layout is ignored. This may be useful while developing a website.

Use the shortcut `all` to disable compression in all environments.

### blanklines

A boolean value to turn on blanklines mode. This mode will only remove lines consisting of whitespace and leave other lines alone.

~~~yaml
compress_html:
  blanklines: true
~~~


### Full-blown sample

~~~yaml
compress_html:
  clippings: all
  comments: ["<!-- ", " -->"]
  endings: all
  ignore:
    envs: [local]
  blanklines: false
  profile: true
  startings: [html, head, body]
~~~

## Restrictions

* Whitespaces inside of the `textarea` element are squeezed. Please don’t use the layout on pages with non-empty `textarea`.
* Inline JS can become broken where `//` comments used. Please remove the comments or change to `/**/` style.
* Invalid markup can lead to unexpected results. Please make sure your markup is valid before.

## Examples

This page itself is compressed by the layout. It’s hosted by GitHub in the `gh-pages` [branch][github-repo-gh-pages].

Look how [others use][github-search] the layout on GitHub too.

## Development

Feel free to submit bugs, patches, and questions in the [repository][github-repo].

Take a look at project’s `test/source` and `test/expected` directories. They contain self-explanatory specifications. Run `rake` to test the layout.

## Reviews

* _[A pure Liquid way to compress HTML][hutchison-review]_ by David Hutchison
* _[I am a Jekyll God][braithwaite-review]_ by Garth Braithwaite
* _[Compressing HTML in Jekyll without a plugin][knight-review]_ by Rich Knight
* _[Generating my static site with Jekyll and GitHub Pages][thorne-review]_ by Michael Thorne
* _[99/100 Google Page Speed Score][steinbach-review]_ by James Steinbach

----

© 2014–{{ site.time | date: "%Y" }} [Anatol Broder](http://anatol.penibelst.de/). Released under the MIT License.

[jekyll]: http://jekyllrb.com/
[html-spec]: https://html.spec.whatwg.org/multipage/
[html-semantics]: https://html.spec.whatwg.org/multipage/semantics.html
[html-syntax]: https://html.spec.whatwg.org/multipage/syntax.html
[html-tabular]: https://html.spec.whatwg.org/multipage/tables.html
[liquid]: http://docs.shopify.com/themes/liquid-documentation/basics
[github-repo]: https://github.com/penibelst/jekyll-compress-html
[github-repo-latest]: https://github.com/penibelst/jekyll-compress-html/releases/latest
[github-repo-gh-pages]: https://github.com/penibelst/jekyll-compress-html/tree/gh-pages
[github-search]: https://github.com/search?l=html&o=desc&q=filename%3Acompress.html+penibelst+compress_html&s=indexed&type=Code
[cond]: http://msdn.microsoft.com/en-us/library/ms537512.aspx
[hutchison-review]: http://www.devwithimagination.com/2014/06/12/jekyll-compress-a-pure-liquid-way-to-compress-html/
[knight-review]: http://rich-knight.com/articles/compressing-html-in-jekyll/
[braithwaite-review]: http://garthdb.com/writings/i-am-a-jekyll-god/
[thorne-review]: http://www.userx.co.za/journal/generating-my-static-site-with-jekyll-and-github-pages/
[steinbach-review]: https://jdsteinbach.com/performance/99-100-google-page-speed/
