# frozen_string_literal: true

require 'active_interaction'

# credits to : https://github.com/formigarafa/active_interaction/pull/2
# This allows to import_filters inside hash. Example :
# hash :user do
#   import_filters UserSignup
# end

module ActiveInteraction
  class HashFilter < Filter
    # Import filters from another interaction.
    #
    # @param klass [Class] The other interaction.
    # @param options [Hash]
    #
    # @option options [Array<Symbol>, nil] :only Import only these filters.
    # @option options [Array<Symbol>, nil] :except Import all filters except
    #   for these.
    #
    # @!visibility public
    def import_filters(klass, options = {}) # rubocop:disable Metrics/AbcSize
      only = options[:only]
      except = options[:except]
      groups = options[:groups] || [klass.to_s.demodulize.underscore.to_sym]

      klass.filters.each do |name, filter|
        next if only && ![*only].include?(name)
        next if except && [*except].include?(name)

        options = filter.options.merge(groups: groups)
        filter_copy = filter.class.new(name, options)
        filters[name] = filter_copy
      end
    end
  end
end
