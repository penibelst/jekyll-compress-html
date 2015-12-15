require "rake"
require "rake/testtask"
require "rake/clean"

task :default => [:test]

BUILD_DIR = "_build"
BUILD_FILE = File.join(BUILD_DIR, "compress.html")

directory BUILD_DIR
file BUILD_FILE => FileList["src/compress.*", BUILD_DIR] do |bf|
  yaml = File.open("src/compress.yaml").read
  liquid = File.open("src/compress.liquid").read
    .gsub(/\s+/, " ")
    .gsub(/\s+(?={)|/, "")
    .gsub(/{% comment %}[^{]+{% endcomment %}/, "")
    .strip

  File.open bf.name, 'w' do |f|
    f.puts yaml, liquid
  end
end

Rake::TestTask.new :test => BUILD_FILE do |t|
  t.libs << "test"
  t.test_files = FileList["test/test_*.rb"]
end

task :performance => BUILD_FILE do
  require "benchmark"
  Dir.chdir "performance" do
    puts Benchmark.measure { sh "bundle exec jekyll build" }
  end
end

CLEAN.include FileList["vnu*", "Gemfile.lock", "**/_site"]
CLOBBER.include FileList["_build/*", "_gh-pages"]

namespace :site do
  task :build do
    Dir.chdir "site" do
      sh "bundle exec jekyll build"
    end
  end

  task :preview do
    Dir.chdir "site" do
      sh "bundle exec jekyll serve --drafts"
    end
  end

  VALIDATOR = "vnu/vnu.jar"
  file VALIDATOR do |f|
    sh "wget -O vnu.zip https://github.com/validator/validator/releases/download/20141006/vnu-20141013.jar.zip"
    sh "unzip vnu.zip #{f.name}"
  end

  task :validate => [:build, VALIDATOR] do
    sh "java -jar #{File.join(".", VALIDATOR)} ./site/_site"
  end

  task :proof => :build do
    require 'html/proofer'
    HTML::Proofer.new("./site/_site", {
      :verbose => true,
      :typhoeus => {
        :ssl_verifypeer => false,
        :ssl_verifyhost => 0}
    }).run
  end

  task :test => [:validate, :proof]

  GH_PAGES_DIR = "_gh-pages"
  directory GH_PAGES_DIR
  file GH_PAGES_DIR do |f|
    sh "git clone git@github.com:penibelst/jekyll-compress-html #{f.name}"
  end

  desc "Commit the local site to the gh-pages branch and publish to GitHub Pages"
  task :publish => [GH_PAGES_DIR, :test] do
    Dir.chdir GH_PAGES_DIR do
      sh "git checkout gh-pages"
      sh "git pull origin gh-pages"
    end

    puts "Cleaning gh-pages directory..."
    rm_rf FileList[File.join(GH_PAGES_DIR, "**", "*")]

    puts "Copying site to gh-pages branch..."
    cp_r FileList[File.join("site", "*"), ".gitignore"], GH_PAGES_DIR

    puts "Committing and pushing to GitHub Pages..."
    sha = `git log`.match(/[a-z0-9]{40}/)[0]
    Dir.chdir GH_PAGES_DIR do
      sh "git add ."
      sh "git commit --allow-empty -m 'Updating to #{sha}.'"
      sh "git push origin gh-pages"
    end
    puts 'Done.'
  end
end
