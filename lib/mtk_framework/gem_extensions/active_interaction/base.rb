# frozen_string_literal: true

module ActiveInteraction
  class Base
    def self.import_filters_optionally(klass, options = {})
      only = options[:only]
      except = options[:except]
      default_value = options[:default_value]

      other_filters = klass.filters.dup
      other_filters.select! { |k, _| [*only].include?(k) } if only
      other_filters.reject! { |k, _| [*except].include?(k) } if except

      other_filters.each_value do |filter|
        filter.options[:default] = default_value
        initialize_filter(filter)
      end
    end
  end
end
