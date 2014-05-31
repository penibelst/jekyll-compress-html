require 'rake'
require 'rake/testtask'

task :jekyll do
  Dir.chdir('test') do
    sh 'jekyll build'
  end
end

Rake::TestTask.new(:test => :jekyll) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test_*.rb']
  t.verbose = true
end

task :default => [:test]

