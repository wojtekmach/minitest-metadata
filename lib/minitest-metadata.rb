require 'minitest/spec'

# Metadata support for minitest/spec
module MiniTest::Metadata
  # Current minitest-metadata version
  VERSION = '0.1.0'
end

class MiniTest::Spec
  # Returns Hash metadata for class' test methods
  def self.metadata
    @metadata ||= {}
  end

  # Returns Hash metadata for currently running test
  def metadata
    self.class.metadata[__name__] || {}
  end

  class << self
    # @private
    alias :old_it :it

    # @private
    def it(description = "", metadata = {}, &block)
      methods = test_methods
      ret = old_it description, &block
      name = (test_methods - methods).first
      self.metadata[name] = metadata
      ret
    end
  end
end
