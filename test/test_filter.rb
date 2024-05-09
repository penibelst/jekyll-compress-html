require "minitest/autorun"

class TestCompressed < Minitest::Test

  def setup
    Dir.glob File.join(COMPRESSED_DIR, "**", "*.html") do |path|
      File.delete path if File.file? path
    end
  end

  def test_default
    jekyll_build ["_config.yml"]
    assert_dir "default"
  end

  def test_all
    jekyll_build ["_config.yml", "_config_all.yml"]
    assert_dir "all"
  end

  def test_disabled
    jekyll_build ["_config.yml", "_config_all.yml"]
    assert_dir "disabled"
  end

  def test_clippings
    jekyll_build ["_config.yml", "_config_clippings.yml"]
    assert_dir "clippings"
  end

  def test_endings
    jekyll_build ["_config.yml", "_config_endings.yml"]
    assert_dir "endings"
  end

  def test_comments
    jekyll_build ["_config.yml", "_config_comments.yml"]
    assert_dir "comments"
  end

  def test_conditional
    jekyll_build ["_config.yml", "_config_conditional.yml"]
    assert_dir "conditional"
  end

  def test_profile
    jekyll_build ["_config.yml", "_config_profile.yml"]
    assert_dir "profile"
  end

  def test_ignore
    ENV["JEKYLL_ENV"] = "ignore"
    jekyll_build ["_config.yml", "_config_ignore.yml"]
    assert_dir "ignore"
    ENV["JEKYLL_ENV"] = nil
  end

  def test_ignore_all
    ENV["JEKYLL_ENV"] = "production"
    jekyll_build ["_config.yml", "_config_ignore_all.yml"]
    assert_dir "ignore"
    ENV["JEKYLL_ENV"] = nil
  end

  def test_startings
    jekyll_build ["_config.yml", "_startings.yml"]
    assert_dir "startings"
  end

  def test_blanklines
    jekyll_build ["_config.yml", "_config_blanklines.yml"]
    assert_dir "blanklines"
  end

  private

  EXPECTED_DIR = File.join File.dirname(__FILE__), "expected"
  COMPRESSED_DIR = File.join File.dirname(__FILE__), "_site"

  def assert_dir(dir)
    Dir.glob File.join(EXPECTED_DIR, dir, "*.html") do |path|
      assert_equal File.new(path).read, File.new(path.gsub(EXPECTED_DIR, COMPRESSED_DIR)).read, File.basename(path)
    end
  end

  def jekyll_build(configs)
    Dir.chdir File.dirname(__FILE__) do
      %x{bundle exec jekyll build --config #{configs.join(",")}}
    end
  end
end
