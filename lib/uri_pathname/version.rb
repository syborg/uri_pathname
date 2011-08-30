# it's only a version number

class UriPathname

  module Version

    MAJOR = 0
    MINOR = 0
    PATCH = 0
    BUILD = 'pre2'
	
    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join(".")

  end

end
