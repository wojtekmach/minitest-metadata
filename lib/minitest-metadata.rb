require 'minitest/spec'

require 'minitest-metadata/version'

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
      if !metadata.empty?
        methods = test_methods
        ret = old_it description, &block
        name = (test_methods - methods).first
        self.metadata[name] = metadata
        ret
      else
        old_it description, &block
      end
    end
  end
end
