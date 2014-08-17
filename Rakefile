require 'rake'
require 'rake/testtask'

task :default => [:test]
task :test => [:build]

task :build do
  yaml = File.open('src/compress.yaml').read
  liquid = File.open('src/compress.liquid').read.gsub(/\s+(?={)/, '')

  mkdir_p '_layouts'
  File.open('_layouts/compress.html', File::CREAT|File::WRONLY).write "#{yaml}\n#{liquid}"
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test_*.rb']
  t.verbose = true
end

task :performance do
  require 'benchmark'
  Dir.chdir('performance') do
    puts Benchmark.measure {
      sh 'jekyll build'
    }
  end
end
