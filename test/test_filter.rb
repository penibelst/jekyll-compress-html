require 'minitest'
require 'minitest/autorun'


class TestCompressed < Minitest::Test

  def setup
    Dir.glob(File.join(COMPRESSED, '**', '*.html')) do |path|
      File.delete(path) if !File.directory?(path)
    end
  end

  def test_default
    jekyll_build(['_config.yml'])
    assert_dir('default')
  end

  def test_full
    jekyll_build(['_config.yml', '_config_full.yml'])
    assert_dir('full')
  end

  def test_clippings
    jekyll_build(['_config.yml', '_config_clippings.yml'])
    assert_dir('clippings')
  end

  def test_endings
    jekyll_build(['_config.yml', '_config_endings.yml'])
    assert_dir('endings')
  end

  def test_comments
    jekyll_build(['_config.yml', '_config_comments.yml'])
    assert_dir('comments')
  end

  private

  EXPECTED = 'test/expected'
  COMPRESSED = 'test/compressed'

  def assert_dir(dir)
    Dir.glob(File.join(EXPECTED, dir, '*.html')) do |path|
      assert_equal File.new(path).read, File.new(path.gsub(EXPECTED, COMPRESSED)).read, File.basename(path)
    end
  end

  def jekyll_build(configs)
    Dir.chdir(File.dirname(__FILE__)) do
      %x{jekyll build --config #{configs.join(',')}}
    end
  end
end
