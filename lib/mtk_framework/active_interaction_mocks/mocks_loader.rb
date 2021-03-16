# frozen_string_literal: true

module MtkFramework
  module ActiveInteractionMocks
    class MocksLoader
      def run
        # force require of all interactions
        Dir['app/interactions/**/*.rb'].each do |x|
          require Rails.root.join(x)
        rescue StandardError
          false
        end

        ApplicationInteraction.descendants.each do |klass|
          mocked = Class.new(ApplicationInteraction) do
            import_filters klass

            # delegate i18n translation to mocked class
            define_singleton_method :human_attribute_name do |*args|
              klass.human_attribute_name(*args)
            end

            define_singleton_method :model_name do |*args|
              klass.model_name(*args)
            end

            define_method :to_model do
              klass.to_s.split('::').first.singularize.safe_constantize&.new
            end

            private

            def execute; end
          end

          failing = Class.new(mocked) do
            private

            def execute
              errors.add(:base, 'shit happens')
            end
          end

          klass.const_set('Mocked', mocked)
          klass.const_set('Fail', failing)
        end

        require_relative 'interaction_mocks_helper.rb'
        require_relative 'interaction_group_mocks_helper.rb'
      end
    end
  end
end
