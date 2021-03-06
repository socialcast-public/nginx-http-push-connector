require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "nginx-http-push-connector"
    gem.summary = %Q{Wrapper for the nginx_http_push_module}
    gem.description = %Q{Provides an API for easily connecting to the nginx_http_push_module in Ruby}
    gem.email = "scashin133@gmail.com"
    gem.homepage = "http://github.com/socialcast/nginx-http-push-connector"
    gem.authors = ["Sean Cashin", "Socialcast"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.add_dependency "typhoeus", "0.1.13"
    gem.add_dependency "configatron", ">= 0"
    gem.add_dependency "crack", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "nginx-http-push-connector #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
