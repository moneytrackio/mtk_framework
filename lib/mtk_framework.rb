# frozen_string_literal: true

# External libs
require 'active_interaction'
require 'active_support/core_ext/hash/indifferent_access'
require 'grape'
require 'rails'
require 'tezos_client'

# Gem extensions
GEM_EXTENSIONS_PATH = 'mtk_framework/gem_extensions/active_interaction'

require_relative "#{GEM_EXTENSIONS_PATH}/filters/abstract_tz_filter.rb"
require_relative "#{GEM_EXTENSIONS_PATH}/filters/hash_filter.rb"
require_relative "#{GEM_EXTENSIONS_PATH}/filters/tz_account_filter.rb"
require_relative "#{GEM_EXTENSIONS_PATH}/filters/tz_contract_address_filter.rb"
require_relative "#{GEM_EXTENSIONS_PATH}/filters/tz_operation_filter.rb"
require_relative "#{GEM_EXTENSIONS_PATH}/filters/tz_public_key_filter.rb"
require_relative "#{GEM_EXTENSIONS_PATH}/filters/tz_secret_key_filter.rb"
require_relative "#{GEM_EXTENSIONS_PATH}/filters/tz_signature_filter.rb"
require_relative "#{GEM_EXTENSIONS_PATH}/base.rb"

# Core extensions
CORE_EXTENSIONS_PATH = 'mtk_framework/core_extensions'

require_relative "#{CORE_EXTENSIONS_PATH}/array/except.rb"
require_relative "#{CORE_EXTENSIONS_PATH}/class/virtual_method.rb"
require_relative "#{CORE_EXTENSIONS_PATH}/hash/rename_keys.rb"

# ActiveInteractionParams
require_relative 'mtk_framework/active_interaction_params.rb'

# ActiveInteractionConcerns
ACTIVE_INTERACTION_CONCERNS_PATH = 'mtk_framework/active_interaction_concerns'

require_relative "#{ACTIVE_INTERACTION_CONCERNS_PATH}/i18nable.rb"
require_relative "#{ACTIVE_INTERACTION_CONCERNS_PATH}/rescuable.rb"
require_relative "#{ACTIVE_INTERACTION_CONCERNS_PATH}/interruptable.rb"
require_relative "#{ACTIVE_INTERACTION_CONCERNS_PATH}/loggable.rb"
require_relative "#{ACTIVE_INTERACTION_CONCERNS_PATH}/updatable_object.rb"

I18n.load_path.unshift(
  *Dir.glob(
    File.expand_path(
      File.join(%w[mtk_framework locale *.yml]), File.dirname(__FILE__)
    )
  )
)

require_relative 'mtk_framework/railtie.rb' if defined?(Rails::Railtie)
