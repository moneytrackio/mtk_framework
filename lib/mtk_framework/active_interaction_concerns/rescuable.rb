# frozen_string_literal: true

module MtkFramework
  module ActiveInteractionConcerns
    module Rescuable
      extend ActiveSupport::Concern
      include ActiveSupport::Rescuable

      included do
        set_callback :execute,
                     :around,
                     :handle_rescue
      end

      def handle_rescue(*args)
        yield(*args)
      rescue StandardError => e
        raise unless rescue_with_handler(e)

        if errors.any?
          @_interaction_valid = false
          errors.backtrace = e.backtrace
        end
      end
    end
  end
end
