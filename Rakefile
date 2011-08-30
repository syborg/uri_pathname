require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  require './lib/uri_pathname/version'
  Jeweler::Tasks.new do |gem|
    gem.name = "uri_pathname"
    gem.summary = %Q{Simple converter between URIs and Pathnames}
    gem.description = %Q{Simple converter between URIs and Pathnames. 
      It creates valid, unique and readable filenames from URIs and 
      viceversa. It can be used to name files while saving data from 
      websites and conversely, read files assigned to URIs while, for
      instance, simulating or stubbing web accesses by means of reading
      files}.gsub(/\s+/,' ')
    gem.email = "xaxaupua@gmail.com"
    gem.homepage = "http://github.com/syborg/uri_pathname"
    gem.authors = ["Marcel Massana"]
    # gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.version = UriPathname::Version::STRING
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
  rdoc.title = "uri_pathname #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
