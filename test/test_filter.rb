require 'test/unit'


class TestCompressed < Test::Unit::TestCase
  # Helpers
  def file_content(file, directory)
    path = File.join('test', directory, file)
    File.new(path).read
  end

  def assert_file(file)
    assert_equal file_content(file, 'expected'), file_content(file, 'compressed'), file
  end

  def jekyll_build
    Dir.chdir(File.dirname(__FILE__)) do
      %x{jekyll build}
    end
  end

  # Tests
  def setup
    jekyll_build
  end

  def test_compressed
    Dir.glob("test/expected/*.html") do |path|
      assert_file File.basename(path)
    end
  end

end
