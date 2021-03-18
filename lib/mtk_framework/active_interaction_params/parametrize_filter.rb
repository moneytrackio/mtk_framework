# frozen_string_literal: true

module MtkFramework
  module ActiveInteractionParams
    class ParametrizeFilter
      TYPES_MAPPING = {
        'Integer' => Integer,
        'Float' => Float,
        'Boolean' => Grape::API::Boolean,
        'String' => String,
        'Symbol' => Symbol,
        'Date' => Date,
        'DateTime' => DateTime,
        'Time' => Time,
        'File' => File,
        'Hash' => Hash,
        'Array' => Array,
        'TzSecretKey' => String,
        'TzAccount' => String,
        'TzContractAddress' => String,
        'TzPublicKey' => String,
        'TzSignature' => String
      }.freeze

      class <<self
        # TODO: handle the case of Object, Record, Interface(?)
        def call(filter, params_scope)
          unless nestable_filter?(filter)
            return params_scope.send(grape_method(filter), filter.name,
                                     **grape_options(filter))
          end

          parametrize_nestable(filter, params_scope)
        end

        def parametrize_nestable(filter, params_scope)
          current_filter = filter

          params_scope.send(grape_method(current_filter), current_filter.name,
                            **grape_options(current_filter)) do
            current_filter.filters.each do |_, child_filter|
              unless ParametrizeFilter.array_hash_filters?(current_filter, child_filter)
                ParametrizeFilter.call(child_filter, self)
              end

              # skip the hash require in the case of an array of hashes (AI and grape handle this case differently)
              child_filter.filters.each do |_, small_child_filter|
                ParametrizeFilter.call(small_child_filter, self)
              end
            end
          end
        end

        def grape_filter_type(filter)
          if filter.is_a? ActiveInteraction::ArrayFilter
            return array_grape_filter_type(filter)
          end

          filter_name = filter.class.name.split('::').second.split('Filter').first

          TYPES_MAPPING.fetch(filter_name)
        end

        # returns Array[<File | Integer ...>] if not array of hashes
        # else return Array, because in this case we use nested params with a block
        def array_grape_filter_type(filter)
          child_filter = filter.filters.values.first

          unless child_filter.is_a? ActiveInteraction::HashFilter
            return Array[grape_filter_type(child_filter)]
          end

          Array
        end

        def grape_options(filter)
          grape_options = { desc: filter.options.fetch(:desc, ''), type: grape_filter_type(filter) }
          if filter.options[:default]
            grape_options[:default] = filter.options[:default]
          end

          grape_options
        end

        def grape_method(filter)
          filter.options.key?(:default) ? :optional : :requires
        end

        def array_hash_filters?(filter, child_filter)
          filter.is_a?(ActiveInteraction::ArrayFilter) && child_filter.is_a?(ActiveInteraction::HashFilter)
        end

        def nestable_filter?(filter)
          unless filter.is_a? ActiveInteraction::ArrayFilter
            return filter.filters.any?
          end

          # this case is not supposed to happen since ActiveInteraction only allows one type in the case of an Array
          raise NotImplementedError unless filter.filters.count == 1

          # if it is an array of hashes => we use nested params with a block
          # else we use types like Array[String] => not nestable
          filter.filters.values.first.is_a? ActiveInteraction::HashFilter
        end
      end
    end
  end
  end
