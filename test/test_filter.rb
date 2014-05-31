class TestFilter < Test::Unit::TestCase
  def assert_file(file) do
    rendered = File.join('_site', file)
    assertion = File.join('assertion', file)
    assert File.identical?(rendered, assertion), File.new(rendered)
  end

  context "Empty" do
    should "render empty file to empty" do
      assert_file 'empty.html'
    end
  end

end
