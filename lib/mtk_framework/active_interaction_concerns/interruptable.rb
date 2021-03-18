# frozen_string_literal: true

module MtkFramework
  module ActiveInteractionConcerns
    module Interruptable
      extend ActiveSupport::Concern
      include ::MtkFramework::ActiveInteractionConcerns::Rescuable

      included do
        class ApplicationInterrupt < StandardError; end

        rescue_from ApplicationInterrupt do
          raise unless errors.any?
        end
      end

      def interrupt_execute!(*args)
        if args.any?
          if args[0].is_a? ActiveModel::Errors
            errors.merge!(args[0])
          else
            errors.add(*args)
          end
        end

        raise 'interrupt_execute! called without error' if errors.empty?

        raise ApplicationInterrupt
      end
    end
  end
end
