require 'test/unit'


class TestFilter < Test::Unit::TestCase
  # Helpers
  def file_content(file, directory)
    path = File.join('test', directory, file)
    File.new(path).read.rstrip
  end

  def assert_file(file)
    assert_equal file_content(file, 'expected'), file_content(file, 'filtered')
  end

  # Tests
  def test_empty
    assert_file 'empty.html'
  end

end
