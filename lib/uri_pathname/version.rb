# it's only a version number

class UriPathname

  module Version

    MAJOR = 0
    MINOR = 1
    PATCH = 1 
    BUILD = 0
	
    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join(".")

  end

end
