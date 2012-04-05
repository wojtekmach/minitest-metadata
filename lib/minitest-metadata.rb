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
      old_it(description, &block).tap do |name|
        self.metadata[name] = metadata
      end
    end
  end
end
