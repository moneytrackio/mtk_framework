# frozen_string_literal: true

module ActiveInteraction
  class Base
    # @!method self.tz_signature(*attributes, options = {})
    #   Creates accessors for the attributes and ensures that values passed to
    #     the attributes are Strings.
    #
    #   @example
    #     tz_signature :signature
  end

  # @private
  class TzSignatureFilter < AbstractTzFilter
    register :tz_signature

    private

    def prefixes
      %i[edsig spsig1 p2sig sig].freeze
    end
  end
end
