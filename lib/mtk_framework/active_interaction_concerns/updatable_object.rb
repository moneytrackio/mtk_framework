# frozen_string_literal: true

module MtkFramework
  module ActiveInteractionConcerns
    module UpdatableObject
      extend ActiveSupport::Concern

      def update_object_from_filters(object, **options)
        filters = self.class.filters.except(*options[:except])

        filters.each_key do |filter_name|
          if !send(filter_name).nil? && object.respond_to?("#{filter_name}=")
            object.send("#{filter_name}=", send(filter_name))
          end
        end
      end

      class_methods do
        def from_object(object)
          params = filters.keys.reduce({}) do |acc, filter|
            if object.respond_to? filter
              acc.merge!(filter => object.send(filter))
            else
              acc
            end
          end
          new(object.class.name.downcase => object, **params)
        end
      end
    end
  end
end
