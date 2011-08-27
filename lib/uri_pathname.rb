# uri_pathname
# MME 25/8/2011

require 'uri'

class UriPathname

  # Error codes
  class InvalidPathName < StandardError; end
  class InvalidURI < StandardError; end
  
  PTH_SEP = '_|_' # used to swap chars from and to '/' while converting to
  # pathname and viceversa. To work it should be a String that
  # doesn't exist in URIs and that can be used in pathnames.

  HOST_SEP = '__|' # used to separate hostname from the

  NO_PTH = '_NOPATH_' # used to make a filename for root uris (empty path).
  # To work it should be a String that doesn't exist in uris

  DEFAULT_DIR = '~/uri_pathname' # dir prepended to all pathnames
  
  HOST_2_DIR = true # URI hostname will become a subdirectory?

  # Converts an uri to a valid pathname, that is:
  #   [_basedirpath_/]_hostname_HS_path_?_query_(_scheme_)[._extension_]
  # where
  #   HS is UriPathname::HOST_SEP
  #   all '/' within _path_ and _query_ will be substituted by
  # UriPathname::PTH_SEP value.
  def self.uri_to_pathname(uri,dirname="",extension="")
    arr = URI.split uri
    # raise(InvalidURI, "#{uri} lacks scheme and/or host") unless (arr[0] && arr[2])
    return nil unless (arr[0] && arr[2])
    scheme = "(" << arr[0] << ")"
    host = arr[2]
    path = arr[5]
    if path.size <= 1 # "" or "/"
      path = NO_PTH
    else
      path=path[1..-1].gsub("/",PTH_SEP) # first '/' isn't necessary
    end
    query = arr[7]
    query = if query
      "?" << query.gsub("/",PTH_SEP)
    else
      ""
    end
    pathname = host << HOST_SEP << path << query << scheme << extension
    dirname.size > 0 ? File.expand_path(pathname, dirname) : pathname
  end

  # converts +pathname+ to an URI. UriPathname::PTH_SEP appearances will be
  # substituted by "/" (the standard path separator).
  # returns the URI String if +pathname+ was convertible or nil in other case.
  def self.pathname_to_uri(pathname)
    self.parse(pathname)[7]
  end

  # splits up a +pathname+ and returns an array where:
  # - the 3 first elements correspond to Pathname
  #   arr[0] = dirname
  #   arr[1] = basename (without extension)
  #   arr[2] = extension
  # - the last elements correspond to URI
  #   arr[3] = scheme
  #   arr[4] = hostname
  #   arr[5] = path
  #   arr[6] = query
  #   arr[7] = URI (complete)
  # returns nil if +pathname+ doesn't correspond to UriPathname format (see
  # UriPathname::uri_to_pathname)
  def self.parse(pathname)
    # raise(InvalidPathName, "pathname should be a String") \
    #   unless pathname.respond_to? :to_s
    return nil unless pathname.respond_to? :to_s
    complete_pathname = File.expand_path(pathname.to_s)

    # pathname parsed from complete_pathname
    extension = complete_pathname.slice!(/(\.[^\)\(\/]*)?$/)
    dirname, basename = File.split(complete_pathname)
    
    # further uri restored
    # hostname
    if HOST_SEP == '/'
      path_to_host, rest_of_thing = dirname, basename
      hostname = File.basename(path_to_host)
    else
      rest_of_thing = basename
      hostname, rest_of_thing = rest_of_thing.split(HOST_SEP)
    end
    # path, query and scheme
    return nil unless rest_of_thing =~ /(.*)\(([^\(]+)\)$/
    path_query, scheme= rest_of_thing.match(/(.*)\(([^\(]+)\)$/)[1..2]
    uri = scheme + '://' + hostname
    case path_query
    when NO_PTH
      path = ''
      query = ''
    else
      path, query = path_query.gsub(PTH_SEP,"/").split("?")
    end
    uri += "/" + path unless path.nil? or path.empty?
    uri += "?" + query unless query.nil? or query.empty?
    arr = []
    arr << dirname << basename << extension << scheme << hostname << path << query << uri
  end

end

