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
  class TzContractAddressFilter < AbstractTzFilter
    register :tz_contract_address

    private

    def prefixes
      %i[KT].freeze
    end
  end
end
