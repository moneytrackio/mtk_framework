# frozen_string_literal: true

module ActiveInteraction
  class Base
    # @!method self.tz_secret_key(*attributes, options = {})
    #   Creates accessors for the attributes and ensures that values passed to
    #     the attributes are Strings.
    #
    #   @example
    #     tz_secret_key :secret_key
  end

  # @private
  class TzSecretKeyFilter < AbstractTzFilter
    register :tz_secret_key

    private

    def prefixes
      %i[edsk edsk2].freeze
    end
  end
end
