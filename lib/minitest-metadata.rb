require 'minitest/spec'

class MiniTest::Metadata
  VERSION = '0.1.0'
end

class MiniTest::Spec
  # Returns Hash metadata for each test method
  def self.metadata
    @metadata ||= {}
  end

  # Returns Hash metadata for current test method
  def metadata
    self.class.metadata[__name__] || {}
  end

  class << self
    alias old_it it

    def it(description = "", metadata = {}, &block)
      methods = test_methods
      ret = old_it description, &block
      name = (test_methods - methods).first
      self.metadata[name] = metadata
      ret
    end
  end
end
