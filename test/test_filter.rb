require 'test/unit'
require 'shoulda'

class TestFilter < Test::Unit::TestCase
  def file_content(file, directory)
    path = File.join('test', directory, file)
    File.new(path).read.rstrip
  end

  def expected_content(file)
    file_content(file, 'expected')
  end

  def filtered_content(file)
    file_content(file, '_site')
  end

  def assert_file(file)
    filtered = filtered_content(file)
    expected = expected_content(file)
    assert_equal(expected, filtered)
  end

  context 'Empty' do
    should 'render empty file to empty' do
      assert_file 'empty.html'
    end
  end

end
