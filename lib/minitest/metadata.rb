module MiniTest::Metadata
  module ClassMethods
    # Returns Hash metadata for class' test methods
    def metadata
      @metadata ||= {}
    end
  end

  def self.included(klass)
    klass.extend ClassMethods
    klass.class_eval do
      class << self
        # @private
        alias :old_it :it
        alias :old_test :test

        # @private
        def it(description = "", *metadata, &block)
          old_it(description, &block).tap do |name|
            self.metadata[name] = _compute_metadata(metadata)
          end
        end

        def test(description = "", *metadata, &block)
          # generated test name isn't returned in this case, name generation
          # algorithm pulled from https://github.com/rails/rails/blob/v4.0.4/ \
          # activesupport/lib/active_support/testing/declarative.rb#L26
          test_name = "test_#{description.gsub(/\s+/,'_')}"
          old_test(description, &block)
          self.metadata[test_name] = _compute_metadata(metadata)
        end

        def _compute_metadata(metadata)
          metadata.inject({}) { |hash, key|
            if key.is_a?(Hash)
              hash.merge!(key)
            else
              hash[key] = true
            end
            hash
          }
        end
      end
    end
    super
  end

  # Returns Hash metadata for currently running test
  def metadata
    self.class.metadata[__name__] || {}
  end
end
