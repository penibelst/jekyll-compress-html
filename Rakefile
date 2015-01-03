require "rake"
require "rake/testtask"
require "rake/clean"

task :default => [:test]

task :build => :clean do
  yaml = File.open("src/compress.yaml").read
  liquid = File.open("src/compress.liquid").read.gsub(/\s+(?={)/, "").gsub(/{% comment %}[^{]+{% endcomment %}/, "")

  mkdir_p "_build"
  File.open "_build/compress.html", File::CREAT|File::WRONLY do |f|
    f.puts yaml, "", liquid
  end
end

Rake::TestTask.new :test => :build do |t|
  t.libs << "test"
  t.test_files = FileList["test/test_*.rb"]
end

task :performance => :build do
  require "benchmark"
  Dir.chdir "performance" do
    puts Benchmark.measure { sh "bundle exec jekyll build" }
  end
end

CLEAN.include FileList["_build/compress.html"]

namespace :site do
  task :build do
    Dir.chdir "site" do
      sh "bundle exec jekyll build"
    end
  end
  task :test => :build do
    Dir.chdir "site" do
      sh "wget -O vnu.zip https://github.com/validator/validator/releases/download/20141006/vnu-20141013.jar.zip"
      sh "unzip vnu.zip"
      sh "java -jar ./vnu/vnu.jar ./_site/"
    end
  end
end
