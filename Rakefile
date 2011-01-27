require "rake/testtask"
Rake::TestTask.new do |test|
  test.test_files = Dir['test/**/*_test.rb']
  test.verbose = true
end

task :default => :test