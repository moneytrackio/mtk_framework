# frozen_string_literal: true

module ActiveInteraction
  # @abstract
  #
  # Common logic for filters that handle numeric objects.
  #
  # @private
  class AbstractTzFilter < Filter
    private

    def matches?(value)
      value.is_a?(String) && valid_tz_entry?(value)
    rescue NoMethodError # BasicObject
      false
    end

    def valid_tz_entry?(value)
      TezosClient.new.decode_tz(value) do |prefix, _payload|
        return false unless prefixes.include? prefix
      end

      true
    rescue ArgumentError
      false
    end
  end
end
