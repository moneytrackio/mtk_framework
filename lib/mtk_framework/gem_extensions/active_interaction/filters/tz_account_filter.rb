# frozen_string_literal: true

module ActiveInteraction
  class Base
    # @!method self.tz_public_key(*attributes, options = {})
    #   Creates accessors for the attributes and ensures that values passed to
    #     the attributes are Strings.
    #
    #   @example
    #     tz_public_key :public_key
  end

  # @private
  class TzAccountFilter < AbstractTzFilter
    register :tz_account

    private

    def prefixes
      %i[tz1 tz2 tz3].freeze
    end
  end
end
