# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{uri_pathname}
  s.version = "0.0.0.pre1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcel Massana"]
  s.date = %q{2011-08-28}
  s.description = %q{Simple converter between URIs and Pathnames. It creates valid, unique and readable filenames from URIs and viceversa. It can be used to name files while saving data from websites and conversely, read files assigned to URIs while, for instance, simulating or stubbing web accesses by neabs of reading files}
  s.email = %q{xaxaupua@gmail.com}
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
     "lib/uri_pathname.rb",
     "lib/uri_pathname/version.rb",
     "test/helper.rb",
     "test/test_uri_pathname.rb",
     "uri_pathname.gemspec"
  ]
  s.homepage = %q{http://github.com/syborg/uri_pathname}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Simple converter between URIs and Pathnames}
  s.test_files = [
    "test/helper.rb",
     "test/test_uri_pathname.rb",
     "examples/simple_examples.rb",
     "examples/using_fakeweb.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end

