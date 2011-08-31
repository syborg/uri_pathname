# uri_pathname
# MME 25/8/2011

require 'uri'
require 'uri_pathname/version'

class UriPathname

  # Error codes
  class InvalidPathName < StandardError; end
  class InvalidURI < StandardError; end
  
  PTH_SEP = '_|_' # used to swap chars from and to '/' while converting to
  # pathname and viceversa. To work it should be a String that
  # doesn't exist in URIs and that can be used in pathnames.

  HOST_SEP = '__|' # used to separate hostname from the path

  NO_PTH = '_NOPATH_' # used to make a filename for root uris (empty path).
  # To work it should be a String that doesn't exist in uris

  BASE_DIR = '' # dir prepended to all pathnames

  #default attributes
  DEFAULT_ATTRS = {
      :pth_sep => PTH_SEP,
      :host_sep => HOST_SEP,
      :no_pth => NO_PTH,
      :base_dir => BASE_DIR,
    }

  attr_accessor *(DEFAULT_ATTRS.keys)

  # Initializes an UriPathname that can be used to convert between URIs and
  # pathnames. +options+ is a hash that can contain any of:
  #      :pth_sep => String that will be used to substitute '/' inside URI's path and queries (default UriPathname::PTH_SEP)
  #      :host_sep => String that will be used to substitute '/' between host and path (default UriPathname::HOST_SEP)
  #      :no_pth => String that will be used as a path placeholder when no URI's path exists, (default UriPathname::NO_PTH)
  #      :base_dir => String containing base directory prepended to any pathname, (default UriPathname::DEFAULT_DIR)
  def initialize(options = {})

    attributes = DEFAULT_ATTRS.merge options if options.is_a? Hash

    attributes.each { |k,v| instance_eval("@#{k}='#{v}'") if DEFAULT_ATTRS.keys.include?(k) }

  end

  # Converts an uri to a valid pathname, that is:
  #   [_DIR_/]_hostname_HS_path_?_query_(_scheme_)[._extension_]
  # where
  #   DIR is +basedirpath+ if given else _@base_dir_
  #   HS is UriPathname::HOST_SEP
  #   all '/' within _path_ and _query_ will be substituted by
  # UriPathname::PTH_SEP value.
  def uri_to_pathname(uri,basedirpath=nil,extension="")
    arr = URI.split uri
    # raise(InvalidURI, "#{uri} lacks scheme and/or host") unless (arr[0] && arr[2])
    return nil unless (arr[0] && arr[2])
    scheme = "(" << arr[0] << ")"
    host = arr[2]
    path = arr[5]
    if path.size <= 1 # "" or "/"
      path = @no_pth
    else
      path=path[1..-1].gsub("/",@pth_sep) # first '/' isn't necessary
    end
    query = arr[7]
    query = if query
      "?" << query.gsub("/",@pth_sep)
    else
      ""
    end
    extension='' unless extension
    extension.insert(0,'.') unless extension.empty? or extension.start_with? '.'
    pathname = host << @host_sep << path << query << scheme << extension
    basedirpath = @base_dir unless basedirpath
    basedirpath.size > 0 ? File.expand_path(pathname, basedirpath) : pathname
  end

  # converts +pathname+ to an URI. UriPathname::PTH_SEP appearances will be
  # substituted by "/" (the standard path separator).
  # returns the URI String if +pathname+ was convertible or nil in other case.
  def pathname_to_uri(pathname)
    pn = self.parse(pathname)
    pn ? pn[7] : nil
  end

  # splits up a +pathname+ and returns an array where:
  # 1. the 3 first elements correspond to Pathname
  #   - arr[0] = dirname
  #   - arr[1] = basename (without extension)
  #   - arr[2] = extension
  # 2. the last elements correspond to URI
  #   - arr[3] = scheme
  #   - arr[4] = hostname
  #   - arr[5] = path
  #   - arr[6] = query
  #   - arr[7] = URI (complete)
  # returns nil if +pathname+ doesn't correspond to UriPathname format (see
  # UriPathname::uri_to_pathname)
  def parse(pathname)
    # raise(InvalidPathName, "pathname should be a String") \
    #   unless pathname.respond_to? :to_s
    return nil unless pathname.respond_to? :to_s
    complete_pathname = File.expand_path(pathname.to_s)

    # pathname parsed from complete_pathname
    extension = complete_pathname.slice!(/(\.[^\)\(\/]*)?$/)
    dirname, basename = File.split(complete_pathname)
    
    # further uri restored
    # hostname
    if @host_sep == '/'
      path_to_host, rest_of_thing = dirname, basename
      hostname = File.basename(path_to_host)
    else
      rest_of_thing = basename
      hostname, rest_of_thing = rest_of_thing.split(@host_sep)
    end
    # path, query and scheme
    return nil unless rest_of_thing =~ /(.*)\(([^\(]+)\)$/ and !hostname.empty?
    path_query, scheme= rest_of_thing.match(/(.*)\(([^\(]+)\)$/)[1..2]
    uri = scheme + '://' + hostname
    case path_query
    when @no_pth
      path = ''
      query = ''
    else
      path, query = path_query.gsub(@pth_sep,"/").split("?")
    end
    uri += "/" + path unless path.nil? or path.empty?
    uri += "?" + query unless query.nil? or query.empty?
    arr = []
    arr << dirname << basename << extension << scheme << hostname << path << query << uri
  end

end

