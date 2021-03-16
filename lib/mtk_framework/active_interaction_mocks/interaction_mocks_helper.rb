# frozen_string_literal: true

module MtkFramework
  module ActiveInteractionMocks
    module InteractionMocksHelper
      def mock_interaction(
        klass,
        methods: nil,
        failing: false,
        mandatory: true,
        expected_params: nil,
        additional_params: nil,
        return_proc: nil,
        call_original: false
      )
        stubbed_methods = methods || (mandatory ? [:run] : %i[run run!])

        spec_method = mandatory ? :expect : :allow
        const_name = failing ? 'Fail' : 'Mocked'
        mocking_klass = klass.const_get(const_name)

        if block_given? || return_proc.present?
          mocking_klass = Class.new(mocking_klass)
          test_scope = self

          mocking_klass.define_method :execute do
            return_value = yield self if block_given?
            if return_proc.present?
              return_value = test_scope.instance_exec(&return_proc)
            end

            return_value
          end

          mocking_klass.define_singleton_method :name do
            "#{klass.name}::#{const_name}"
          end
        end

        stubbed_methods.map do |stubbed_method|
          block = lambda { |*params|
            mocking_klass.send(stubbed_method, *params, &block)
          }

          rspec_sentence = receive(stubbed_method, &block)

          if expected_params
            with = expected_params.respond_to?(:call) ? instance_eval(&expected_params) : expected_params
            rspec_sentence.with(with, &block)
          end

          additional_params&.call(rspec_sentence)

          rspec_sentence.and_call_original if call_original

          send(spec_method, klass).to rspec_sentence
        end
      end
    end
  end
end
