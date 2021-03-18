# frozen_string_literal: true

module MtkFramework
  module ActiveInteractionConcerns
    module I18nable
      extend ActiveSupport::Concern

      def i18n_scope
        "#{self.class.i18n_scope}.#{self.class.name.underscore}"
      end

      def t(*args, **h_args)
        h_args.reverse_merge!(scope: i18n_scope)
        I18n.t(*args, **h_args)
      end
    end
  end
end
