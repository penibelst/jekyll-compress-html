require 'rake'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test_*.rb']
  t.verbose = true
end

task :default => [:test]

task :performance do
  require 'benchmark'
  Dir.chdir('performance') do
    puts Benchmark.measure {
      sh 'jekyll build'
    }
  end
end
