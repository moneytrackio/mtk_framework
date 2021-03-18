# frozen_string_literal: true

require_relative 'interaction_mocks_helper.rb'

module MtkFramework
  module ActiveInteractionMocks
    module InteractionGroupMocksHelper
      include InteractionMocksHelper

      # /!\ mandatory is set to false by default because it mocks inside a before block
      def group_mock_interaction(klass,
                                 methods: nil,
                                 failing: false,
                                 mandatory: false,
                                 expected_params: nil,
                                 return_proc: nil, # a proc that will be executed in the before block scope
                                 call_original: false,
                                 &exec_block)
        before do
          mock_interaction(klass,
                           methods: methods,
                           failing: failing,
                           mandatory: mandatory,
                           expected_params: expected_params,
                           return_proc: return_proc,
                           call_original: call_original,
                           &exec_block)
        end
      end
    end
  end
end
