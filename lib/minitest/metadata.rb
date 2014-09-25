module MiniTest::Metadata
  module ClassMethods
    # Returns Hash metadata for class' test methods
    def metadata
      @metadata ||= Hash.new({})
    end
  end

  def self.included(klass)
    klass.extend ClassMethods
    klass.class_eval do
      class << self
        # @private
        alias :old_it :it

        # @private
        def it(description = "", *metadata, &block)
          name = old_it(description, &block)
          self.metadata[name] = _compute_metadata(metadata) unless metadata.empty?
          name
        end

        def _compute_metadata(metadata)
          if metadata[-1].is_a? Hash
            meta = metadata.pop
          else
            meta = {}
          end
          metadata.each { |key| meta[key] = true }
          meta
        end
      end

      # MiniTest 5 compatibility, https://github.com/wojtekmach/minitest-metadata/issues/7
      alias_method :__name__, :name unless method_defined? :__name__
    end
    super
  end

  # Returns Hash metadata for currently running test
  def metadata
    self.class.metadata[__name__] || {}
  end
end
