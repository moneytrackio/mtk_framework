# frozen_string_literal: true

require 'rails/backtrace_cleaner'
require 'active_support/parameter_filter'

module MtkFramework
  module ActiveInteractionConcerns
    module Loggable
      extend ActiveSupport::Concern

      included do
        set_callback :type_check,
                     :after,
                     :log_errors,
                     if: -> { errors.any? }

        set_callback :execute,
                     :after,
                     :log_errors,
                     if: -> { errors.any? }

        set_callback :validate,
                     :after,
                     :log_errors,
                     if: -> { errors.any? }
      end

      class_methods do
        def new(*args)
          Rails.logger.info "Interaction #{name} #{filtered_interaction_params(args)} called from #{interaction_caller}"
          super
        end

        def filtered_interaction_params(params)
          @param_filter ||= ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters)
          params.map do |arg|
            @param_filter.filter(arg)
          end
        end

        def filter_backtrace(backtrace)
          backtrace_cleaner.clean(backtrace)
        end

        def interaction_caller
          filter_backtrace(Thread.current.backtrace)[0]
        end

        private

        def backtrace_cleaner
          @backtrace_cleaner ||= BacktraceCleaner.new
        end
      end

      def log_errors
        error_msg = errors.full_messages.to_sentence
        Rails.logger.info(
          "Interaction #{self.class.name} failed: '#{error_msg}' called from: #{interaction_caller}"
        )
      end

      delegate :filter_backtrace, :interaction_caller, to: :class

      class BacktraceCleaner < Rails::BacktraceCleaner
        APP_DIRS_PATTERN = %r{^/?(app|config|lib|test|spec|\(\w*\))}.freeze
        CURRENT_FILE = __FILE__

        def initialize
          super
          remove_silencers!
          add_silencer { |line| !APP_DIRS_PATTERN.match?(line) }
          add_silencer { |line| line.include? current_file }
        end

        private

        def current_file
          CURRENT_FILE.gsub(@root, '')
        end
      end
    end
  end
end
