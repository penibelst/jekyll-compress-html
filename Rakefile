require "rake"
require "rake/testtask"
require "rake/clean"

task :default => [:test]

BUILD_DIR = "_build"
BUILD_FILE = File.join(BUILD_DIR, "compress.html")

file BUILD_FILE => FileList["src/compress.*", BUILD_DIR] do
  yaml = File.open("src/compress.yaml").read
  liquid = File.open("src/compress.liquid").read.gsub(/\s+(?={)/, "").gsub(/{% comment %}[^{]+{% endcomment %}/, "")

  File.open BUILD_FILE, File::CREAT|File::WRONLY do |f|
    f.puts yaml, "", liquid
  end
end

Rake::TestTask.new :test => BUILD_FILE do |t|
  t.libs << "test"
  t.test_files = FileList["test/test_*.rb"]
end

task :performance => BUILD_FILE do
  require "benchmark"
  Dir.chdir "performance" do
    puts Benchmark.measure do
      sh "bundle exec jekyll build"
    end
  end
end

CLEAN.include FileList["vnu*"]
CLOBBER.include FileList["_build/*"]

namespace :site do
  task :build do
    Dir.chdir "site" do
      sh "bundle exec jekyll build"
    end
  end

  VALIDATOR = "vnu/vnu.jar"
  file VALIDATOR do
    sh "wget -O vnu.zip https://github.com/validator/validator/releases/download/20141006/vnu-20141013.jar.zip"
    sh "unzip vnu.zip #{VALIDATOR}"
  end

  task :validate => [:build, VALIDATOR] do
    sh "java -jar ./#{VALIDATOR} ./site/_site"
  end

  task :proofer => :build do
    require 'html/proofer'
    HTML::Proofer.new("./site/_site", ssl_verifypeer: false).run
  end

  task :test => [:validate]

  desc "Commit the local site to the gh-pages branch and publish to GitHub Pages"
  task :publish do
    GH_PAGES_DIR = "_gh-pages"

    # Ensure the gh-pages dir exists so we can generate into it.
    unless File.exist? GH_PAGES_DIR
      sh "git clone git@github.com:penibelst/jekyll-compress-html #{GH_PAGES_DIR}"
    end

    # Ensure latest gh-pages branch history.
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
