# frozen_string_literal: true

RSpec.describe MtkFramework::ActiveInteractionConcerns::Loggable do
  let(:logger_output) { StringIO.new }
  let(:logger) { Logger.new(logger_output) }

  before do
    allow(Rails).to receive(:logger).and_return(logger)
  end

  describe 'run' do
    before do
      application_interaction = Class.new(ActiveInteraction::Base) do
        include MtkFramework::ActiveInteractionConcerns::Loggable
        include MtkFramework::ActiveInteractionConcerns::Interruptable
      end

      stub_const('ApplicationInteraction', application_interaction)
    end
    context 'simple interaction' do
      subject { DummyInteraction.run(params) }

      before do
        dummy_interaction = Class.new(ApplicationInteraction) do
          integer :integer_param

          validates :integer_param, numericality: { geater_than: 0 }

          def execute
            errors.add(:integer_param, :invalid) unless integer_param > 10
          end
        end

        stub_const('DummyInteraction', dummy_interaction)
      end

      context 'type_check fails' do
        let(:params) { {} }

        it 'logs errors' do
          expect(subject).not_to be_valid
          expect(logger_output.string)
            .to match %r{Interaction DummyInteraction failed: 'Integer param est obligatoire' called from: spec/active_interaction_concerns/loggable_spec\.rb} # rubocop:disable Layout/LineLength
        end
      end

      context 'type_check succeeds' do
        context 'validation fails' do
          let(:params) { { integer_param: 0 } }

          it 'logs errors' do
            expect(subject).not_to be_valid
            expect(logger_output.string)
          end
        end

        context 'validation succeeds' do
          context 'execution fails' do
            let(:params) { { integer_param: 1 } }

            it 'logs errors' do
              expect(subject).not_to be_valid
              expect(logger_output.string)
              expect(logger_output.string)
            end
          end

          context 'execution succeeds' do
            let(:params) { { integer_param: 11 } }

            it 'logs call' do
              expect(subject).to be_valid
              expect(logger_output.string)
            end
          end
        end
      end

      context 'with compose' do
        subject { DummyWithcompose.run(params) }

        before do
          dummy_with_compose = Class.new(ApplicationInteraction) do
            integer :integer_param

            def execute
              compose(DummyInteraction, integer_param: integer_param)
            end
          end

          stub_const('DummyWithcompose', dummy_with_compose)
        end

        context 'succeeds' do
          let(:params) { { integer_param: 11 } }

          it 'works' do
            expect(subject).to be_valid
            expect(logger_output.string)
            expect(logger_output.string)
              .to include 'Interaction DummyInteraction [{:integer_param=>11}] called from spec/active_interaction_concerns/loggable_spec.rb' # rubocop:disable Layout/LineLength
          end
        end

        context 'compose execution fails' do
          let(:params) { { integer_param: 0 } }

          it 'logs failures for each interaction' do
            expect(subject).not_to be_valid
            expect(logger_output.string).to include 'Interaction DummyInteraction failed'
          end
        end
      end
    end

    context 'interrupted' do
      subject { DummyInterrupted.run }

      before do
        dummy_interaction = Class.new(ApplicationInteraction) do
          def execute
            interrupt_execute! :base, :invalid
          end
        end

        stub_const('DummyInterrupted', dummy_interaction)
      end

      it 'works' do
        expect(subject).not_to be_valid
        expect(logger_output.string)
          .to include 'Interaction DummyInterrupted [] called from spec/active_interaction_concerns/loggable_spec.rb' # rubocop:disable Layout/LineLength
        expect(logger_output.string)
          .to include "Interaction DummyInterrupted failed: 'est invalide' called from: spec/active_interaction_concerns/loggable_spec.rb" # rubocop:disable Layout/LineLength
      end
    end

    context 'run! interrupted' do
      subject { DummyInterrupted.run! }

      before do
        dummy_interaction = Class.new(ApplicationInteraction) do
          def execute
            interrupt_execute! :base, :invalid
          end
        end

        stub_const('DummyInterrupted', dummy_interaction)
      end

      it 'works' do
        expect { subject }.to raise_error ActiveInteraction::InvalidInteractionError, 'est invalide'
        expect(logger_output.string)
          .to include 'Interaction DummyInterrupted [] called from spec/active_interaction_concerns/loggable_spec.rb' # rubocop:disable Layout/LineLength
        expect(logger_output.string)
          .to include "Interaction DummyInterrupted failed: 'est invalide' called from: spec/active_interaction_concerns/loggable_spec.rb" # rubocop:disable Layout/LineLength
      end
    end

    context 'filtering logs' do
      subject { DummyInteraction.run(params) }

      let(:params) do
        {
          password: 'super secret',
          bank_account: {
            name: 'name_value'
          },
          not_filtered: 'value'
        }
      end

      before do
        dummy_interaction = Class.new(ApplicationInteraction) do
          string :password
          hash :bank_account do
            string :name
          end
          string :not_filtered

          def execute; end
        end

        stub_const('DummyInteraction', dummy_interaction)
      end

      it 'logs call filtering params' do
        expect(subject).to be_valid
        x = logger_output.string
        expect(logger_output.string)
          .to include 'Interaction DummyInteraction [{:password=>"[FILTERED]", :bank_account=>{:name=>"[FILTERED]"}, :not_filtered=>"value"}] called from spec/active_interaction_concerns/loggable_spec.rb' # rubocop:disable Layout/LineLength
      end
    end
  end
end
