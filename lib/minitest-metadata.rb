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
    alias :old_method_added :method_added

    # @private
    def method_added(name)
      Thread.current[:minitest_metadata_name] = name.to_s
      old_method_added(name)
    end

    # @private
    alias :old_it :it

    # @private
    def it(description = "", metadata = {}, &block)
      ret = old_it description, &block
      name = Thread.current[:minitest_metadata_name]
      self.metadata[name] = metadata
      ret
    end
  end
end
