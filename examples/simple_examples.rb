# simple_examples
# MME 26/8/2011

require 'rubygems'
require 'uri_pathname'

# GENERATE PATHNAMES

  # From URI with path and query
  puts UriPathname::uri_to_pathname("http://www.fake.fak/path1/path2?query")
  # => www.fake.fak__|path1_|_path2?query(http)

  # From URI without path and query
  puts UriPathname::uri_to_pathname("http://www.fake.fak")
  # => www.fake.fak__|_NOPATH_(http)

  # Fragments or other URI parts are silently ignored
  puts UriPathname::uri_to_pathname('http://donaldfagen.com/disc_nightfly.php#rubybaby')
  # => donaldfagen.com__|disc_nightfly.php(http)

  # If a directory is given as a second arg, pathname will be prepended with that
  # expanded directory
  puts UriPathname::uri_to_pathname("http://www.fake.fak", "~/my_webdumps")
  # => /home/marcel/my_webdumps/www.fake.fak__|_NOPATH_(http)

  # Also a third argument can be given and will be appended as an extension
  puts UriPathname::uri_to_pathname("http://www.fake.fak/path","", ".html")
  # => www.fake.fak__|path(http).html

# RECOVERING URIs FROM PATHNAMES

  # pathnames can be parsed if correctly generated as above examples (see docs)
  p UriPathname::parse('/home/marcel/my_webdumps/www.fake.fak__|path1_|_path2?query(http).html.gz')

  # URI can be also retrieved from correct (Uri)pathnames
  puts UriPathname::pathname_to_uri('/home/marcel/my_webdumps/www.fake.fak__|_NOPATH_(http).html.gz')
  # => http://www.fake.fak
  puts UriPathname::pathname_to_uri('www.fake.fak__|path?query(http).html.gz')
  # => http://www.fake.fak/path?query




