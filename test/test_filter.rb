require 'minitest/autorun'


class TestFilter < Minitest::Test
  # Helpers
  def file_content(file, directory)
    path = File.join('test', directory, file)
    File.new(path).read.rstrip
  end

  def expected_content(file)
    file_content(file, 'expected')
  end

  def filtered_content(file)
    file_content(file, 'filtered')
  end

  def assert_file(file)
    filtered = filtered_content(file)
    expected = expected_content(file)
    assert_equal(expected, filtered)
  end

  # Tests
  def test_empty
    assert_file 'empty.html'
  end

end
