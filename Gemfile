source "https://rubygems.org"

gem "jekyll", ENV['JEKYLL_VERSION'] ? "~>#{ENV['JEKYLL_VERSION']}" : nil

group :test do
  gem "rake"
  gem "minitest"
  gem "html-proofer", ">= 4", "< 6"
end

if ENV['USE_KRAMDOWN'] then
  gem "kramdown-parser-gfm"
end
