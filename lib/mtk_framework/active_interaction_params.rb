# frozen_string_literal: true

require_relative 'active_interaction_params/parametrize_filter.rb'

module MtkFramework
  module ActiveInteractionParams
    def params_from_interaction(klass, except: [])
      params do
        klass.filters.except(*except).each do |_, filter|
          ParametrizeFilter.call(filter, self)
          yield self if block_given?
        end
      end
    end
  end
end
