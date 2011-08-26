# uri_fname
# MME 25/8/2011

require 'uri_pathname/pathname'
require 'uri_pathname/uri'

module UriFname

  # Error codes
  class InvalidPathName < StandardError; end
  class InvalidURI < StandardError; end
  
  PTH_SEP = '_|_' # used to swap chars from and to '/' while converting to
  # filename and viceversa. To work it should be a String that
  # doesn't exist in uris
  NO_PTH = '_NOPATH_' # used to make a filename for root uris (empty path).
  # To work it should be a String that doesn't exist in uris
  DEFAULT_DIR = '~/uri_pathname' # dir prepended to all pathnames
  HOST_2_DIR = true # URI host will become a subdirectory?

end

