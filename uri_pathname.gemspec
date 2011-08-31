# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "uri_pathname"
  s.version = "0.1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcel Massana"]
  s.date = "2011-08-31"
  s.description = "Simple converter between URIs and Pathnames. It creates valid, unique and readable filenames from URIs and viceversa. It can be used to name files while saving data from websites and conversely, read files assigned to URIs while, for instance, simulating or stubbing web accesses by means of reading files"
  s.email = "xaxaupua@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "examples/simple_examples.rb",
     "examples/using_fakeweb.rb",
     "lib/uri_pathname.rb",
     "lib/uri_pathname/version.rb",
     "test/test_uri_pathname.rb",
     "uri_pathname.gemspec"
  ]
  s.homepage = "http://github.com/syborg/uri_pathname"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Simple converter between URIs and Pathnames"
  s.test_files = [
    "test/test_uri_pathname.rb",
     "examples/simple_examples.rb",
     "examples/using_fakeweb.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

