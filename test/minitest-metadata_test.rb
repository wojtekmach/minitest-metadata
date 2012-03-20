require "minitest/autorun"
require "minitest-metadata"

describe MiniTest::Spec do
  it "::metadata returns metadata hash for each test method" do
    @cls = describe "A spec" do
      it "test1", :js => true do; end

      it "test2" do; end

      it "test3", :js => false do; end
    end

    @cls.metadata["test_0001_test1"].must_equal :js => true
    @cls.metadata["test_0002_test2"].must_equal(nil)
    @cls.metadata["test_0003_test3"].must_equal :js => false
  end

  it "#meta returns empty hash when nothing passed to ::it" do
    metadata.must_equal({})
  end

  it "#meta returns metadata hash when passed to ::it", :js => true do
    metadata.must_equal :js => true
  end
end
