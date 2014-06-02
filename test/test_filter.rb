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

  # Tests
  def test_compressed
    Dir.glob("test/expected/*.html") do |path|
      assert_file File.basename(path)
    end
  end

end
