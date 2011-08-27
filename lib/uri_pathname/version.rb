# it's only a version number

module Version

	MAJOR = 0
	MINOR = 0
	PATCH = 0
	BUILD = 'pre1'
	
	STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join(".")

end
