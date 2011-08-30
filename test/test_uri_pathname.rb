require 'test/unit'
require 'uri_pathname'

class TC_Uri2Pathname < Test::Unit::TestCase

  def setup
    @up = UriPathname.new
  end

  def test_uri_without_path
    assert_equal('www.fake.fak__|_NOPATH_(http)',@up.uri_to_pathname('http://www.fake.fak'))
    assert_equal('www.fake.fak__|_NOPATH_(http)',@up.uri_to_pathname('http://www.fake.fak/'))
  end

  def test_uri_with_path
    assert_equal('www.fake.fak__|path1_|_path2(http)',@up.uri_to_pathname('http://www.fake.fak/path1/path2'))
    assert_equal('foo-bar.com__|yay?_|_hi(http)',@up.uri_to_pathname('http://foo-bar.com/yay?/hi'))
  end

  def test_uri_with_path_and_fragment
    assert_equal('donaldfagen.com__|disc_nightfly.php(http)',@up.uri_to_pathname('http://donaldfagen.com/disc_nightfly.php#rubybaby'))
  end

  def test_uri_with_path_and_query
    assert_equal('www.fake.fak__|path1_|_path2?query(http)',@up.uri_to_pathname('http://www.fake.fak/path1/path2?query'))
    assert_equal('foo-bar.com__|yay_|_?foo=bar&a=22(http)',@up.uri_to_pathname('http://foo-bar.com/yay/?foo=bar&a=22'))
  end

  def test_uri_dir_expansion_and_exension
    assert_equal('/tmp/my_webdumps/www.fake.fak__|path1_|_path2?query(http).html',@up.uri_to_pathname("http://www.fake.fak/path1/path2?query", "/tmp/my_webdumps",".html"))
    assert_equal('/tmp/my_webdumps/www.fake.fak__|path1_|_path2?query(http).html',@up.uri_to_pathname("http://www.fake.fak/path1/path2?query", "/tmp/my_webdumps","html"))
  end

end

class TC_Pathname2Uri < Test::Unit::TestCase

  def setup
    @up = UriPathname.new
  end

  def test_pn_absolute
    assert_equal('http://www.fake.fak',@up.pathname_to_uri('/home/marcel/my_webdumps/www.fake.fak__|_NOPATH_(http).html.gz'))
  end

  def test_pn_relative
    assert_equal('http://www.fake.fak',@up.pathname_to_uri('my_webdumps/www.fake.fak__|_NOPATH_(http).html.gz'))
  end

  def test_pn_malformed
    assert_equal(nil,@up.pathname_to_uri('my_webdumps/www.fake.fak__|_NOPATH_(http)html.gz'), "No dot after last )")
    assert_equal(nil,@up.pathname_to_uri('my_webdumps/www.fake.fak__|_NOPATH_(http.html.gz'), "No clossing )")
    assert_equal(nil,@up.pathname_to_uri('my_webdumps/www.fake.fak__|_NOPATH_http).html.gz'), "No opening (")
    assert_equal(nil,@up.pathname_to_uri('my_webdumps/__|_NOPATH_(http).html.gz'), "No host")
    assert_equal(nil,@up.pathname_to_uri('my_webdumps/www.fake.fak__|_NOPATH_().html.gz'), "No scheme")
  end

end