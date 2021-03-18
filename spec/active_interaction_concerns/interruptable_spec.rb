# frozen_string_literal: true

RSpec.describe MtkFramework::ActiveInteractionConcerns::Interruptable do
  describe 'Interruptable' do
    before do
      application_interaction = Class.new(ActiveInteraction::Base) do
        include MtkFramework::ActiveInteractionConcerns::Interruptable
      end

      stub_const('ApplicationInteraction', application_interaction)
    end

    describe '#run with interrupt_execute'
    context 'adding error' do
      subject { interrupted_interaction.run }

      let(:interrupted_interaction) do
        Class.new(ApplicationInteraction) do
          def self.name
            'InterruptedInterraction'
          end

          def execute
            errors.add :base, :invalid
            interrupt_execute!
            raise "I've not been interrupted"
          end
        end
      end

      it 'interrupts execution' do
        expect { subject }.not_to raise_exception
      end

      it 'lets the interaction invalid with correct errors' do
        expect(subject).to be_invalid
        expect(subject.errors.full_messages).to include 'est invalide'
      end
    end

    context 'passing error while interrupting' do
      subject { interrupted_interaction.run }

      let(:interrupted_interaction) do
        Class.new(ApplicationInteraction) do
          def self.name
            'InterruptedInterraction'
          end

          def execute
            interrupt_execute! :base, :invalid
            raise "I've not been interrupted"
          end
        end
      end

      it 'interrupts execution' do
        expect { subject }.not_to raise_exception
      end

      it 'lets the interaction invalid with correct errors' do
        expect(subject).to be_invalid
        expect(subject.errors.full_messages).to include 'est invalide'
      end
    end

    context 'passing errors while interrupting' do
      before do
        dummy_model = Class.new do
          include ActiveModel::Model
          attr_accessor :label

          validates :label, presence: true
        end

        stub_const('DummyModel', dummy_model)
      end
      subject { interrupted_interaction.run }

      let(:interrupted_interaction) do
        Class.new(ApplicationInteraction) do
          def self.name
            'InterruptedInterraction'
          end

          def execute
            contract = DummyModel.new
            contract.valid?
            interrupt_execute! contract.errors

            raise "I've not been interrupted"
          end
        end
      end

      it 'interrupts execution' do
        expect { subject }.not_to raise_exception
      end

      it 'lets the interaction invalid with correct errors' do
        expect(subject).to be_invalid
        expect(subject.errors.full_messages).to include 'Label doit être rempli(e)'
      end
    end

    context 'forgetting to add errors when interrupting' do
      subject { interrupted_interaction.run }

      let(:interrupted_interaction) do
        Class.new(ApplicationInteraction) do
          def self.name
            'InterruptedInterraction'
          end

          def execute
            interrupt_execute!
            raise "I've not been interrupted"
          end
        end
      end

      it 'raises and exception' do
        expect { subject }.to raise_exception RuntimeError, 'interrupt_execute! called without error'
      end
    end
  end
end
