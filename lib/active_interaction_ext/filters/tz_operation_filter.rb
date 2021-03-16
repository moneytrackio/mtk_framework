# frozen_string_literal: true

module ActiveInteraction
  class Base
    # @!method self.tz_operation(*attributes, options = {})
    #   Creates accessors for the attributes and ensures that values passed to
    #     the attributes are Strings.
    #
    #   @example
    #     tz_operation :operation
  end

  # @private
  class TzOperationFilter < AbstractTzFilter
    register :tz_operation

    private

    def prefixes
      %i[o].freeze
    end
  end
end
