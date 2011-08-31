# fakeweb
# MME 27/8/2011
#
# This example demonstrates how uri_pathname should be used to save and restore
# pages, including a demo with fakeweb (a web stub utility) to simulate web
# accesses.

require 'rubygems'
require 'fileutils'
require 'open-uri'
require 'uri_pathname'
require 'fakeweb' # gem install fakeweb

# put here whatever temporary directory name to use
MY_DIR=File.expand_path '~/my_dumps' 
# put here whatever URIs u want to access
MY_URIS = [
  'http://en.wikipedia.org/wiki/Ruby_Bridges',
  'http://donaldfagen.com/disc_nightfly.php',
  'http://www.rubi.cat/ajrubi/portada/index.php',
  'http://www.google.com/cse?q=array&cx=013598269713424429640%3Ag5orptiw95w&ie=UTF-8&sa=Search'
]

# some convenient defs
def prepare_example
  FileUtils.mkdir_p(MY_DIR) unless (File.exist?(MY_DIR) and File.directory?(MY_DIR))
end

# preparation (comment this if you've already got your test dir)
prepare_example

up = UriPathname.new

# 1st round: Capture MY_URIS, and save them with appropiate UriPathname
puts "1- Capturing URIs"
data = nil
sizes = []
MY_URIS.each do |uri|
  open uri do |u|
    data=u.read
    pathname = up.uri_to_pathname(uri,MY_DIR,".html")
    File.open(pathname,'w') do |f|
      f.write data
      sizes << data.size
      puts "SAVED #{uri} : #{data.size} bytes"
    end
  end
end

# 2nd round: checking saved files and preparing fake web accesses
puts "\n2- CHECKING CAPTURED FILES AND PREPARING FAKE WEB ACCESSES"
FakeWeb.allow_net_connect=false
Dir[File.join(MY_DIR,"*")].each do |name|
  uri = up.pathname_to_uri name
  FakeWeb.register_uri :any, uri, :body=>name, :content_type=>"text/html"
  puts "#{name}\n\tcorresponds to #{uri}"
end

# 3nd round: Access Web without actually accessing web
puts "\n3- FAKE WEB ACCESSES"
MY_URIS.each_with_index do |uri,i|
  open uri do |u|
    data=u.read
    puts "FAKE #{uri} ACCESS #{(data.size == sizes[i]) ? 'OK' : 'KO'}: #{data.size} bytes"
  end
end
