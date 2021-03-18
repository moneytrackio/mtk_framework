# frozen_string_literal: true

module Dummy
  class Application < Rails::Application
    config.eager_load = false
    config.root = ''
    config.filter_parameters = ['password', 'bank_account.name']
    config.i18n.default_locale = :fr
  end
end

Rails.logger = Logger.new('/dev/null')

Rails.application.initialize!
