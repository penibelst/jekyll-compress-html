require 'rake'
require 'rake/testtask'

task :default => [:test, :proof_readme]
task :test => [:build]
task :performance => [:build]

task :build do
  yaml = File.open('src/compress.yaml').read
  liquid = File.open('src/compress.liquid').read.gsub(/\s+(?={)/, '')

  mkdir_p '_layouts'
  File.open '_layouts/compress.html', File::CREAT|File::WRONLY do |f|
    f.puts yaml, '', liquid
  end
end

Rake::TestTask.new :test do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test_*.rb']
end

task :performance do
  require 'benchmark'
  Dir.chdir 'performance' do
    puts Benchmark.measure { sh 'bundle exec jekyll build' }
  end
end

task :proof_readme do
  require 'html/proofer'
  require 'redcarpet'

  redcarpet = Redcarpet::Markdown.new Redcarpet::Render::HTML.new({}), {}
  html = redcarpet.render File.open("README.md").read

  mkdir_p "out"
  File.open "out/README.html", File::CREAT|File::WRONLY do |file|
    file.puts html
  end

  HTML::Proofer.new("./out").run
end
