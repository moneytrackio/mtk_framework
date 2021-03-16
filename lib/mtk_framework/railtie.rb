# frozen_string_literal: true

require_relative 'active_interaction_mocks/mocks_loader.rb'

module MtkFramework
  class Railtie < Rails::Railtie
    config.after_initialize do
      if ENV['RAILS_ENV'] == 'test'
        MtkFramework::ActiveInteractionMocks::MocksLoader.new.run
      end
    end
  end
end
